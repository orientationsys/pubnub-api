package flexUnitTests
{
	import com.pubnub.Pn;
	import com.pubnub.PnCrypto;
	import com.pubnub.PnEvent;
	import com.pubnub.connection.*;
	import com.pubnub.environment.NetMonEvent;
	import com.pubnub.operation.OperationStatus;
	import com.pubnub.subscribe.Subscribe;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import flexunit.framework.Assert;
	
	import mx.controls.Alert;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	import mx.utils.ObjectUtil;
	
	import org.flexunit.async.Async;
	import org.flexunit.async.TestResponder;
	import org.flexunit.token.AsyncTestToken;
	

	public class TestTime
	{		
		public var pn:Pn;
		public var timer:Timer;
		public var resultToken:String;
		
		[Before]
		public function setUp():void
		{
			timer = new Timer(200, 5);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, TimeOver);
			timer.addEventListener(TimerEvent.TIMER, doTimer);
			timer.start();
			
			pn = new Pn();
			var config:Object = {
				origin:		'pubsub.pubnub.com',
				publish_key:'demo',
				sub_key:	'demo',
				secret_key:	'',
				cipher_key:	'',
				ssl:		false};
			
			
			Pn.init(config);
			pn.addEventListener(PnEvent.TIME, handleIntendedResult);
			pn.addEventListener(NetMonEvent.HTTP_ENABLE, onPnConnected);
			pn.time();
			
			
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		[BeforeClass]
		public static function setUpBeforeClass():void
		{
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		[Test(async)]
		public function TestTimeToken():void
		{
			Assert.assertEquals(this.resultToken, null);	
		}
		
		
		public function TimeOver(e:TimerEvent):void
		{
			TestTimeToken();
		}
		
		public function doTimer(e:TimerEvent):void
		{
			trace('timer');
		}
		
		public function onPnConnected(e:NetMonEvent):void
		{
			
		}
		
		private function onInit(e:PnEvent):void {
			trace('onInit');
			trace(Pn.instance.sessionUUID);
			pn.time();
		}
		
		
		public function handleIntendedResult(e:PnEvent):void
		{
			trace(e.status);
				switch (e.status) {
					case OperationStatus.DATA:
						trace('data');
						this.resultToken = "1";
						break;
					
					case OperationStatus.ERROR:
						//callExternalInterface("console.log", ("Time [ERROR]: " + PnJSON.stringify(e.data)));
						trace('error');
						break;
				
				}
		}
		
		public function handleUnintendedFault():void
		{
			
		}
		
	}
}