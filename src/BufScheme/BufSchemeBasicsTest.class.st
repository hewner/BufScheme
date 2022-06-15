Class {
	#name : #BufSchemeBasicsTest,
	#superclass : #TestCase,
	#category : #BufScheme
}

{ #category : #tests }
BufSchemeBasicsTest >> testBadTokenize [

	self should: [ BufSToken tokenizeString: '{' ] raise: BufSParseError.

]

{ #category : #'tests-compilation' }
BufSchemeBasicsTest >> testBasicCallCompilation [

	|universe|
	universe := SchemeUniverse new.
	self assert: (universe evalScheme: '(+ 1 2)') equals: 3.
	self assert: (universe evalScheme: '(+ (+ 3 4 5) 2)') equals: 14.
	 
]

{ #category : #tests }
BufSchemeBasicsTest >> testExtraTokens [

	"we should allow extra whitespace"
	self shouldnt: [BufSAstNode parseToAst: '   foobar   '] raise: BufSParseError.
	"we should not allow extra tokens"
	self should: [ BufSAstNode parseToAst: 'foobar foobar'] raise: BufSParseError


]

{ #category : #'tests-compilation' }
BufSchemeBasicsTest >> testGlobalCompilation [

	|universe|
	universe := SchemeUniverse new.
	universe setGlobal: 'foobar' toValue: 100.
	self assert: (universe evalScheme: 'foobar') equals: 100.
	self should: [SchemeUniverse new evalScheme: 'foobar'] raise: BufSRuntimeError.
]

{ #category : #'tests-compilation' }
BufSchemeBasicsTest >> testIfCompilation [

	|universe|
	universe := SchemeUniverse new.
	self assert: (universe evalScheme: '(if true 1 2)') equals: 1.
	self assert: (universe evalScheme: '(if false 1 2)') equals: 2.
	self assert: (universe evalScheme: '(if true 1 (error "dont eval this"))') equals: 1.
	self assert: (universe evalScheme: '(if false (error "dont eval this") 2)') equals: 2.
]

{ #category : #'tests-compilation' }
BufSchemeBasicsTest >> testLiteralCompilation [

	| universe|
	universe := SchemeUniverse new.
	self assert: (universe evalScheme: '123') equals: 123.
	self assert: (universe evalScheme: '"123"') equals: '123'.
]

{ #category : #tests }
BufSchemeBasicsTest >> testParseList [

	|result result2|
	result := (BufSAstNode parseToAst: '(foo 1 2)') subexpressions .
	self assert: (result at: 1) name equals: 'foo'.
	self assert: (result at: 2) litValue equals: 1.
	self assert: (result at: 3) litValue equals: 2.
	
	result := (BufSAstNode parseToAst: '((foo 3 4) 1 2)') subexpressions.
	result2 := (result at: 1) subexpressions.
	self assert: (result2 at: 1) name equals: 'foo'.
	self assert: (result2 at: 2) litValue equals: 3.
	self assert: (result2 at: 3) litValue equals: 4.	
	self assert: (result at: 2) litValue equals: 1.
	self assert: (result at: 3) litValue equals: 2.

]

{ #category : #tests }
BufSchemeBasicsTest >> testParseNum [

	|result|
	result := BufSAstNode parseToAst: '123'.
	self assert: result litValue equals: 123.


]

{ #category : #tests }
BufSchemeBasicsTest >> testParseString [

	|result|
	result := BufSAstNode parseToAst: '"hello"'.
	self assert: result litValue equals: 'hello'.


]

{ #category : #tests }
BufSchemeBasicsTest >> testParseVarExp [

	|result|
	result := BufSAstNode parseToAst: 'foobar'.
	self assert: result name equals: 'foobar'.


]

{ #category : #tests }
BufSchemeBasicsTest >> testTokenizeList [ 

	| result |
	result := BufSToken tokenizeString: '(a 1 2)'.
	self assert: result size equals: 1.
	result := result first.
	self assert: (result at: 1) data equals: 'a'.
	self assert: (result at: 2) data equals: '1'.
	self assert: (result at: 3) data equals: '2'.



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
	self assert: result size equals: 3.
	self assert: (result at: 1) isEmpty.
	self assert: ((result at: 2) isSpecial: '''').
	self assert: ((result at: 3) isStringToken).
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
