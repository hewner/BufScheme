Class {
	#name : #BufSIfExp,
	#superclass : #BufSAstCompoundExp,
	#instVars : [
		'testAst',
		'thenAst',
		'elseAst'
	],
	#category : #BufScheme
}

{ #category : #'instance creation' }
BufSIfExp class >> fromTokens: tokens [
 
	^self new
		testAst: (BufSAstNode parseExpression: tokens second);
		thenAst: (BufSAstNode parseExpression: tokens third);
		elseAst: (BufSAstNode parseExpression: tokens fourth);
		yourself
		
]

{ #category : #accessing }
BufSIfExp >> elseAst [

	^ elseAst
]

{ #category : #accessing }
BufSIfExp >> elseAst: anObject [

	elseAst := anObject
]

{ #category : #compilation }
BufSIfExp >> generateIR: aIRBuilder [

	self testAst generateIR: aIRBuilder.
	aIRBuilder jumpAheadTo: #elsebranch if: false.
	self thenAst generateIR: aIRBuilder.
	aIRBuilder 
		jumpAheadTo: #endif;
		jumpAheadTarget: #elsebranch.
	self elseAst generateIR: aIRBuilder.
	aIRBuilder jumpAheadTarget: #endif
	
		
	
	
]

{ #category : #accessing }
BufSIfExp >> testAst [

	^ testAst
]

{ #category : #accessing }
BufSIfExp >> testAst: anObject [

	testAst := anObject
]

{ #category : #accessing }
BufSIfExp >> thenAst [

	^ thenAst
]

{ #category : #accessing }
BufSIfExp >> thenAst: anObject [

	thenAst := anObject
]
