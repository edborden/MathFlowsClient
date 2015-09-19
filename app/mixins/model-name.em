ModelName = Ember.Mixin.create

	init: ->
		@_super()
		name = "is#{@modelName}"
		@set name,true

	modelName: Ember.computed -> @toString().split(":")[1].capitalize()
`export default ModelName`