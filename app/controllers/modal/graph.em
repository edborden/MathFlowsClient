class ModalGraphController extends Ember.Controller

	actions:
		screenshot: ->
			@send 'addImage',
				binary: @calculator.screenshot()
				block: @model
		registerCalculator: (calculator) ->
			@calculator = calculator

`export default ModalGraphController`