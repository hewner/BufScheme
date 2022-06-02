Class {
	#name : #BufSParser,
	#superclass : #Object,
	#instVars : [
		'tokens',
		'inProgressLists'
	],
	#category : #BufScheme
}

{ #category : #parsing }
BufSParser >> addToCurrentList: aAstNode [

	self currentList add: aAstNode
		
	
	
]

{ #category : #parsing }
BufSParser >> currentList [

	^inProgressLists last
		
	
	
]

{ #category : #parsing }
BufSParser >> handleToken: aToken [

	aToken isNumToken ifTrue: [ self addToCurrentList: (BufSAstLitExp fromNumToken: aToken). ^self ].
	aToken isStringToken ifTrue: [ self addToCurrentList: (BufSAstLitExp fromStringToken: aToken). ^self ].
	aToken isSymbolToken ifTrue: [ self addToCurrentList: (BufSAstVarExp fromSymbolToken: aToken). ^self].
	(aToken isSpecial: '(') ifTrue: [ inProgressLists add: OrderedCollection new. ^self].
	(aToken isSpecial: ')') ifTrue: [ | doneList |
		doneList := inProgressLists removeLast.
		self addToCurrentList: (BufSAstCompoundExp createFromList: doneList). ^self
		].
	BufSParseError new signal: 'Unknown token'.
		
	
	
]

{ #category : #parsing }
BufSParser >> parseString: schemeString [
	
	tokens := BufSToken tokenizeString: schemeString.
	inProgressLists := OrderedCollection with: OrderedCollection new.
	[ 
		tokens isEmpty ifTrue: [ BufSParseError signal: 'ran out of tokens (unmatched parens?)' ].
		self handleToken: tokens removeFirst.
	 ] doWhileTrue: [  inProgressLists size > 1 ] .
	
	tokens ifNotEmpty: [ BufSParseError signal:  'unused tokens'].
	^inProgressLists first first
	
]
