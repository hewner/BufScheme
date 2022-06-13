Class {
	#name : #BufSLambdaExp,
	#superclass : #BufSAstCompoundExp,
	#instVars : [
		'params',
		'compiledBodies'
	],
	#category : #BufScheme
}

{ #category : #'instance creation' }
BufSLambdaExp class >> fromTokens: tokens [
 
	^self new
		params: (tokens second collect: [:each | each data ]);
		bodies: (tokens collect: [ : each | BufSAstNode parseExpression: each ] from: 3 to: tokens size);
		yourself
		
		
		
]

{ #category : #accessing }
BufSLambdaExp >> bodies: astList [
	
	| builder |

	builder := IRBuilder new.
	builder numArgs: 0.
	self generateForBodies: astList AndBuilder: builder.
	builder returnTop.
	compiledBodies := builder ir compiledMethod.
]

{ #category : #compilation }
BufSLambdaExp >> generateIR: aIRBuilder [

	aIRBuilder
		pushLiteral: BufSClosure ;
		pushLiteral: params ;
		pushLiteral: compiledBodies ;
		pushReceiver ;
		send: #currentEnv ;
		send: #newClosureWithNames:code:andEnvironment:
		
	
]

{ #category : #accessing }
BufSLambdaExp >> params [

	^ params
]

{ #category : #accessing }
BufSLambdaExp >> params: anObject [

	params := anObject
]
