class GroupvitationReceivedComponent extends Ember.Component

	groupvitation: null
	growler: Ember.inject.service()
	server:Ember.inject.service()
	store:Ember.inject.service()
	session:Ember.inject.service()
	me:Ember.computed.alias 'session.me'

	actions:
		accept: ->
			@router.transitionTo('loading').then =>
				@server.post('groupvitations/' + @groupvitation.id + '/accept').then (response) =>
					@me.groupvitations.removeObject @groupvitation
					group = @store.peekRecord 'group',response.group.id
					@me.group = group
					@router.transitionTo('group').then =>
						@growler.growl "Invitation accepted!"

		decline: ->
			@server.post('groupvitations/' + @groupvitation.id + '/decline')
			@me.groupvitations.removeObject @groupvitation
			@growler.growl "Invitation declined."

`export default GroupvitationReceivedComponent`