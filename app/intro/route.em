class IntroRoute extends Ember.Route

	beforeModel: -> 
		@session.open().then (success) =>
			@sessionSuccessHandler()
			(error) =>
				console.log error
				@session.open().then => @sessionSuccessHandler()

	model: -> @session.me.folders.firstObject.tests.firstObject.pages.then => @session.me.folders.firstObject.tests.firstObject.pages.firstObject

	sessionSuccessHandler: ->
		@keen.addEvent 'session'
		@keen.introClick()
		Ember.$(".center-spinner").hide()

`export default IntroRoute`