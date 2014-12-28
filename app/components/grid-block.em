class GridBlockComponent extends Ember.Component

	height: null
	width: null

	#layoutName: 'components/grid-block'
	tagName: 'li'

	attributeBindings: ['data-sizex','data-sizey','data-row','data-col']
	"data-sizex": ~> @width or 1
	"data-sizey": ~> @height or 1
	"data-row": ~> @row or 1
	"data-col": ~> @col or 1

	+observer row
	onRowChange: -> console.log @row

	content: null

	doubleClick: -> 
		@sendAction 'action',@block
			
`export default GridBlockComponent`