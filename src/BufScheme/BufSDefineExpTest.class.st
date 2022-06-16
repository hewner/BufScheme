Class {
	#name : #BufSDefineExpTest,
	#superclass : #TestCase,
	#category : #BufScheme
}

{ #category : #tests }
BufSDefineExpTest >> testDecompile [

	self assert: (BufSAstNode parseToAst: '(define x 1)') decompile equals: '(define x 1)'
]

{ #category : #tests }
BufSDefineExpTest >> testNonRootDefine [

	|universe|
	universe := SchemeUniverse new.
	universe evalScheme: '(define x 2)'.
	universe evalScheme: '(if true (define x 3) (define x 5))'.
	self assert: (universe evalScheme: 'x') equals: 2.
]

{ #category : #tests }
BufSDefineExpTest >> testRootDefine [

	|universe|
	universe := SchemeUniverse new.
	universe evalScheme: '(define plus3 (lambda (x) (+ x 3)))'.
	self assert: (universe evalScheme: '(plus3 4)') equals: 7
]
