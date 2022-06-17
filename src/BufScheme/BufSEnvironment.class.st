Class {
	#name : #BufSEnvironment,
	#superclass : #Object,
	#instVars : [
		'mappings',
		'parent'
	],
	#category : #BufScheme
}

{ #category : #gui }
BufSEnvironment class >> keyValueTable: aBuilder [

	^ aBuilder newTable
		  addColumn: (SpStringTableColumn
				   title: 'Key'
				   evaluated: [ :each | 
					   StObjectPrinter asTruncatedTextFrom: each key ]) beSortable;
		  addColumn: (SpStringTableColumn
				   title: 'Value'
				   evaluated: [ :each | 
					   StObjectPrinter asTruncatedTextFrom: each value ]) beSortable;
		  yourself
]

{ #category : #'instance creation' }
BufSEnvironment class >> newExtending: aParent [

	^self new initializeExtending: aParent
]

{ #category : #'instance creation' }
BufSEnvironment class >> rootEnvironment [ 

	^self newExtending: nil
]

{ #category : #gui }
BufSEnvironment >> allAssociations [

	| collection |	
	collection := OrderedCollection withAll: mappings associations.
	parent ifNotNil: [ collection addAll: parent allAssociations ].
	^collection
]

{ #category : #accessing }
BufSEnvironment >> atMapping: aString put: aValue [

	mappings at: aString put: aValue
]

{ #category : #accessing }
BufSEnvironment >> getMapping: aName ifAbsent: aBlock [

	^mappings at: aName ifAbsent: [ ^parent ifNil: aBlock ifNotNil: [ parent getMapping: aName ifAbsent: aBlock ] ]
]

{ #category : #initialization }
BufSEnvironment >> initializeExtending: aParentEnvironment [

	mappings := Dictionary new.
	parent := aParentEnvironment 
]

{ #category : #gui }
BufSEnvironment >> inspectionItems: aBuilder [

	<inspectorPresentationOrder: 10 title: 'Mappings'>
	| checkbox keyValueTable layout |
	
	keyValueTable := self class keyValueTable: aBuilder.
	checkbox := aBuilder newCheckBox
		label: 'Display parent fields?';
		whenChangedDo: [  :state | state 
			ifTrue: [ keyValueTable items: self allAssociations  ]
			ifFalse: [ keyValueTable items: mappings associations  ] ];
		state: true;	
		yourself.
				
	layout := aBuilder newBoxLayoutTopToBottom
		add: checkbox expand: false;
		add: keyValueTable expand: true;
		yourself.
		
	^aBuilder newPresenter layout: layout; yourself
]
