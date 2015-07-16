class ModelerService extends Ember.Service

	growler:Ember.inject.service()

	saveModel: (model) ->
		return new Ember.RSVP.Promise (resolve,reject) =>
			if model.hasDirtyAttributes
				model.save().then(
					(success) => 
						@growler.growl model.modelName + " saved.",model
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
					@growler.growl model.modelName + " destroyed."
					resolve(success)
				(errors) =>
					@errors errors.errors
					reject(errors)
			)

	errors: (errors) -> 
		for prop,array of errors
			@growler.growl message for message in array

`export default ModelerService`