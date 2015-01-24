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
		window.grid = @gridster
		if @widget.isNew
			Ember.run.next @, =>
				@gridster.add_widget @element,parseInt(@widget.colSpan),parseInt(@widget.rowSpan)
				@syncAttrsToEl().then => @parentView.rerender()
			 
	syncAttrsToEl: ->
		return new Ember.RSVP.Promise (resolve) =>
			@widget.colSpan = $(@element).attr('data-sizex')
			@widget.rowSpan = $(@element).attr('data-sizey')
			@widget.row = $(@element).attr('data-row')
			@widget.col = $(@element).attr('data-col')
			@widget.save().then => resolve()

`export default WidgetRendererComponent`