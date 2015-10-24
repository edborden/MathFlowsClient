`import modeler from 'math-flows-client/utils/modeler'`
saveModel = modeler.saveModel

class ToggleRadioComponent extends Ember.Component

  classNames: ['switch-toggle','switch-3','well']
  alignment: null
  checked: Ember.computed.alias 'alignment.side'

  actions: 
    setValue: (value) ->
      @checked = value
      saveModel @alignment

`export default ToggleRadioComponent`