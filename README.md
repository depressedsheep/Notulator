Notulator
=============

Main repo for notulator.

Use [Issues tab](https://github.com/idkwtfbbq7/Notulator/issues) to track/report bugs/inconsistency in code :)

Try & follow these [coding conventions](http://sourceforge.net/adobe/flexsdk/wiki/Coding%20Conventions/) when commiting to this repo.

V0.2 alpha CHANGELOG
---------------------

### BUG FIXES

* Issue #2 Brackets Wrongly Displayed
* Issue #3 Wrong count of elements
* Issue #6 Inaccurate count of terms in ChemicalSubstance Constructor

### ENCHANCEMENTS

* Issue #1 **Exceptions to Hill System**
* Issue #4 Periodic Table Lookup Class
* Issue #5 Chemical Formula should have its own class

### NEW CLASSES

1. Constants.as (Class containing all chemistry contstants)
2. ChemicalFormulaParser.as (Class that parses ChemicalFormula)
3. PeriodicTableLookUp.as (Class that finds information on elements)

### NEW METHODS

1. ChemicalSubstance
	* `isIonicCompound()`
	* `isOxide()`
	* `isHydroxide()`
	* `isAcid()`

2. ChemicalEquationSolver
	* `formatEquation()`

3. PeriodicTableLookUp
	* `getCategoryBySymbol()`
	* `isMetal()`
	* `isNonmetal()`
	* `isIon()`
	* `isCation()`
	* `isAnion()`

4. ChemicalFormulaParser
	* `termsToFormula()`
	* `parseTerm()`

### CHANGED METHODS

1. ChemicalSubstance
	* `get chemicalFormula()`: Calls ChemicalFormulaParser to parse chemical formula instead
	* constructor `ChemicalSubstance()`: Checks if substance contains metal and non-metal
2. ChemicalEquationSolver
	* `eqnToString()`: Took out the formatting of the formula and put it into its own method due to the repetitive nature of code
3. ChemicalFormulaParser:
	* `termsToFormula()`: Checks if substance is an exception and parses it accordinly. Also took out formatting of terms and put it into its own method due to repetivie nature

### ADDED FUNCTIONALITY

1. XML datasheet of information on all the elements
	* `data/PeriodicTableMain.xml`
	* `data/PeriodicTableGeneral.xml`
	* `data/PeriodicTableAtomicProperties.xml`
	* `data/PeriodicTablePhysicalProperties.xml`

### TODO
* Include method to parse user's input into ChemicalSubstance
* Exceptions and bug fixes
* **Proper documentaion of code (i'm lazy :p)**