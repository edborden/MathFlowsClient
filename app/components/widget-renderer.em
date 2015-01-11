`import ElRegister from 'math-flows-client/mixins/el-register'`

class WidgetRendererComponent extends Ember.Component with ElRegister

	tagName: 'li'

	attributeBindings: ['data-sizex','data-sizey','data-row','data-col']
	"data-sizex": ~> @widget.width
	"data-sizey": ~> @widget.height
	"data-row": ~> @widget.row
	"data-col": ~> @widget.col

	doubleClick: -> 
		@sendAction 'action',@widget

	gridster: ~> @parentView.gridster

	didInsertElement: ->
		@_super()
		if @widget.isNew			
			@gridster.add_widget @element
			@syncAttrsToEl()

	syncAttrsToEl: ->
		@widget.width = $(@element).attr('data-sizex')
		@widget.height = $(@element).attr('data-sizey')
		@widget.row = $(@element).attr('data-row')
		@widget.col = $(@element).attr('data-col')
		@widget.save()
			
`export default WidgetRendererComponent`