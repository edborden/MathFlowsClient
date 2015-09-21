computed = Ember.computed
alias = computed.alias

FocuserService = Ember.Service.extend

	focusedLine: null
	cursorPosition:null
	renderer: alias 'focusedLine.renderer'
	rendererLength: -> computed 'focusedLine', -> $(@renderer.element).children(".content").children().length

	setFocusLine: (line,cursorPosition) ->
		@focusedLine = line

		if cursorPosition is 0
			@cursorPosition = 'start'  # fix for putting cursor at the beginning, because 0 will click textbox
		else
			@cursorPosition = cursorPosition

		@focusLine()

	focusLine: ->
		renderer = $(@get('renderer').get 'element')
		content = renderer.children(".content")

		if @focusedLine.content.length is 0
			@click content

		else

			switch @cursorPosition
				when 'start'
					textbox = content.children().first()
					firstEl = textbox.next()
					unless firstEl.hasClass 'cursor'
						@click firstEl
						@leftArrow textbox

				when 'end'
					@click content.children().last()

				else
					if @rendererLength <= @cursorPosition
						@click content.children().last()
					else
						@click Ember.$(content.children()[@cursorPosition])

	click: (el) -> el.mousedown().mouseup()

	leftArrow: (el) ->
		e = $.Event("keydown")
		e.bubbles = true
		e.cancelable = true
		e.charCode = 37
		e.keyCode = 37
		e.which = 37
		el.trigger e	

`export default FocuserService`