class EquationButtonComponent extends Ember.Component

	latex:null
	insertLatex: 'insertLatex'

	tagName:'span'

	button: null
	init: ->
		@button = @latex unless @button?
		@_super()

	click: -> 
		@sendAction 'insertLatex',@latex
		false

	mouseDown: -> false #keep from grabbing focus and closing menu

	didInsertElement: ->
		mathquillContainer = Ember.$(@element).children().first()
		mathquillContainer.mathquill()
		mathquillContainer.off 'mousedown.mathquill' #remove some mathquill event handlers that are grabbing focus that we don't want
		mathquillContainer.removeClass "hasCursor" #don't want hasCursor here, it is used in the renderer to identify active mathboxes

	mouseEnter: -> @mouseIsOver = true if @top
	mouseLeave: -> @mouseIsOver = false if @top

`export default EquationButtonComponent`