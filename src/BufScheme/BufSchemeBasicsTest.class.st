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

	self should: [ BufSToken tokenizeString: '{' ] raise: BufSParseError.

]

{ #category : #'tests-compilation' }
BufSchemeBasicsTest >> testBasicCallCompilation [

	|ast method universe|
	ast := parser parseString: '(+ 1 2)'.
	method := ast toCompiledMethod.
	universe := SchemeUniverse new.
	self assert: (method valueWithReceiver: universe arguments: Array new) equals: 3.
	ast := parser parseString: '(+ (+ 3 4 5) 2)'.
	method := ast toCompiledMethod.
	self assert: (method valueWithReceiver: universe arguments: Array new) equals: 14.
]

{ #category : #tests }
BufSchemeBasicsTest >> testExtraTokens [

	"we should allow extra whitespace"
	self shouldnt: [parser parseString: '   foobar   '] raise: BufSParseError.
	"we should not allow extra tokens"
	self should: [ parser parseString: 'foobar foobar'] raise: BufSParseError


]

{ #category : #'tests-compilation' }
BufSchemeBasicsTest >> testGlobalCompilation [

	|ast method universe|
	ast := parser parseString: 'foobar'.
	method := ast toCompiledMethod.
	universe := SchemeUniverse new.
	universe setGlobal: 'foobar' toValue: 100.
	self assert: (method valueWithReceiver: universe arguments: Array new) equals: 100.
	self should: [ method valueWithReceiver: SchemeUniverse new arguments: Array new] raise: BufSRuntimeError.
]

{ #category : #'tests-compilation' }
BufSchemeBasicsTest >> testIfCompilation [

	|ast method universe|
	ast := parser parseString: '(if true 1 2)'.
	method := ast toCompiledMethod.
	universe := SchemeUniverse new.
	self assert: (method valueWithReceiver: universe arguments: Array new) equals: 1.
	ast := parser parseString: '(if false 1 2)'.
	method := ast toCompiledMethod.
	self assert: (method valueWithReceiver: universe arguments: Array new) equals: 2.
	ast := parser parseString: '(if true 1 (error "dont eval this"))'.
	method := ast toCompiledMethod.
	universe := SchemeUniverse new.
	self assert: (method valueWithReceiver: universe arguments: Array new) equals: 1.
	ast := parser parseString: '(if false (error "dont eval this") 2)'.
	method := ast toCompiledMethod.
	self assert: (method valueWithReceiver: universe arguments: Array new) equals: 2.
]

{ #category : #'tests-compilation' }
BufSchemeBasicsTest >> testLiteralCompilation [

	|ast method universe|
	ast := parser parseString: '123'.
	method := ast toCompiledMethod.
	universe := SchemeUniverse new.
	self assert: (method valueWithReceiver: universe arguments: Array new) equals: 123
]

{ #category : #tests }
BufSchemeBasicsTest >> testParseList [

	|result result2|
	result := (parser parseString: '(foo 1 2)') components.
	self assert: (result at: 1) name equals: 'foo'.
	self assert: (result at: 2) litValue equals: 1.
	self assert: (result at: 3) litValue equals: 2.
	
	result := (parser parseString: '((foo 3 4) 1 2)') components.
	result2 := (result at: 1) components.
	self assert: (result2 at: 1) name equals: 'foo'.
	self assert: (result2 at: 2) litValue equals: 3.
	self assert: (result2 at: 3) litValue equals: 4.	
	self assert: (result at: 2) litValue equals: 1.
	self assert: (result at: 3) litValue equals: 2.

]

{ #category : #tests }
BufSchemeBasicsTest >> testParseNum [

	|result|
	result := parser parseString: '123'.
	self assert: result litValue equals: 123.


]

{ #category : #tests }
BufSchemeBasicsTest >> testParseString [

	|result|
	result := parser parseString: '"hello"'.
	self assert: result litValue equals: 'hello'.


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
	result := BufSToken tokenizeString: '()''""'.
	self assert: result size equals: 4.
	self assert: ((result at: 1) isSpecial: '(').
	self assert: ((result at: 2) isSpecial: ')').
	self assert: ((result at: 3) isSpecial: '''').
	self assert: ((result at: 4) isStringToken).
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
