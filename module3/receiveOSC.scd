//receiving from iPython

s.boot;

(
n = NetAddr("172.27.160.56", 57120);
n.sendMsg('/texto/supercollider', 1, 2, 3);

//OSCFunc.trace(false);

~data = [];
~output = [0];

~touchVal = nil;
~redVal = nil;
~greenVal = nil;
~blueVal = nil;


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

		// print the important stuff
		"Touch: ".post;
		~touchVal = ~data.at(0).asInteger.postln;
		"Red: ".post;
		~redVal = ~data.at(1).asInteger.postln;
		"Green: ".post;
		~greenVal = ~data.at(2).asInteger.postln;
		"Blue: ".post;
		~blueVal = ~data.at(3).asInteger.postln;


		// current brings val down below 30
		if((~touchVal > 30), {
			"untouched".postln;
		},
		{
			"touched".postln;
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
);

)
// stop posting:
thisProcess.removeOSCRecvFunc(f);

o.free;


