questionNumber = (block,page) ->
	list = page.questionBlocks.sortBy 'row','col'
	index = list.indexOf(block) + 1
	index + "."

QuestionNumberHelper = Ember.Handlebars.makeBoundHelper questionNumber

`export { questionNumber }`

`export default QuestionNumberHelper`
