Class {
	#name : #BufSPrim,
	#superclass : #Object,
	#instVars : [
		'name',
		'universe'
	],
	#category : #BufScheme
}

{ #category : #'instance creation' }
BufSPrim class >> newWithName: aString andUniverse: aUniverse [
	
	^self new initializeWithName: aString andUniverse: aUniverse
]

{ #category : #initialization }
BufSPrim >> initializeWithName: aString andUniverse: aUniverse [

	name := aString.
	universe := aUniverse.
]

{ #category : #invoking }
BufSPrim >> invokeWithArguments: anArray [
			
	name = '+' ifTrue: [ ^( anArray inject: 0 into: [ :sum :each | sum + each ]) ].
	Error signal: 'unknown prim'.
]
