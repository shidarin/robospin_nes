//
// Attract-Mode Front-End - "Robospin NES" layout
//
// Based off the "Robospin" layout by omegaman, verion and raygun
// http://forum.attractmode.org/index.php?topic=198.0
// Nintendo Entertainment System version by Sean 'shidarin' Wallitsch
// https://github.com/shidarin/robospin_nes
//
// The MIT License (MIT)
// 
// Copyright (c) 2017 omegaman, verion, raygun, Sean Wallitsch
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

// modules
fe.load_module("fade")

class UserConfig {
    </
        label="SpinWheel Artwork",
        help="The artwork to spin",
        options="marquee,flyer,wheel"
    /> orbit_art="wheel";
    </
        label="Enable Wheel Mask",
        help="Make background behind the SpinWheel darker.",
        options="Yes,No"
    /> enable_Mask="Yes";
	</
		label="Enable crt shader effect",
		help="CRT effect uses shader",
		options="Yes,No",
	/> enable_crt="Yes";
    </
        label="Transition Time",
        help="Time in milliseconds for wheel spin."
    /> transition_ms="25";
}

local my_config = fe.get_config();

fe.layout.width=1920;
fe.layout.height=1080;

local flx = fe.layout.width;
local fly = fe.layout.height;
local flw = fe.layout.width;
local flh = fe.layout.height;

//background
fe.add_artwork( "bg.png", flx, fly, 0, 0 );

//create surface for snap
local surface_snap = fe.add_surface( 640, 480 );
local snap = FadeArt("snap", 0, 0, 640, 480, surface_snap);
//snap.trigger = Transition.EndNavigation;
snap.preserve_aspect_ratio = false;

//video
//we need different values for the crt vs the non-crt, since the warping brings
//in the edges so much.
if ( my_config["enable_crt"] == "Yes" )
{
	surface_snap.set_pos(flx*0.0015, fly*0.295, 640*0.54, 480*0.99 );
	surface_snap.pinch_x = 0;
	surface_snap.pinch_y = 36;
	surface_snap.skew_x = -25;
	surface_snap.skew_y = -60;
	surface_snap.rotation = -5;

	local sh = fe.add_shader( Shader.VertexAndFragment, "crt.vert", "crt.frag" );
	sh.set_param( "rubyInputSize", 640, 480 );
    sh.set_param( "rubyOutputSize", ScreenWidth, ScreenHeight );
    sh.set_param( "rubyTextureSize", 640, 480 );
	sh.set_texture_param("rubyTexture"); 
	surface_snap.shader = sh;
}
else
{
	surface_snap.set_pos(flx*0.01, fly*0.32, 640*0.49, 480*0.88 );
	surface_snap.pinch_x = 0;
	surface_snap.pinch_y = 20;
	surface_snap.skew_x = -3;
	surface_snap.skew_y = -60;
	surface_snap.rotation = -3;
}
//helps with placement
//surface_snap.alpha = 150;

//cart
local cart = fe.add_artwork( "cart", flx*0.0822, fly*0.819, 158, 60 );
cart.pinch_x = -10;
cart.pinch_y = 0;
cart.skew_x = 87;
cart.skew_y = 0;
cart.rotation = -12.7;
cart.preserve_aspect_ratio = false;
//helps with placement
//cart.alpha = 150;

//Image of overlay
local overlay_top = fe.add_image( "overlay.png", 0, 0, flw, flh );

//box art
local box = fe.add_artwork(
    "flyer", flx*0.18, fly*0.67, flw*0.15625, flh*0.277
);
box.preserve_aspect_ratio = true;

//mask
if ( my_config["enable_Mask"] == "Yes" )
{
	local mask = fe.add_image( "mask.png", 0, 0, flw, flx );
}


//wheel settings
fe.load_module( "conveyor" );

local wheel_x = [
    flx*0.8, flx*0.8, flx*0.8, flx*0.8, flx*0.8, flx*0.8,
    flx*0.58,
    flx*0.8, flx*0.8, flx*0.8, flx*0.8, flx*0.8,
]; 
local wheel_y = [
    -fly*0.22, -fly*0.105, fly*0.0, fly*0.105, fly*0.215, fly*0.325,
    fly*0.42,
    fly*0.61, fly*0.72 fly*0.83, fly*0.935, fly*0.99,
];
local wheel_w = [
    flw*0.18, flw*0.18, flw*0.18, flw*0.18, flw*0.18, flw*0.18,
    flw*0.35,
    flw*0.18, flw*0.18, flw*0.18, flw*0.18, flw*0.18,
];
local wheel_a = [
	100, 100, 100, 100, 100, 100,
	255,
	100, 100, 100, 100, 100, 100, 
];
local wheel_h = [ 
    flh*0.09, flh*0.09, flh*0.09, flh*0.09, flh*0.09, flh*0.09,
    flh*0.16,
    flh*0.09, flh*0.09, flh*0.09, flh*0.09, flh*0.09,
];
local num_arts = 12;

class WheelEntry extends ConveyorSlot
{
	constructor()
	{
		base.constructor( ::fe.add_artwork( my_config["orbit_art"] ) );
	}

	function on_progress( progress, var )
	{
		local p = progress / 0.1;
		local slot = p.tointeger();
		p -= slot;
		slot++;

		if ( slot < 0 ) slot=0;
		if ( slot >= 10 ) slot=10;

		m_obj.x = wheel_x[slot] + p * ( wheel_x[slot+1] - wheel_x[slot] );
		m_obj.y = wheel_y[slot] + p * ( wheel_y[slot+1] - wheel_y[slot] );
		m_obj.width = wheel_w[slot] + p * ( wheel_w[slot+1] - wheel_w[slot] );
		m_obj.height = wheel_h[slot] + p * ( wheel_h[slot+1] - wheel_h[slot] );
		m_obj.rotation = 0;
		m_obj.alpha = wheel_a[slot] + p * ( wheel_a[slot+1] - wheel_a[slot] );
	}
};

local wheel_entries = [];
for ( local i=0; i<num_arts/2; i++ )
	wheel_entries.push( WheelEntry() );

local remaining = num_arts - wheel_entries.len();

// we do it this way so that the last wheelentry created is the middle one showing the current
// selection (putting it at the top of the draw order)
for ( local i=0; i<remaining; i++ )
	wheel_entries.insert( num_arts/2, WheelEntry() );

local conveyor = Conveyor();
conveyor.set_slots( wheel_entries );
conveyor.transition_ms = 50;
try { conveyor.transition_ms = my_config["transition_ms"].tointeger(); } catch ( e ) { }

//fe.add_image( "art2.png", -115, 0, 1024, 768 );

local message = fe.add_text("Launching...",0,300,fe.layout.width,80);
message.alpha = 0;
message.style = Style.Bold;

local red = 255;
local green = 255;
local blue = 255;

// Transitions
fe.add_transition_callback( "fancy_transitions" );

function fancy_transitions( ttype, var, ttime ) {
 switch ( ttype )
 {
 case Transition.StartLayout:
 case Transition.ToNewList:
 case Transition.ToNewSelection:
 case Transition.EndLayout:
  red = 255;
  green = 255;
  blue = 255;
  //emulator.set_rgb (red,green,blue);
  message.set_rgb (red,green,blue);
  break;

 case Transition.FromGame:
  if ( ttime < 255 )
  {
   foreach (o in fe.obj)
    o.alpha = ttime;
    message.alpha = 0;     
     return true;
  }
  else
  {
   foreach (o in fe.obj)
    o.alpha = 255;
   message.alpha = 0;
     break;
  }
  case Transition.EndLayout:
  if ( ttime < 255 )
  {
   foreach (o in fe.obj)
    o.alpha = 255 - ttime;
   message.alpha = 0; 
     return true;
  }
  else
  {
   foreach (o in fe.obj)
     o.alpha = 255;
    message.alpha = 0;
  }
  break;
     
 case Transition.ToGame:
  if ( ttime < 255 )
  {
   foreach (o in fe.obj)
    o.alpha = 255 - ttime;
    message.alpha = ttime;
    return true;
  }   
  break; 
 }
 return false;
}
