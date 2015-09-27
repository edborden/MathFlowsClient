`import modeler from 'math-flows-client/utils/modeler'`
saveModel = modeler.saveModel

class DirectionsWidgetComponent extends Ember.Component

	session:Ember.inject.service()

	open: Ember.computed.alias 'session.me.preference.directions'

	classNameBindings: ['open:open:closed']

	actions:
		toggle: ->
			@toggleProperty 'open'
			saveModel @session.me.preference

`export default DirectionsWidgetComponent`