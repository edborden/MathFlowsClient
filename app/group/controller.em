class GroupController extends Ember.Controller

	group: Ember.computed.alias 'session.me.group'
	groupvitations: Ember.computed.alias 'session.me.groupvitations'
	groupvitationsSent: Ember.computed.alias 'session.me.groupvitationsSent'
	isEditingName: false
	modeler:Ember.inject.service()
	server:Ember.inject.service()

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
			groupvitation = @store.createRecord 'groupvitation',{receiverEmail:email}
			@modeler.saveModel(groupvitation).then => 
				@growler.growl "Invitation sent!"
				@session.me.groupvitationsSent.pushObject groupvitation

		remove: (groupvitation) ->
			@modeler.destroyModel groupvitation

`export default GroupController`