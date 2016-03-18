package  {
	import flash.net.*;
	import flash.events.Event;
	
	public class PersonalCollectionSaver {
		
		public function PersonalCollectionSaver() {
			
		}
		
		public function saveCollection(images:Array, cTitle:String, cName:String):void{
			var uR:URLRequest = new URLRequest("http://localhost/collection.php");
			var uV:URLVariables = new URLVariables();
			
			uV.title = cTitle;
			uV.name = cName;
			uV.total = images.length;
			uV.file = ImageParser.settings.GlobalSettings.outputFile;
			switch(images.length){
				case 1:
					uV.image1 = images[0];
					break;
				case 2:
					uV.image1 = images[0];
					uV.image2 = images[1];
					break;
				case 3:
					uV.image1 = images[0];
					uV.image2 = images[1];
					uV.image3 = images[2];
					break;
				case 4:
					uV.image1 = images[0];
					uV.image2 = images[1];
					uV.image3 = images[2];
					uV.image4 = images[3];
					break;
				case 5:
					uV.image1 = images[0];
					uV.image2 = images[1];
					uV.image3 = images[2];
					uV.image4 = images[3];
					uV.image5 = images[4];
					break;
				case 6:
					uV.image1 = images[0];
					uV.image2 = images[1];
					uV.image3 = images[2];
					uV.image4 = images[3];
					uV.image5 = images[4];
					uV.image6 = images[5];
					break;
				case 7:
					uV.image1 = images[0];
					uV.image2 = images[1];
					uV.image3 = images[2];
					uV.image4 = images[3];
					uV.image5 = images[4];
					uV.image6 = images[5];
					uV.image7 = images[6];
					break;
				case 8:
					uV.image1 = images[0];
					uV.image2 = images[1];
					uV.image3 = images[2];
					uV.image4 = images[3];
					uV.image5 = images[4];
					uV.image6 = images[5];
					uV.image7 = images[6];
					uV.image8 = images[7];
					break;
				case 9:
					uV.image1 = images[0];
					uV.image2 = images[1];
					uV.image3 = images[2];
					uV.image4 = images[3];
					uV.image5 = images[4];
					uV.image6 = images[5];
					uV.image7 = images[6];
					uV.image8 = images[7];
					uV.image9 = images[8];
					break;
				case 10:
					uV.image1 = images[0];
					uV.image2 = images[1];
					uV.image3 = images[2];
					uV.image4 = images[3];
					uV.image5 = images[4];
					uV.image6 = images[5];
					uV.image7 = images[6];
					uV.image8 = images[7];
					uV.image9 = images[8];
					uV.image10 = images[9];
					break;
				default:
					trace("The number of images in the collection was unexpected: " + images.length);
			}
			
			var now:Date = new Date();
			uV.date = now.toString();
			
			uR.data = uV;
			
			
			var uL:URLLoader = new URLLoader(uR);
			uL.dataFormat = URLLoaderDataFormat.TEXT;
			uL.addEventListener(Event.COMPLETE, loaderCompleteHandler);
			
			function loaderCompleteHandler(e:Event):void{
				trace("Response from collection.php was: " + uL.data);
			}
			
		}

	}
	
}
