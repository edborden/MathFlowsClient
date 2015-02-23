class EquationMenuComponent extends Ember.Component

	classNames:['equationEditorMenu']

	actions:
		buttonClicked: (latex) -> @sendAction 'action',latex

	click:-> false

`export default EquationMenuComponent`