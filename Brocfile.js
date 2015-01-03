/* global require, module */

var EmberApp = require('ember-cli/lib/broccoli/ember-app');

var app = new EmberApp();

require('broccoli-ember-script')(app.toTree())

var pickFiles = require('broccoli-static-compiler');
var mergeTrees = require('broccoli-merge-trees');

// Use `app.import` to add additional libraries to the generated
// output files.
//
// If you need to use different assets in different
// environments, specify an object as the first parameter. That
// object's keys should be the environment name and the values
// should be the asset to use in that environment.
//
// If the library that you are including contains AMD or ES6
// modules that you would like to import into your application
// please specify an object with the list of modules as keys
// along with the exports of each module as its value.

// jsPDF
app.import('bower_components/jspdf/dist/jspdf.min.js');

// jspdf HTML2Canvas
app.import('bower_components/html2canvas/build/html2canvas.min.js');

// Gridster
app.import('bower_components/gridster.js/dist/jquery.gridster.min.js');
app.import('bower_components/gridster.js/dist/jquery.gridster.min.css');

// Underscore (equation editor dependency)
app.import('bower_components/equation-editor/src/lib/underscore-1.6.0.js');

// Equation-Editor
app.import('bower_components/equation-editor/src/lib/mousetrap-1.4.6.js');
var equationEditorFonts = pickFiles('bower_components/equation-editor/src/Fonts', {
    srcDir: '/',
	destDir: '/fonts'
});
var equationEditorImages = pickFiles('bower_components/equation-editor/src/Images', {
    srcDir: '/',
	destDir: 'assets/images/equation-editor'
});
var equationEditorMenuImages = pickFiles('bower_components/equation-editor/src/MenuImages', {
    srcDir: '/',
	destDir: 'assets/images/equation-editor/MenuImages'
});

app.import('bower_components/equation-editor/src/app/js/property.js');
app.import('bower_components/equation-editor/src/app/js/init.js');
app.import('bower_components/equation-editor/src/app/js/symbolSizeConfiguration.js');
app.import('bower_components/equation-editor/src/app/js/equation.js');
app.import('bower_components/equation-editor/src/app/js/equationDom.js');
app.import('bower_components/equation-editor/src/app/js/container.js');
app.import('bower_components/equation-editor/src/app/js/containerDom.js');
app.import('bower_components/equation-editor/src/app/js/wrapper.js');
app.import('bower_components/equation-editor/src/app/js/wrapperDom.js');
app.import('bower_components/equation-editor/src/app/js/symbol.js');
app.import('bower_components/equation-editor/src/app/js/symbolWrapper.js');
app.import('bower_components/equation-editor/src/app/js/operatorWrapper.js');
app.import('bower_components/equation-editor/src/app/js/emptyContainerWrapper.js');
app.import('bower_components/equation-editor/src/app/js/topLevelEmptyContainerWrapper.js');
app.import('bower_components/equation-editor/src/app/js/topLevelEmptyContainerMessage.js');
app.import('bower_components/equation-editor/src/app/js/squareEmptyContainerWrapper.js');
app.import('bower_components/equation-editor/src/app/js/squareEmptyContainer.js');
app.import('bower_components/equation-editor/src/app/js/squareEmptyContainerFillerWrapper.js');
app.import('bower_components/equation-editor/src/app/js/stackedFractionWrapper.js');
app.import('bower_components/equation-editor/src/app/js/stackedFractionNumeratorContainer.js');
app.import('bower_components/equation-editor/src/app/js/stackedFractionDenominatorContainer.js');
app.import('bower_components/equation-editor/src/app/js/stackedFractionHorizontalBar.js');
app.import('bower_components/equation-editor/src/app/js/superscriptWrapper.js');
app.import('bower_components/equation-editor/src/app/js/superscriptContainer.js');
app.import('bower_components/equation-editor/src/app/js/subscriptWrapper.js');
app.import('bower_components/equation-editor/src/app/js/subscriptContainer.js');
app.import('bower_components/equation-editor/src/app/js/superscriptAndSubscriptWrapper.js');
app.import('bower_components/equation-editor/src/app/js/squareRootWrapper.js');
app.import('bower_components/equation-editor/src/app/js/squareRootOverBar.js');
app.import('bower_components/equation-editor/src/app/js/squareRootRadical.js');
app.import('bower_components/equation-editor/src/app/js/squareRootDiagonal.js');
app.import('bower_components/equation-editor/src/app/js/squareRootRadicandContainer.js');
app.import('bower_components/equation-editor/src/app/js/nthRootWrapper.js');
app.import('bower_components/equation-editor/src/app/js/nthRootOverBar.js');
app.import('bower_components/equation-editor/src/app/js/nthRootRadical.js');
app.import('bower_components/equation-editor/src/app/js/nthRootDiagonal.js');
app.import('bower_components/equation-editor/src/app/js/nthRootRadicandContainer.js');
app.import('bower_components/equation-editor/src/app/js/nthRootDegreeContainer.js');
app.import('bower_components/equation-editor/src/app/js/bracketWrapper.js');
app.import('bower_components/equation-editor/src/app/js/bracket.js');
app.import('bower_components/equation-editor/src/app/js/wholeBracket.js');
app.import('bower_components/equation-editor/src/app/js/topBracket.js');
app.import('bower_components/equation-editor/src/app/js/middleBracket.js');
app.import('bower_components/equation-editor/src/app/js/bottomBracket.js');
app.import('bower_components/equation-editor/src/app/js/leftBracket.js');
app.import('bower_components/equation-editor/src/app/js/rightBracket.js');
app.import('bower_components/equation-editor/src/app/js/leftParenthesisBracket.js');
app.import('bower_components/equation-editor/src/app/js/rightParenthesisBracket.js');
app.import('bower_components/equation-editor/src/app/js/leftParenthesisWholeBracket.js');
app.import('bower_components/equation-editor/src/app/js/leftParenthesisTopBracket.js');
app.import('bower_components/equation-editor/src/app/js/leftParenthesisMiddleBracket.js');
app.import('bower_components/equation-editor/src/app/js/leftParenthesisBottomBracket.js');
app.import('bower_components/equation-editor/src/app/js/rightParenthesisWholeBracket.js');
app.import('bower_components/equation-editor/src/app/js/rightParenthesisTopBracket.js');
app.import('bower_components/equation-editor/src/app/js/rightParenthesisMiddleBracket.js');
app.import('bower_components/equation-editor/src/app/js/rightParenthesisBottomBracket.js');
app.import('bower_components/equation-editor/src/app/js/leftSquareBracket.js');
app.import('bower_components/equation-editor/src/app/js/leftSquareWholeBracket.js');
app.import('bower_components/equation-editor/src/app/js/leftSquareTopBracket.js');
app.import('bower_components/equation-editor/src/app/js/leftSquareMiddleBracket.js');
app.import('bower_components/equation-editor/src/app/js/leftSquareBottomBracket.js');
app.import('bower_components/equation-editor/src/app/js/rightSquareBracket.js');
app.import('bower_components/equation-editor/src/app/js/rightSquareWholeBracket.js');
app.import('bower_components/equation-editor/src/app/js/rightSquareTopBracket.js');
app.import('bower_components/equation-editor/src/app/js/rightSquareMiddleBracket.js');
app.import('bower_components/equation-editor/src/app/js/rightSquareBottomBracket.js');
app.import('bower_components/equation-editor/src/app/js/leftCurlyBracket.js');
app.import('bower_components/equation-editor/src/app/js/leftCurlyWholeBracket.js');
app.import('bower_components/equation-editor/src/app/js/leftCurlyTopBracket.js');
app.import('bower_components/equation-editor/src/app/js/leftCurlyMiddleBracket.js');
app.import('bower_components/equation-editor/src/app/js/leftCurlyBottomBracket.js');
app.import('bower_components/equation-editor/src/app/js/rightCurlyBracket.js');
app.import('bower_components/equation-editor/src/app/js/rightCurlyWholeBracket.js');
app.import('bower_components/equation-editor/src/app/js/rightCurlyTopBracket.js');
app.import('bower_components/equation-editor/src/app/js/rightCurlyMiddleBracket.js');
app.import('bower_components/equation-editor/src/app/js/rightCurlyBottomBracket.js');
app.import('bower_components/equation-editor/src/app/js/leftAngleBracket.js');
app.import('bower_components/equation-editor/src/app/js/leftAngleWholeBracket.js');
app.import('bower_components/equation-editor/src/app/js/rightAngleBracket.js');
app.import('bower_components/equation-editor/src/app/js/rightAngleWholeBracket.js');
app.import('bower_components/equation-editor/src/app/js/leftFloorBracket.js');
app.import('bower_components/equation-editor/src/app/js/leftFloorWholeBracket.js');
app.import('bower_components/equation-editor/src/app/js/leftFloorMiddleBracket.js');
app.import('bower_components/equation-editor/src/app/js/leftFloorBottomBracket.js');
app.import('bower_components/equation-editor/src/app/js/rightFloorBracket.js');
app.import('bower_components/equation-editor/src/app/js/rightFloorWholeBracket.js');
app.import('bower_components/equation-editor/src/app/js/rightFloorMiddleBracket.js');
app.import('bower_components/equation-editor/src/app/js/rightFloorBottomBracket.js');
app.import('bower_components/equation-editor/src/app/js/leftCeilBracket.js');
app.import('bower_components/equation-editor/src/app/js/leftCeilWholeBracket.js');
app.import('bower_components/equation-editor/src/app/js/leftCeilTopBracket.js');
app.import('bower_components/equation-editor/src/app/js/leftCeilMiddleBracket.js');
app.import('bower_components/equation-editor/src/app/js/rightCeilBracket.js');
app.import('bower_components/equation-editor/src/app/js/rightCeilWholeBracket.js');
app.import('bower_components/equation-editor/src/app/js/rightCeilTopBracket.js');
app.import('bower_components/equation-editor/src/app/js/rightCeilMiddleBracket.js');
app.import('bower_components/equation-editor/src/app/js/leftAbsValBracket.js');
app.import('bower_components/equation-editor/src/app/js/rightAbsValBracket.js');
app.import('bower_components/equation-editor/src/app/js/leftAbsValWholeBracket.js');
app.import('bower_components/equation-editor/src/app/js/leftAbsValMiddleBracket.js');
app.import('bower_components/equation-editor/src/app/js/rightAbsValWholeBracket.js');
app.import('bower_components/equation-editor/src/app/js/rightAbsValMiddleBracket.js');
app.import('bower_components/equation-editor/src/app/js/leftNormBracket.js');
app.import('bower_components/equation-editor/src/app/js/rightNormBracket.js');
app.import('bower_components/equation-editor/src/app/js/leftNormWholeBracket.js');
app.import('bower_components/equation-editor/src/app/js/leftNormMiddleBracket.js');
app.import('bower_components/equation-editor/src/app/js/rightNormWholeBracket.js');
app.import('bower_components/equation-editor/src/app/js/rightNormMiddleBracket.js');
app.import('bower_components/equation-editor/src/app/js/bracketPairWrapper.js');
app.import('bower_components/equation-editor/src/app/js/bracketContainer.js');
app.import('bower_components/equation-editor/src/app/js/bigOperatorWrapper.js');
app.import('bower_components/equation-editor/src/app/js/bigOperatorUpperLimitContainer.js');
app.import('bower_components/equation-editor/src/app/js/bigOperatorLowerLimitContainer.js');
app.import('bower_components/equation-editor/src/app/js/bigOperatorOperandContainer.js');
app.import('bower_components/equation-editor/src/app/js/bigOperatorSymbol.js');
app.import('bower_components/equation-editor/src/app/js/sumBigOperatorSymbol.js');
app.import('bower_components/equation-editor/src/app/js/bigCapBigOperatorSymbol.js');
app.import('bower_components/equation-editor/src/app/js/bigCupBigOperatorSymbol.js');
app.import('bower_components/equation-editor/src/app/js/bigSqCapBigOperatorSymbol.js');
app.import('bower_components/equation-editor/src/app/js/bigSqCupBigOperatorSymbol.js');
app.import('bower_components/equation-editor/src/app/js/bigSqCupBigOperatorSymbol.js');
app.import('bower_components/equation-editor/src/app/js/prodBigOperatorSymbol.js');
app.import('bower_components/equation-editor/src/app/js/coProdBigOperatorSymbol.js');
app.import('bower_components/equation-editor/src/app/js/bigVeeBigOperatorSymbol.js');
app.import('bower_components/equation-editor/src/app/js/bigWedgeBigOperatorSymbol.js');
app.import('bower_components/equation-editor/src/app/js/integralWrapper.js');
app.import('bower_components/equation-editor/src/app/js/integralSymbol.js');
app.import('bower_components/equation-editor/src/app/js/doubleIntegralSymbol.js');
app.import('bower_components/equation-editor/src/app/js/tripleIntegralSymbol.js');
app.import('bower_components/equation-editor/src/app/js/contourIntegralSymbol.js');
app.import('bower_components/equation-editor/src/app/js/contourDoubleIntegralSymbol.js');
app.import('bower_components/equation-editor/src/app/js/contourTripleIntegralSymbol.js');
app.import('bower_components/equation-editor/src/app/js/integralUpperLimitContainer.js');
app.import('bower_components/equation-editor/src/app/js/integralLowerLimitContainer.js');
app.import('bower_components/equation-editor/src/app/js/word.js');
app.import('bower_components/equation-editor/src/app/js/functionWord.js');
app.import('bower_components/equation-editor/src/app/js/functionWrapper.js');
app.import('bower_components/equation-editor/src/app/js/functionLowerWrapper.js');
app.import('bower_components/equation-editor/src/app/js/functionLowerWord.js');
app.import('bower_components/equation-editor/src/app/js/functionLowerContainer.js');
app.import('bower_components/equation-editor/src/app/js/logLowerWrapper.js');
app.import('bower_components/equation-editor/src/app/js/logLowerWord.js');
app.import('bower_components/equation-editor/src/app/js/logLowerContainer.js');
app.import('bower_components/equation-editor/src/app/js/limitWrapper.js');
app.import('bower_components/equation-editor/src/app/js/limitLeftContainer.js');
app.import('bower_components/equation-editor/src/app/js/limitRightContainer.js');
app.import('bower_components/equation-editor/src/app/js/limitWord.js');
app.import('bower_components/equation-editor/src/app/js/limitSymbol.js');
app.import('bower_components/equation-editor/src/app/js/matrixWrapper.js');
app.import('bower_components/equation-editor/src/app/js/matrixContainer.js');
app.import('bower_components/equation-editor/src/app/js/accentWrapper.js');
app.import('bower_components/equation-editor/src/app/js/accentSymbol.js');
app.import('bower_components/equation-editor/src/app/js/accentContainer.js');
app.import('bower_components/equation-editor/src/app/js/blinkingCursor.js');
app.import('bower_components/equation-editor/src/app/js/mouseInteraction.js');
app.import('bower_components/equation-editor/src/app/js/addWrapperUtil.js');
app.import('bower_components/equation-editor/src/app/js/keyboardInteraction.js');
app.import('bower_components/equation-editor/src/app/js/menuInteraction.js');
app.import('bower_components/equation-editor/src/app/js/clipboard.js');
app.import('bower_components/equation-editor/src/app/js/equationEditor.js');
app.import('bower_components/equation-editor/src/app/js/latexGenerator.js');

module.exports = mergeTrees([app.toTree(),equationEditorFonts,equationEditorImages,equationEditorMenuImages]);
