package flexUnitTests
{
	import com.pubnub.Pn;

	public class PrepareTesting
	{
		public static function PnConfig(pn:Pn):void
		{
			pn = Pn.instance;
			var config:Object = {
				origin:		'pubsub.pubnub.com',
				publish_key:'demo',
				sub_key:	'demo',
				secret_key:	'',
				cipher_key:	'',
				ssl:		false};
			
			Pn.init(config);
		}
	}
}