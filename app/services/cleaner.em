class CleanerService extends Ember.Service

	clean: (line,mathquill) ->
		line.content = @latex mathquill.mathquill 'latex'

	latex: (latex) ->

		#fix for create math box then don't enter anything
		ar = latex.split ""
		for char,index in ar
			shouldRun = char is "$" and ar[index+1] is "$"
			while shouldRun
				ar.splice index,2
				shouldRun = char is "$" and ar[index+1] is "$"
		latex = ar.join ""

		console.log latex

		#fix for pasted text adding in \text{}
		if latex.match /\\text{.*}/
			for match in latex.match /\\text{.*}/
				latex = latex.replace match,match.substring(6,match.length-1)

		console.log latex

		# Add back in leading \ to $
		#https://github.com/mathquill/mathquill/issues/382


		latex = @replaceLeadingSlash latex


		#ar = latex.split " "
		#for string,index in ar
		#	unless string.charAt(0) is "$" and string.charAt(string.length - 1) is "$"
		#		string = string.replace "$", "\\$"
		#		string = string.replace "\\\\$","\\$"
		#		ar.splice index,1,string
		#latex = ar.join " "

		console.log latex

		return latex

	replaceLeadingSlash: (string) ->
		replaced = 0
		dollarIndexes = @findDollarIndexes string
		dollarIndexesInsideLatex = @findDollarIndexesInsideLatex string
		console.log dollarIndexes,dollarIndexesInsideLatex

		for index in dollarIndexes
			console.log index,@checkIfInsideLatex(index,dollarIndexesInsideLatex)
			unless @checkIfInsideLatex(index,dollarIndexesInsideLatex) or string[index-1+replaced] is "\\"
				string = @stringInsert string,index+replaced,"\\"
				replaced = replaced + 1

		return string

	stringInsert: (string, index, value) ->
		string.substr(0, index) + value + string.substr(index)

	checkIfInsideLatex: (index,latexIndexes) ->
		inside = false
		for latexObj in latexIndexes
			inside = true if index >= latexObj.start and index <= latexObj.end
		return inside

	findDollarIndexes: (string) ->
		regex = /\$/g
		indexes = []

		while match = regex.exec(string)
			indexes.push match.index

		return indexes

	findDollarIndexesInsideLatex: (string) ->
		regex = /(^|\s)\$.*\$($|\s)/g
		indexes = []

		while match = regex.exec(string)
			console.log match
			indexes.push
				start: match.index
				end: match.index+match[0].length-2

		return indexes


`export default CleanerService`