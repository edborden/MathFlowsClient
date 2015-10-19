`import growl from 'math-flows-client/utils/growl'`
`import modeler from 'math-flows-client/utils/modeler'`
saveModel = modeler.saveModel
destroyModel = modeler.destroyModel

alias = Ember.computed.alias
service = Ember.inject.service

class GroupController extends Ember.Controller

	## ATTRIBUTES

	isEditingName: false

	## SERVICES

	server: service()

	## COMPUTED

	me: alias 'session.me'
	group: alias 'me.group'
	groupvitations: alias 'me.groupvitations'
	groupvitationsSent: alias 'me.groupvitationsSent'
	preference: alias 'me.preference'
	groupHelp: alias 'preference.groupHelp'

	actions:
		editName: ->
			@isEditingName = true
			false

		doneEditingName: ->
			@isEditingName = false

		newGroup: ->
			group = @store.createRecord 'group', {name:@session.me.name + "'s Group"}
			@send 'saveModel',group
			@session.me.group = group

		unjoin: ->
			@server.post 'groups/unjoin'
			@session.me.group = null

		invite: (email) -> 
			groupvitation = @store.createRecord 'groupvitation',{receiverEmail:email.toLowerCase()}
			saveModel(groupvitation).then => 
				growl "Invitation sent!"
				@session.me.groupvitationsSent.pushObject groupvitation

		remove: (groupvitation) ->
			destroyModel groupvitation

		groupHelpClick: ->
			@groupHelp = false
			saveModel @preference

`export default GroupController`