/** 
* Math Functions Class
* 
* Math class than includes useful mathematical functions
*
* @author Kaian  
* @verion 1.0
*/ 
package com.notulator
{
    import flash.events.*;
    import flash.display.*;

    public class MathFunctions{

        /** 
        * This method is to calculate the GCD (Greatest Common Divisor)
        * using the Euclidean algorithm
        *
        * @param x First number
        * @param y Second number
        * @return int The greatest common divisor
        * @see http://en.wikipedia.org/wiki/Euclidean_algorithm
        */ 

        public function GCD(x,y):int{
            var temp;

            while( y != 0 ){
                temp = y;
                y = x % y;
                x = temp;
            }

            return x;
        }

        /** 
        * This method is to calculate the LCM (Lowest Common Multiple)
        *
        * @param x First number
        * @param y Second number
        * @return int The lowest common multiple
        */ 

        public function LCM(x,y):int{
            return( x * y / GCD(x,y) );
        }

        /** 
        * This method is to check if a var is a float or integer
        *
        * @param x Number
        * @return Boolean If the number is an int, true is returned
        */ 

        public function isInt(x):Boolean{
            return (x % 1 === 0);
        }
    }
}
