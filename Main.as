/** 
* Main class
* 
* Main class for debugging and testing purposes
*
* @author Kaian  
* @verion 1.0
* @todo Fix ChemicalFormula T.T
*/ 
package
{
	import com.notulator.*;
	import br.com.stimuli.loading.BulkLoader;
    	import br.com.stimuli.loading.BulkProgressEvent;
	import flash.events.*;
	import flash.display.*;
	import flash.text.*;
	import flash.net.*;
	import flash.utils.*;

	public class Main extends Sprite{

		/**
	        	* preLoader to pre load the XML data files during init
	        	*/

		public var preLoader:BulkLoader;

		/** 
	        	* Constructor
	        	* 
	        	* Call init()
	        	*
	        	* @param Nothing
	        	* @return Nothing
	        	*/ 

		public function Main():void{
			init();
		}

		/** 
	        	* This method is for initializing variables, etc
	        	* and preloads the XML data files for later use
	        	*
	        	* @param Nothing
	        	* @return Nothing
	        	* @see https://code.google.com/p/bulk-loader/
	        	*/ 

		public function init():void{
			//New instance of BulkLoad named 'preloadXML'
			preLoader = new BulkLoader("preloadXML");

			//Add XML data files to be loaded
			//We also give each file an id for easy access later
			preLoader.add('data/cation.xml', {id:'cations'});
			preLoader.add('data/anion.xml', {id:'anions'});

			//Add event listener and start loading
			preLoader.addEventListener(BulkLoader.COMPLETE, preloadComplete);
			preLoader.start();
		}

		/** 
	        	* Handles BulkLoader event completion
	        	*
	        	* @param event This is the event object
	        	* @return Nothing
	        	*/ 

		public function preloadComplete(event):void{ derp(); }

		/** 
	        	* For debugging purposes, etc.
	        	*
	        	* @param Nothing
	        	* @return Nothing
	        	*/ 

		public function derp():void{
			var base = new Base(['Zn', 'OH*2']);
			var acid = new Acid(['H', 'Cl']);
			var solve = new ChemicalEquationSolver();
			trace('Base is: ' + base.chemicalFormula);
			trace('Acid is: ' + acid.chemicalFormula);
			trace('Balanced and formatted equation: ' + solve.acidAndBase(acid,base));

			/**
			* Tests
			*
			* Hill System sorting functionality
			* var derp:ChemicalSubstance = new ChemicalSubstance(["C*2", "H*3", "O*2", "Br"])
			* trace(derp.chemicalFormula);
			*
			* Num of element functionality
			* var weirdShit = new ChemicalSubstance(["Fe", "NH4*2", "SO4*2", "N3H8ArCr4*3"]);
			* trace( weirdShit.getNumOfElem('H') );
			*
			* Solving acid and base equations
			* var HCl = new Acid(["SO4", "H*2"]);
			* var NaOH = new Base(["Na", "OH"]);
			* var solve = new ChemicalEquationSolver();
			* trace( solve.acidAndBase(HCl, NaOH) );
			*/
		}
	}
}