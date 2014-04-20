/** 
* Such Derp class
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

	public class Derp extends Sprite{

	    //preLoader to pre load the XML data files during init
		public var preLoader:BulkLoader;

		//Text format
		public var formatT:TextFormat;

		/** 
	    * Constructor
    	* 
    	* Call init()
    	*
    	* @param Nothing
    	* @return Nothing
    	*/ 

		public function Derp():void{
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
			/*//Making things pretty
			formatT = new TextFormat();
			formatT.bold = false; 
   			formatT.color = 0x333333; 
   			formatT.font = "Lato Light";    
   			formatT.size = 24;

   			calcBtn.setStyle('textFormat', formatT);
   			inputBase.setStyle('textFormat', formatT);
   			inputAcid.setStyle('textFormat', formatT);*/	


			//New instance of BulkLoad named 'preloadXML'
			preLoader = new BulkLoader("preloadXML");

			//Add XML data files to be loaded
			//We also give each file an id for easy access later
			preLoader.add('data/cation.xml', {id:'cations'});
			preLoader.add('data/anion.xml', {id:'anions'});
			preLoader.add('data/PeriodicTableMain.xml', {id:'ptMain'});
			preLoader.add('data/PeriodicTableGeneral.xml', {id:'ptGeneral'});
			preLoader.add('data/PeriodicTableAtomicProperties.xml', {id:'ptAtmoicProperties'});
			preLoader.add('data/PeriodicTablePhysicalProperties.xml', {id:'ptPhysicalProperties'});


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

		public function preloadComplete(event):void{
			//calcBtn.addEventListener( MouseEvent.CLICK, test);
			test('derp');
		}

		/** 
    	* For debugging purposes, etc.
    	*
    	* @param event event This is the event obj
    	* @return Nothing
    	*/ 

		public function test(event):void{
			//var rex:RegExp = /[\s\r\n]*/gim;
			/*
			var base = inputBase.text.replace(rex,'').split(',');
			var acid = inputAcid.text.replace(rex,'').split(',');

			base = new Base(base);
			acid = new Acid(acid);*/

			var acid = new Acid(['H','Cl','O*3']);
			var base = new Base(['Ba','OH*2'])

			var solve = new ChemicalEquationSolver();

			log('Base is: ' + base.chemicalFormula, 500);
			log('Acid is: ' + acid.chemicalFormula, 550);
			log('Final equation:\n' + solve.acidAndBase(acid,base), 600);

			//trace('Anion is: ' + acid.anion.chemicalFormula + ' with a charge of ' + acid.anionCharge);
			//trace('Cation is: ' + base.cation.chemicalFormula + ' with a charge of ' + base.cationCharge);*/

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
			*
			* Case 1: Hydrochloric acid and Sodium Hydroxide
			* var HCl = new Acid(["SO4", "H*2"]);
			* var NaOH = new Base(["Na", "OH"]);
			*
			* Case 2: Chloric acid and Barium Hydroxide
			* var acid = new Acid(['H','Cl','O*3']);
			* var base = new Base(['Ba','OH*2'])
			*
			* Case 3: Phosphoric acid and Potassium Hydroxide
			* var base = new Base(['K','OH']);
			* var acid = new Acid(['H*3','PO4*1'])
			*/
		}

		/** 
    	* Trace a message and display it on screen
    	*
    	* @param string message The message to be displayed
    	* @param int y The y coord of the textfield
    	* @return Nothing
    	*/ 

		public function log(message,y):void{
			var toDisplay = new TextField();
			toDisplay.text =  message;
			toDisplay.y = y;
			toDisplay.x = 50;
			toDisplay.width = 400;

			formatT = new TextFormat();
   			formatT.bold = false; 
   			formatT.color = 0x3498db; 
   			formatT.font = "Lato Light";    
   			formatT.size = 24;

   			toDisplay.setTextFormat(formatT)
			addChild(toDisplay);
			trace(message);
		}
	}
}