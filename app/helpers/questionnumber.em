questionNumber = (block,page) ->
	index = page.document.questionBlocksSorted.indexOf(block) + 1
	index + "."

QuestionNumberHelper = Ember.Handlebars.makeBoundHelper questionNumber

`export { questionNumber }`

`export default QuestionNumberHelper`
