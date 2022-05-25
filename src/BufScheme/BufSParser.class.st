Class {
	#name : #BufSParser,
	#superclass : #Object,
	#instVars : [
		'tokens'
	],
	#category : #BufScheme
}

{ #category : #parsing }
BufSParser >> handleToken: aToken [

	aToken isNumToken ifTrue: [ ^ BufSAstLitExp fromNumToken: aToken ].
	aToken isSymbolToken ifTrue: [ ^ BufSAstVarExp fromSymbolToken: aToken ].
	BufSParseException new signal: 'Unknown token'.
		
	
	
]

{ #category : #parsing }
BufSParser >> parseString: schemeString [
	
	|result|
	tokens := BufSToken tokenizeString: schemeString.
	result := self handleToken: tokens removeFirst.
	tokens ifNotEmpty: [ BufSParseException signal:  'unused tokens'].
	^result
	
]
