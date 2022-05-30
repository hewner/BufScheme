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
