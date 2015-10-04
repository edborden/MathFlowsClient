`import config from 'math-flows-client/config/environment'`

computed = Ember.computed
alias = computed.alias

class KeenService extends Ember.Service

	session:Ember.inject.service()
	me: alias 'session.me'
	id: alias 'me.id'
	guest: alias 'me.guest'

	client: computed -> 
		if config.environment is 'production'
			new Keen
				projectId: "54dcf35546f9a747ff1d341c"
				writeKey: "75f3c35a4eab3138fad5473436a37cf397e837e95946a36f696b5e1b4a4ccbc5ccdcec1a447a570563c8cdf42b7fd4c7bc3b126c99195cf92ed9d45459ef01e21de8a44dbb7398dd7cc4917b3615380ecb6d1dc181823255079d8785594edf68b19ebdaebfff63e7287a734674e415d8"
				protocol: "auto"
				host: "api.keen.io/3.0"
				requestType: "jsonp"
		else
			{addEvent: -> return}

	user: computed 'guest', -> {
		id: @id
		guest: @guest
	}

	logSession: ->
		@client.addEvent 'session', 
			#page: window.location.href
			#time: new Date().toISOString()
			referrer: document.referrer
			agent: window.navigator.userAgent
			user: @user

	introClickPosition: null
	introClick: ->
		if @introClickPosition?
			@client.addEvent 'introClick',
				position: @introClickPosition
				user: @user

`export default KeenService`