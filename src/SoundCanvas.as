package {
	import flash.display.Sprite;
	import flash.external.ExternalInterface;
	import flash.system.Security;
	import flash.utils.Timer;
	
	import flash.events.*;
	import flash.media.*;
	
	
	public class SoundCanvas extends Sprite {
		
		private var sound:Sound;
		private var channel:SoundChannel;
		
		
		public function SoundCanvas() {
			Security.allowDomain("*");
			
			if (ExternalInterface.available) {
				ExternalInterface.marshallExceptions = true;
				
				ExternalInterface.addCallback("play", API_play);
				ExternalInterface.addCallback("stop", API_stop);
				
				init();
				
				if (checkJavaScriptReady()) {
					ExternalInterface.call("SoundCanvas._onReady");
				}
				else {
					var readyTimer:Timer = new Timer(50, 0);
					readyTimer.addEventListener(TimerEvent.TIMER, readyTimerHandler);
					readyTimer.start();
				}
			}
		}
		
		private function checkJavaScriptReady():Boolean {
			var isReady:Boolean = ExternalInterface.call("SoundCanvas._isReady");
			return isReady;
		}
		
		private function readyTimerHandler(event:TimerEvent):void {
			var isReady:Boolean = checkJavaScriptReady();
			if (isReady) {
				Timer(event.target).stop();
				ExternalInterface.call("SoundCanvas._onReady");
			}
		}
		
		private function init():void {
			sound = new Sound();
    		sound.addEventListener(SampleDataEvent.SAMPLE_DATA, generate);
		}
		
		private function generate(e:SampleDataEvent):void {
		    var data:Array = ExternalInterface.call("SoundCanvas._onGenerate", e.position);
		    
		    for (var i:int = 0; i < data.length; i++) {
		        e.data.writeFloat(data[i]);
		    }
		}
		
		private function API_play():void {
		    channel = sound.play();
		}
		
		private function API_stop():void {
		    if (channel != null)
		        channel.stop();
		}
		
	}
}