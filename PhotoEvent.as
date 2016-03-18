package  {
	import flash.events.Event;	
	
	public class PhotoEvent extends Event{
		public static const PHOTO_REQUEST:String = "photo requested";
		public static const PHOTO_DESTROY:String = "photo destroyed";
		public static const PHOTO_ADD:String = "photo added";
		private var _id:int;
		private var _x:int;
		private var _y:int;
		private var _other:Boolean;
		
		public function PhotoEvent(type:String, id:int, x:int=NaN, y:int=NaN, other:Boolean=false) {
			super(type, true);
			_id = id;
			_x = x;
			_y = y;
			_other = other;
		}
		
		public function get id():int{
			return _id;
		}
		
		public function get x():int{
			return _x;
		}
		
		public function get y():int{
			return _y;
		}
		
		public function get other():Boolean{
			return _other;
		}
		
		public override function clone():Event {
			return new PhotoEvent(type, _id, _x, _y, _other); 
		}

	}
	
}
