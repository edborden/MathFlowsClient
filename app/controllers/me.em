class MeController extends Ember.Controller

	actions:
		docEdit: (document) ->
			@transitionToRoute 'document',document
		newDoc: (document) ->
			@store.createRecord('document',{copyFrom:document,flow:document.flow}).save()
		newFolder: -> @store.createRecord('folder',{user:@session.me}).save()
		newFlow: (folder) -> @store.createRecord('flow',{folder:folder}).save()
		editHeader: -> 
			@transitionToRoute 'block',@session.me.header
		newGroup: ->
			group = @store.createRecord('group').save()
			@model.group = group
		invite: (email) -> @store.createRecord('invitation',{email:email}).save()

`export default MeController`