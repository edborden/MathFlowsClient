`import config from 'math-flows-client/config/environment'`

computed = Ember.computed
alias = computed.alias
service = Ember.inject.service

class KeenService extends Ember.Service

	session: service()
	me: alias 'session.me'
	id: alias 'me.id'
	guest: alias 'me.guest'

	client: computed -> 
		if config.environment is 'production'
			new Keen
				projectId: config.keenProjectId
				writeKey: config.keenWriteKey
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