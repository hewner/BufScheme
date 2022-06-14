Class {
	#name : #BufSDefineExp,
	#superclass : #BufSAstCompoundExp,
	#instVars : [
		'name',
		'valueAst'
	],
	#category : #BufScheme
}

{ #category : #'instance creation' }
BufSDefineExp class >> fromTokens: tokens [
 
	^self new
		name: tokens second data;
		valueAst: (BufSAstNode parseExpression: tokens third);
		yourself
]

{ #category : #compilation }
BufSDefineExp >> generateIR: aIRBuilder [

	^self generateIR: aIRBuilder withSetter: #addEnvMapping:to:
	
]

{ #category : #compilation }
BufSDefineExp >> generateIR: aIRBuilder withSetter: aMessageSymbol [

	aIRBuilder 
		pushReceiver;
		pushLiteral: name.
	valueAst generateIR: aIRBuilder.
	aIRBuilder send: aMessageSymbol.
	
		
	
]

{ #category : #compilation }
BufSDefineExp >> generateRootIR: aIRBuilder [

	^self generateIR: aIRBuilder withSetter: #setGlobal:toValue:
	
]

{ #category : #accessing }
BufSDefineExp >> name: anObject [

	name := anObject
]

{ #category : #accessing }
BufSDefineExp >> valueAst: anObject [

	valueAst := anObject
]
