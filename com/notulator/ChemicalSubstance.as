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
        * this.consitsOf[ termName ] = numberOfTerms
        */

        public var consitsOf:Array = [];

        /**
        * If the substance contains Carbon/Hydrogen
        */
        public var consitsCarbon:Boolean = false;
        public var consitsHydrogen:Boolean = false;

        /** 
        * Constructor
        * 
        * Set array consitsOf to param and check if substance contains
        * carbon or hydrogen
        *
        * @param terms This is an array of terms in the substance
        * @return Nothing
        */ 

    	public function ChemicalSubstance(terms):void{
            //Loop throught the param
            for( var i=0;i<terms.length;i++ ){
                var termName = terms[i];

                if( termName.indexOf("*") >= 0 ){
                    //If it contains '*', there is more than one of the specified term
                    var term:Array = termName.split("*");

                    //Sets consitsOf[ element ] to the number of terms
                    this.consitsOf[ term[0] ] = term[1];

                    //Check if it is Carbon or Hydrogen
                    if(term[0] == 'C') this.consitsCarbon = true;
                    if(term[0] == 'H') this.consitsHydrogen = true;
                }else{
                    //Only has one of the specified term
                    //Sets consitsOf[ term ] to 1
                    this.consitsOf[ termName ] = 1;

                    //Same story
                    if(termName == 'C') this.consitsCarbon = true;
                    if(termName == 'H') this.consitsHydrogen = true;
                }
            }
    	}

        /** 
        * This method is used to get the Chemical Formula of the substance
        * for mostly displaying purposes. Using the "HIll System" to organize
        * the order of terms in the formula ( Carbon first, Hydrogen second, etc.)
        *
        * @param Nothing
        * @return string This returns the chemical formula
        * @see Hill System http://en.wikipedia.org/wiki/Chemical_formula#Hill_System
        */ 

        public function get chemicalFormula():String{
            var chemicalFormula = "";
            var termNameArray = [];

            for( var term in this.consitsOf){
                //Populate termNameArray while making sure the term is not Carbon or Hydrogen
                if(consitsCarbon){
                    if(term != 'C' && term != 'H') 
                        termNameArray.push(term);
                }else
                    termNameArray.push(term);
            }

            if(consitsCarbon){
                //If it contains Carbon, add it to the front of the chemical formula
                chemicalFormula += 'C' + consitsOf['C'];

                //If it also contains Hydrogen, add it to the formula but after Carbon
                //Note: if it contains Hydrogen but not Carbon, the Hydrogen is sorted alphabetically
                if(consitsHydrogen)
                    chemicalFormula += 'H' + consitsOf['H'];
            }

            //With Carbon and Hydrogen out of the way, the rest of the terms are sorted
            //alphabetically by their name
            termNameArray.sort(Array.CASEINSENSITIVE);

            for( var i=0;i<termNameArray.length;i++ ){
                var termName = termNameArray[i];
                var numOfTerm = this.consitsOf[termName];
				
                //If there is only one of the term, don't display '1'
                if(numOfTerm == '1') numOfTerm = "";

                //Adds the term to the Chemical Formula
                if( this.getNumOfElemsInTerm(termName) == 1)
                    //If there is only one element in this term, we just add it
                    chemicalFormula += termName + numOfTerm;
                else
                    //Else, we put brackets around the term
                    chemicalFormula += '(' + termName + ')' + numOfTerm;
            }
        
            return chemicalFormula;
        }


        /** 
        * This method is used to get the number of a particular term
        * in this substance
        *
        * @param elemName The name of the term
        * @return int The number of term
        */ 

        public function getNumOfTerm(termName):int{
            if( this.consitsOf[termName]>0 ) return this.consitsOf[termName];
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
            for( var term in this.consitsOf ){
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
                        totalNumOfElement += this.consitsOf[ term ] * numOfElem;
                    }
                }
            }

            //If doesnt contain the element, return 0,
            if(!containElement) return 0;
            else return totalNumOfElement;
        }

        /**  
        * This method is used to get the total number of terms
        * in this substance
        *
        * @param Nothing
        * @return int The total number of terms
        */ 

        public function get totalNumOfTerms():int{
            var numOfTerms = 0;

            for( var term in this.consitsOf )
                //Loops through all the terms and add the number of it to the total count
                numOfTerms += this.consitsOf[term];
            
            return numOfTerms;
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
            for( var term in this.consitsOf )
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
            for(var term in this.consitsOf){
                var tmp = term.replace( /([A-Z])/g , ' $1');
                if ( tmp.charAt(0) == ' ' )
                    tmp = tmp.substr( 1 );
                tmp = tmp.split(' ');

                var len = tmp.length;
                for( var i=0;i<len;i++ )
                    if( elemArray.indexOf(tmp[i]) == -1 ) elemArray.push(tmp[i]);
            }

            return elemArray;
        }

        /**  
        * This method is used to get the total number of elements
        * in a particular term
        *
        * @param string term The term to be searched
        * @return int The total number of elements
        */ 

        public function getNumOfElemsInTerm(term):int{
            //Add a space before each element
            var tmp = term.replace(  /([A-Z])/g , ' $1');
            if ( tmp.charAt(0) == ' ' )
                tmp = tmp.substr( 1 );

            //Split into an array
            var elements = tmp.split(' ');

            return elements.length;
        }
    }
}