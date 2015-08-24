`import ActiveBlock from 'math-flows-client/mixins/active-block'`

class MeController extends Ember.Controller with ActiveBlock

	model: Ember.computed.alias 'session.me'
	modeler:Ember.inject.service()

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
			@modeler.saveModel(model).then =>
				centerSpinner.hide()

		newTestFolder: -> 
			model = @store.createRecord('folder',{user:@session.me,testFolder:true,name:"New Folder"})
			@modeler.saveModel model

		newObj: (containingFolder) -> 
			model = @store.createRecord('test',{folder:containingFolder,name:"New Test"})
			@modeler.saveModel model
			containingFolder.open = true
			@modeler.saveModel containingFolder
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
				@modeler.saveModel dropped
				@model.notifyPropertyChange 'topTestFolders'
				
		deleteDrop: (target,dropped) -> 
			@modeler.destroyModel dropped
			@model.testsCount = @model.testsCount - 1 if dropped.isTest

`export default MeController`