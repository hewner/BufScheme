Class {
	#name : #BufSAstNode,
	#superclass : #Object,
	#instVars : [
		'tokens'
	],
	#category : #BufScheme
}

{ #category : #compilation }
BufSAstNode >> generateIR: aIRBuilder [

	^self subclassResponsibility 
	
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
