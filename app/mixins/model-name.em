ModelName = Ember.Mixin.create

	init: ->
		@_super()
		name = "is#{@modelName}"
		@set name,true

	modelName: ~> @toString().split(":")[1].capitalize()
`export default ModelName`