//receiving from Python

//s.boot;


Server.killAll;

(
s.waitForBoot(

n = NetAddr("172.27.160.56", 57120); // update IP address; 57120 is SuperCollider port
n.sendMsg('/texto/supercollider', 1, 2, 3);

//OSCFunc.trace(false);

~output = [0]; // output of Arduino and Python; input for SC
~data = [0, 0, 0, 0]; // store parsed input

~touchVal = 0;
~redVal = 0;
~greenVal = 0;
~blueVal = 0;

// arrays to store touch and RGB data
~touchArr = [];
~redArr = [];
~greenArr = [];
~blueArr = [];
~notes = [];

~isTouched = false;

TempoClock.tempo = 60/60;

(

f = { |msg, time, addr|
    if(msg[0] != '/status.reply') {
		//"%\n".postf(msg[0]);

		// saving current vals
		~output = ~output.put(0, msg[0]);
		~current = ~output.at(0).postln;

		// splitting into separate vals
		~str = ~current.asString;
		~data = ~str.split($,);
	//	~data.at(3).postln;

		// print the important stuff
		//"Touch: ".post;
		if(~data.at(0) != nil, {~touchVal = ~data.at(0).asInteger});
		//"Red: ".post;
		if(~data.at(1) != nil, {~redVal = ~data.at(1).asInteger});
		//"Green: ".post;
		if(~data.at(2) != nil, {~greenVal = ~data.at(2).asInteger});
		//"Blue: ".post;
		if(~data.at(3) != nil, {~blueVal = ~data.at(3).asInteger});

		// store current vals to arrays to read them later

		~blueArr = ~blueArr.add(~blueVal);

		// current brings val down below 30
		if((~touchVal > 30), {
			"untouched".postln;
			~isTouched = false;
		},
		{
			"touched".postln;
			~isTouched = true;
		}
		);

		// higher vals = darker room
		if((~redVal > 400) && (~greenVal > 400) && (~blueVal > 400),
			{
				"it's dark".postln;
			},
			{
				"it's bright".postln;
			}
		);

		// for my sanity
	    "".postln;

    }
};
  thisProcess.addOSCRecvFunc(f);


// *************** THE FUN STUFF *****************

    // Piano SynthDef
/*	SynthDef(\pianoChords, { |out=0, freq=440, gate=1, amp = 0.8, vel = 100|
		var son;

		son = MdaPiano.ar(freq, gate, vel: vel, release: 0.0, stereo: 0.3, sustain: 0.8);
		son = FreeVerb.ar(son, mix: 0.5, damp: 0.01);
		son = LPF.ar(son);

		DetectSilence.ar(son, 0.0001, doneAction:2);

		Out.ar(out, son * amp);
	}).add;*/

SynthDef(\saw, { |cutoff=1000, greenMix=0.5, pos=1|
	var sig;
	sig = Saw.ar(60);
	sig = RLPF.ar(sig, cutoff.lag(0.02), 0.25, 0.2);
//	sig = FreeVerb.ar(sig, greenMix, damp: 0.5);
	//sig = Pan2.ar(sig, pan);
	//sig = Pan2.ar(sig, pos: pan);
	//Out.ar(0, Pan2.ar(sig, pos: pan));
	//pos = LinPan2.ar(sig, Line.kr(-1, 1, dur));
	sig = Pan2.ar(sig, pos);
	Out.ar(0, sig);

}).add;

/*SynthDef(\sine, { |out=0,freq=200, amp=0.5, pan=0|
	var sin;
	sin = SinOsc.ar(freq);
	//sin = RLPF.ar(sig, cutoff.lag(0.02), 0.25, 0.2);
	sin = sin * amp;

	Out.ar(out, Pan2.ar(sin, pos: -1));
}).add;*/

	SynthDef(\pianoChords, { |out=0, freq=440, gate=1, amp = 0.8, vel = 100|
		var son;

		son = MdaPiano.ar(freq, gate, vel: vel, release: 0.0, stereo: 0.3, sustain: 0.8);
		son = FreeVerb.ar(son, mix: 0.5, damp: 0.01);
		son = LPF.ar(son);

		DetectSilence.ar(son, 0.0001, doneAction:2);

		Out.ar(out, son * amp);
	}).add;



);

)


)

// stop posting:
thisProcess.removeOSCRecvFunc(f);

//s.sync;




//test parameter setting
~z.set(\freq, 233);
~z.set(\amp, 0.1);
~z.free;


(
~create = Routine.new({
	{
		"test".postln;
		if(~touchVal != 0 && ~touchVal != nil, {~notes = ~notes.add(~touchVal * 2).postln});
		~dur = [1];
		~arpOut = Pbind(\instrument, \pianoChords, \midinote, Pseq(~notes, inf), \dur, Pseq(~dur, inf), \amp, 0.6); // # measures x 4
		~arpOut.play;
		5.wait;

	}.loop;

}).play;

)

~create.stop;


~synth = Synth(\saw, [\cutoff, 200, \dur, 0.2, \pos, 0]);
~synth.set(\pos, 0);
//~synthOut = Pbind(\instrument, \saw, \midinote, 60, \amp, 0.4).play;
~synth.free;

(
~controlSynth = Routine.new({
	{
		if(~isTouched == false, {
			~synth.set(\cutoff,233);
			~synth.set(\mix, 0.5);
			~synth.set(\pan, 1);
		}, {
			if(~isTouched == true && ~blueVal != 0 && ~blueVal != nil && (~blueVal <= 4000), {~synth.set(\cutoff, ~blueVal)});
			if(~isTouched == true && ~greenVal != 0 && ~greenVal != nil, {~synth.set(\greenMix, (1/~greenVal))});
			if(~isTouched == true && ~redVal != 0 && ~redVal != nil && (~redVal > 5000), {~synth.set(\pos, 1)});
			if(~isTouched == true && ~redVal != 0 && ~redVal != nil && (~redVal > 500 && (~redVal <= 5000)), {~synth.set(\pos, 0.5)});
			if(~isTouched == true && ~redVal != 0 && ~redVal != nil && (~redVal > 250 && (~redVal <= 500)), {~synth.set(\pos, 0)});
			if(~isTouched == true && ~redVal != 0 && ~redVal != nil && (~redVal > 100 && (~redVal <= 250)), {~synth.set(\pos, -0.5)});
			if(~isTouched == true && ~redVal != 0 && ~redVal != nil && (~redVal < 100), {~synth.set(\pos, -1)})

		});
		0.005.wait;
	}.loop
}).play
)
~controlSynth.stop;


(
~controlAmp = Routine.new({
	{
		if(~isTouched == false, {~z.set(\amp,0.3)}, {
			if(~isTouched == true && ~redVal > 4 && ~redVal != nil, {~z.set(\amp, (4/~redVal))});
		});
		0.005.wait;
	}.loop
}).play
)
~controlCutOff.stop;




o.free;



SynthDef(\saw, { |cutoff=1000, greenMix=0.5, pos=1|
	var sig;
	sig = Saw.ar([59,60]);
	sig = RLPF.ar(sig, cutoff.lag(0.02), 0.25, 0.2);
//	sig = FreeVerb.ar(sig, greenMix, damp: 0.5);
	//sig = Pan2.ar(sig, pan);
	//sig = Pan2.ar(sig, pos: pan);
	//Out.ar(0, Pan2.ar(sig, pos: pan));
	//pos = LinPan2.ar(sig, Line.kr(-1, 1, dur));
	sig = Pan2.ar(sig, pos);
	Out.ar(0, sig);

}).add;

~synth = Synth(\saw, [\cutoff, 200, \dur, 0.2, \pos, -1]);

