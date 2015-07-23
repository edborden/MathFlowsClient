class DirectionsWidgetComponent extends Ember.Component

	session:Ember.inject.service()
	modeler:Ember.inject.service()

	open: Ember.computed.alias 'session.me.preference.directions'

	classNameBindings: ['open:open:closed']

	actions:
		toggle: ->
			@toggleProperty 'open'
			@modeler.saveModel @session.me.preference

`export default DirectionsWidgetComponent`