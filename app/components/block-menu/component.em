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

	test: alias 'block.test'

	# ACTIONS

	actions:
		toggleNumber: ->
			if @block.question
				@block.set 'kind','directions'
			else
				@block.set 'kind','question'
			saveModel @block
			@test.refreshQuestionNumbers() if @test?
			@keen.toggleNumber @block

		openFileDialog: ->
			cloudinary.openUploadWidget {upload_preset: 'fqd73ph6',cropping: 'server',show_powered_by:false}, (error, result) => 
				newDimensions = newdimensions result[0]
				image = @store.createRecord 'image',
					block: @block
					cloudinaryId: result[0].public_id
					width: newDimensions.width
					height: newDimensions.height
				image.setPosition()
				@keen.createImage image


		openGraphModal: -> @modaler.openModal 'graph-modal',@block

		cutBlock: ->
			block = @block
			@setActiveItem null
			block.removeFromPage()
			@session.me.notifyPropertyChange 'clipboard'
			saveModel block
			@keen.cutBlock @block

		copyBlock: ->
			@server.post('blocks/' + @block.id + '/copy').then =>
				@session.me.notifyPropertyChange 'clipboard'
			@keen.copyBlock @block

		destroyBlock: ->
			@keen.destroyBlock @block
			@setActiveItem null
			destroyModel @block

`export default BlockMenuComponent`