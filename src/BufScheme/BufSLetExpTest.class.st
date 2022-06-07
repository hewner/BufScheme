Class {
	#name : #BufSLetExpTest,
	#superclass : #TestCase,
	#category : #BufScheme
}

{ #category : #'tests-compilation' }
BufSLetExpTest >> testLetFallback [

	|method universe|
	universe := SchemeUniverse new.
	method := (BufSAstNode parseToAst: '(let ((y 2)) (let ((x 1)) y))') toCompiledMethod.
	self assert: (method valueWithReceiver: universe arguments: Array new) equals: 2.

]

{ #category : #'tests-compilation' }
BufSLetExpTest >> testLetMultiBody [

	|method universe|
	universe := SchemeUniverse new.
	method := (BufSAstNode parseToAst: '(let ((y 2) (x 1)) x y)') toCompiledMethod.
	self assert: (method valueWithReceiver: universe arguments: Array new) equals: 2.

]

{ #category : #'tests-compilation' }
BufSLetExpTest >> testLetSuperBasic [

	|ast method universe|
	ast := BufSAstNode parseToAst: '(let ((x 1)) x)'.
	method := ast toCompiledMethod.
	universe := SchemeUniverse new.
	self assert: (method valueWithReceiver: universe arguments: Array new) equals: 1.
	method := (BufSAstNode parseToAst: '(let ((y 2) (x 1)) y)') toCompiledMethod.
	self assert: (method valueWithReceiver: universe arguments: Array new) equals: 2.

]

{ #category : #'tests-compilation' }
BufSLetExpTest >> testLetVarShadow [

	|ast method universe|
	"ast := BufSAstNode parseToAst: '(let ((x 1)) (let ((x 2)) x))'.
	method := ast toCompiledMethod.
	universe := SchemeUniverse new.
	self assert: (method valueWithReceiver: universe arguments: Array new) equals: 2."
	universe := SchemeUniverse new.
	ast := BufSAstNode parseToAst: '(let ((x 1)) (let ((x 2)) x) x)'.
	method := ast toCompiledMethod.
	self assert: (method valueWithReceiver: universe arguments: Array new) equals: 1.

]
