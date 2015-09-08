`import NewDimensions from 'math-flows-client/mixins/new-dimensions'`

class BlockMenuComponent extends Ember.Component with NewDimensions

	modeler: Ember.inject.service()
	store: Ember.inject.service()
	modaler: Ember.inject.service()
	static:null
	block:null

	classNames: ['right-side']

	setInactiveBlock: 'setInactiveBlock'

	actions:
		toggleNumber: ->
			@block.kind = if @block.question then 'directions' else 'question'
			@modeler.saveModel @block
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
				@modeler.saveModel image
		openGraphModal: -> @modaler.openModal 'graph-modal',@block
		cutBlock: -> 
			@block.removeFromPage()
			@block.test.notifyPropertyChange 'clipboard'
			@modeler.saveModel @block
			@sendAction 'setInactiveBlock',@block
		copyBlock: ->
			block = @store.createRecord 'block', {copyFromId:@block.id}
			@modeler.saveModel block
		destroyBlock: ->
			@sendAction 'setInactiveBlock',@block
			@send 'destroyModel',@block
			@refreshQuestionNumbers()
		destroyModel: (model) ->
			@modeler.destroyModel model
		addTable: ->
			table = @store.createRecord 'table',{ rowsCount:2,colsCount:2,block:@block }
			@modeler.saveModel table
			@block.table = table

	refreshQuestionNumbers: -> @block.test.refreshQuestionNumbers() if @block.test?

`export default BlockMenuComponent`