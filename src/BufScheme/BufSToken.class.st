Class {
	#name : #BufSToken,
	#superclass : #Object,
	#instVars : [
		'type',
		'data',
		'start',
		'end'
	],
	#category : #BufScheme
}

{ #category : #'as yet unclassified' }
BufSToken class >> consumeSpaces: aStream [

	self tryToEat: self spaceRegex typedAs: #ignored from: aStream
]

{ #category : #'as yet unclassified' }
BufSToken class >> nextTokenFromStream: aStream [

	| maybeToken returnBlock |
	maybeToken := self
		              tryToEat: self numRegex
		              typedAs: #num
		              from: aStream.
	returnBlock := [ 
	               self consumeSpaces: aStream.
	               ^ maybeToken ].
	maybeToken ifNotNil: returnBlock.
	maybeToken := self
		              tryToEat: self stringRegex
		              typedAs: #string
		              from: aStream.
	maybeToken ifNotNil: returnBlock.
	maybeToken := self
		              tryToEat: self symbolRegex
		              typedAs: #symbol
		              from: aStream.
	maybeToken ifNotNil: returnBlock.
	maybeToken := self
		              tryToEat: self specialCharRegex
		              typedAs: #special
		              from: aStream.
	maybeToken ifNotNil: returnBlock.
	BufSParseError new signal: 'characters do not match any token'
]

{ #category : #regexes }
BufSToken class >> numRegex [
	"regex identifying a BufScheme number"	
			
	^'\d+' asRegex 
]

{ #category : #regexes }
BufSToken class >> spaceRegex [
	"regex identifying BufScheme whitespace (skipped, but seperates tokens)"	
			
	^'\s+' asRegex 
]

{ #category : #regexes }
BufSToken class >> specialCharRegex [
	"symbols with special scheme meaning"	
			
	^'[()'']' asRegex 
]

{ #category : #regexes }
BufSToken class >> stringRegex [
	"basically eat everything till the closing quote"	
			
	^'".*"' asRegex 
]

{ #category : #regexes }
BufSToken class >> symbolRegex [
	"regex identifying a BufScheme (unquoted) symbol"	
			
	^'[[:alnum:]+\-*/]+' asRegex 
]

{ #category : #accessing }
BufSToken class >> tokenizeList: aStream toCollection: aCollection [

	| next |
	aStream atEnd ifTrue: [ ^#end ].
	next := (self nextTokenFromStream: aStream).
	(next isSpecial: ')') ifTrue: [ ^#closeparen ].
	(next isSpecial: '(') 
		ifTrue: [ | subcollection subResult |  
			subcollection := OrderedCollection  new.
			subResult := self tokenizeList: aStream toCollection: subcollection.
			subResult = #end ifTrue: [ BufSParseError signal: 'unmatched parens' ].
			aCollection add: subcollection ]
		ifFalse: [ aCollection add: next ].
	^self tokenizeList: aStream toCollection: aCollection
]

{ #category : #'as yet unclassified' }
BufSToken class >> tokenizeString: aString [

	|result stream|
	result := OrderedCollection new.
	stream := aString readStream.
	self consumeSpaces: stream.
	(self tokenizeList: stream toCollection: result) = #end ifFalse: [ BufSParseError signal: 'extra close paren' ].
	^result
]

{ #category : #'as yet unclassified' }
BufSToken class >> tryToEat: aRegex typedAs: aSymbol from: aStream [
	
	|oldPos|
	oldPos := aStream position.
	(aRegex matchesStreamPrefix: aStream) ifTrue: [ 
		^self new newTokenType: aSymbol 
					 data: (aRegex subexpression: 1)
					 from: oldPos
					 to: aStream position ].
	aStream position: oldPos.
	^nil
				
	
]

{ #category : #accessing }
BufSToken >> data [

	^ data
]

{ #category : #accessing }
BufSToken >> end [

	^ end
]

{ #category : #testing }
BufSToken >> isNumToken [

	^type = #num
]

{ #category : #testing }
BufSToken >> isSpecial: aChar [

	^type = #special and: data = aChar
]

{ #category : #testing }
BufSToken >> isStringToken [

	^type = #string
]

{ #category : #testing }
BufSToken >> isSymbolToken [

	^type = #symbol
]

{ #category : #'instance creation' }
BufSToken >> newTokenType: symbol data: aString from: startIndex to:  endIndex [
	"Creates a new token.  Probably best to call this from clas methods."

	type := symbol.
	data := aString.
	start := startIndex.
	end := endIndex.

]

{ #category : #accessing }
BufSToken >> start [

	^ start
]

{ #category : #accessing }
BufSToken >> type [

	^ type
]
