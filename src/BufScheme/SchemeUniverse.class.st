Class {
	#name : #SchemeUniverse,
	#superclass : #Object,
	#instVars : [
		'globals'
	],
	#category : #BufScheme
}

{ #category : #globals }
SchemeUniverse >> getGlobal: aSymbol [
	
	^globals at: aSymbol
]

{ #category : #initialization }
SchemeUniverse >> initialize [
			
	globals := Dictionary new.
]

{ #category : #globals }
SchemeUniverse >> setGlobal: aSymbol toValue: aValue [
			
	globals at: aSymbol put: aValue
]
