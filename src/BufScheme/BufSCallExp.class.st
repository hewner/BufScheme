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
BufSCallExp >> decompile [ 

	^ '(' , (' ' join: (subexpressions collect: [  :sub | sub decompile ])) , ')'
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
	aIRBuilder 
		pushReceiver ;
		send: #invokeWithArguments:onUniverse:
	
]

{ #category : #accessing }
BufSCallExp >> subexpressions [

	^ subexpressions
]

{ #category : #accessing }
BufSCallExp >> subexpressions: anObject [

	subexpressions := anObject
]
