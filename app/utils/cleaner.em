clean = (line,mathquill) ->
  content = mathquill.mathquill 'latex'
  content = removeDoubleDollars content
  content = pasteFix content
  #content = replaceLeadingSlashes content
  line.content = content 

pasteFix = (string) -> #fix for pasted text adding in \text{}
  if string.match /\\text{.*}/
    for match in string.match /\\text{.*}/
      string = string.replace match,match.substring(6,match.length-1)
  return string 

removeDoubleDollars = (string) -> #fix for create math box then don't enter anything
  ar = string.split ""
  for char,index in ar
    shouldRun = char is "$" and ar[index+1] is "$"
    while shouldRun
      ar.splice index,2
      shouldRun = char is "$" and ar[index+1] is "$"
  string = ar.join ""

replaceLeadingSlashes = (string) -> #this happens when entering '$' via mathquill('latex')
  replaced = 0
  dollarIndexes = findDollarIndexes string
  dollarIndexesInsideLatex = findDollarIndexesInsideLatex string

  for index in dollarIndexes
    unless checkIfInsideLatex(index,dollarIndexesInsideLatex) or string[index-1+replaced] is "\\"
      string = stringInsert string,index+replaced,"\\"
      replaced = replaced + 1

  return string

stringInsert = (string, index, value) ->
  string.substr(0, index) + value + string.substr(index)

checkIfInsideLatex = (index,latexIndexes) ->
  inside = false
  for latexObj in latexIndexes
    inside = true if index >= latexObj.start and index <= latexObj.end
  return inside

findDollarIndexes = (string) ->
  regex = /\$/g
  indexes = []

  while match = regex.exec(string)
    indexes.push match.index

  return indexes

findDollarIndexesInsideLatex = (string) ->
  indexes = []
  startFrom = 0

  while match = latexRegex string
    matchObject = 
      start: match.index+startFrom
      end: match.index+match[0].length-1+startFrom
    indexes.push matchObject

    startFrom = matchObject.end-1
    string = string.slice startFrom

  return indexes

latexRegex = (string) ->
  regex = /(^|\s)\$(.*?)\$($|\s)/g
  regex.exec string

`export default clean`