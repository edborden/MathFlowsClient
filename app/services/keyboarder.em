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

	cursorInsideEquation: false

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
					@cursorInsideEquation = true if jqEl.find(".hasCursor").length isnt 0
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
		unless @cursorInsideEquation
			switch keyCode
				when 13 #enter
					console.log 'enter'
					newPosition = (@position+@nextPosition)/2
					newLine = @store.createRecord 'line', {block:@block,content:@substringAfterCursor(),position:newPosition} 
					@modeler.saveModel(newLine)
					@line.content = @substringBeforeCursor()
					@modeler.saveModel(@line)

					@focuser.setFocusLine newLine,'start'

					true

				when 8 # backspace
					if @cursorPosition is 0 and @block.sortedLines.firstObject isnt @line
						console.log 'backspace, beginning of valid line'

						@lineBefore.content = @lineBefore.content + @line.content						
						@modeler.saveModel(@lineBefore).then =>	
							@focuser.setFocusLine @lineBefore,'end'
							@modeler.destroyModel(@line).then =>
								@block.reload() #reload block to get validations, in case deleting lines removed existing validations
						true
					else
						console.log 'backspace, no action'
						false

				when 46 # delete
					if Ember.$(@element).children('.content').children().last().hasClass("cursor") and @lineAfter?
						console.log 'delete, end of valid line'

						@line.content = @line.content + @lineAfter.content
						console.log @line.content
						@modeler.saveModel(@line).then =>
							@focuser.setFocusLine @line,@cursorPosition
							@modeler.destroyModel(@lineAfter).then =>
								@block.reload()
						true
					else
						console.log 'delete, no action'
						false

				when 37 # left arrow

					if @cursorPosition is 0 and @lineBefore?
						console.log 'left arrow, beginning of line'

						@focuser.setFocusLine @lineBefore,'end'
						
					false

				when 38 # up arrow
					if @lineBefore?
						console.log 'up arrow, with valid line above'
						@focuser.setFocusLine @lineBefore,@cursorPosition
					false

				when 39 # right arrow
					if Ember.$(@element).children('.content').children().last().hasClass("cursor") and @lineAfter?
						console.log 'right arrow, with valid line after'
						@focuser.setFocusLine @lineAfter,'start'
					false

				when 40 # down arrow
					if @lineAfter?
						console.log 'down arrow, with valid line after'
						@focuser.setFocusLine @lineAfter,@cursorPosition
					false

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