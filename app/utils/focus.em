computed = Ember.computed
alias = computed.alias

FocusUtil = Ember.Object.extend

  line: null
  cursorPosition:null
  renderer: alias 'line.renderer'
  rendererEl: computed -> Ember.$(@renderer.element)
  content: computed -> @rendererEl.children(".content")
  contentChildren: computed -> @content.children()
  rendererLength: computed -> @contentChildren.length
  textBox: computed -> @contentChildren.first()
  firstElement: computed -> @textBox.next()

  init: ->

    if @cursorPosition is 0
      @cursorPosition = 'start'  # fix for putting cursor at the beginning, because 0 will click textbox

    @focus()

  focus: ->

    @renderer.click()

    if @line.content.length is 0
      @click @content

    else

      switch @cursorPosition
        when 'start'
          unless @firstElement.hasClass 'cursor'
            @click @firstElement
            @leftArrow @textBox

        when 'end'
          @click @contentChildren.last()

        else
          if @rendererLength <= @cursorPosition
            @click @contentChildren.last()
          else
            @click Ember.$(@contentChildren[@cursorPosition])

  click: (el) -> el.mousedown().mouseup()

  leftArrow: (el) ->
    e = $.Event("keydown")
    e.bubbles = true
    e.cancelable = true
    e.charCode = 37
    e.keyCode = 37
    e.which = 37
    el.trigger e  

`export default FocusUtil`