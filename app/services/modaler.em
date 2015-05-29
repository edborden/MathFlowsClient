class ModalerService extends Ember.Service

	showModal:false
	modalName: null
	modalModel: null

	openModal: (name,model) ->
		@modalName = name
		@modalModel = model
		@showModal = true
		
	closeModal: ->
		@showModal = false
		@modalName = null
		@modalModel = null

`export default ModalerService`