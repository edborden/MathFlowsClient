`import config from 'math-flows-client/config/environment'`

attr = DS.attr

class Layout extends DS.Model

	in: ~> 1.5 * 72
	blocks: DS.hasMany 'block'
	pdfLink: ~> config.apiHostName+'/layouts/'+@id+'?token='+@session.token
	cols: attr "number"
	rows: attr "number"
	pageWidth: attr "number"
	pageHeight: attr "number"
	pageMargin: ~> 0.5*@in
	blockMargin: ~> 0.08*@in
	blockBaseWidth: ~> @blockDimCalc @pageWidth*@in,@cols
	blockBaseHeight: ~> @blockDimCalc @pageHeight*@in,@rows

	blockDimCalc: (pageDim,sliceNum) ->
		spaceBetweenMargin = pageDim - 2*@pageMargin
		totalWigitMargin = (sliceNum-1) * 2 * @blockMargin
		workingSpace =  spaceBetweenMargin - totalWigitMargin
		workingSpace / sliceNum

`export default Layout`