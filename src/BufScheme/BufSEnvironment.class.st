Class {
	#name : #BufSEnvironment,
	#superclass : #Object,
	#instVars : [
		'mappings',
		'parent'
	],
	#category : #BufScheme
}

{ #category : #'instance creation' }
BufSEnvironment class >> newExtending: aParent [

	^self new initializeExtending: aParent
]

{ #category : #'instance creation' }
BufSEnvironment class >> rootEnvironment [ 

	^self newExtending: nil
]

{ #category : #accessing }
BufSEnvironment >> atMapping: aString put: aValue [

	mappings at: aString put: aValue
]

{ #category : #accessing }
BufSEnvironment >> getMapping: aName ifAbsent: aBlock [

	mappings at: aName ifAbsent: [ ^parent ifNil: aBlock ifNotNil: [ parent getMapping: aName ifAbsent: aBlock ] ]
]

{ #category : #initialization }
BufSEnvironment >> initializeExtending: aParentEnvironment [

	mappings := Dictionary new.
	parent := aParentEnvironment 
]
