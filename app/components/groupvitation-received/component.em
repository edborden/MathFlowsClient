`import growl from 'math-flows-client/utils/growl'`

class GroupvitationReceivedComponent extends Ember.Component

	groupvitation: null
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
						growl "Invitation accepted!"

		decline: ->
			@server.post('groupvitations/' + @groupvitation.id + '/decline')
			@me.groupvitations.removeObject @groupvitation
			growl "Invitation declined."

`export default GroupvitationReceivedComponent`