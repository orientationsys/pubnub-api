package com.pubnub.operation {
	import com.adobe.crypto.*;
	import com.pubnub.*;
	import com.pubnub.json.*;
	import com.pubnub.net.*;
	/**
	 * ...
	 * @author firsoff maxim, support@pubnub.com
	 */
	public class PublishOperation extends Operation {
		public var subscribeKey:String;
		private var _channel:String;
		private var uid:String;
		public var secretKey:String; 
		public var cipherKey:String = ""; 
		public var publishKey:String = ""; 
		
		
		public function PublishOperation(origin:String):void {
			super(origin);
			parseToJSON = false;
		}
		
		override public function setURL(url:String = null, args:Object = null):URLRequest {
			//var temp:Number = getTimer();
			_channel = args.channel;
			var message:String = args.message;
			if (_channel == null || message == null) {
				dispatchEvent(new OperationEvent(OperationEvent.FAULT, [ -1, "Channel Not Given and/or Message"]));
				return null;
			}
			var signature:String = "0";
			var packageMessage:Object = packageToJSON(message);
			var serializedMessage:String = PnJSON.stringify(packageMessage);
			if (secretKey){
				// Create the signature for this message                
				var concat:String = publishKey + "/" + subscribeKey + "/" + secretKey + "/" + _channel + "/" + serializedMessage;
				
				// Sign message using HmacSHA256
				signature = HMAC.hash(secretKey, concat, SHA256);        
			}
			
			if(cipherKey && cipherKey.length > 0){
				serializedMessage = PnJSON.stringify(PnCrypto.encrypt(cipherKey, serializedMessage));
			}
			
			uid = PnUtils.getUID();
			_url = origin + "/" + "publish" + "/" + publishKey + "/" + subscribeKey + "/" + signature + "/" + PnUtils.encode(_channel) + "/" + 0 + "/" +PnUtils.encode(serializedMessage as String);
			return createRequest();
		}
		
		
		private function packageToJSON(message:String):Object{
			return { text:message };
		}
		
		override public function onData(data:Object = null):void {
			try {
				dispatchEvent(new OperationEvent(OperationEvent.RESULT, PnJSON.parse(String(data))));
			}
			catch (e:*){
				dispatchEvent(new OperationEvent(OperationEvent.FAULT, [-1, "[Pn.publish()] JSON.parse error"] ));
			}
		}
		
		public function get channel():String {
			return _channel;
		}
	}
}