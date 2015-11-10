service = Ember.inject.service

class KickstarterRoute extends Ember.Route

  keen: service()

  model: (params) ->
    @keen.addEvent 'kickstarter_visit', {kickstarterReferrer:@kickstarterReferrer}
    @keen.kickstarterReferrer = @kickstarterReferrer
    @keen.introClickPosition = 0 if params.target is "intro"
    @replaceWith params.target

  kickstarterReferrer: Ember.computed -> (0|Math.random()*9e6).toString(36)

`export default KickstarterRoute`