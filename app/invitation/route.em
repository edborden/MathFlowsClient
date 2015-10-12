service = Ember.inject.service

class InvitationRoute extends Ember.Route

  server: service()
  keen: service()

  model: (params) ->

    @keen.invitationId = parseInt params.invitation_id
    @keen.source = "invitation"

    @server.post 'invitations/' + params.invitation_id + '/visit'
    @replaceWith 'index'

`export default InvitationRoute`