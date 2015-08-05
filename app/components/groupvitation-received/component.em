`import ServerTalk from 'math-flows-client/mixins/server-talk'`

class GroupvitationReceivedComponent extends Ember.Component with ServerTalk

	groupvitation: null

	actions:
		accept: ->
			@postServer('groupvitations/' + @groupvitation.id + '/accept').then (response) =>
				@session.me.group = response

		decline: ->
			@postServer('groupvitations/' + @groupvitation.id + '/decline')
			@session.me.groupvitations.removeObject @groupvitation

`export default GroupvitationReceivedComponent`