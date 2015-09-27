`import clean from 'math-flows-client/utils/cleaner'`

computed = Ember.computed
alias = computed.alias
service = Ember.inject.service

`import modeler from 'math-flows-client/utils/modeler'`
saveModel = modeler.saveModel
destroyModel = modeler.destroyModel

class KeyboarderService extends Ember.Service

	##SETUP

	store: service()
	focuser: service()

	codesToHandle: Ember.A [13,8,37,38,39,40,46]
	line:null
	block: alias 'line.block'
	position: alias 'line.position'
	allLines: alias 'block.lines'
	element:null
	mathquill: null
	cursorPosition:null
	equations:null
	stringPosition:null

	lineIndex: computed 'block.sortedLines', -> @block.sortedLines.indexOf @line
	lineAfter: computed 'allLines', -> @allLines.objectAt @lineIndex+1
	lineBefore: computed 'allLines', -> @allLines.objectAt @lineIndex-1
	nextPosition: computed 'lineAfter', -> if @lineAfter? then @lineAfter.position else @position + 1

	cursorInsideEquation: false

	##RUN

	process: (line,keyCode,mathquill) ->
		@setup(line,mathquill).keyDown(keyCode) if @codesToHandle.contains keyCode

	setup: (line,mathquill) ->
		@line = line
		@mathquill = mathquill
		@element = line.renderer.element
		@setMetaData()
		return @

	keyDown: (keyCode) ->
		unless @cursorInsideEquation
			switch keyCode
				when 13 then @enter()
				when 8 then @backspace()
				when 46 then @delete()
				when 37 then @leftArrow()
				when 38 then @upArrow()
				when 39 then @rightArrow()
				when 40 then @downArrow()

	##HELPERS

	setMetaData: ->
		@cursorPosition = -1 #account for invisible textbox element
		@equations = []
		@cursorInsideEquation = false
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

	getLengthOfEquation: (position) ->
		ar = @line.content.split ""
		stop = false
		length = 0
		until stop
			length = length + 1
			position = position + 1
			stop = true if ar[position] is "$" or typeof ar[position] isnt 'string' #if equation isnt finished, it won't end with $, so have to look for undefined
		return length

	enter: ->
		console.log 'enter'

		clean @line,@mathquill
		newPosition = (@position+@nextPosition)/2
		newContent = @substringAfterCursor()
		@line.content = @substringBeforeCursor()
		saveModel(@line).then =>
			newLine = @store.createRecord 'line', {block:@block,content:newContent,position:newPosition} 
			@block.lines.pushObject newLine
			saveModel(newLine).then => @block.validate()
			Ember.run.next @,=> 
				@focuser.setFocusLine newLine,'start'

	backspace: ->
		if @cursorPosition is 0 and @block.sortedLines.firstObject isnt @line
			console.log 'backspace, beginning of valid line'

			clean @line,@mathquill
			@setMetaData()
			newContent = @lineBefore.content + @line.content
			lineBefore = @lineBefore
				#@focuser.setFocusLine @lineBefore,'end'
			destroyModel(@line).then =>
					lineBefore.content = newContent
					Ember.run.next @,=> @focuser.setFocusLine lineBefore,'end'
					saveModel(lineBefore).then =>	
						@block.validate() if @block.contentInvalid

	delete: ->
		if Ember.$(@element).children('.content').children().last().hasClass("cursor") and @lineAfter?
			console.log 'delete, end of valid line'

			@setMetaData()
			clean @line,@mathquill
			@line.content = @line.content + @lineAfter.content
			saveModel(@line).then =>
				@focuser.setFocusLine @line,@cursorPosition+1
				destroyModel(@lineAfter).then =>
					@block.validate() if @block.contentInvalid

	leftArrow: ->
		if @cursorPosition is 0 and @lineBefore?
			console.log 'left arrow, beginning of line'

			@focuser.setFocusLine @lineBefore,'end'

	upArrow: ->
		if @lineBefore?
			console.log 'up arrow, with valid line above'
			@focuser.setFocusLine @lineBefore,@cursorPosition

	rightArrow: ->
		console.log Ember.$(".cursor")
		if Ember.$(@element).children('.content').children().last().hasClass("cursor") and @lineAfter?
			console.log 'right arrow, with valid line after'
			@focuser.setFocusLine @lineAfter,'start'

	downArrow: ->
		if @lineAfter?
			console.log 'down arrow, with valid line after',@cursorPosition
			@focuser.setFocusLine @lineAfter,@cursorPosition

`export default KeyboarderService`