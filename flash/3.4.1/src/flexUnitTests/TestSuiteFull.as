package flexUnitTests
{
	import flexUnitTests.TestLibraryExistanceValidation;
	import flexUnitTests.TestRemoteObject;
	
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class TestSuiteFull
	{
		public var test1:flexUnitTests.TestLibraryExistanceValidation;
		//public var test2:flexUnitTests.TestRemoteObject;
		public var test3:flexUnitTests.TestPnCrypto;
		public var test4:flexUnitTests.TestTime;
	}
}