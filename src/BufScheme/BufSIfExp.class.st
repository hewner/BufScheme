Class {
	#name : #BufSIfExp,
	#superclass : #BufSAstCompoundExp,
	#category : #BufScheme
}

{ #category : #compilation }
BufSIfExp >> generateIR: aIRBuilder [

	self components second generateIR: aIRBuilder.
	aIRBuilder jumpAheadTo: #elsebranch if: false.
	self components third generateIR: aIRBuilder.
	aIRBuilder 
		jumpAheadTo: #endif;
		jumpAheadTarget: #elsebranch.
	self components fourth generateIR: aIRBuilder.
	aIRBuilder jumpAheadTarget: #endif
	
		
	
	
]
