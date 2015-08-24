`import ServerTalk from 'math-flows-client/mixins/server-talk'`

class InvitationsController extends Ember.Controller with ServerTalk

	modeler:Ember.inject.service()

	actions:

		invite: (email) -> 
			invitation = @store.createRecord 'invitation',{referralEmail:email}
			@modeler.saveModel invitation
			@session.me.invitationsSent.pushObject invitation

`export default InvitationsController`