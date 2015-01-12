`import RandomId from 'math-flows-client/mixins/random-id'`

class FixedGridComponent extends Ember.Component with RandomId

	#classNames: ['gridster']
	layoutName: 'components/fixed-grid'

	gridster: null

	widgetBaseWidth: 12
	widgetBaseHeight: ~> @lineHeight
	lineHeight: ~> 1.5*@fontSize
	in: ~> 1.5 * 72

	didInsertElement: ->
		@_super()
		@gridster = Ember.$(@element).children().first().gridster(
			widget_margins: [0,0],
			widget_base_dimensions: [12, 20]
			namespace: "#" + @randomId
		).data('gridster').disable()

`export default FixedGridComponent`