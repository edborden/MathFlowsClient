class MeController extends Ember.Controller

	actions:
		docEdit: (document) ->
			@transitionToRoute 'document',document
		newDoc: (flow) ->
			@store.createRecord('document',{flow:flow}).save()
		newFolder: -> @store.createRecord('folder',{user:@session.me}).save()
		newFlow: (folder) -> @store.createRecord('flow',{folder:folder}).save()

`export default MeController`