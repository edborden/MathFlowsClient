class SessionService extends Ember.Service

	store: Ember.inject.service()
	growler:Ember.inject.service()

	loggedIn: ~> @model?
	model: null
	token: ~> if @model? then @model.token else null
	me: ~> @model.user
	
	open: ->
		return new Ember.RSVP.Promise (resolve,reject) =>
			token = localStorage.mathFlowsToken
			if token?
				@store.query('session', {token: token}).then(
					(response) => 
						@model = response.objectAt(0)
						resolve response
					(errors) => 
						@growler.muted errors.errors[0].title
						@close() if errors.errors[0].status is "401"
						reject errors.errors[0].title
				)
			else
				@post('issue').then => resolve()

	post: (token,redirectUri) ->
		return new Ember.RSVP.Promise (resolve,reject) =>
			@store.createRecord('session',{token:token,redirectUri:redirectUri}).save().then(
				(response) => 
					@growler.muted 'success'
					@model = response
					localStorage.mathFlowsToken = @token
					resolve()
				(errors) => 
					@growler.muted errors.errors[0].title
					@close() if errors.errors[0].status is "401"
					reject errors.errors[0].title
			)

	close: ->
		localStorage.clear()
		@model = null

`export default SessionService`