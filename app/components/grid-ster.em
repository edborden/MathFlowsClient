class GridSterComponent extends Ember.Component

	layoutName: 'components/grid-ster'

	didInsertElement: ->
		Ember.$(".gridster ul").gridster
			widget_margins: [10, 10],
			widget_base_dimensions: [140, 140]
			
`export default GridSterComponent`