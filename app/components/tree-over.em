class TreeOverComponent extends Ember.Component
	tree:null
	layoutName: 'components/tree-over'
	mouseOver: false
	classNames: ['inline']
	isEditing:false
	showEdit: ~> not @isEditing and @mouseOver

	mouseEnter: -> 
		@mouseOver = true
		false
	mouseLeave: ->
		@mouseOver = false

	actions:
		editClicked: -> 
			@isEditing = true
			false
		saveClicked: ->
			@tree.save() if @tree.isDirty
			@isEditing = false
		deleteClicked: -> @tree.destroyRecord()
			
`export default TreeOverComponent`