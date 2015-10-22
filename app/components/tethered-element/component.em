class TetheredElementComponent extends Ember.Component

	target: null
	tether: null
	attachment: "top left"
	targetAttachment: "bottom left"
	eventer: Ember.inject.service()

	didInsertElement: ->
		@tether = new Tether
			element: @element
			target: @target
			attachment: @attachment
			targetAttachment: @targetAttachment
		@eventer.on 'activeEquationChanged', @, @repositionTether

	willDestroyElement: ->
		@eventer.off 'activeEquationChanged', @, @repositionTether
		@tether.destroy()

	repositionTether: ->
		@tether.position()

	action:'action'
	actions:
		action: (param) -> @sendAction 'action', param

`export default TetheredElementComponent`