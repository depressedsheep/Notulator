/** 
* Base Class
* 
* Base Class that extends Chemical Substance to provide 
* base specific functions
*
* @author Kaian  
* @verion 1.0
*/ 
package com.notulator 
{
    import br.com.stimuli.loading.BulkLoader;
    import br.com.stimuli.loading.BulkProgressEvent;
    import flash.events.*;
    import flash.display.*;

    public class PeriodicTableLookUp{

        public var constants;
        public var ptMain;
        public var ptGeneral;
        public var ptAtomicProperties;
        public var ptPhysicalProperties;

        /** 
        * Constructor
        * 
        * Initialize variables
        *
        * @param Nothing
        * @return Nothing
        */ 

        public function PeriodicTableLookUp():void{
            var preloader = BulkLoader.getLoader("preloadXML");

            this.ptMain = preloader.getXML("ptMain");
            this.ptGeneral = preloader.getXML("ptGeneral");
            this.ptAtomicProperties = preloader.getXML("ptAtomicProperties");
            this.ptPhysicalProperties = preloader.getXML("ptPhysicalProperties");


            this.constants = new Constants();
        }

        /** 
        * Get element category by symbol
        * 
        * Find the category of a particular element by its symbol
        *
        * @param string symbolToBeSearched This is the symbol of the element
        * @return string The category of the element
        */ 

        public function getCategoryBySymbol(symbolToBeSearched):String{
            return this.ptMain.element.(symbol == symbolToBeSearched).category;
        }

        /** 
        * Is an element a metal
        * 
        * Checks if an element is a metal by its symbol
        *
        * @param string symbolToBeSearched This is the symbol of the element
        * @return boolean If the element is a metal
        */ 

        public function isMetal(symbolToBeSearched):Boolean{

            var atomicNumber = ptMain.element.(symbol == symbolToBeSearched).number;
            atomicNumber = parseInt(atomicNumber);

            if(this.constants.METALS_BY_ATOMIC_NUMBER.indexOf(atomicNumber) >= 0) return true;
            else return false;
        }

        /** 
        * Is an element a nonmetal
        * 
        * Checks if an element is a nonmetal by using the isMetal method
        *
        * @param string symbol This is the symbol of the element
        * @return boolean If the element is a non-metal
        */ 

        public function isNonmetal(symbol):Boolean{
            return isMetal(symbol) ? false : true;
        }

        //@todo documentation (the irony :p)

        public function isIon(symbol):Boolean{
            return (constants.IONS.indexOf(symbol) >= 0) ? true : false;
        }

        public function isAnion(symbol):Boolean{
            return (constants.ANIONS.indexOf(symbol) >= 0) ? true : false;
        }

        public function isCation(symbol):Boolean{
            return (constants.CATIONS.indexOf(symbol) >= 0) ? true : false;
        }

        public function isElement(formula):Boolean{
            return (constants.ELEMENTS_BY_SYMBOLS.indexOf(formula) >= 0) ? true : false;
        }

    }
}
