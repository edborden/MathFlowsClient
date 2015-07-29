class GroupController extends Ember.Controller

	group: Ember.computed.alias 'session.me.group'
	isEditingName: false

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

		openInviteModal: -> return

		invite: (email) -> @store.createRecord('invitation',{referrer:@model,referralEmail:email}).save()

`export default GroupController`