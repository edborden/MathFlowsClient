`import newdimensions from 'math-flows-client/utils/newdimensions'`
`import modeler from 'math-flows-client/utils/modeler'`
saveModel = modeler.saveModel
destroyModel = modeler.destroyModel

service = Ember.inject.service
alias = Ember.computed.alias

class BlockMenuComponent extends Ember.Component

	# ATTRIBUTES

	static:null
	block:null

	# SERVICES

	store: service()
	modaler: service()
	session: service()
	server: service()
	keen: service()

	# COMPUTED

	page: alias 'block.page'

	# ACTIONS

	actions:
		toggleNumber: ->
			@keen.addEditorEvent 'toggleNumber', @block
			if @block.question
				@block.set 'kind','directions'
			else
				@block.set 'kind','question'
			saveModel @block
			@page.refreshQuestionNumbers() if @page?

		openFileDialog: ->
			cloudinary.openUploadWidget {upload_preset: 'fqd73ph6',cropping: 'server',show_powered_by:false}, (error, result) => 
				newDimensions = newdimensions result[0]
				image = @store.createRecord 'image',
					block: @block
					cloudinaryId: result[0].public_id
					width: newDimensions.width
					height: newDimensions.height
				image.setPosition()
				@keen.addEditorEvent 'createImage', image

		openGraphModal: -> @modaler.openModal 'graph-modal',@block

		cutBlock: ->
			page = @page
			@keen.addEditorEvent 'cutBlock', @block
			block = @block
			@setActiveItem null
			block.removeFromPage()
			@session.me.clips.addObject block
			saveModel block
			page.notifyPropertyChange 'invalidBlocks'

		copyBlock: ->
			@keen.addEditorEvent 'copyBlock', @block
			@server.post('blocks/' + @block.id + '/copy').then (response) =>
				newBlock = @store.peekRecord 'block',response.block.id
				@session.me.clips.pushObject newBlock

		destroyBlock: ->
			@setActiveItem null
			destroyModel @block
			@page.notifyPropertyChange 'invalidBlocks' if @page?

`export default BlockMenuComponent`