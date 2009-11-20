var SoundCanvas = {
	
	options: {
		BUFFER_SIZE: 8192
	},
	
	events: {
		onready: function() {},
		ongenerate: function(position) { return []; }
	},
	
	internal: {
		flash: undefined,
		ready: false
	},
	
	init: function() {
		document.body.innerHTML += "<div id='_soundcanvas'></div>";
		swfobject.embedSWF(
			"../build/SoundCanvas.swf",
			"_soundcanvas",
			"100",
			"100",
			"10.0.0",
			"../lib/expressInstall.swf",
			{},
			{allowScriptAccess: "always", "allowNetworking": "true"},
			{},
			function(obj) {
				SoundCanvas.internal.flash = obj.ref;
			}
		);
		
		SoundCanvas.internal.ready = true;
	},
	
	play: function() {
	    SoundCanvas.internal.flash.play();
	},
	
	stop: function() {
	    SoundCanvas.internal.flash.stop();
	},
	
	_isReady: function() {
		return SoundCanvas.internal.ready;
	},
	
	_onReady: function() {
		SoundCanvas.events.onready();
	},
	
	_onGenerate: function(position) {
	    return SoundCanvas.events.ongenerate(position);
	}
};