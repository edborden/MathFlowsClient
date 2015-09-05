`import ModelName from 'math-flows-client/mixins/model-name'`

attr = DS.attr
belongsTo = DS.belongsTo
hasMany = DS.hasMany

class Alignment extends DS.Model with ModelName

	modeler: Ember.inject.service()

	# ATTRIBUTES

	side: attr()

	# COMPUTED

	left: Ember.computed.equal 'side','left'
	right: Ember.computed.equal 'side', 'right'

	sideBoolean: Ember.computed 'side',
		get: -> @right
		set: (key,value) ->
			console.log key,value
			if value is true
				@side = 'right'
			else
				@side = 'left'
			@modeler.saveModel @
			return value

`export default Alignment`