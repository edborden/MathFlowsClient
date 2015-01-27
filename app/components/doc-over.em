`import TreeOverComponent from 'math-flows-client/components/tree-over'`

class DocOverComponent extends TreeOverComponent
	action: 'docEdit'
	copyAction: 'newDoc'
	canCopy:true

	actions:
		editClicked: -> 
			@sendAction 'action', @tree
		copyClicked: ->
			@sendAction 'copyAction',@tree
			
`export default DocOverComponent`