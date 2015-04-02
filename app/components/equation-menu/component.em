class EquationMenuComponent extends Ember.Component

	classNames:['horizontal-tiny-button-menu']

	actions:
		buttonClicked: (latex) -> @sendAction 'action',latex

	click:-> false

`export default EquationMenuComponent`