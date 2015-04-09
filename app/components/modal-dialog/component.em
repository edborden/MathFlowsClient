class ModalDialogComponent extends Ember.Component

	classNames: ['modal']

	didInsertElement: ->
		Ember.$(@element).modal(
			keyboard: false
			backdrop: 'static'
		).on 'hidden.bs.modal', ( ->
			this.sendAction 'close'
		).bind this

	actions:
		ok: ->
			@sendAction 'ok'
			Ember.$('.modal-cancel').click()

`export default ModalDialogComponent`