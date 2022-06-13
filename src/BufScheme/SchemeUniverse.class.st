Class {
	#name : #SchemeUniverse,
	#superclass : #Object,
	#instVars : [
		'globals',
		'environments'
	],
	#category : #BufScheme
}

{ #category : #'as yet unclassified' }
SchemeUniverse class >> evalScheme: aString [

	^self new evalScheme: aString
]

{ #category : #environments }
SchemeUniverse >> addEnvMapping: aString to: aValue [

	self currentEnv atMapping: aString put: aValue
]

{ #category : #prims }
SchemeUniverse >> callPrim: nameSymbol withArguments: anArray [

	^self perform: nameSymbol with: anArray 
]

{ #category : #environments }
SchemeUniverse >> currentEnv [

	^environments last
]

{ #category : #'as yet unclassified' }
SchemeUniverse >> evalScheme: aString [

	|ast method |

	ast := BufSAstNode parseToAst: aString.
	method := ast toCompiledMethod.
	^ method valueWithReceiver: self arguments: Array new.
]

{ #category : #environments }
SchemeUniverse >> getEnvValue: aString [
	
	^self currentEnv getMapping: aString ifAbsent: [ self getGlobal: aString ]
]

{ #category : #environments }
SchemeUniverse >> getGlobal: aString [

	^ globals at: aString ifAbsent: [ 
		  (self isPrim: aString)
			  ifTrue: [ BufSPrim newWithName: aString ]
			  ifFalse: [ BufSRuntimeError signal: 'name lookup failed' ] ]
]

{ #category : #initialization }
SchemeUniverse >> initialize [
			
	globals := Dictionary new.
	globals at: 'true' put: true.
	globals at: 'false' put: false.
	environments := OrderedCollection with: BufSEnvironment rootEnvironment
]

{ #category : #'as yet unclassified' }
SchemeUniverse >> inspectionSchemeEval [
	"This provides an editable comment of the current class"
	<inspectorPresentationOrder: 1000 title: 'Scheme Eval'>
	
	| presenter entryBox  outputBox layout |
	presenter := SpPresenter new.
	layout :=  SpBoxLayout newTopToBottom.
	outputBox := (presenter newText text: 'hello world2').
	outputBox text: 'Scheme output appears here'.
	outputBox beNotEditable.
	layout add: outputBox.
	entryBox := presenter newTextInput text: '(+ 1 2)'.
	entryBox 
		whenSubmitDo: [ :text | | result | 
			result := self evalScheme: text.
			outputBox text: outputBox text , Character cr asString ,  result asString.
			 ].
	
	
	layout add: entryBox expand: false.
	presenter layout: layout.
	^presenter
	
]

{ #category : #prims }
SchemeUniverse >> isPrim: aName [

	^#('+') includes: aName
	
]

{ #category : #environments }
SchemeUniverse >> popEnv [

	environments removeLast 
]

{ #category : #environments }
SchemeUniverse >> pushEnv: environment [

	environments add: environment
]

{ #category : #environments }
SchemeUniverse >> pushExtendingEnvironment [

	self pushEnv: (BufSEnvironment newExtending: (self currentEnv))
]

{ #category : #environments }
SchemeUniverse >> setGlobal: aSymbol toValue: aValue [
			
	globals at: aSymbol put: aValue
]
