computed = Ember.computed
alias = computed.alias

class TreeMenuComponent extends Ember.Component
  classNames: ['dropdown','open']
  attributeBindings: ['style']
  target: null
  model: null
  indented: false

  width: computed -> 
    width = Ember.$(@target).width()
    width = width + 10 if @indented
    return width
  style: computed -> "left:#{@width}px".htmlSafe()

`export default TreeMenuComponent`