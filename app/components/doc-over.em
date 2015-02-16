`import MouseOverComponent from 'math-flows-client/components/mouse-over'`

class DocOverComponent extends MouseOverComponent
	action: 'docEdit'
	copyAction: 'newDoc'
	canCopy:true

	actions:
		editClicked: -> 
			@sendAction 'action', @tree
		copyClicked: ->
			@sendAction 'copyAction',@tree
			
`export default DocOverComponent`