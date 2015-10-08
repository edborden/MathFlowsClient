class TetheredElementComponent extends Ember.Component

	target: null
	tether: null
	attachment: "top left"
	targetAttachment: "bottom left"

	classNames:['btn-group']

	didInsertElement: ->
		@tether = new Tether
			element: @element
			target: @target
			attachment: @attachment
			targetAttachment: @targetAttachment

	willDestroyElement: ->
		@tether.destroy()

	action:'action'
	actions:
		action: (param) -> @sendAction 'action', param

`export default TetheredElementComponent`