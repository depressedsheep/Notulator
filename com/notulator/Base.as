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

    public class Base extends ChemicalSubstance{

        /** 
        * Constructor
        * 
        * Call ChemicalSubstance constructor with param
        *
        * @param elements This is an array of elements in the acid
        * @return Nothing
        */ 

        public function Base(elems:Array):void{
            super(elems);
        }

        /** 
        * This method is used to get the cation of the base
        *
        * @param Nothing
        * @return ChemicalSubstance This returns the Cation with type ChemicalSubstance
        * @todo Exceptions
        */ 

        public function get cation():ChemicalSubstance{
            //Note: Due to a severe lack of intelligence, I have no idea how to determine
            //the cation/anion of this acid/base

            var cationElems:Array = [];
            for(var elem in this.consistsOf)

                //If the element is not OH- or O2-, add it to the anion
                if( elem != "OH" && elem != "O"){
                    //If there is more than one of the element/term, we multiply is accordingly
                    if( this.consistsOf[elem] > 1 ) cationElems.push(elem + '*' + this.consistsOf[elem] );
                    else cationElems.push(elem);
                }
            trace(cationElems);
            //Return the cation
            var cation = new ChemicalSubstance(cationElems);
            return cation;
        }

        /** 
        * This method is used to get the charge of cation for
        * chemical eqaution balancing
        *
        * @param Nothing
        * @return int This returns the charge
        */ 

        public function get cationCharge():int{
            //Get BulkLoader Obj that preloaded XML files during init
            var cations:XML = BulkLoader.getLoader("preloadXML").getXML("cations");

            //Get value of 'charge' node in XML file
            var charge = cations.cation.(formula == this.cation.chemicalFormula).charge;

            return charge;
        }

    }
}
