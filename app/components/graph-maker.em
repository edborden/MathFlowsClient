class GraphMakerComponent extends Ember.Component
	
	classNames: ['calculator']

	registerCalculator: 'registerCalculator'

	didInsertElement: ->
		calculator = Desmos.Calculator @element
		calculator.setExpression({id:'graph1', latex:'y=x^2'})
		@sendAction 'registerCalculator',calculator

`export default GraphMakerComponent`