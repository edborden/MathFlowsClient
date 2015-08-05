`import ServerTalk from 'math-flows-client/mixins/server-talk'`

class GroupController extends Ember.Controller with ServerTalk

	group: Ember.computed.alias 'session.me.group'
	groupvitations: Ember.computed.alias 'session.me.groupvitations'
	groupvitationsSent: Ember.computed.alias 'session.me.groupvitationsSent'
	isEditingName: false
	modeler:Ember.inject.service()

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
			@postServer 'groups/unjoin'
			@session.me.group = null

		invite: (email) -> 
			groupvitation = @store.createRecord 'groupvitation',{receiverEmail:email}
			@modeler.saveModel groupvitation
			@session.me.groupvitationsSent.pushObject groupvitation

		remove: (groupvitation) ->
			@modeler.destroyModel groupvitation

`export default GroupController`