`import TreeAccordianComponent from 'math-flows-client/components/tree-accordian'`

class FolderAccordianComponent extends TreeAccordianComponent

	drop: 'drop'

	actions:
		drop: (object,options) ->
			@sendAction 'drop',object,options
			
`export default FolderAccordianComponent`