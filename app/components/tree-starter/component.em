`import modeler from 'math-flows-client/utils/modeler'`
saveModel = modeler.saveModel

`import HandlesDragging from 'math-flows-client/mixins/handles-dragging'`
`import TreeObjects from 'math-flows-client/mixins/tree-objects'`

alias = Ember.computed.alias

class TreeStarterComponent extends Ember.Component with HandlesDragging,TreeObjects

	## ATTRIBUTES

	model: null
	children: null
	somethingIsDragging: null
	static: false
	activeObj: null
	preference: null

	## COMPUTED

	name: alias 'model.name'
	meGroupHelp: alias 'preference.meGroupHelp'
	meTestHelp: alias 'preference.meTestHelp'

	actions:
		helpClick: (pref) ->
			console.log pref
			@preference.set pref, false
			saveModel @preference

`export default TreeStarterComponent`