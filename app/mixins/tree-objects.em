TreeObjects = Ember.Mixin.create

	editObj: 'editObj'
	copyObj: 'copyObj'

	actions:
		editObj: (obj,isStatic) ->
			@sendAction 'editObj',obj,isStatic
		copyObj: (obj) ->
			@sendAction 'copyObj',obj

`export default TreeObjects`