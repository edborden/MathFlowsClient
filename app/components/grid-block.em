`import ElRegister from 'math-flows-client/mixins/el-register'`

class GridBlockComponent extends Ember.Component with ElRegister

	#layoutName: 'components/grid-block'
	tagName: 'li'
	classNames: ['blockEl']

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
		Ember.run.next @,=>	
			if @block.isNew			
				@gridster.add_widget @element
				@syncAttrsToEl()
			else
				@syncElToAttrs()

	syncAttrsToEl: ->
		@block.width = $(@element).attr('data-sizex')
		@block.height = $(@element).attr('data-sizey')
		@block.row = $(@element).attr('data-row')
		@block.col = $(@element).attr('data-col')
		@block.save()

	syncElToAttrs: ->
		$(@element).attr('data-sizex',@block.width)
		$(@element).attr('data-sizey',@block.height)
		$(@element).attr('data-row',@block.row)
		$(@element).attr('data-col',@block.col)
			
`export default GridBlockComponent`