Class {
	#name : #BufSAstNode,
	#superclass : #Object,
	#instVars : [
		'tokens'
	],
	#category : #BufScheme
}

{ #category : #parsing }
BufSAstNode class >> parseExpression: aToken [

	"if its a list, then it must be a compound expression"
	aToken isCollection ifTrue: [ ^BufSAstCompoundExp createFromList: aToken  ].

	aToken isNumToken ifTrue: [ ^BufSAstLitExp fromNumToken: aToken].
	aToken isStringToken ifTrue: [ ^BufSAstLitExp fromStringToken: aToken ].
	aToken isSymbolToken ifTrue: [ ^BufSAstVarExp fromSymbolToken: aToken ].
]

{ #category : #parsing }
BufSAstNode class >> parseToAst: schemeString [

	| tokens |

	tokens := BufSToken tokenizeString: schemeString.
	tokens size = 1 ifFalse: [ BufSParseError signal: 'extra tokens in expression' ].
	^self parseExpression: tokens first.
]

{ #category : #compilation }
BufSAstNode >> generateIR: aIRBuilder [

	^self subclassResponsibility 
	
]

{ #category : #compilation }
BufSAstNode >> generateRootIR: aIRBuilder [

	^self generateIR: aIRBuilder 
	
]

{ #category : #compilation }
BufSAstNode >> toCompiledMethod [

	|builder|
	builder := IRBuilder new.
	builder numArgs: 0.
	self generateIR: builder.
	builder returnTop.
	^ builder ir compiledMethod.
	
]

{ #category : #compilation }
BufSAstNode >> toCompiledRootMethod [

	|builder|
	builder := IRBuilder new.
	builder numArgs: 0.
	self generateRootIR: builder.
	builder returnTop.
	^ builder ir compiledMethod.
	
	
]
