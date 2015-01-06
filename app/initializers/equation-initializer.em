`import SizeService from 'math-flows-client/services/size'`

initializer =
	name: 'equation'
	initialize: (container,application) ->
		#application.deferReadiness()
		WebFont.load
			custom:
				families: ['MathJax_Main:n4,i4', 'MathJax_Math:i4', 'MathJax_Size1:n4', 'MathJax_Size2:n4', 'MathJax_Size3:n4', 'MathJax_Size4:n4', 'MathJax_AMS:n4']
				testStrings: {'MathJax_Size2:n4': '\u2211\u22C2\u2A00\u220F\u22C3\u2A02\u2210\u2A06\u2A01\u222B\u22C1\u2A04'}
		#	active: -> application.advanceReadiness()
		
		#application.register 'service:size', SizeService, {singleton: true}
		#application.inject 'controller', 'size', 'service:size'
		#symbolSizeConfig = new eqEd.SymbolSizeConfiguration()
		#clipboard = new eqEd.Clipboard()
		#inializePropertyHooks(symbolSizeConfig)
		#setupKeyboardEvents(symbolSizeConfig, clipboard)
		#setupMenuEvents(symbolSizeConfig)

`export default initializer`