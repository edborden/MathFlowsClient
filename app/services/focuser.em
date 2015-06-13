class FocuserService extends Ember.Service

	focusedLine: null

	focusLine: (line) ->
		@focusedLine = line
		@focusElement @focusedLine.renderer

	focusElement: (renderer) ->
		renderer = Ember.$(renderer.element)
		content = renderer.children(".content")
		content.mousedown().mouseup()
		e = $.Event("keydown")
		e.bubbles = true
		e.cancelable = true
		e.charCode = 39
		e.keyCode = 39
		e.which = 39
		renderer.find('textarea').trigger(e)

`export default FocuserService`