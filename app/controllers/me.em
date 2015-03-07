class MeController extends Ember.Controller

	actions:
		docEdit: (document) ->
			@transitionToRoute 'document',document
		newDoc: (document) ->
			@store.createRecord('document',{copyFrom:document,flow:document.flow}).save()
		newFolder: -> @store.createRecord('folder',{user:@session.me}).save()
		newFlow: (folder) -> @store.createRecord('flow',{folder:folder}).save()
		newGroup: ->
			group = @store.createRecord('group').save()
			@model.group = group
		invite: (email) -> @store.createRecord('invitation',{referrer:@model,referralEmail:email}).save()
		drop: (object,options) -> 
			object.isDraggingObject = false
			folder = options.target.model
			object.folder = folder
			object.save()
			@model.notifyPropertyChange 'topFolders'

`export default MeController`