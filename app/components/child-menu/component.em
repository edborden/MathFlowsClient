`import modeler from 'math-flows-client/utils/modeler'`
destroyModel = modeler.destroyModel

class ChildMenuComponent extends Ember.Component

	# ATTRIBUTES

	child: null
	classNames: ['right-side']

	# ACTIONS

	actions:
		destroyModel: (model) -> destroyModel model

`export default ChildMenuComponent`