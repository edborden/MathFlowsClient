ElRegister = Ember.Mixin.create
	
	didInsertElement: (element) ->
		Ember.$(@element).data('emberObject',@)

`export default ElRegister`