class BlockMenuComponent extends Ember.Component

	modeler: Ember.inject.service()
	store: Ember.inject.service()
	modaler: Ember.inject.service()

	block:null

	classNames: ['right-side']

	setInactiveBlock: 'setInactiveBlock'

	actions:
		toggleNumber: ->
			@block.toggleProperty 'question'
			@modeler.saveModel @block
			@refreshQuestionNumbers()
			@block.notifyPropertyChange 'width' #trigger width resize on equation box
		openFileDialog: ->
			cloudinary.openUploadWidget {upload_preset: 'fqd73ph6',cropping: 'server',show_powered_by:false}, (error, result) => 
				image = @store.createRecord 'image',
					block: @block
					cloudinaryId: result[0].public_id
					width: result[0].width
					height: result[0].height
				@modeler.saveModel image
		openGraphModal: -> @modaler.openModal 'graph-modal',@block
		cutBlock: -> 
			@block.removeFromPage()
			@block.test.notifyPropertyChange 'clipboard'
			@modeler.saveModel @block
			@sendAction 'setInactiveBlock',@block
		copyBlock: ->
			model = @store.createRecord 'block', {copyFromId:@block.id}
			@modeler.saveModel(model).then (response) -> console.log response
		destroyBlock: ->
			@sendAction 'setInactiveBlock',@block
			@send 'destroyModel',@block
			@refreshQuestionNumbers()
		destroyModel: (model) ->
			@modeler.destroyModel model

	refreshQuestionNumbers: -> @block.test.refreshQuestionNumbers() if @block.test?

`export default BlockMenuComponent`