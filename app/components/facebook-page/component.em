class FacebookPageComponent extends Ember.Component

  classNames: ['inline']

  didInsertElement: ->
    FB.XFBML.parse()

`export default FacebookPageComponent`