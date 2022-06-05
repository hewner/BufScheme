Class {
	#name : #SchemeUniverse,
	#superclass : #Object,
	#instVars : [
		'globals',
		'environments'
	],
	#category : #BufScheme
}

{ #category : #environments }
SchemeUniverse >> addEnvMapping: aString to: aValue [

	self currentEnv atMapping: aString put: aValue
]

{ #category : #prims }
SchemeUniverse >> callPrim: nameSymbol withArguments: anArray [

	^self perform: nameSymbol with: anArray 
]

{ #category : #environments }
SchemeUniverse >> currentEnv [

	^environments last
]

{ #category : #environments }
SchemeUniverse >> getEnvValue: aString [
	
	^self currentEnv getMapping: aString ifAbsent: [ self getGlobal: aString ]
]

{ #category : #environments }
SchemeUniverse >> getGlobal: aString [
	
	^globals at: aString ifAbsent: [ (self isPrim: aString) 
		ifTrue: [ BufSPrim newWithName: aString andUniverse: self ]
		ifFalse: [ BufSRuntimeError signal: 'name lookup failed'] ]
]

{ #category : #initialization }
SchemeUniverse >> initialize [
			
	globals := Dictionary new.
	globals at: 'true' put: true.
	globals at: 'false' put: false.
	environments := OrderedCollection with: BufSEnvironment rootEnvironment
]

{ #category : #prims }
SchemeUniverse >> isPrim: aName [

	^#('+') includes: aName
	
]

{ #category : #'as yet unclassified' }
SchemeUniverse >> myMethod [

	globals add: 2.
	^3
]

{ #category : #environments }
SchemeUniverse >> setGlobal: aSymbol toValue: aValue [
			
	globals at: aSymbol put: aValue
]
