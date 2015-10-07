`import newdimensions from 'math-flows-client/utils/newdimensions'`
`import modeler from 'math-flows-client/utils/modeler'`
saveModel = modeler.saveModel
destroyModel = modeler.destroyModel

service = Ember.inject.service

class BlockMenuComponent extends Ember.Component

	# ATTRIBUTES

	static:null
	block:null
	classNames: ['right-side']

	# SERVICES

	store: service()
	modaler: service()
	session: service()

	# ACTIONS

	actions:
		toggleNumber: ->
			if @block.question
				@block.set 'kind','directions'
			else
				@block.set 'kind','question'
			saveModel @block
			@refreshQuestionNumbers()
			@block.notifyPropertyChange 'width' #trigger width resize on equation box
		openFileDialog: ->
			cloudinary.openUploadWidget {upload_preset: 'fqd73ph6',cropping: 'server',show_powered_by:false}, (error, result) => 
				newDimensions = newdimensions result[0]
				image = @store.createRecord 'image',
					block: @block
					cloudinaryId: result[0].public_id
					width: newDimensions.width
					height: newDimensions.height
				image.setPosition()
		openGraphModal: -> @modaler.openModal 'graph-modal',@block
		cutBlock: ->
			@block.removeFromPage()
			@session.me.notifyPropertyChange 'clipboard'
			saveModel @block
			@setActiveItem null
		copyBlock: ->
			block = @store.createRecord 'block', {copyFromId:@block.id}
			saveModel block
		destroyBlock: ->
			@setActiveItem null
			destroyModel model
			@refreshQuestionNumbers()

	refreshQuestionNumbers: -> @block.test.refreshQuestionNumbers() if @block.test?

`export default BlockMenuComponent`