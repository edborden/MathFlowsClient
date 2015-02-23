class ModalGraphController extends Ember.Controller

	actions:
		screenshot: ->
			console.log @model
			@send 'addImage',
				binary: @calculator.screenshot()
				block: @model
		registerCalculator: (calculator) ->
			@calculator = calculator

`export default ModalGraphController`