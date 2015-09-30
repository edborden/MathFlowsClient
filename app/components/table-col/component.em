class TableColComponent extends Ember.Component

	tagName: 'th'

	col: null

	attributeBindings: ['style']
	style: ~> "width:#{@col.size}px".htmlSafe()

	didInsertElement: ->
		@col.renderer = "#" + Ember.$(@element).attr "id"

`export default TableColComponent`