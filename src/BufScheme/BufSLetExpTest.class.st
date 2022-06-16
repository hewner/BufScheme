Class {
	#name : #BufSLetExpTest,
	#superclass : #TestCase,
	#instVars : [
		'universe'
	],
	#category : #BufScheme
}

{ #category : #'tests-compilation' }
BufSLetExpTest >> setUp [

	universe := SchemeUniverse new.

]

{ #category : #'tests-compilation' }
BufSLetExpTest >> testDecompile [

	self assert: (BufSAstNode parseToAst: '(let ((x 1) (y 2)) x y)') decompile equals: '(let ((x 1) (y 2)) x y)'
]

{ #category : #'tests-compilation' }
BufSLetExpTest >> testLetFallback [

	|method universe|
	universe := SchemeUniverse new.
	self assert: (universe evalScheme: '(let ((y 2)) (let ((x 1)) y))') equals: 2

]

{ #category : #'tests-compilation' }
BufSLetExpTest >> testLetMultiBody [

	self assert: (universe evalScheme:  '(let ((y 2) (x 1)) x y)')  equals: 2.

]

{ #category : #'tests-compilation' }
BufSLetExpTest >> testLetSuperBasic [

	self assert: (universe evalScheme: '(let ((x 1)) x)') equals: 1.
	self assert: (universe evalScheme: '(let ((y 2) (x 1)) y)') equals: 2.

]

{ #category : #'tests-compilation' }
BufSLetExpTest >> testLetVarShadow [

	self assert: (universe evalScheme: '(let ((x 1)) (let ((x 2)) x))') equals: 2.
	self assert: (universe evalScheme: '(let ((x 1)) (let ((x 2)) x) x)') equals: 1.
]
