HandlesEquations = Ember.Mixin.create

	actions:
		activeEquationLine: (mathquill) ->
			@sendAction 'activeEquationLine',mathquill

		inactiveEquationLine: (mathquill) ->
			@sendAction 'inactiveEquationLine',mathquill

		contentsClicked: ->
			@sendAction 'contentsClicked'

	contentsClicked: 'contentsClicked'
	activeEquationLine: 'activeEquationLine'
	inactiveEquationLine: 'inactiveEquationLine'

`export default HandlesEquations`