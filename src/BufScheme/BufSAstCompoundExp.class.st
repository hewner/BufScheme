Class {
	#name : #BufSAstCompoundExp,
	#superclass : #BufSAstNode,
	#instVars : [
		'components'
	],
	#category : #BufScheme
}

{ #category : #'as yet unclassified' }
BufSAstCompoundExp class >> createFromList: listOfAstNodes [
			
	^self new components: listOfAstNodes 
]

{ #category : #accessing }
BufSAstCompoundExp >> components [

	^ components
]

{ #category : #accessing }
BufSAstCompoundExp >> components: anObject [

	components := anObject
]
