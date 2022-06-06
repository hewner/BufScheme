Class {
	#name : #BufSCallExp,
	#superclass : #BufSAstCompoundExp,
	#instVars : [
		'subexpressions'
	],
	#category : #BufScheme
}

{ #category : #'instance creation' }
BufSCallExp class >> fromTokens: tokens [
 
	^self new subexpressions: (tokens collect: [ : each | BufSAstNode parseExpression: each ])
]

{ #category : #compilation }
BufSCallExp >> generateIR: aIRBuilder [

	| paramList invokable |
	paramList := self subexpressions copy.
	invokable := paramList removeFirst.
	
	invokable generateIR: aIRBuilder.
	aIRBuilder pushNewArray: paramList size.
	paramList keysAndValuesDo: [ :index :value |
			aIRBuilder 
				pushDup;
				pushLiteral: index.
			value generateIR: aIRBuilder.
			aIRBuilder
				send: #at:put:;
				popTop
		 ].
	aIRBuilder send: #invokeWithArguments:
	
]

{ #category : #accessing }
BufSCallExp >> subexpressions [

	^ subexpressions
]

{ #category : #accessing }
BufSCallExp >> subexpressions: anObject [

	subexpressions := anObject
]
