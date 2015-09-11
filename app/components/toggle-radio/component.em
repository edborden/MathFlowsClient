class ToggleRadioComponent extends Ember.Component

	modeler: Ember.inject.service()

	classNames: ['switch-toggle','switch-3','well']
	alignment: null
	checked: Ember.computed.alias 'alignment.side'

	actions: 
		setValue: (value) ->
			@checked = value
			@modeler.saveModel @alignment

`export default ToggleRadioComponent`