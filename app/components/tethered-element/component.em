class TetheredElementComponent extends Ember.Component

	target: null
	tether: null

	classNames:['btn-group']

	didInsertElement: ->
		@tether = new Tether
			element: @element
			target: @target
			attachment: "top left"
			targetAttachment: "bottom left"

	willDestroyElement: ->
		@tether.destroy()

	action:'action'
	actions:
		action: (param) -> @sendAction 'action', param

`export default TetheredElementComponent`