class EquationMenuComponent extends Ember.Component

	classNames:['equationEditorMenu']

	layoutName: 'components/equation-menu'

	actions:
		buttonClicked: (latex) -> @sendAction 'action',latex

	click:-> false

`export default EquationMenuComponent`