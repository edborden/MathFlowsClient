`import ActiveItem from 'math-flows-client/mixins/active-item'`
`import clean from 'math-flows-client/utils/cleaner'`
`import modeler from 'math-flows-client/utils/modeler'`
saveModel = modeler.saveModel
destroyModel = modeler.destroyModel

service = Ember.inject.service
computed = Ember.computed
alias = computed.alias
observer = Ember.observer
scheduleOnce = Ember.run.scheduleOnce

class EquationRendererComponent extends Ember.Component with ActiveItem

  # ATTRIBUTES

  line:null
  preview:null
  insideEquation: null
  attributeBindings: ['style']

  # SERVICES

  store: service()
  keyboarder: service()
  eventer: service()

  # COMPUTED

  model: alias 'line'
  questionNumberWidth: alias 'line.block.questionNumberWidth'
  blockWidth: alias 'line.block.width'
  width: computed 'questionNumberWidth','blockWidth', -> @blockWidth - @questionNumberWidth
  style: computed 'width', -> "width:#{@width}px".htmlSafe()
  blockLine: computed -> @line.get('block')? is true
  cell: alias 'line.cell'

  # SETUP

  didInitAttrs: ->
    @line.renderer = @ if @blockLine

  didInsertElement: -> scheduleOnce 'afterRender', @, 'setupMathquill'

  setupMathquill: ->
    @mathquill = Ember.$(@element).children(".content").first().mathquill('textbox')
    @setMathQuillContent()
    @setKeyDownHandler()
    @setClickHandler()
    Ember.$(@element).find('.cursor').remove()  

  # BREAKDOWN

  willDestroyElement: -> 
    @removeKeyDownHandler()
    @removeClickHandler()

  ##EVENTS

  onKeyDown: (ev) ->
    unless @preview

      console.log ev.keyCode,ev.shiftKey
      unless (ev.keyCode is 190 or ev.keyCode is 188) and ev.shiftKey is true #filter out < > while they are broken

        @keyboarder.process @line,ev.keyCode,@mathquill if @blockLine
        Ember.run.next @,@checkIfInsideEquation
        true

      else
        false

  focusOut: -> 
    unless @preview
      @insideEquation = false
      clean @line,@mathquill
      if @cell?
        unless @cell.isNew and @line.content is ""
          saveModel(@cell).then => saveModel(@line)
      else
        saveModel(@line)

  click: (bubble=true) -> 
    @_super()
    @checkIfInsideEquation()
    bubble

  equationClick: ->
    @click false

  contentChanged: observer 'line.content', -> 
    @setMathQuillContent()
    Ember.$(@element).find('.cursor').remove()

  ##HELPERS

  setMathQuillContent: -> @mathquill.mathquill 'latex',@line.content

  setKeyDownHandler: ->
    #set handler
    onKeyDown = Ember.run.bind @,@onKeyDown
    @mathquill.on 'keydown',onKeyDown

    #reorder handlers for ember to run before mathquill
    handlers = jQuery._data( @mathquill[0], "events" ).keydown
    handler = handlers.pop()
    handlers.splice(0, 0, handler)

  setClickHandler: ->
    onClick = Ember.run.bind @,@equationClick
    @mathquill.on 'click',onClick

  removeKeyDownHandler: ->
    @mathquill.off 'keydown', '**'

  removeClickHandler: ->
    @mathquill.off 'click', '**'

  checkIfInsideEquation: ->
    unless @isDestroyed
      cursorElement = Ember.$('.hasCursor')
      @insideEquation = cursorElement.hasClass('mathquill-rendered-math') or cursorElement.parents('.mathquill-rendered-math').length isnt 0
      @eventer.triggerActiveEquationChanged()

  actions:
    insertLatex: (latex) ->
      @mathquill.mathquill 'cmd',latex

`export default EquationRendererComponent`