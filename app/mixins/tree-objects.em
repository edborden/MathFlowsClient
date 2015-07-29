TreeObjects = Ember.Mixin.create

	editObj: 'editObj'
	copyObj: 'copyObj'
	newObj: 'newObj'

	actions:
		newObj: (containingFolder) ->
			@sendAction 'newObj',containingFolder
		editObj: (obj,isStatic) ->
			@sendAction 'editObj',obj,isStatic
		copyObj: (obj) ->
			@sendAction 'copyObj',obj

`export default TreeObjects`