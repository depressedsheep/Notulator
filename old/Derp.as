package com.notulator
{
	public class Derp{
			public function analyze(_obj:Object):String{
			var result:String = new String();
			var item:Object;
			switch (typeof(_obj)){
				case "object":
					result += "<object>";
					result += _obj.toString();
					for each (item in _obj){
						analyze(item);
					};
					result += "</object>";
				break;
				case "xml":
					result += "<xml>";
					result += _obj;
					result += "</xml>";
				break;
				default:
					result+= _obj + " (" + typeof(_obj) + ")";
				break;
			};
			return result;
		}

	}
}