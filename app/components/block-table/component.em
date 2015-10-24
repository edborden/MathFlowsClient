computed = Ember.computed
alias = computed.alias

class BlockTableComponent extends Ember.Component

  table: null
  side: alias 'table.alignment.side'
  preview: null
  attributeBindings: ['style']

  style: computed 'side', -> "float:#{@side}".htmlSafe()

`export default BlockTableComponent`