class SizeService extends Ember.Object

	init: ->
		@symbolSizeConfig = new eqEd.SymbolSizeConfiguration()
		clipboard = new eqEd.Clipboard()
		inializePropertyHooks(@symbolSizeConfig)
		setupKeyboardEvents(@symbolSizeConfig, clipboard)
		setupMenuEvents(@symbolSizeConfig)
		console.log 'size init'

`export default SizeService`