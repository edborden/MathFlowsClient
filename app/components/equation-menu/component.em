class EquationMenuComponent extends Ember.Component

	mathquill: null
	tether: null

	didInsertElement: ->
		@tether = new Tether
			element: @element
			target: @mathquill
			attachment: "top left"
			targetAttachment: "bottom left"

	willDestroyElement: ->
		@tether.destroy()

	actions:
		insertLatex: (latex) ->
			@mathquill.mathquill 'cmd',latex

`export default EquationMenuComponent`