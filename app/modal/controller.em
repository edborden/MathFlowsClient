class ModalController extends Ember.Controller

	actions:
		cancel: ->
			@model.rollback() if @model
			@send 'closeModal'

`export default ModalController`