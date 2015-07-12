class IntroRoute extends Ember.Route

	beforeModel: -> 
		@session.open().then (success) =>
			@sessionSuccessHandler()
			(error) =>
				console.log error
				@session.open().then => @sessionSuccessHandler()

	sessionSuccessHandler: ->
		@keen.logSession()
		@keen.introClick()
		Ember.$(".center-spinner").hide()

`export default IntroRoute`