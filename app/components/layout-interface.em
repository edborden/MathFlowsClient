`import ElRegister from 'math-flows-client/mixins/el-register'`

class LayoutInterfaceComponent extends Ember.Component with ElRegister

	layoutName: 'components/layout-interface'
	classNames: ['layout-interface','gridster']

	gridster: null

	in: ~> 1.5 * 72
	rows: 8
	cols: 4
	widget_margin: ~> 0.08*@in
	widget_base_width: ~> 
		working_space = 7.5*@in - ((@cols-1) * 2 * @widget_margin) 
		working_space / @cols
	widget_base_height: ~>
		working_space = 10*@in - ((@rows-1) * 2 * @widget_margin)		
		working_space / @rows

	didInsertElement: ->
		@_super()
		@gridster = Ember.$(@element).children().first().gridster(
			widget_margins: [@widget_margin,@widget_margin],
			widget_base_dimensions: [@widget_base_width, @widget_base_height]
			max_cols: @cols
			min_cols: @cols
			resize: 
				enabled: true
				stop: @runSync
			draggable:
				stop: @runSync
		).data 'gridster'

	runSync: ->
		obj = Ember.$(".layout-interface").data 'emberObject'
		obj.syncChangedBlocks()

	syncChangedBlocks: ->
		for diffBlock in @blocksDiff 
			obj = Ember.$(diffBlock).data 'emberObject'
			obj.syncAttrsToEl()

	+volatile
	blockElArray: -> Ember.$('.block')

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

	actions:
		editBlock: (block) ->
			@sendAction 'action',block

`export default LayoutInterfaceComponent`