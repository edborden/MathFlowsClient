`import ElRegister from 'math-flows-client/mixins/el-register'`

class GridSterComponent extends Ember.Component with ElRegister

	layoutName: 'components/grid-ster'
	tagName: 'ul'
	classNames: ['gridster']

	gridster: null

	didInsertElement: ->
		@gridster = Ember.$(@element).gridster(
			widget_margins: [10, 10],
			widget_base_dimensions: [200, 100]
			max_cols: 4
			min_cols: 4
			resize: 
				enabled: true
				stop: @runSync
			draggable:
				stop: @runSync
		).data('gridster')

	runSync: (e) ->
		el = e.target
		el = el.parentElement if el.tagName is 'SPAN'
		obj = Ember.$(el).data 'emberObject'
		parent = obj.parentView		
		parent.syncChangedBlocks()

	syncChangedBlocks: ->
		for diffBlock in @blocksDiff 
			obj = Ember.$(diffBlock).data 'emberObject'
			obj.syncAttrsToEl()

	+volatile
	blockElArray: -> Ember.$('.blockEl')

	# Block elements that are different from their models
	+volatile
	blocksDiff: -> 
		@blockElArray.filter (idx,el) =>
			obj = Ember.$(el).data('emberObject').block
			@widthIsDiff(el,obj) or @heightIsDiff(el,obj) or @rowIsDiff(el,obj) or @colIsDiff(el,obj)
			
	widthIsDiff: (el,obj) -> obj.width isnt parseInt $(el).attr('data-sizex')
	heightIsDiff: (el,obj) -> obj.height isnt parseInt $(el).attr('data-sizey')
	rowIsDiff: (el,obj) -> obj.row isnt parseInt $(el).attr('data-row')
	colIsDiff: (el,obj) -> obj.col isnt parseInt $(el).attr('data-col')

	syncBlockAttrsToEl: (block) ->
		el = e.target
		obj = Ember.$(el).data 'emberObject'
		obj.syncAttrsToEl()

	actions:
		editBlock: (block) ->
			@sendAction 'action',block

`export default GridSterComponent`