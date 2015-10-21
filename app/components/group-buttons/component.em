GroupButtonsComponent = Ember.Component.extend

  tagName: "span"

  editName: null
  unjoin: null

  actions:
    editName: -> @editName()
    unjoin: -> @unjoin()

  didInsertElement: ->
    @renderChildTooltips()

`export default GroupButtonsComponent`