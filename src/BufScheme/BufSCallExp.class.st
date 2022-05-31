Class {
	#name : #BufSCallExp,
	#superclass : #BufSAstCompoundExp,
	#category : #BufScheme
}

{ #category : #compilation }
BufSCallExp >> generateIR: aIRBuilder [

	| paramList invokable |
	paramList := self components copy.
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
