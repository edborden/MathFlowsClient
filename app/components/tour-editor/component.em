`import FullEditorComponent from 'math-flows-client/components/full-editor/component'`
`import layout from 'math-flows-client/components/full-editor/template'`
`import modeler from 'math-flows-client/utils/modeler'`
saveModel = modeler.saveModel
service = Ember.inject.service
computed = Ember.computed
alias = computed.alias

class TourEditorComponent extends FullEditorComponent

	tour: service()
	session: service()

	layout: layout
	tourPreference: alias 'session.me.preference.tour'

	didInsertElement: ->
		if @tourPreference
			@tour.defaults = 
				showCancelLink: false
				highlightClass: 'highlight'
				classes: 'shepherd shepherd-open shepherd-theme-arrows shepherd-transparent-text'
			@tour.modal = true
			Ember.run.next @, => 
				Ember.$( Ember.$(".grid-stack-item-content")[7] ).click()
				@tour.steps = @steps()
				@tour.trigger 'start'
			@tourPreference = false
			saveModel @session.me.preference

	steps: -> [

		{}=
			options:
				attachTo:
					element: Ember.$(".grid-stack").children()[6]
					on: "right"
				text: ["This is the MathFlows test editor!", "You'll find it is made up of 'drag-and-drop' blocks of content, like this one, which is much better suited to creating test layouts than a word processor."]
				builtInButtons: [@nextButton()]
				when:
					show: -> window.scrollTo(0, 0)
					cancel: -> Ember.$(".grid-stack").children()[6].style.pointerEvents = "all"

		{}=
			options:
				attachTo:
					element: Ember.$(".mathquill-rendered-math")
					on: "left"
				text: ["You can type equations in-line just like you type text! No more equation editors!", "You can switch to 'math mode' with the '$' key."]
				builtInButtons: [@backButton(),@nextButton()]

		{}=
			options:
				attachTo:
					element: ".right-side"
					on: "left"
				text: ["When you click on any block, you'll bring up this menu.","Here, you can easily add content like images and graphs."]
				builtInButtons: [@backButton(),@nextButton()]

		{}=
			options:
				attachTo:
					element: Ember.$(".question-number:contains('2')")
					on: "left"
				text: ["Numbering is taken care of for you.","Whenever you change the position of a block on the page, MathFlows will automatically update every block's number."]
				builtInButtons: [@backButton(),@nextButton()]

		{}=
			options:
				attachTo:
					element: Ember.$(".left-side").children().first().children().last()[0]
					on: "right"
				text: ["Whenever you want, you can grab the PDF version of the test over here."]
				builtInButtons: [@backButton(),@nextButton()]

		{}=
			options:
				highlightClass: null
				attachTo: '.navbar bottom'
				text: ["That's it!","Login to save and organize tests and to share tests with other teachers in your department!"]
				builtInButtons: [@backButton(),@exitButton()]
				when:
					hide: -> Ember.$(".navbar")[0].style.pointerEvents = 'all'
	]

	backButton: ->
		classes: 'shepherd-button-secondary'
		text: 'Back'
		type: 'back'

	nextButton: ->
		classes: 'shepherd-button-primary'
		text: 'Next'
		type: 'next'

	exitButton: ->
		classes: 'shepherd-button-primary'
		text: 'Done'
		type: 'cancel'

`export default TourEditorComponent`