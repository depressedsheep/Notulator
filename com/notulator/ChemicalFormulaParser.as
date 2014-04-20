/** 
* Chemical Formula class
* 
* Chemical Formula class has chemical formula specific functions
*
* @author Kaian  
* @verion 1.0
*/ 
package com.notulator
{
    import flash.events.*;
    import flash.display.*;

    public class ChemicalFormulaParser{

        //Class properties

        public var chemicalSubstance;
        public var terms;
        public var containsCarbon;
        public var containsHydrogen;

        /**  
        * Constructor
        *
        * @param ChemicalSubstance chemicalSubstance The reference to the object
        * @return Nothing
        */ 

        public function ChemicalFormulaParser(chemicalSubstance):void{
            this.chemicalSubstance = chemicalSubstance;
            this.terms = chemicalSubstance.consistsOf;
            this.containsCarbon = chemicalSubstance.containsCarbon;
            this.containsHydrogen = chemicalSubstance.containsHydrogen;
        }


        /** 
        * This method is used to get the Chemical Formula of an array of terms
        * for mostly displaying purposes. Using the "HIll System" to organize
        * the order of terms in the formula ( Carbon first, Hydrogen second, etc.)
        * This is usually called by ChemicalSubstance
        *
        * @param Nothing
        * @return string This returns the chemical formula
        * @see Hill System http://en.wikipedia.org/wiki/Chemical_formula#Hill_System
        * @todo Exceptions to hill system - Ionic compounds, oxides, acids, hydroxides
        */ 

        public function termsToFormula():String{
            var chemicalFormula = "";
            var lookup = new PeriodicTableLookUp();

            if(this.chemicalSubstance.isIonicCompound != 'N'){
                var firstPart = "";
                var secondPart = "";
                var lookup = new PeriodicTableLookUp();

                for( var term in terms )
                    if( lookup.isCation(term) )
                        firstPart += parseTerm(term);
                    else
                        secondPart += parseTerm(term);

                chemicalFormula = firstPart + secondPart;
                
            }else if(this.chemicalSubstance.isOxide){

                for( var term in terms)
                    if(term != 'O') chemicalFormula += parseTerm(term);

                chemicalFormula += parseTerm('O');

            }else if(this.chemicalSubstance.isHydroxide){

                for( var term in terms)
                    if(term != 'OH') chemicalFormula += parseTerm(term);

                chemicalFormula += parseTerm('OH');

            }else if(this.chemicalSubstance.isAcid){

                chemicalFormula += parseTerm('H');

                for( var term in terms )
                    if(term != 'H') chemicalFormula += parseTerm(term);

            }else{

                if(containsCarbon){
                    //If it contains Carbon, add it to the front of the chemical formula
                    chemicalFormula += parseTerm('C');

                    //If it also contains Hydrogen, add it to the formula but after Carbon
                    //Note: if it contains Hydrogen but not Carbon, the Hydrogen is sorted alphabetically
                    if(containsHydrogen) chemicalFormula += parseTerm('H')
                }

                var termsArray = [];
                for( var term in terms)
                    if(containsCarbon)
                        if(containsHydrogen)
                            if(term != 'H') termsArray.push(term);
                        else if(term != 'C') termsArray.push(term);

                    else termsArray.push(term);

                termsArray.sort(Array.CASEINSENSITIVE);

                for( var i=0;i<termsArray.length;i++ )
                    chemicalFormula += parseTerm(termsArray[i]);
            }
        
            return chemicalFormula;
        }

        public function parseTerm(term):String{
            var numOfTerm = terms[term] > 1 ? terms[term] : '';
            if( chemicalSubstance.getUniqueNumOfElemsInTerm(term) > 1 )
                return '(' + term + ')' + numOfTerm;
            else
                return term + numOfTerm;
        }

    }
}

