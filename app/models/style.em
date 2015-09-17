`import ModelName from 'math-flows-client/mixins/model-name'`

attr = DS.attr
belongsTo = DS.belongsTo
hasMany = DS.hasMany

class Style extends DS.Model with ModelName
	line: belongsTo 'line', {async:false}
	effect: attr()

	css: (-> 
		switch @effect
			when "bold" then "font-weight:bold;"
			when "italic" then "font-style:italic;"
			when "underline" then "text-decoration:underline;"
			when "red" then "color:red;"
	).property "effect"

`export default Style`