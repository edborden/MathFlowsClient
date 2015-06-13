class EquationRendererComponent extends Ember.Component

	cleaner: Ember.inject.service()
	store:Ember.inject.service()
	focuser:Ember.inject.service()
	enterer: Ember.inject.service()
	modeler:Ember.inject.service()

	line:null
	block: Ember.computed.alias 'line.block'
	
	didInsertElement: ->
		@setQuestionElement()
		@mathquill = Ember.$(@element).children().last().mathquill('textbox')
		@setMathQuillContent()
		@line.renderer = @		
		@focuser.focusLine @line if @line.isNew
		if @focuser.focusedLine is @line
			@focuser.focusElement @
		else
			Ember.$(@element).find('.cursor').remove()

	mathquill: null
	setMathQuillContent: ->
		@mathquill.mathquill('latex',@line.content)
		@length = @line.content.length

	+observer block.question
	setQuestionElement: ->
		if @block.question
			@element.style.paddingLeft = @block.questionNumberWidth() + "px"
		else
			@element.style.paddingLeft = 0

	actions:
		insertLatex: (latex) ->
			Ember.$(@element).focus()
			@displayEquationEditorMenu = true
			@mathquill.mathquill('cmd',latex)

	click: -> 
		@checkIfInsideEquation()
		true

	length: null	

	keyDown: (ev) ->
		switch ev.keyCode
			when 13
				return
			when 8
				if @cleanedContent().length is 0 and @length is 0 and @block.lines.length isnt 1 and @block.sortedLines.firstObject isnt @line
					block = @line.block
					lineBefore = block.lineBefore @line
					@focuser.focusLine lineBefore
					@modeler.destroyModel(@line).then => @block.reload() #refresh the block to check invalidations
					false
				else
					@length = @cleanedContent().length
					Ember.run.next @,@checkIfInsideEquation
					true
			else
				Ember.run.next @,@checkIfInsideEquation
				true

	checkIfInsideEquation: ->
		unless @isDestroyed
			cursorElement = Ember.$('.hasCursor')
			if cursorElement.hasClass('mathquill-rendered-math') or cursorElement.parents('.mathquill-rendered-math').length isnt 0
				@displayEquationEditorMenu = true
			else
				@displayEquationEditorMenu = false

	cleanedContent: ->
		@cleaner.latex @mathquill.mathquill 'latex'	

	focusOut: -> 
		unless @line.isDeleted
			@displayEquationEditorMenu = false
			@line.content = @cleanedContent()
			@modeler.saveModel @line
			@setMathQuillContent() #this sync's the displayed math to the block's content, applying any changes performed in cleanOutput()

`export default EquationRendererComponent`