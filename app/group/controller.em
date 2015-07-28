class GroupController extends Ember.Controller

	actions:
		newGroup: ->
			group = @store.createRecord 'group', {name:@session.me.name + "'s Group"}
			@send 'saveModel',group
			@session.me.group = group

		openInviteModal: -> return

		invite: (email) -> @store.createRecord('invitation',{referrer:@model,referralEmail:email}).save()

`export default GroupController`