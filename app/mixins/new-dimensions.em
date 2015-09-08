NewDimensions = Ember.Mixin.create

	newDimensions: (obj) ->
		if obj.width < obj.height
			smallerDim = "width" 
			biggerDim = "height"
		else
			smallerDim = "height"
			biggerDim = "width"

		newSmallerDim = 150 * obj[smallerDim] / obj[biggerDim]
		newBiggerDim = 150
		
		newDimensions = {}
		newDimensions[smallerDim] = newSmallerDim
		newDimensions[biggerDim] = newBiggerDim
		return newDimensions

`export default NewDimensions`