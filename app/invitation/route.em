class InvitationRoute extends Ember.Route

  server: Ember.inject.service()

  model: (params) ->

    @server.post 'invitations/' + params.invitation_id + '/visit'
    @replaceWith 'index'

`export default InvitationRoute`