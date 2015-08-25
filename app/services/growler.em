class GrowlerService extends Ember.Service

	growl: (message) ->
		Messenger().post message

	muted: (message) ->
		console.log message

`export default GrowlerService`