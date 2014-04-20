/** 
* Chemical Equation Solver Class
* 
* Solves and balances equations
*
* @author Kaian  
* @verion 1.0
* @copyright Cai Kaian 2014
*/ 
package com.notulator
{
    import flash.events.*;
    import flash.display.*;

    public class ChemicalEquationSolver{

        /** 
        * Acid and Base equations
        * 
        * Solves Acid and Base reactions
        *
        * @param acid The acid in the equation
        * @param base The base in the equation
        * @return string The balanced equation
        * @see http://hyperphysics.phy-astr.gsu.edu/hbase/chemical/acidbase.html
        */ 

        public function acidAndBase(acid, base):String{
            //Products - Salt & Water
            var salt = this.getSalt(acid,base);
            var water = new ChemicalSubstance(["H*2", "O"]);
            var products = [salt, water];

            //Reactants - Acid & Base
            var reactants = [acid, base];

            //Balance the equation and return the formatted eqn
            var coefficients = this.balanceEqn(reactants, products);

            return eqnToString(reactants, products, coefficients);
        }

        /** 
        * Balance Equations
        *
        * @param array leftSide The left side of the equation
        * @param array rightSide The right side of the equation
        * @return Array An array of the respective coefficients
        * @copyright Cai Kaian 2014 (<- this fucking shit took me forever)
        */ 

        public function balanceEqn(leftSide, rightSide):Array{

            //Get a unique list of elements in the left side
            var elemsInLeft = [];
            for( var i=0;i<leftSide.length;i++  ){
                //List of elements in this term
                var elemList = leftSide[i].listOfElems;

                //Loop through the list and add the element to the array
                //if it isn't already inside
                for( var k=0;k<elemList.length;k++ ){
                    if( elemsInLeft.indexOf(elemList[k]) == -1 )
                        elemsInLeft.push( elemList[k] );
                }
            }
            //Sort the array alpahbetically for consistency
            elemsInLeft.sort(Array.CASEINSENSITIVE);

            //Same story
            var elemsInRight = [];
            for( var i=0;i<rightSide.length;i++  ){
                var elemList = rightSide[i].listOfElems;
                trace(rightSide[i].chemicalFormula);

                for( var k=0;k<elemList.length;k++ ){
                    if( elemsInRight.indexOf(elemList[k]) == -1)
                        elemsInRight.push( elemList[k] );
                }
            }
            elemsInRight.sort(Array.CASEINSENSITIVE);

            //Make sure that the 2 sides are equal inorder to balance it
            //Check that they have the same length, else return
            if( elemsInLeft.length != elemsInRight.length ){
                trace('Error! Left and Right do not have the same length');
                trace('Left:' + elemsInLeft.length);
                trace('Right:' + elemsInRight.length);
                return [];
            }

            //Loop through the left array and compare the corresponding elements
            //If there is one inconsistency, return
            var len = elemsInLeft.length;
            for( var i=0;i<len;i++ )
                if(elemsInLeft[i] != elemsInRight[i]){
                    trace('Error! Left and Right are not the same');
                    trace('Left:' + elemsInLeft[i]);
                    trace('Right:' + elemsInRight[i]);
                    return [];
                }
        
            //Since the 2 arrays are the same, we only need one array from
            //here on to prevent confusion
            var elementArray = elemsInLeft;

            //The coefficient of each term is an unknown, so we calculate
            //the total number of unknowns to get the number of columns
            //for the matrix
            var numOfUnknowns = leftSide.length + rightSide.length;

            //Array containing the matrix
            var systemOfEqn = [];
            
            //Loop through each element
            len = elementArray.length;
            for( var i=0;i<len;i++ ){
                var currentElem = elementArray[i];

                //The current row of the matrix
                var currentRow = [];
                
                //Loop through each term on the left side and add
                //the number of current element each term has to the current row
                //Uncomment the trace statement if still confused :p
                for( var j=0;j<leftSide.length;j++ ){
                    currentRow.push( leftSide[j].getNumOfElem(currentElem) );
                    //trace( leftSide[j].chemicalFormula + " has " + leftSide[j].getNumOfElem(currentElem) + " of " + currentElem);
                }

                //Same story here
                for( var j=0;j<rightSide.length;j++ ){
                    currentRow.push( -(rightSide[j].getNumOfElem(currentElem)) ) ;
                    //trace( rightSide[j].chemicalFormula + " has " + rightSide[j].getNumOfElem(currentElem) + " of " + currentElem);
                }

                //We add another colum of 0s to get a non-homogeneous equation
                currentRow.push(0);

                //Add the completed row to the matrix
                systemOfEqn.push(currentRow);
            }

            //Here we add another row in the form of [1,0,..,0,1] to get a non-homogeneous equation
            //The first element in the last row is 1
            var lastRow = [1];

            //Here, the number of 0s to add is determined by:
            // NumberOfRows - 2 (2 is subtracted to compensate for the leading and trailing 1s)
            //NumberOfRows is determined by the number of unknowns plus 1
            //to compensate for the extra column of 0s
            len = (numOfUnknowns + 1) - 2;

            //Add the 0s
            for( var i=0;i<len;i++ ) lastRow.push(0);

            //Add the trailing 1
            lastRow.push(1);

            //Add the last row to the matrix
            systemOfEqn.push(lastRow);

            //We make a new instance of the CustomMatrix class for the RREF function
            var matrix = new CustomMatrix(systemOfEqn);

            //Solve the equations by converting the matrix
            //to Reduced Row Echelon Form
            matrix.toRREF()

            //We remove the last row as its useless [0,0,...,0,0]
            matrix.mtx.pop();

            //The answer to the equations is the last element of each row
            var ans = [];

            //Loop through the solved matrix
            len = matrix.mtx.length;
            for( var i=0;i<len;i++ ) 
                //Add the last element of each row to the ans array
                ans.push(matrix.mtx[i].pop());

            //Sometimes, the answer is a fraction of x.5, so we need to determine if there is a fraction
            var needToMultiplyBy2 = false;
            var math =  new MathFunctions();

            //Loop through the answer array
            len = ans.length;
            for( var i=0;i<len;i++ )
                //If the current element is not an integer, set the bool to true
                if( !math.isInt(ans[i]) ) needToMultiplyBy2 = true;

            //If bool is true, we loop through the answer array again
            if(needToMultiplyBy2)
                for( var i=0;i<len;i++ )
                    //Multiply each element by 2 to get an integer form
                    ans[i] *= 2;

            //Return the coefficients
            return ans;
        }

        /** 
        * Get Salt of an acid and a base
        *
        * @param ChemicalSubstance acid The acid in the equation
        * @param ChemicalSubstance rightSide The base in the equation
        * @return ChemicalSubstance The salt
        * 
        */ 

        public function getSalt(acid,base):ChemicalSubstance{
            trace(base.cation.chemicalFormula);
            //We get the charges of the cation and anion
            var anionCharge = acid.anionCharge;
            var cationCharge =  base.cationCharge;

            if(anionCharge == cationCharge)
                //If charge is equal, no multiplying is needed
                return new ChemicalSubstance([acid.anion, base.cation]);
            else{
                //Else, we determine the Lowest Common Factor of the 2 charges
                var math =  new MathFunctions();
                var LCM = math.LCM(anionCharge, cationCharge);

                //Determine the number of times to multiply each ion by
                var timesAnionBy = LCM / anionCharge;
                var timesCationBy = LCM / cationCharge;

                //Get the ions
                var anion = acid.anion.chemicalFormula + '*' + timesAnionBy;
                var cation = base.cation.chemicalFormula + '*' + timesCationBy

                return new ChemicalSubstance([anion, cation]);
            }
        }

        /** 
        * Equation To String
        *
        * @param Array leftSide The left side of the equation
        * @param Array rightSide The right side of the equation
        * @param Array coefficients The respective coefficients
        * @return string The final equation
        * 
        */ 

        public function eqnToString(leftSide, rightSide, coefficients):String{

            //Split the coefficient array into left and right side
            var leftSideCoefficients = [];
            var len = leftSide.length;
            for( var i=0;i<len;i++ ) leftSideCoefficients.push(coefficients[i]);

            var rightSideCoefficients = [];
            len = rightSide.length;
            for( var i=0;i<len;i++ ){
                //Here, we correct the index as the first few elements are for the left side
                var correctedIndex = leftSide.length + i;
                rightSideCoefficients.push(coefficients[correctedIndex]);
            }

            
            return formatEquation(leftSide,leftSideCoefficients)
                + ' → '
                + formatEquation(rightSide,rightSideCoefficients);
        }

        /** 
        * Format Equation
        *
        * @param Array eqn The equation to format
        * @param Array coefficients The respective coefficients
        * @return string The formatted equation
        * 
        */

        public function formatEquation(eqn,coefficients):String{
            var formattedEqn = "";
            var len = eqn.length;

            for( var i=0;i<len;i++ ){
                if(coefficients[i] == 1)
                    //If there is only one of the term, no need to display '1'

                    //If this is the first term, we dont need a '+' before it
                    if(i == 0) formattedEqn += eqn[i].chemicalFormula + ' ';
                    //Else, add a '+'
                    else formattedEqn += '+ ' + eqn[i].chemicalFormula;
                else
                    //Else, display the number of terms and the term itself
                    if(i == 0) formattedEqn += coefficients[i] + ' ' + eqn[i].chemicalFormula + ' ';
                    else formattedEqn += '+ ' + coefficients[i] + ' ' + eqn[i].chemicalFormula;
            }

            return formattedEqn;
        }
    }
}
