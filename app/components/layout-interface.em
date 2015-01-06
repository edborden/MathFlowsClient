`import ElRegister from 'math-flows-client/mixins/el-register'`

class LayoutInterfaceComponent extends Ember.Component with ElRegister

	layoutName: 'components/layout-interface'
	tagName: 'ul'
	classNames: ['gridster']

	gridster: null

	didInsertElement: ->
		@_super()
		@gridster = Ember.$(@element).gridster(
			widget_margins: [5, 5],
			widget_base_dimensions: [200, 100]
			max_cols: 4
			min_cols: 4
			resize: 
				enabled: true
				stop: @runSync
			draggable:
				stop: @runSync
		).data 'gridster'

	runSync: ->
		obj = Ember.$(".gridster").data 'emberObject'
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