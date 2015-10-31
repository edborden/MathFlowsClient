computed = Ember.computed
alias = computed.alias

class BlockLinesComponent extends Ember.Component

  attributeBindings: ['style']

  questionNumberWidth: alias 'block.questionNumberWidth'
  blockWidth: alias 'block.width'
  width: computed 'questionNumberWidth','blockWidth', -> @blockWidth - @questionNumberWidth
  style: computed 'width', -> "width:#{@width}px".htmlSafe()

`export default BlockLinesComponent`