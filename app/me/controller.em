`import modeler from 'math-flows-client/utils/modeler'`
saveModel = modeler.saveModel
destroyModel = modeler.destroyModel

class MeController extends Ember.Controller

	model: Ember.computed.alias 'session.me'

	activeObj: null
	activeObjStatic:false

	actions:
		editObj: (test, isStatic) ->
			@activeObj = test
			@activeObjStatic = isStatic
			false

		copyObj: (test) ->
			centerSpinner = Ember.$('.center-spinner')
			centerSpinner.show()
			model = @store.createRecord('test',{copyFromId:test.id})
			saveModel(model).then =>
				centerSpinner.hide()

		newTestFolder: -> 
			model = @store.createRecord('folder',{user:@session.me,contents:"tests",name:"New Folder"})
			saveModel model

		newObj: (containingFolder) -> 
			model = @store.createRecord('test',{folder:containingFolder,name:"New Test"})
			saveModel model
			containingFolder.open = true
			saveModel containingFolder
			@model.testsCount = @model.testsCount + 1

		thisSomethingIsDragging: (something) ->
			@somethingIsDragging = something

		nothingIsDragging: ->
			@somethingIsDragging = null

		drop: (target,dropped) -> 
			#don't let a folder get dropped on itself or drop on childFolder
			#TODO: account for deeeeep childFolders
			unless dropped is target or target.folder is dropped 
				dropped.folder = target
				dropped.send 'becomeDirty' #changing belongsTo doesn't becomeDirty, known issue: https://github.com/emberjs/data/issues/2122
				saveModel dropped
				@model.notifyPropertyChange 'topTestFolders'
				
		deleteDrop: (target,dropped) -> 
			if dropped.isTest
				@send 'editObj', null, null
				@model.testsCount = @model.testsCount - 1 
			destroyModel dropped				

`export default MeController`