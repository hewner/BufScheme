Class {
	#name : #BufSAstCompoundExp,
	#superclass : #BufSAstNode,
	#category : #BufScheme
}

{ #category : #'as yet unclassified' }
BufSAstCompoundExp class >> createFromList: listOfTokens [

	self
		if: listOfTokens matches: 'if' do: [ ^BufSIfExp fromTokens: listOfTokens ];
		if: listOfTokens matches: 'let' do: [ ^BufSLetExp fromTokens: listOfTokens ].
	^BufSCallExp fromTokens: listOfTokens 
]

{ #category : #'instance creation' }
BufSAstCompoundExp class >> fromTokens: tokens [
 
	^self subclassResponsibility
]

{ #category : #'as yet unclassified' }
BufSAstCompoundExp class >> if: list matches: aName do: aBlock [

	^list first data = aName ifTrue: aBlock
]
