/** 
* Custom Matrix class
* 
* Matrices with functionality instead of the default (read: useless) Matrix class
* Adapted from http://rosettacode.org/wiki/Rref#Javascript under GNU Free Documentation License 1.2.
*
* @author Kaian
* @verion 1.0
*/ 
package com.notulator
{
    import flash.events.*;
    import flash.display.*;

    public class CustomMatrix{

        //The matrix in type array
        public var mtx:Array;

        // Rows * Cols
        public var cols:int;
        public var rows:int;

        /** 
        * Constructor
        *
        * @param matrixArray The array containing the matrix
        * @return Nothing
        * @see Matrix http://en.wikipedia.org/wiki/Matrix_(mathematics)
        */ 

        public function CustomMatrix(matrixArray){
            this.mtx = matrixArray;
            this.rows = matrixArray.length;
            this.cols = matrixArray[0].length;
        }

        /** 
        * To Reducted Row Echelon Form
        *
        * This is a mathematical function that returns the matrix in
        * RREF for solving a system of linear equations
        *
        * @param Nothing
        * @return Array The matrix in RREF
        * @see RREF http://en.wikipedia.org/wiki/Row_echelon_form#Reduced_row_echelon_form
        * @see Guass Jordan Elimination http://en.wikipedia.org/wiki/Gauss–Jordan_elimination
        */ 

        public function toRREF():Array{
            var lead = 0;
            for( var r=0; r<this.rows;r++ ){
                if (this.cols <= lead) break;

                var i = r;
                while (this.mtx[i][lead] == 0) {
                    i++;
                    if (this.rows == i) {
                        i = r;
                        lead++;
                        if (this.cols == lead) return this.mtx;
                    }
                }
         
                var tmp = this.mtx[i];      
                this.mtx[i] = this.mtx[r];
                this.mtx[r] = tmp;
         
                var val = this.mtx[r][lead];
                for (var j = 0; j < this.cols; j++)
                    this.mtx[r][j] /= val;
         
                for (var i = 0; i < this.rows; i++) {
                    if (i == r) continue;
                    val = this.mtx[i][lead];
                    for (var j = 0; j < this.cols; j++)
                        this.mtx[i][j] -= val * this.mtx[r][j];
                }
                lead++;
            }
            return this.mtx;
        }
    }
}
