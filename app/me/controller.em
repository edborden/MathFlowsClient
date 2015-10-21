`import modeler from 'math-flows-client/utils/modeler'`
saveModel = modeler.saveModel
destroyModel = modeler.destroyModel

service = Ember.inject.service
computed = Ember.computed
alias = computed.alias

class MeController extends Ember.Controller

	## ATTRIBUTES

	activeObj: null
	activeObjStatic:false

	## SERVICES

	eventer: service()
	server: service()

	## COMPUTED

	model: alias 'session.me'
	group: alias 'model.group'
	preference: alias 'model.preference'

	## ACTIONS

	actions:
		editObj: (test, isStatic) ->
			@activeObj = test
			@activeObjStatic = isStatic
			@eventer.triggerActiveObjChanged()
			false

		copyObj: (test) ->
			centerSpinner = Ember.$('.center-spinner')
			centerSpinner.show()
			@server.post('tests/' + test.id + '/copy').then (response) =>
				centerSpinner.hide()
				newTest = @store.peekRecord 'test',response.test.id
				@model.tests.pushObject newTest
				@model.testsCount = @model.testsCount + 1

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
				@send 'editObj', null #always set null, in case activeObj is test in folder
				@model.testsCount = @model.testsCount - 1 
			destroyModel dropped

`export default MeController`