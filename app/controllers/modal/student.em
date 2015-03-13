class ModalStudentController extends Ember.Controller

	actions:
		newStudent: ->
			@model.save()

`export default ModalStudentController`