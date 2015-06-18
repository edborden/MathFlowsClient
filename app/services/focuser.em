class FocuserService extends Ember.Service

	focusedLine: null
	cursorPosition:null
	renderer: Ember.computed.alias 'focusedLine.renderer'
	rendererLength: ~> Ember.$(@renderer.element).children(".content").children().length if @focusedLine

	setFocusLine: (line,cursorPosition) ->
		@focusedLine = line
		@cursorPosition = cursorPosition
		@cursorPosition = 'start' if @cursorPosition is 0 # fix for putting cursor at the beginning, because 0 will click textbox
		@focusLine()

	focusLine: ->
		renderer = Ember.$(@renderer.element)
		content = renderer.children(".content")

		switch @cursorPosition
			when 'start'
				textbox = content.children().first()
				@click textbox.next()
				e = $.Event("keydown")
				e.bubbles = true
				e.cancelable = true
				e.charCode = 37
				e.keyCode = 37
				e.which = 37
				textbox.trigger(e)

			when 'end'
				@click content.children().last()

			else
				if @rendererLength <= @cursorPosition
					@click content.children().last()
				else
					@click Ember.$(content.children()[@cursorPosition])

	click: (el) -> el.mousedown().mouseup()

`export default FocuserService`