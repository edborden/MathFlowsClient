BlockCalc = Ember.Mixin.create

	pageMargin: null
	widgetMargin: null
	
	blockDimCalc: (pageDim,sliceNum) ->
		spaceBetweenMargin = pageDim - 2*@pageMargin
		totalWigitMargin = (sliceNum-1) * 2 * @widgetMargin
		workingSpace =  spaceBetweenMargin - totalWigitMargin
		workingSpace / sliceNum

`export default BlockCalc`