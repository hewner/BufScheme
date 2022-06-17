Class {
	#name : #BufSClosure,
	#superclass : #Object,
	#instVars : [
		'environment',
		'code'
	],
	#category : #BufScheme
}

{ #category : #'instance creation' }
BufSClosure class >> newClosureWithCode: exp andEnvironment: aEnvironment [

	^self new
		code: exp;
		environment: aEnvironment;
		yourself
]

{ #category : #accessing }
BufSClosure >> code: anObject [

	code := anObject
]

{ #category : #accessing }
BufSClosure >> codeString: schemeString [

	| newAst |

	newAst := BufSAstNode parseToAst: schemeString.
	newAst isLambdaExp ifFalse: [ BufSParseError signal: 'cant modify a closure to non-closure value' ].
	self code: newAst.
]

{ #category : #accessing }
BufSClosure >> environment: anObject [

	environment := anObject
]

{ #category : #gui }
BufSClosure >> inspectionDecompile: aBuilder [

	<inspectorPresentationOrder: 10 title: 'Scheme'>

	^aBuilder newText
		text: code decompile;
		whenSubmitDo: [ :codeString | self codeString: codeString  ];
		yourself
]

{ #category : #invoking }
BufSClosure >> invokeWithArguments: aCollection onUniverse: aUniverse [
	
	| result |
	
	aUniverse
		pushEnv: environment;
		pushExtendingEnvironment.
	aCollection doWithIndex: [  :each :index |
		aUniverse addEnvMapping: (code params at: index) to: each ].
	result := code compiledBodies valueWithReceiver: aUniverse arguments: #().
	aUniverse popEnv; popEnv.
	^result
	
]
