Class {
	#name : #BufSAstVarExp,
	#superclass : #BufSAstNode,
	#instVars : [
		'name'
	],
	#category : #BufScheme
}

{ #category : #'instance creation' }
BufSAstVarExp class >> fromSymbolToken: aSymbolToken [
			
	^self new name: aSymbolToken data
]

{ #category : #compilation }
BufSAstVarExp >> generateIR: aIRBuilder [

	aIRBuilder 
		pushReceiver;
		pushLiteral: name;
		send: #getGlobal:
]

{ #category : #accessing }
BufSAstVarExp >> name [

	^ name
]

{ #category : #accessing }
BufSAstVarExp >> name: anObject [

	name := anObject
]
