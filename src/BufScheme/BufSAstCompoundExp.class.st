Class {
	#name : #BufSAstCompoundExp,
	#superclass : #BufSAstNode,
	#category : #BufScheme
}

{ #category : #'instance creation' }
BufSAstCompoundExp class >> createFromList: listOfTokens [

	self
		if: listOfTokens matches: 'if' do: [ ^BufSIfExp fromTokens: listOfTokens ];
		if: listOfTokens matches: 'let' do: [ ^BufSLetExp fromTokens: listOfTokens ];
		if: listOfTokens matches: 'lambda' do: [ ^BufSLambdaExp fromTokens: listOfTokens ];
		if: listOfTokens matches: 'define' do: [ ^BufSDefineExp fromTokens: listOfTokens ].
	^BufSCallExp fromTokens: listOfTokens 
]

{ #category : #'instance creation' }
BufSAstCompoundExp class >> fromTokens: tokens [
 
	^self subclassResponsibility
]

{ #category : #'instance creation' }
BufSAstCompoundExp class >> if: list matches: aName do: aBlock [

	| first |
	first := list first.
	first isCollection ifTrue: [ ^false ].
	^first data = aName ifTrue: aBlock
]

{ #category : #compilation }
BufSAstCompoundExp >> generateForBodies: bodies AndBuilder: aIRBuilder [

	bodies from: 1 to: bodies size - 1 do: [ :each | 
		each generateIR: aIRBuilder.
		aIRBuilder popTop ].
	bodies last generateIR: aIRBuilder.
]
