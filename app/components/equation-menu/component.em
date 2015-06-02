class EquationMenuComponent extends Ember.Component

	action: 'insertLatex'

	actions:
		insertLatex: (latex) -> 
			@sendAction 'action',latex

`export default EquationMenuComponent`