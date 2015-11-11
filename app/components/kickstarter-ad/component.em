class KickstarterAdComponent extends Ember.Component

  tagName: "a"
  href: "https://www.kickstarter.com/projects/mathflows/the-mathflows-grader"
  attributeBindings: ['href']

  endDate: Ember.computed -> new Date Date.UTC(2015, 11, 10, 0, 57)

`export default KickstarterAdComponent`