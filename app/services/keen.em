`import config from 'math-flows-client/config/environment'`
`import structure from 'math-flows-client/utils/structure'`

structuredUser = structure.user

computed = Ember.computed
alias = computed.alias
service = Ember.inject.service

class KeenService extends Ember.Service

	session: service()
	me: alias 'session.me'

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

	logSession: ->
		@client.addEvent 'session', 
			#page: window.location.href
			#time: new Date().toISOString()
			referrer: document.referrer
			agent: window.navigator.userAgent
			user: structuredUser(@me)

	introClickPosition: null
	introClick: ->
		if @introClickPosition?
			@client.addEvent 'introClick',
				position: @introClickPosition
				user: structuredUser(@me)
				invitationId: @invitationId

	invitationId: null

	blockCreate: (block) ->
		@client.addEvent 'blockCreate',
			user: structuredUser(@me)

`export default KeenService`