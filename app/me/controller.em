class MeController extends Ember.Controller

	model: ~> @session.me

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

		thisSomethingIsDragging: (something) ->
			@somethingIsDragging = something

		nothingIsDragging: ->
			@somethingIsDragging = null

		#newGroup: ->
		#	group = @store.createRecord('group').save()
		#	@model.group = group
		#invite: (email) -> @store.createRecord('invitation',{referrer:@model,referralEmail:email}).save()
		drop: (target,dropped) -> 
			#don't let a folder get dropped on itself or drop on childFolder
			#TODO: account for deeeeep childFolders
			unless dropped is target or target.folder is dropped 
				dropped.folder = target
				dropped.send 'becomeDirty' #changing belongsTo doesn't becomeDirty, known issue: https://github.com/emberjs/data/issues/2122
				@send 'saveModel',dropped
				@model.notifyPropertyChange 'topTestFolders'
				@model.notifyPropertyChange 'topStudentFolders'
		deleteDrop: (target,dropped) -> @send 'destroyModel',dropped
		#newStudent: (folder) ->
		#	model = @store.createRecord 'student',{folder:folder}
		#	@send 'openModal','modal/student',model

`export default MeController`