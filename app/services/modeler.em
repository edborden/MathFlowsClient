class ModelerService extends Ember.Service

	saveModel: (model) ->
		return new Ember.RSVP.Promise (resolve,reject) =>
			if model.hasDirtyAttributes
				model.save().then(
					(success) => 
						console.log model.modelName + " saved.",model
						resolve(success)
					(errors) => 
						@errors errors.errors
						reject(errors)
				)
			else
				resolve()

	destroyModel: (model) ->
		return new Ember.RSVP.Promise (resolve,reject) =>
			model.destroyRecord().then(
				(success) => 
					console.log model.modelName + " destroyed."
					resolve(success)
				(errors) =>
					@errors errors.errors
					reject(errors)
			)

	errors: (errors) -> 
		for prop,array of errors
			console.log message for message in array

`export default ModelerService`