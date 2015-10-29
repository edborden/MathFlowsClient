class PageDeleterComponent extends Ember.Component

  check: false
  deletePage: 'deletePage'

  actions:
    deletePushed: ->
      @set 'check', true
      false

    confirm: ->
      @sendAction 'deletePage'

    cancel: ->
      @set 'check', false

`export default PageDeleterComponent`