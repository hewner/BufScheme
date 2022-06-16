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
BufSAstVarExp >> decompile [

	^name
]

{ #category : #compilation }
BufSAstVarExp >> generateIR: aIRBuilder [

	aIRBuilder 
		pushReceiver;
		pushLiteral: name;
		send: #getEnvValue:
]

{ #category : #accessing }
BufSAstVarExp >> name [

	^ name
]

{ #category : #accessing }
BufSAstVarExp >> name: anObject [

	name := anObject
]
