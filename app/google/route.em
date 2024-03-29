service = Ember.inject.service

class GoogleRoute extends Ember.Route

  keen: service()

  model: (params) ->
    @keen.googleReferrer = params.id
    @keen.addEvent 'google_visit', params
    @replaceWith 'index'

`export default GoogleRoute`