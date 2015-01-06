`import ElRegister from 'math-flows-client/mixins/el-register'`

class GridBlockComponent extends Ember.Component with ElRegister

	layoutName: 'components/block-content'
	tagName: 'li'
	classNames: ['block']

	attributeBindings: ['data-sizex','data-sizey','data-row','data-col']
	"data-sizex": ~> @block.width
	"data-sizey": ~> @block.height
	"data-row": ~> @block.row
	"data-col": ~> @block.col

	doubleClick: -> 
		@sendAction 'action',@block

	gridster: ~> @parentView.gridster

	didInsertElement: ->
		@_super()
		if @block.isNew			
			@gridster.add_widget @element
			@syncAttrsToEl()

	syncAttrsToEl: ->
		@block.width = $(@element).attr('data-sizex')
		@block.height = $(@element).attr('data-sizey')
		@block.row = $(@element).attr('data-row')
		@block.col = $(@element).attr('data-col')
		@block.save()
			
`export default GridBlockComponent`