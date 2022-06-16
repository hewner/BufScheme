Class {
	#name : #BufSLetExp,
	#superclass : #BufSAstCompoundExp,
	#instVars : [
		'varPairs',
		'bodies'
	],
	#category : #BufScheme
}

{ #category : #'instance creation' }
BufSLetExp class >> fromTokens: tokens [
 
	|pairs|
	pairs := tokens second collect: [ :each |
		OrderedCollection 
			with: each first data
			with: (BufSAstNode parseExpression: each second) ].
	^self new
		varPairs: pairs;
		bodies: (tokens 
			collect: [: each | BufSAstNode parseExpression: each]
			from: 3 to: tokens size);
		yourself
]

{ #category : #accessing }
BufSLetExp >> bodies [

	^ bodies
]

{ #category : #accessing }
BufSLetExp >> bodies: anObject [

	bodies := anObject
]

{ #category : #compilation }
BufSLetExp >> decompile [

	| pairsDecomp |
	pairsDecomp := varPairs collect: [ :each | '(' , each first , ' ' , each second decompile , ')'].

	^'(let (' , (' ' join: pairsDecomp) , ') ' , (' ' join: (bodies collect: [:each| each decompile])) , ')'
	
]

{ #category : #compilation }
BufSLetExp >> generateIR: aIRBuilder [

	aIRBuilder
		pushReceiver;
		send: #pushExtendingEnvironment;
		popTop.
	varPairs do: [ :each | 
		aIRBuilder
			pushReceiver;
			pushLiteral: each first.
		each second generateIR: aIRBuilder.
		aIRBuilder
			send: #addEnvMapping:to:;
			popTop.].
	self generateForBodies: bodies AndBuilder: aIRBuilder.
	aIRBuilder
		pushReceiver;
		send: #popEnv;
		popTop.
]

{ #category : #accessing }
BufSLetExp >> varPairs [

	^ varPairs
]

{ #category : #accessing }
BufSLetExp >> varPairs: anObject [

	varPairs := anObject
]
