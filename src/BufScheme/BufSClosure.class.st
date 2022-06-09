Class {
	#name : #BufSClosure,
	#superclass : #Object,
	#instVars : [
		'names',
		'environment',
		'code'
	],
	#category : #BufScheme
}

{ #category : #'instance creation' }
BufSClosure class >> newClosureWithNames: paramNames code: compiledMethod andEnvironment: aEnvironment [

	^self new
		names: paramNames;
		code: compiledMethod;
		environment: aEnvironment;
		yourself
]

{ #category : #accessing }
BufSClosure >> code: anObject [

	code := anObject
]

{ #category : #accessing }
BufSClosure >> environment: anObject [

	environment := anObject
]

{ #category : #invoking }
BufSClosure >> invokeWithArguments: aCollection onUniverse: aUniverse [
	
	| result |
	
	aUniverse
		pushEnv: environment;
		pushExtendingEnvironment.
	aCollection doWithIndex: [  :each :index |
		aUniverse addEnvMapping: (names at: index) to: each ].
	result := code valueWithReceiver: aUniverse arguments: #().
	aUniverse popEnv; popEnv.
	^result
	
]

{ #category : #accessing }
BufSClosure >> names: anObject [

	names := anObject
]
