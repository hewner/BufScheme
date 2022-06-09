Class {
	#name : #SchemeUniverse,
	#superclass : #Object,
	#instVars : [
		'globals',
		'environments'
	],
	#category : #BufScheme
}

{ #category : #'as yet unclassified' }
SchemeUniverse class >> evalScheme: aString [

	|ast method universe|
	ast := BufSAstNode parseToAst: aString.
	method := ast toCompiledMethod.
	universe := self new.
	^method valueWithReceiver: universe arguments: Array new
]

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

	^ globals at: aString ifAbsent: [ 
		  (self isPrim: aString)
			  ifTrue: [ BufSPrim newWithName: aString ]
			  ifFalse: [ BufSRuntimeError signal: 'name lookup failed' ] ]
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

{ #category : #environments }
SchemeUniverse >> popEnv [

	environments removeLast 
]

{ #category : #environments }
SchemeUniverse >> pushEnv: environment [

	environments add: environment
]

{ #category : #environments }
SchemeUniverse >> pushExtendingEnvironment [

	self pushEnv: (BufSEnvironment newExtending: (self currentEnv))
]

{ #category : #environments }
SchemeUniverse >> setGlobal: aSymbol toValue: aValue [
			
	globals at: aSymbol put: aValue
]
