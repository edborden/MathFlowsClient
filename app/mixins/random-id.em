RandomId = Ember.Mixin.create

	randomId: ~> 
		randomString = Math.random().toString(36).substr(2, 5)
		randomId = "grid-" + randomString

`export default RandomId`