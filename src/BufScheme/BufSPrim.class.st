Class {
	#name : #BufSPrim,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #BufScheme
}

{ #category : #'instance creation' }
BufSPrim class >> newWithName: aString [

	^ self new initializeWithName: aString
]

{ #category : #initialization }
BufSPrim >> initializeWithName: aString [

	name := aString.
]

{ #category : #invoking }
BufSPrim >> invokeWithArguments: anArray onUniverse: aUniverse [
			
	name = '+' ifTrue: [ ^( anArray inject: 0 into: [ :sum :each | sum + each ]) ].
	name = 'error' ifTrue: [ BufSRuntimeError signal: anArray asString ].
	Error signal: 'unknown prim'.
]
