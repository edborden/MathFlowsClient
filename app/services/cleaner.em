class CleanerService extends Ember.Service

	clean: (line,mathquill) ->
		console.log 'cleaning'
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

		#handles removing space from between brackets when fields aren't filled in, causing issues in parsing in other places
		matches = latex.match /{ }/
		if matches
			for match in matches
				latex = latex.replace match,"{}"
		matches = latex.match /\[ ]/
		if matches
			for match in matches
				latex = latex.replace match,"[]"

		#fix for pasted text adding in \text{}
		if latex.match /\\text{.*}/
			for match in latex.match /\\text{.*}/
				latex = latex.replace match,match.substring(6,match.length-1)

		# Add back in leading \ to $
		#https://github.com/mathquill/mathquill/issues/382
		ar = latex.split " "
		for string,index in ar
			unless string.charAt(0) is "$" and string.charAt(string.length - 1) is "$"
				string = string.replace "$", "\\$"
				string = string.replace "\\\\$","\\$"
				ar.splice index,1,string
		latex = ar.join " "

		return latex


`export default CleanerService`