ModelName = Ember.Mixin.create
	modelName: ~> @toString().split(":")[1].capitalize()
`export default ModelName`