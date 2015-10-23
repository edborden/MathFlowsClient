service = Ember.inject.service

class FacebookRoute extends Ember.Route

  keen: service()

  model: (params) ->
    @replaceWith 'index'

`export default FacebookRoute`