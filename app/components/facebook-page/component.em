class FacebookPageComponent extends Ember.Component

  classNames: ['inline']

  didInsertElement: ->
    FB.XFBML.parse() if FB?

`export default FacebookPageComponent`