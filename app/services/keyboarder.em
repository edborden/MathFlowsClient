class KeyboarderService extends Ember.Service

	modeler:Ember.inject.service()
	store:Ember.inject.service()
	focuser:Ember.inject.service()

	line:null
	block: ~> @line.block if @line
	position: ~> @line.position if @line
	element:null
	cursorPosition:null
	equations:null
	stringPosition:null

	lineIndex: ~> @block.sortedLines.indexOf @line
	lineAfter: ~> @block.lines.objectAt @lineIndex+1
	lineBefore: ~> @block.lines.objectAt @lineIndex-1

	##

	setup: (line) ->
		@line = line
		@element = line.renderer.element
		@cursorPosition = -1 #account for invisible textbox element
		@equations = []
		@setMetaData()
		return @

	setMetaData: ->
		ar = Ember.$.makeArray Ember.$(@element).children('.content').children()
		stop = false
		for el in ar
			unless stop
				jqEl = Ember.$(el)
				if jqEl.hasClass "mathquill-rendered-math"
					if jqEl.children().first().hasClass "cursor" #cursor is at beginning of equation, take the equation to the next line
						stop = true
					else 
						@incrementPosition()
						@equations.push @cursorPosition
				if jqEl.hasClass "cursor"
					stop = true 
				else
					@incrementPosition()
		@setStringPosition()

	incrementPosition: -> @cursorPosition = @cursorPosition + 1

	setStringPosition: ->
		if @equations.length isnt 0
			for equation in @equations
				@stringPosition = @cursorPosition + @getLengthOfEquation(equation)
		else
			@stringPosition = @cursorPosition

	substringBeforeCursor: -> @line.content.substr 0,@stringPosition
	substringAfterCursor: -> @line.content.substr @stringPosition

	nextPosition: ~> if @lineAfter? then @lineAfter.position else @position + 1

	keyDown: (keyCode) ->
		switch keyCode
			when 13 #enter
				newPosition = (@position+@nextPosition)/2
				newLine = @store.createRecord 'line', {block:@block,content:@substringAfterCursor(),position:newPosition} 
				@modeler.saveModel(newLine)
				@line.content = @substringBeforeCursor()
				@modeler.saveModel(@line)

				@focuser.focusLine newLine

				true

			when 8 #backspace
				if @cursorPosition is 0 and @block.sortedLines.firstObject isnt @line

					@lineBefore.content = @lineBefore.content + @line.content						
					@modeler.saveModel(@lineBefore).then =>	
						@focuser.focusLine @lineBefore
						@modeler.destroyModel(@line).then =>
							@block.reload() #reload block to get validations, in case deleting lines removed existing validations
					true
				else
					false

			else
				false

	getLengthOfEquation: (position) ->
		ar = @line.content.split ""
		stop = false
		length = 0
		until stop
			length = length + 1
			position = position + 1
			stop = true if ar[position] is "$"
		return length

`export default KeyboarderService`