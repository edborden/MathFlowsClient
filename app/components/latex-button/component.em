`import MenuButtonComponent from 'math-flows-client/components/menu-button/component'`
`import layout from 'math-flows-client/components/menu-button/template'`

class LatexButtonComponent extends MenuButtonComponent

	layout:layout
	action: 'insertLatex'

	didInsertElement: ->
		mathquillContainer = Ember.$(@element).children().first()
		mathquillContainer.mathquill()
		mathquillContainer.off 'mousedown.mathquill' #remove some mathquill event handlers that are grabbing focus that we don't want
		mathquillContainer.removeClass "hasCursor" #don't want hasCursor here, it is used in the renderer to identify active mathboxes

`export default LatexButtonComponent`