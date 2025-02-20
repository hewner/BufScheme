Class {
	#name : #BufSAstLitExp,
	#superclass : #BufSAstNode,
	#instVars : [
		'litValue'
	],
	#category : #BufScheme
}

{ #category : #'instance creation' }
BufSAstLitExp class >> fromNumToken: aNumToken [
			
	^self new litValue: aNumToken data asNumber
]

{ #category : #'instance creation' }
BufSAstLitExp class >> fromStringToken: aStringToken [
	
	|valueWithQuotes|
	valueWithQuotes := aStringToken data.		
	^self new litValue: ( valueWithQuotes copyFrom: 2 to: valueWithQuotes size - 1)
]

{ #category : #compilation }
BufSAstLitExp >> decompile [

	"TODO: gonna need more work for quotes"
	
	litValue isNumber ifTrue: [ ^litValue asString ].
	litValue isString ifTrue: [ ^ '"' , litValue , '"' ].
	Error signal: 'dont know how to decompile this value'
	
]

{ #category : #compilation }
BufSAstLitExp >> generateIR: aIRBuilder [

	aIRBuilder pushLiteral: litValue 
	
]

{ #category : #accessing }
BufSAstLitExp >> litValue [

	^ litValue
]

{ #category : #accessing }
BufSAstLitExp >> litValue: anObject [

	litValue := anObject
]
