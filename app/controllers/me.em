class MeController extends Ember.Controller

	actions:
		editDocument: (document) ->
			@transitionToRoute 'document',document
		copyDocument: (document) ->
			@store.createRecord('document',{copyFrom:document,flow:document.flow}).save()
		newFlowFolder: -> @store.createRecord('folder',{user:@session.me,flowFolder:true}).save()
		newStudentFolder: -> @store.createRecord('folder',{user:@session.me,studentFolder:true}).save()
		newFlow: (folder) -> @store.createRecord('flow',{folder:folder}).save()
		newGroup: ->
			group = @store.createRecord('group').save()
			@model.group = group
		invite: (email) -> @store.createRecord('invitation',{referrer:@model,referralEmail:email}).save()
		drop: (object,options) -> 
			object.isDraggingObject = false
			folder = options.target.model
			unless object is folder or object.isDocument #don't let an item get dropped on itself
				object.folder = folder
				object.save()
				@model.notifyPropertyChange 'topFlowFolders'
				@model.notifyPropertyChange 'topStudentFolders'
		deleteDrop: (object) -> object.destroyRecord()
		newStudent: (block) ->
			@sendAction 'openModal','modal/student',block

`export default MeController`