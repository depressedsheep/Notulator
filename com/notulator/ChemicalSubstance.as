/** 
* Chemical Substance Class
* 
* Base class to define Chemical Substances and includes
* useful methods
*
* @author Kaian  
* @verion 1.0
* @copyright Cai Kaian 2014
*/ 
package com.notulator
{
    import flash.events.*;
    import flash.display.*;

    public class ChemicalSubstance{

        /**
        * Associative array of terms
        * this.consistsOf[ termName ] = numberOfTerms
        */

        public var consistsOf:Array = [];

        /**
        * If the substance contains Carbon/Hydrogen/Nonmetal/Metal
        */
        public var containsCarbon:Boolean = false;
        public var containsHydrogen:Boolean = false;
        public var containsMetal:Boolean = false;
        public var containsNonmetal:Boolean = false;

        /** 
        * Constructor
        * 
        * Set array consistsOf to param and check if substance contains
        * carbon or hydrogen
        *
        * @param terms This is an array of terms in the substance
        * @return Nothing
        */ 

    	public function ChemicalSubstance(terms):void{
            var lookup = new PeriodicTableLookUp();

            //Loop throught the param
            for( var i=0;i<terms.length;i++ ){
                var termName = terms[i];

                if( termName.indexOf("*") >= 0 ){
                    //If it contains '*', there is more than one of the specified term
                    var term:Array = termName.split("*");

                    //Sets consistsOf[ element ] to the number of terms
                    this.consistsOf[ term[0] ] = term[1];

                    //Check if it is Carbon or Hydrogen or a Metal/Nonmetal
                    if(term[0] == 'C') this.containsCarbon = true;
                    if(term[0] == 'H') this.containsHydrogen = true;
                    if( lookup.isMetal(term[0]) ) this.containsMetal = true;
                    else this.containsNonmetal = true;
                }else{
                    //Only has one of the specified term
                    //Sets consistsOf[ term ] to 1
                    this.consistsOf[ termName ] = 1;

                    //Same story
                    if(termName == 'C') this.containsCarbon = true;
                    if(termName == 'H') this.containsHydrogen = true;
                    if( lookup.isMetal(termName) ) this.containsMetal = true;
                    else this.containsNonmetal = true;
                }
            }
    	}

        /** 
        * This method is used to get the Chemical Formula of the substance
        * through the ChemicalFormula class
        *
        * @param Nothing
        * @return string This returns the chemical formula
        * @see ChemicalFormula
        */ 

        public function get chemicalFormula():String{
            var parse = new ChemicalFormulaParser(this);
            return parse.termsToFormula();
        }


        /** 
        * This method is used to get the number of a particular term
        * in this substance
        *
        * @param elemName The name of the term
        * @return int The number of term
        */ 

        public function getNumOfTerm(termName):int{
            if( this.consistsOf[termName]>0 ) return this.consistsOf[termName];
            else return 0;
        }

        /** 
        * This method is used to get the number of a particular element
        * in this substance. It loops through each term, separate iy into its elements and
        * gets the total number of elements by numOfElem * numOfTerms
        *
        * @param elemName The name of the element
        * @return int The number of element
        */ 

        public function getNumOfElem(elemName):int{
            var containElement = false;
            var totalNumOfElement = 0;

            //Loop through each term
            for( var term in this.consistsOf ){
                //Add a space before each Captial letter (element)
                var tmp = term.replace(  /([A-Z])/g , ' $1');
                if ( tmp.charAt(0) == ' ' )
                    tmp = tmp.substr( 1 );

                //Split into an array
                var elements = tmp.split(' ');
                var len = elements.length;

                //Loop through array of elements
                for( var i=0;i<len;i++ ){
                    //Check if the current element is the one we are looking for
                    if( elements[i].indexOf(elemName) >= 0 ){
                        var elem = elements[i];
                        var numOfElem = 1;

                        //If the string ends with a number, it has more than 1 of the element
                        if( elem.match(/\d$/) ){
                            numOfElem = elem.slice(-1);
                            elem = elem.substr(0,elem.length-1);
                        }
                    
                        containElement = true;

                        //Add the number of elements to the total count
                        totalNumOfElement += this.consistsOf[ term ] * numOfElem;
                    }
                }
            }

            //If doesnt contain the element, return 0,
            if(!containElement) return 0;
            else return totalNumOfElement;
        }

        /**  
        * This method is used to get the total number of all terms
        * in this substance
        *
        * @param Nothing
        * @return int The total number of terms
        */ 

        public function get totalNumOfTerms():int{
            var numOfTerms = 0;

            for( var term in this.consistsOf )
                //Loops through all the terms and add the number of it to the total count
                numOfTerms += parseInt(this.consistsOf[term]);

            return numOfTerms;
        }

        /**  
        * This method is used to get the unique number of terms 
        * without accounting for the number of each term
        * in this substance
        *
        * @param Nothing
        * @return int The unique number of terms
        */ 

        public function get uniqueNumOfTerms():int{
            var uniqueNumOfTerms = 0;

            for( var term in this.consistsOf )
                uniqueNumOfTerms++;

            return uniqueNumOfTerms;
        }

        /** 
        * This method is used to get a list of terms
        * in this substance
        *
        * @param Nothing
        * @return array The list of terms
        */ 

        public function get listOfTerms():Array{
            var termArray = [];
            for( var term in this.consistsOf )
                termArray.push(term);

            return termArray;
        }

        /** 
        * This method is used to get a list of elements
        * in this substance
        *
        * @param Nothing
        * @return array The list of elements
        */ 

        public function get listOfElems():Array{
            var elemArray = [];
            for(var term in this.consistsOf){
                //Adds a space before each captial letter
                var tmp = term.replace( /([A-Z])/g , ' $1');
                if ( tmp.charAt(0) == ' ' )
                    tmp = tmp.substr( 1 );

                //Split it into an array
                tmp = tmp.split(' ');

                //Define the regualr expression used to remove numbers at the end of a string
                var rex = /[0-9]$/;
                var len = tmp.length;
                for( var i=0;i<len;i++ ){
                    //Remove any trailing number
                    tmp[i] = tmp[i].replace(rex,'');
                    //If the element is not alreay inside, add it
                    if( elemArray.indexOf(tmp[i]) == -1 ) elemArray.push(tmp[i]);
                }
            }

            return elemArray;
        }

        /**  
        * This method is used to get the unique number of elements
        * in a particular term
        *
        * @param string term The term to be searched
        * @return int The unique number of elements
        */ 

        public function getUniqueNumOfElemsInTerm(term):int{
            //Add a space before each element
            var tmp = term.replace(  /([A-Z])/g , ' $1');
            if ( tmp.charAt(0) == ' ' )
                tmp = tmp.substr( 1 );

            //Split into an array
            var elements = tmp.split(' ');

            return elements.length;
        }

        /**  
        * This method is used to determine if this substance is ionic
        *
        * @param Nothing
        * @return string 'N'/'T'/'B', Nope, Teneray Ionic, Binary Ionic
        */ 

        public function get isIonicCompound():String{
            if( this.uniqueNumOfTerms != 2 ) return 'N';

            var terms = this.listOfTerms;
            var termX = terms[0];
            var termY = terms[1];

            var lookup = new PeriodicTableLookUp();
            var xIsMetal = lookup.isMetal(termX);
            var yIsMetal = lookup.isMetal(termY);
            var xIsIon = lookup.isIon(termX);
            var yIsIon = lookup.isIon(termY);

            if( lookup.isElement(termX) && lookup.isElement(termY) ){

                if( (xIsMetal && !yIsMetal) || (!xIsMetal && yIsMetal) )
                    return 'B';
                else return 'N';

            }else if( xIsIon || yIsIon ){
                //We know that the ion is diatomic

                if( xIsIon && yIsMetal ) return 'T';
                else if( xIsMetal && yIsIon ) return 'T';
                else return 'N';
            }else {
                return 'N';
            }
        }

        /**  
        * This method is used to determine if this substance is an oxide
        *
        * @param Nothing
        * @return boolean If the substance is an oxide
        */ 

        public function get isOxide():Boolean{
            if( this.uniqueNumOfTerms != 2 ) return false;

            var containsOxygen = false;
            for(var term in this.consistsOf) 
                if(term == 'O') containsOxygen = true;

            return containsOxygen ? true : false;
        }

        /**  
        * This method is used to determine if this substance is a hydroxide
        *
        * @param Nothing
        * @return boolean If the substance is a hydroxide
        */ 

        public function get isHydroxide():Boolean{
            if( this.uniqueNumOfTerms != 2 ) return false;

            var containsHydroxide = false;
            var containsMetal = false;
            var lookup = new PeriodicTableLookUp();

            for(var term in this.consistsOf) 
                if(term == 'OH') containsHydroxide = true;
                if( lookup.isMetal(term) ) containsMetal = true;

            return containsHydroxide && containsMetal ? true : false;
        }

        public function get isAcid():Boolean{
            if(!this.containsHydrogen) return false;

            return this.containsNonmetal ? true : false;
        }
    }
}