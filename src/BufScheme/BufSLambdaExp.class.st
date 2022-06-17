Class {
	#name : #BufSLambdaExp,
	#superclass : #BufSAstCompoundExp,
	#instVars : [
		'params',
		'bodies',
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

	bodies := astList.
	
	builder := IRBuilder new.
	builder numArgs: 0.
	self generateForBodies: astList AndBuilder: builder.
	builder returnTop.
	compiledBodies := builder ir compiledMethod.
]

{ #category : #accessing }
BufSLambdaExp >> compiledBodies [
	
	^compiledBodies 
]

{ #category : #compilation }
BufSLambdaExp >> decompile [

	^'(lambda (' , (' ' join: params ) , ') ' , (' ' join: (bodies collect: [ : each | each decompile ])) , ')'
	
]

{ #category : #compilation }
BufSLambdaExp >> generateIR: aIRBuilder [

	aIRBuilder
		pushLiteral: BufSClosure ;
		pushLiteral: self ;
		pushReceiver ;
		send: #currentEnv ;
		send: #newClosureWithCode:andEnvironment:
		
	
]

{ #category : #accessing }
BufSLambdaExp >> isLambdaExp [ 

	^true
]

{ #category : #accessing }
BufSLambdaExp >> params [

	^ params
]

{ #category : #accessing }
BufSLambdaExp >> params: anObject [

	params := anObject
]
