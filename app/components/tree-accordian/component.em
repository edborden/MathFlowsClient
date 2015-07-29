`import HandlesDragging from 'math-flows-client/mixins/handles-dragging'`
`import TreeObjects from 'math-flows-client/mixins/tree-objects'`

class TreeAccordianComponent extends Ember.Component with HandlesDragging,TreeObjects

	model:null
	static: null
	folders: Ember.computed.alias 'model.folders'
	children: Ember.computed.alias 'model.children'
	activeObj:null

	mouseOver: false

	mouseEnter: -> 
		@mouseOver = true
		false
	mouseLeave: ->
		@mouseOver = false
			
`export default TreeAccordianComponent`