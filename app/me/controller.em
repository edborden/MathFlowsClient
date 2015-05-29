class MeController extends Ember.Controller

	actions:
		editObj: (test) ->
			@transitionToRoute 'page',test.pages.firstObject

		copyObj: (test) ->
			model = @store.createRecord('test',{copyFromId:test.id})
			@send 'saveModel',model

		newTestFolder: -> 
			model = @store.createRecord('folder',{user:@session.me,testFolder:true,name:"New Folder"})
			@send 'saveModel',model

		newStudentFolder: -> 
			model = @store.createRecord('folder',{user:@session.me,studentFolder:true,name:"New Folder"})
			@send 'saveModel',model

		newObj: (containingFolder) -> 
			model = @store.createRecord('test',{folder:containingFolder,name:"New Test"})
			@send 'saveModel',model
			containingFolder.open = true
			@send 'saveModel',containingFolder

		#newGroup: ->
		#	group = @store.createRecord('group').save()
		#	@model.group = group
		#invite: (email) -> @store.createRecord('invitation',{referrer:@model,referralEmail:email}).save()
		drop: (object,options) -> 
			object.isDraggingObject = false
			folder = options.target.model
			unless object is folder #don't let an item get dropped on itself
				object.folder = folder
				@send 'saveModel',object
				@model.notifyPropertyChange 'topTestFolders'
				@model.notifyPropertyChange 'topStudentFolders'
		deleteDrop: (object) -> object.destroyRecord()
		#newStudent: (folder) ->
		#	model = @store.createRecord 'student',{folder:folder}
		#	@send 'openModal','modal/student',model

`export default MeController`