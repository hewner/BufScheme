Class {
	#name : #SchemeUniverse,
	#superclass : #Object,
	#instVars : [
		'globals'
	],
	#category : #BufScheme
}

{ #category : #prims }
SchemeUniverse >> callPrim: nameSymbol withArguments: anArray [

	^self perform: nameSymbol with: anArray 
]

{ #category : #globals }
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

{ #category : #globals }
SchemeUniverse >> setGlobal: aSymbol toValue: aValue [
			
	globals at: aSymbol put: aValue
]
