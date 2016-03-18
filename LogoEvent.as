package  {
	import flash.events.Event;	
	public class LogoEvent extends Event{
		public static const LOGO_LOADED:String = "logo loaded";
		public function LogoEvent(type:String){
			super(type, true);
		}
	}
}
