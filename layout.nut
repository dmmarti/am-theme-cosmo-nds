////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// 10/11/2016 updated by DGM for the RetroPie Facebook group 
// Updated and enhanced to now include many new features and options
//
// Updated 9/08/2016 by omegaman                                                                      
// Attract-Mode "Robospin" layout. Thanks to verion for cleaning cab skins and to malfacine's for glogos                             
// Notes: Lots of changes...  
////////////////////////////////////////////////////////////////////////////////////////////////////////   

class UserConfig {

 	</ label="Type of wheel", help="Select round wheel or vertical wheel", options="wheel,vert_wheel", order=1 /> enable_list_type="wheel";
 	</ label="Select spinwheel art", help="The artwork to spin", options="marquee, wheel", order=2 /> orbit_art="wheel";
 	</ label="Wheel transition time", help="Time in milliseconds for wheel spin.", order=3 /> transition_ms="25";  
 	</ label="Show box art", help="Show box art", options="Yes,No", order=4 /> enable_gboxart="Yes"; 
 	</ label="Artwork aspect ratio", help="Preserve aspect ratio of box art", options="Yes,No", order=6 /> ratio="Yes";  
 	</ label="Enable animations", help="Enable box animations", options="Yes,No", order=7 /> enable_ganimate="Yes";

 	</ label="Select pointer", help="Select animated pointer", options="default,emulator,none", order=8 /> enable_pointer="emulator"; 

 	</ label="Enable game information", help="Show game information", options="Yes,No", order=9 /> enable_ginfo="Yes";
 	</ label="Enable text frame", help="Show text frame", options="Yes,No", order=10 /> enable_frame="Yes"; 
 	</ label="Enable MFR game logos", help="Select game logos", options="Yes,No", order=11 /> enable_mlogos="Yes"; 
 	</ label="Enable random text colors", help=" Select random text colors", options="Yes,No", order=12 /> enable_colors="No";

 	</ label="Enable monitor static effect", help="Show static effect when snap is null", options="Yes,No", order=13 /> enable_static="Yes"; 
	</ label="Mute Videos", help="Mute Videos", options="Yes,No", order=14 /> sound="No"; 
}  

local my_config = fe.get_config();
local flx = fe.layout.width;
local fly = fe.layout.height;
local flw = fe.layout.width;
local flh = fe.layout.height;
//fe.layout.font="Roboto";

// modules
fe.load_module("fade");
fe.load_module( "animate" );


/////////////////////////////////////////////////////////
// Video Preview or static video if none available
///////////////////////////////////////////////////////
// remember to make both sections the same dimensions and size
/////////////////////////////////////////////////////////////////


// Video Preview or static video if none available
// remember to make both sections the same dimensions and size
if ( my_config["enable_static"] == "Yes" )
{
//adjust the values below for the static preview video snap
   const SNAPBG_ALPHA = 200;
   local snapbg=null;
   snapbg = fe.add_image( "static.mp4", flx*0.26, fly*0., flw*0.27, flh*0.99);
   snapbg.trigger = Transition.EndNavigation;
   snapbg.skew_y = 0;
   snapbg.skew_x = 0;
   snapbg.pinch_y = 0;
   snapbg.pinch_x = 0;
   snapbg.rotation = 0;
   snapbg.set_rgb( 155, 155, 155 );
   snapbg.alpha = SNAPBG_ALPHA;
}
 else
 {
 local temp = fe.add_text("", flx*0.092, fly*0.38, flw*0.226, flh*0.267 );
 temp.bg_alpha = SNAPBG_ALPHA;
 }

//create surface for snap
local surface = fe.add_surface( 240, 360 );
local snap = surface.add_artwork("snap", 0, 0, 240, 360);
snap.trigger = Transition.EndNavigation;
snap.preserve_aspect_ratio = false;

//now position and pinch the surface
surface.set_pos(flx*0.265, fly*0.24, flw*0.255, flh*0.68);
surface.skew_y = 0;
surface.skew_x = 0;
surface.pinch_y = 0;
surface.pinch_x = 0;
surface.rotation = 0;

//create surface for snap
local surface = fe.add_surface( 240, 180 );
local snap = surface.add_artwork("snap", 0, 0, 240, 360);
snap.trigger = Transition.EndNavigation;
snap.preserve_aspect_ratio = false;

//now position and pinch the surface
surface.set_pos(flx*0.265, fly*0.07, flw*0.255, flh*0.34);
surface.skew_y = 0;
surface.skew_x = 0;
surface.pinch_y = 0;
surface.pinch_x = 0;
surface.rotation = 0;


// mute the video
 if ( my_config["sound"] == "Yes" )
 {
     snap.video_flags = Vid.NoAudio;
 }




////////////////////////////////////////////
//Background
///////////////////////////////////
// Load background based up display name
/////////////////////////////////////////

// Background Art 
// This section will display the two different background art 
// based up on the layout option choice

local b_art = fe.add_image("backgrounds/[DisplayName]", 0, 0, flw, flh );
b_art.alpha=255;


/////////////////////////////////////////////////////////
// Cabinet image
///////////////////////////////////////////////////////
// for wheel background
/////////////////////////////////////////////////////////////////

if ( my_config["enable_list_type"] == "wheel" )
{
 	local cab = fe.add_image( "wheel_art.png", 0, 0, flw, flh );
}

if ( my_config["enable_list_type"] == "vert_wheel" )
{
 	local cab = fe.add_image( "wheel_vert.png", 0, 0, flw, flh );
}


////////////////////////////////////////////////////////////////////////////////////////////////////
//Boxart
/////////////////////////////////////////////
// Box art to display, uses the emulator.cfg path for cartart for cartridge image location
/////////////////////////////////////////////////////////////////////////////////////////////

if ( my_config["enable_gboxart"] == "Yes" )
{
	local boxart = fe.add_artwork("boxart", flx*0, fly*0.04 flw*0.25, flh*0.4 );

	if ( my_config["ratio"] == "Yes" )
	{
		boxart.preserve_aspect_ratio = true;
	}

	if ( my_config["enable_ganimate"] == "Yes" )
	{
		local move_transition1 = {
		when = Transition.ToNewSelection,
		property = "x",
		start = flx*-2,
		end = flx*0.0, 
		time = 1500
		}

	animation.add( PropertyAnimation( boxart, move_transition1 ) );
	}
}


///////////////////////////////////////
// Wheels
///////////////////////////////////////
// The following section sets up what type and wheel and displays the users choice
///////////////////////////////////////


//This enables vertical art instead of default wheel
if ( my_config["enable_list_type"] == "vert_wheel" )
{
fe.load_module( "conveyor" );
  local wheel_x = [ flx*0.78, flx*0.78, flx*0.78, flx*0.78, flx*0.78, flx*0.78, flx*0.76, flx*0.78, flx*0.78, flx*0.78, flx*0.78, flx*0.78, ]; 
  local wheel_y = [ -fly*0.22, -fly*0.105, fly*0.0, fly*0.105, fly*0.215, fly*0.325, fly*0.436, fly*0.61, fly*0.72 fly*0.83, fly*0.935, fly*0.99, ];
  local wheel_w = [ flw*0.18, flw*0.18, flw*0.18, flw*0.18, flw*0.18, flw*0.18, flw*0.22, flw*0.18, flw*0.18, flw*0.18, flw*0.18, flw*0.18, ];
  local wheel_a = [  80,  80,  80,  80,  150,  150, 255,  150,  150,  80,  80,  80, ];
  local wheel_h = [  flh*0.11,  flh*0.11,  flh*0.11,  flh*0.11,  flh*0.11,  flh*0.11, flh*0.15,  flh*0.11,  flh*0.11,  flh*0.11,  flh*0.11,  flh*0.11, ];
  local wheel_r = [  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ];
local num_arts = 8;

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
		if ( slot >=10 ) slot=10;

		m_obj.x = wheel_x[slot] + p * ( wheel_x[slot+1] - wheel_x[slot] );
		m_obj.y = wheel_y[slot] + p * ( wheel_y[slot+1] - wheel_y[slot] );
		m_obj.width = wheel_w[slot] + p * ( wheel_w[slot+1] - wheel_w[slot] );
		m_obj.height = wheel_h[slot] + p * ( wheel_h[slot+1] - wheel_h[slot] );
		m_obj.rotation = wheel_r[slot] + p * ( wheel_r[slot+1] - wheel_r[slot] );
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
}
 
if ( my_config["enable_list_type"] == "wheel" )
{
fe.load_module( "conveyor" );
local wheel_x = [ flx*0.80, flx*0.795, flx*0.756, flx*0.725, flx*0.70, flx*0.68, flx*0.64, flx*0.68, flx*0.70, flx*0.725, flx*0.756, flx*0.76, ]; 
local wheel_y = [ -fly*0.22, -fly*0.105, fly*0.0, fly*0.105, fly*0.215, fly*0.325, fly*0.436, fly*0.61, fly*0.72 fly*0.83, fly*0.935, fly*0.99, ];
local wheel_w = [ flw*0.18, flw*0.18, flw*0.18, flw*0.18, flw*0.18, flw*0.18, flw*0.24, flw*0.18, flw*0.18, flw*0.18, flw*0.18, flw*0.18, ];
local wheel_a = [  80,  80,  80,  80,  80,  80, 255,  80,  80,  80,  80,  80, ];
local wheel_h = [  flh*0.11,  flh*0.11,  flh*0.11,  flh*0.11,  flh*0.11,  flh*0.11, flh*0.17,  flh*0.11,  flh*0.11,  flh*0.11,  flh*0.11,  flh*0.11, ];
local wheel_r = [  30,  25,  20,  15,  10,   5,   0, -10, -15, -20, -25, -30, ];
local num_arts = 8;

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
		if ( slot >=10 ) slot=10;

		m_obj.x = wheel_x[slot] + p * ( wheel_x[slot+1] - wheel_x[slot] );
		m_obj.y = wheel_y[slot] + p * ( wheel_y[slot+1] - wheel_y[slot] );
		m_obj.width = wheel_w[slot] + p * ( wheel_w[slot+1] - wheel_w[slot] );
		m_obj.height = wheel_h[slot] + p * ( wheel_h[slot+1] - wheel_h[slot] );
		m_obj.rotation = wheel_r[slot] + p * ( wheel_r[slot+1] - wheel_r[slot] );
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
}


/////////////////////////////////////////////////////////
// Pointers
/////////////////////////////////////////////////////////////////


// The following sets up which pointer to show on the wheel
//property animation - wheel pointers

if ( my_config["enable_pointer"] == "emulator") 
{
local point = fe.add_image("pointers/[DisplayName]", flx*0.88, fly*0.34, flw*0.2, flh*0.35);

local alpha_cfg = {
    when = Transition.ToNewSelection,
    property = "alpha",
    start = 110,
    end = 255,
    time = 300
}
animation.add( PropertyAnimation( point, alpha_cfg ) );

local movey_cfg = {
    when = Transition.ToNewSelection,
    property = "y",
    start = point.y,
    end = point.y,
    time = 200
}
animation.add( PropertyAnimation( point, movey_cfg ) );

local movex_cfg = {
    when = Transition.ToNewSelection,
    property = "x",
    start = flx*0.83,
    end = point.x,
    time = 200	
}	
animation.add( PropertyAnimation( point, movex_cfg ) );

}


if ( my_config["enable_pointer"] == "default") 
{
local point = fe.add_image("pointers/default.png", flx*0.88, fly*0.34, flw*0.2, flh*0.35);

local alpha_cfg = {
    when = Transition.ToNewSelection,
    property = "alpha",
    start = 110,
    end = 255,
    time = 300
}
animation.add( PropertyAnimation( point, alpha_cfg ) );

local movey_cfg = {
    when = Transition.ToNewSelection,
    property = "y",
    start = point.y,
    end = point.y,
    time = 200
}
animation.add( PropertyAnimation( point, movey_cfg ) );

local movex_cfg = {
    when = Transition.ToNewSelection,
    property = "x",
    start = flx*0.83,
    end = point.x,
    time = 200	
}	
animation.add( PropertyAnimation( point, movex_cfg ) );
}



if ( my_config["enable_pointer"] == "none") 
{
 local point = fe.add_image( "", 0, 0, 0, 0 );
}


/////////////////////////////////////////////////////////
// Game information and text frame
/////////////////////////////////////////////////////////////////


// Game information text box at bottom of screen
//add frame to make text standout 
if ( my_config["enable_frame"] == "Yes" )
{
local frame = fe.add_image( "frame.png", 0, fly*0.94, flw, flh*0.06 );
frame.alpha = 255;
}
// Game information to show inside text box frame
if ( my_config["enable_ginfo"] == "Yes" )
{
//Year text info
local texty = fe.add_text("[Year]", flx*0.18, fly*0.942, flw*0.13, flh*0.05 );
texty.set_rgb( 255, 255, 255 );
//texty.style = Style.Bold;
//texty.align = Align.Left;

//Title text info
local textt = fe.add_text( "[Title]", flx*0.315, fly*0.955, flw*0.6, flh*0.028  );
textt.set_rgb( 225, 255, 255 );
//textt.style = Style.Bold;
textt.align = Align.Left;
textt.rotation = 0;
textt.word_wrap = true;

//display filter info
local filter = fe.add_text( "[ListFilterName]: [ListEntry]-[ListSize]  [PlayedCount]", flx*0.7, fly*0.962, flw*0.3, flh*0.022 );
filter.set_rgb( 255, 255, 255 );
//filter.style = Style.Italic;
filter.align = Align.Right;
filter.rotation = 0;


/////////////////////////////////////////////////////////
// Genre logo
/////////////////////////////////////////////////////////////////


//category icons 

local glogo1 = fe.add_image("glogos/unknown1.png", flx*0.12, fly*0.945, flw*0.045, flh*0.05);
glogo1.preserve_aspect_ratio = true
glogo1.trigger = Transition.EndNavigation;

class GenreImage1
{
    mode = 1;       //0 = first match, 1 = last match, 2 = random
    supported = {
        //filename : [ match1, match2 ]
        "action": [ "action" ],
        "adventure": [ "adventure" ],
        "fighting": [ "fighting", "fighter", "beat'em up" ],
        "platformer": [ "platformer", "platform" ],
        "puzzle": [ "puzzle" ],
        "maze": [ "maze" ],
		"paddle": [ "paddle" ],
		"rhythm": [ "rhythm" ],
		"pinball": [ "pinball" ],
		"racing": [ "racing", "driving" ],
        "rpg": [ "rpg", "role playing", "role-playing" ],
        "shooter": [ "shooter", "shmup" ],
        "sports": [ "sports", "boxing", "golf", "baseball", "football", "soccer" ],
        "strategy": [ "strategy"]
    }

    ref = null;
    constructor( image )
    {
        ref = image;
        fe.add_transition_callback( this, "transition" );
    }
    
    function transition( ttype, var, ttime )
    {
        if ( ttype == Transition.ToNewSelection || ttype == Transition.ToNewList )
        {
            local cat = " " + fe.game_info(Info.Category, var).tolower();
            local matches = [];
            foreach( key, val in supported )
            {
                foreach( nickname in val )
                {
                    if ( cat.find(nickname, 0) ) matches.push(key);
                }
            }
            if ( matches.len() > 0 )
            {
                switch( mode )
                {
                    case 0:
                        ref.file_name = "glogos/" + matches[0] + "1.png";
                        break;
                    case 1:
                        ref.file_name = "glogos/" + matches[matches.len() - 1] + "1.png";
                        break;
                    case 2:
                        local random_num = floor(((rand() % 1000 ) / 1000.0) * ((matches.len() - 1) - (0 - 1)) + 0);
                        ref.file_name = "glogos/" + matches[random_num] + "1.png";
                        break;
                }
            } else
            {
                ref.file_name = "glogos/unknown1.png";
            }
        }
    }
}
GenreImage1(glogo1);


/////////////////////////////////////////////////////////
// Manufacturer logo
/////////////////////////////////////////////////////////////////

//Game MFR Logos
if ( my_config["enable_mlogos"] == "Yes")  
{
local mlogos = fe.add_image("mlogos/[Manufacturer]", flx*0.01, fly*0.945, flw*0.06, flh*0.05 );
mlogos.preserve_aspect_ratio = true
mlogos.trigger = Transition.EndNavigation;
}		


/////////////////////////////////////////////////////////
// Random color text
/////////////////////////////////////////////////////////////////


// random number for the RGB levels
if ( my_config["enable_colors"] == "Yes" )
{
function brightrand() {
 return 255-(rand()/255);
}

local red = brightrand();
local green = brightrand();
local blue = brightrand();

// Color Transitions
fe.add_transition_callback( "color_transitions" );
function color_transitions( ttype, var, ttime ) {
 switch ( ttype )
 {
  case Transition.StartLayout:
  case Transition.ToNewSelection:
  red = brightrand();
  green = brightrand();
  blue = brightrand();
  //listbox.set_rgb(red,green,blue);
  texty.set_rgb (red,green,blue);
  textt.set_rgb (red,green,blue);
  break;
 }
 return false;
 }
}}
