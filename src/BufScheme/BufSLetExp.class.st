Class {
	#name : #BufSLetExp,
	#superclass : #BufSAstCompoundExp,
	#category : #BufScheme
}

{ #category : #compilation }
BufSLetExp >> generateIR: aIRBuilder [

	self components second do: [ :each |
		aIRBuilder
			pushReceiver;
			pushLiteral: each first name.
		each second generateIR: aIRBuilder.
		aIRBuilder
			send: #addEnvMapping:To:;
			popTop. ].
	self components third generateIR: aIRBuilder.
		
	
]
