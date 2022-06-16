Class {
	#name : #BufSLambdaExpTest,
	#superclass : #TestCase,
	#category : #BufScheme
}

{ #category : #tests }
BufSLambdaExpTest >> testDecompile [

	self assert: (BufSAstNode parseToAst: '(lambda (x y) x y)') decompile equals: '(lambda (x y) x y)'
]

{ #category : #tests }
BufSLambdaExpTest >> testLambdaEnv [

	self assert: (SchemeUniverse evalScheme: '((let ((x 2)) (lambda () x)))') equals: 2.
]

{ #category : #tests }
BufSLambdaExpTest >> testLambdaMultibody [

	self assert: (SchemeUniverse evalScheme: '((lambda (x y) x y) 1 2)') equals: 2.
]

{ #category : #tests }
BufSLambdaExpTest >> testLambdaSuperBasic [

	self assert: (SchemeUniverse evalScheme: '(lambda (p) (+ 1 p))') class equals: BufSClosure.
	self assert: (SchemeUniverse evalScheme: '((lambda (p) (+ 1 p)) 2)') equals: 3.
]
