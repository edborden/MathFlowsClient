class ModalDialogComponent extends Ember.Component

	didInsertElement: ->
		Ember.$('.modal').modal(
			keyboard: false
			backdrop: 'static'
		).on 'hidden.bs.modal', ( ->
			this.sendAction 'close'
		).bind this

	actions:
		ok: ->
			@sendAction 'ok'
			@sendAction 'close'

`export default ModalDialogComponent`