class ModelerService extends Ember.Service

	growler:Ember.inject.service()

	saveModel: (model) ->
		return new Ember.RSVP.Promise (resolve,reject) =>
			if model.hasDirtyAttributes
				model.save().then(
					(success) => 
						@growler.muted model.modelName + " saved.",model
						resolve(success)
					(errors) => 
						console.log errors
						@errors errors.errors
						reject(errors)
				)
			else
				resolve()

	destroyModel: (model) ->
		return new Ember.RSVP.Promise (resolve,reject) =>
			model.destroyRecord().then(
				(success) => 
					@growler.muted model.modelName + " destroyed."
					resolve(success)
				(errors) =>
					@errors errors.errors
					reject(errors)
			)

	errors: (errors) -> 
		@growler.growl "Failed because #{error.detail}" for error in errors

`export default ModelerService`