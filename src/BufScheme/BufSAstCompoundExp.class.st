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

	"TODO: not every compond exp is a call"
	
	^BufSCallExp new components: listOfAstNodes 
]

{ #category : #accessing }
BufSAstCompoundExp >> components [

	^ components
]

{ #category : #accessing }
BufSAstCompoundExp >> components: anObject [

	components := anObject
]
