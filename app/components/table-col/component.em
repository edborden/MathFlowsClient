computed = Ember.computed
alias = computed.alias

class TableColComponent extends Ember.Component

  tagName: 'th'

  col: null
  width: alias 'col.size'

  attributeBindings: ['style']
  style: computed 'width', -> "width:#{@width}px".htmlSafe()

  didInsertElement: ->
    @col.renderer = "#" + Ember.$(@element).attr "id"

`export default TableColComponent`