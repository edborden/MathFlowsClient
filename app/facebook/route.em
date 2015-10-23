service = Ember.inject.service

class FacebookRoute extends Ember.Route

  keen: service()

  model: ->
    @keen.addEvent 'facebook_visit', {facebookReferrer:@facebookReferrer}
    @keen.facebookReferrer = @facebookReferrer
    @replaceWith 'index'

  facebookReferrer: Ember.computed -> (0|Math.random()*9e6).toString(36)

`export default FacebookRoute`