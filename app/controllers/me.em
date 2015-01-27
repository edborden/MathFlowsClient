class MeController extends Ember.Controller

	actions:
		docEdit: (document) ->
			@transitionToRoute 'document',document
		newDoc: (document) ->
			@store.createRecord('document',{copyFrom:document,flow:document.flow}).save()
		newFolder: -> @store.createRecord('folder',{user:@session.me}).save()
		newFlow: (folder) -> @store.createRecord('flow',{folder:folder}).save()

`export default MeController`