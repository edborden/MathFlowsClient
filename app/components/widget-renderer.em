`import ElRegister from 'math-flows-client/mixins/el-register'`

class WidgetRendererComponent extends Ember.Component with ElRegister

	tagName: 'li'

	doubleClick: -> 
		@sendAction 'action',@widget

	attributeBindings: ['data-sizex','data-sizey','data-row','data-col']
	"data-sizex": ~> @widget.colSpan
	"data-sizey": ~> @widget.rowSpan
	"data-row": ~> @widget.row
	"data-col": ~> @widget.col

	gridster: ~> @parentView.gridster

	didInsertElement: ->
		@_super()
		if @widget.isNew			
			@gridster.add_widget @element
			@syncAttrsToEl()			
			 
	syncAttrsToEl: ->
		@widget.colSpan = $(@element).attr('data-sizex')
		@widget.rowSpan = $(@element).attr('data-sizey')
		@widget.row = $(@element).attr('data-row')
		@widget.col = $(@element).attr('data-col')
		@widget.save()

`export default WidgetRendererComponent`