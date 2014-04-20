/** 
* Acid Class
* 
* Acid Class that extends Chemical Substance to provide 
* acid specific functions
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

    public class Acid extends ChemicalSubstance{
    	
        /** 
        * Constructor
        * 
        * Call ChemicalSubstance constructor with param
        *
        * @param elems This is an array of elements in the acid
        * @return Nothing
        */ 

        public function Acid(elems):void{
            super(elems);
        }

        /** 
        * This method is used to get the anion of the acid
        *
        * @param Nothing
        * @return ChemicalSubstance This returns the Anion with type ChemicalSubstance
        * @todo Exceptions such as Acetic Groups
        */ 

        public function get anion():ChemicalSubstance{
            //Note: Due to a severe lack of intelligence, I have no idea how to determine
            //the cation/anion of this acid/base

            var anionElems:Array = [];
            for(var elem:String in super.consistsOf){
                //If the element is not H+, add it to the anion
                if(elem != "H")
                    //If there is more than one of the element/term, we multiply is accordingly
                    if( this.consistsOf[elem] > 1 ) anionElems.push(elem + '*' + this.consistsOf[elem] );
                    else anionElems.push(elem);
            }
        	
            //Return the anion
            var anion = new ChemicalSubstance(anionElems);
            return anion;
        }

        /** 
        * This method is used to get the charge of anion for 
        * chemical eqaution balancing
        *
        * @param Nothing
        * @return int This returns the charge
        */ 

        public function get anionCharge():int{
            //Get BulkLoader Obj that preloaded XML files during init
            var anions:XML = BulkLoader.getLoader("preloadXML").getXML("anions");

            //Get value of 'charge' node in XML file
            var charge = anions.anion.(formula == this.anion.chemicalFormula).charge;

            return charge;
        }
    }
}
