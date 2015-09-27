`import NewDimensions from 'math-flows-client/mixins/new-dimensions'`
`import modeler from 'math-flows-client/utils/modeler'`
saveModel = modeler.saveModel
destroyModel = modeler.destroyModel

class BlockMenuComponent extends Ember.Component with NewDimensions

	store: Ember.inject.service()
	modaler: Ember.inject.service()
	session:Ember.inject.service()
	static:null
	block:null

	classNames: ['right-side']

	setInactiveBlock: 'setInactiveBlock'

	actions:
		toggleNumber: ->
			@block.kind = if @block.question then 'directions' else 'question'
			saveModel @block
			@refreshQuestionNumbers()
			@block.notifyPropertyChange 'width' #trigger width resize on equation box
		openFileDialog: ->
			cloudinary.openUploadWidget {upload_preset: 'fqd73ph6',cropping: 'server',show_powered_by:false}, (error, result) => 
				newDimensions = @newDimensions result[0]
				image = @store.createRecord 'image',
					block: @block
					cloudinaryId: result[0].public_id
					width: newDimensions.width
					height: newDimensions.height
				image.setPosition()
				saveModel image
		openGraphModal: -> @modaler.openModal 'graph-modal',@block
		cutBlock: ->
			@block.removeFromPage()
			@session.me.notifyPropertyChange 'clipboard'
			saveModel @block
			@sendAction 'setInactiveBlock',@block
		copyBlock: ->
			block = @store.createRecord 'block', {copyFromId:@block.id}
			saveModel block
		destroyBlock: ->
			@sendAction 'setInactiveBlock',@block
			@send 'destroyModel',@block
			@refreshQuestionNumbers()
		destroyModel: (model) ->
			destroyModel model

	refreshQuestionNumbers: -> @block.test.refreshQuestionNumbers() if @block.test?

`export default BlockMenuComponent`