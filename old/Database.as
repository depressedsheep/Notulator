package com.notulator
{
	import flash.events.*;
	import flash.display.*;
    import flash.net.*;

    public class Database{

        public function query(SQL:String, callBack:Function):void{
          var urlReq:URLRequest = new URLRequest("query.php");
          urlReq.method = URLRequestMethod.GET;

          var urlVars:URLVariables = new URLVariables();
          urlVars.q = SQL;


          urlReq.data = urlVars;

          var loader:URLLoader = new URLLoader(urlReq);
          loader.addEventListener(Event.COMPLETE, _queryComplete);

          loader.dataFormat = URLLoaderDataFormat.VARIABLES;
          loader.load(urlReq);

          function _queryComplete(e:Event):void{
            callBack("derpp");
          }
        }
    }
}

/*fail code (i think)
private var _conn:sqlConnection;

        //Constructor
        public function Database() {
            this._conn = new SQLConnection();
            _conn.addEventListener(SQLEvent.OPEN, openSuccess);
            _conn.addEventListener(SQLEvent.ERROR, openFail);
            _conn.openAsync(null);

            function openSuccess(e:SQLEvent){return true;}
            function openFail(e:SQLEvent){return false;}
        }

        public function query(SQL:String):Boolean{
            var query:SQLStatement = new SQLStatement();
            query.sqlConnection = this._conn;
            query.text = SQL;

            query.addEventListener(SQLEvent.RESULT, querySuccess);
            query.addEventListener(SQLEvent.ERROR, queryFail);

            query.execute();

            function querySuccess(e:SQLEvent){return true;}
            function queryFail(e:SQLEvent){return false;}
        }
*/
