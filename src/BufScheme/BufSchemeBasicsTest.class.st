Class {
	#name : #BufSchemeBasicsTest,
	#superclass : #TestCase,
	#instVars : [
		'parser'
	],
	#category : #BufScheme
}

{ #category : #running }
BufSchemeBasicsTest >> setUp [
	super setUp.
	parser := BufSParser new.
]

{ #category : #tests }
BufSchemeBasicsTest >> testBadTokenize [

	self should: [ BufSToken tokenizeString: '{' ] raise: BufSParseException.

]

{ #category : #tests }
BufSchemeBasicsTest >> testExtraTokens [

	"we should allow extra whitespace"
	self shouldnt: [parser parseString: '   foobar   '] raise: BufSParseException.
	"we should not allow extra tokens"
	self should: [ parser parseString: 'foobar foobar'] raise: BufSParseException


]

{ #category : #tests }
BufSchemeBasicsTest >> testParseNum [

	|result|
	result := parser parseString: '123'.
	self assert: result litValue equals: 123.


]

{ #category : #tests }
BufSchemeBasicsTest >> testParseVarExp [

	|result|
	result := parser parseString: 'foobar'.
	self assert: result name equals: 'foobar'.


]

{ #category : #tests }
BufSchemeBasicsTest >> testTokenizeNum [

	| result |
	result := BufSToken tokenizeString: '123'.
	self assert: result size equals: 1.
	result := result at: 1.
	self assert: result isNumToken.
	self assert: result data equals: '123'.
]

{ #category : #tests }
BufSchemeBasicsTest >> testTokenizeSpecials [

	| result |
	result := BufSToken tokenizeString: '()''"'.
	self assert: result size equals: 4.
	self assert: ((result at: 1) isSpecial: '(').
	self assert: ((result at: 2) isSpecial: ')').
	self assert: ((result at: 3) isSpecial: '''').
	self assert: ((result at: 4) isSpecial: '"').
]

{ #category : #tests }
BufSchemeBasicsTest >> testTokenizeSymbol [

	| result |
	result := BufSToken tokenizeString: 'a123'.
	self assert: result size equals: 1.
	result := result at: 1.
	self assert: result isSymbolToken.
	self assert: result data equals: 'a123'.
]
