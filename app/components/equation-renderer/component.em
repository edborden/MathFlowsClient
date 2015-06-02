class EquationRendererComponent extends Ember.Component
	
	mathquill: ~>
		Ember.$(@element).children().last().mathquill('textbox')

	didInsertElement: ->
		@setWidth()
		@mathquill.mathquill('latex',@block.content)
		Ember.$('.cursor').remove()
		@sendAction 'setEquationContainerHeight',Ember.$(@element).height()

	willDestroyElement: ->
		@mathquill = null # fixes destroyElement error

	+observer block.width
	setWidth: ->
		thisJq = Ember.$(@element)
		parentWidth = @block.width
		pageNumberWidth = thisJq.parent().children().first().outerWidth()
		width = parentWidth-pageNumberWidth
		thisJq.width(width)

	setEquationContainerHeight: 'setEquationContainerHeight'
	saveModel: 'saveModel'

	actions:
		insertLatex: (latex) ->
			Ember.$(@element).focus()
			@displayEquationEditorMenu = true
			@mathquill.mathquill('cmd',latex)

	+volatile
	output: -> @mathquill.mathquill 'latex'

	click: -> @checkIfInsideEquation()

	keyDown: -> 
		Ember.run.next @,@checkIfInsideEquation
		true

	#checkIfHeightChanged: ->
	#	Ember.$(@element).outerHeight()

	checkIfInsideEquation: ->
		cursorElement = Ember.$('.hasCursor')
		if cursorElement.hasClass('mathquill-rendered-math') or cursorElement.parents('.mathquill-rendered-math').length isnt 0
			@displayEquationEditorMenu = true
		else
			@displayEquationEditorMenu = false

	focusOut: -> 
		@displayEquationEditorMenu = false
		@block.content = @cleanOutput
		@sendAction 'saveModel',@block
		@didInsertElement() #this sync's the displayed math to the block's content, applying any changes performed in cleanOutput()

	+volatile
	cleanOutput: ->

		#fix for create math box then don't enter anything
		ar = @output.split ""
		for char,index in ar
			shouldRun = char is "$" and ar[index+1] is "$"
			while shouldRun
				ar.splice index,2
				shouldRun = char is "$" and ar[index+1] is "$"
		output = ar.join ""

		#handles removing space from between brackets when fields aren't filled in, causing issues in parsing in other places
		matches = output.match /{ }/
		if matches
			for match in matches
				output = output.replace match,"{}"
		matches = output.match /\[ ]/
		if matches
			for match in matches
				output = output.replace match,"[]"

		#fix for pasted text adding in \text{}
		if output.match /\\text{.*}/
			for match in output.match /\\text{.*}/
				output = output.replace match,match.substring(6,match.length-1)

		# Add back in leading \ to $
		#https://github.com/mathquill/mathquill/issues/382
		ar = output.split " "
		for string,index in ar
			unless string.charAt(0) is "$" and string.charAt(string.length - 1) is "$"
				string = string.replace "$", "\\$"
				string = string.replace "\\\\$","\\$"
				ar.splice index,1,string
		output = ar.join " "

		return output

`export default EquationRendererComponent`