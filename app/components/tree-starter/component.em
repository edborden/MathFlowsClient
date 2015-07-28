`import HandlesDragging from 'math-flows-client/mixins/handles-dragging'`
`import TreeObjects from 'math-flows-client/mixins/tree-objects'`

class TreeStarterComponent extends Ember.Component with HandlesDragging,TreeObjects

	model:null
	children:null
	somethingIsDragging:null
	static:false
	name:Ember.computed.alias 'model.name'
	activeObj:null

`export default TreeStarterComponent`