class EquationRendererComponent extends Ember.Component
	
	classNames: ['equation-renderer-container']

	position:null
	block: ~> @position.block

	mathquill: ~>
		Ember.$(@element).children().first().mathquill('textbox')

	didInsertElement: ->
		@setWidth()
		@mathquill.mathquill('latex',@block.content)
		Ember.$('.cursor').remove()
		@sendAction 'setEquationContainerHeight',Ember.$(@element).height()

	setWidth: ->
		thisJq = Ember.$(@element)
		parentWidth = @position.width
		pageNumberWidth = thisJq.parent().children().first().outerWidth()
		thisJq.width(parentWidth-pageNumberWidth)

	setEquationContainerHeight: 'setEquationContainerHeight'

	actions:
		insertLatex: (latex) ->
			Ember.$(@element).focus()
			@displayEquationEditorMenu = true
			@mathquill.mathquill('cmd',latex)

	+volatile
	output: -> @mathquill.mathquill 'latex'

	click: -> @checkIfInsideEquation()

	keyDown: -> 
		@checkIfInsideEquation()
		true

	#checkIfHeightChanged: ->
	#	Ember.$(@element).outerHeight()

	checkIfInsideEquation: ->
		if Ember.$('.hasCursor').hasClass('mathquill-rendered-math') or Ember.$('.hasCursor').parents('.mathquill-rendered-math').length isnt 0
			@displayEquationEditorMenu = true
		else
			@displayEquationEditorMenu = false

	focusOut: -> 
		@displayEquationEditorMenu = false
		output = @cleanOutput
		unless @block.content is output
			@block.content = output
			@block.save()

	
	+volatile
	cleanOutput: ->

		# Add back in leading \ to $
		#https://github.com/mathquill/mathquill/issues/382
		ar = @output.split " "
		for string,index in ar
			unless string.charAt(0) is "$" and string.charAt(string.length - 1) is "$"
				string = string.replace "$", "\\$"
				string = string.replace "\\\\$","\\$"
				ar.splice index,1,string
		output = ar.join " "

		#fix for pasted text adding in \text{}
		if output.match /\\text{.*}/
			for match in output.match /\\text{.*}/
				output = output.replace match,match.substring(6,match.length-1)

		return output

`export default EquationRendererComponent`