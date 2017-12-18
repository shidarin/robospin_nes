
Robospin NES
============

- **Author/Maintainer:** Sean Wallitsch
- **Email:** shidarin@alphamatte.com
- **License:** MIT
- **Status:** Development
- **Version:** 1.0
- **GitHub:** https://github.com/shidarin/robospin_nes

Introduction
------------

[Attract-Mode](http://attractmode.org/about.html) emulator layout based on the
classic robospin theme. Customized for Nintendo Entertainment System (NES) 
games. Classic wheel design showcases snaps or videos on a 1980s TV, 
as well as showing cart art.

[![Theme Preview](preview.png?raw=true)](preview.png?raw=true)

[Original photography](http://i.imgur.com/mClRw.jpg) for this theme is from 
the back cover of the [NES Action Set](http://nintendo.wikia.com/wiki/NES_Action_Set).

Installation
------------

The simplest installation method is through git, from within your attract
mode layout folder::

    git clone https://github.com/shidarin/robospin_ngpc.git

This will create a `robospin_nes` folder inside your layout folder, and 
you can now select `robospin_nes` as a theme for a display.

You can also unzip archives from the [release page](https://github.com/shidarin/robospin_nes/releases) 
into a `robospin_nes` folder in your layout folder, and it will do the same 
thing without git.

Usage
-----

`robospin_nes` uses a new art type, `cart` to display cartridges. If you wish 
to display carts, you must create a new art entry from the emulator settings 
window. Box art is not used. 

Options
-------

`robospin_nes` exposes the following options:

* SpinWheel Artwork: The artwork to spin
* Enable Wheel Mask: Darkens the area behind the SpinWheel
* Enable crt shader effect: Add scanlines and CRT screen bulge using a shader.
* Transition Time: Time in milliseconds for wheel spin.

Changelog
---------

*New in version 1.0:*

Initial release.

License
-------

	The MIT License (MIT)

	| robospin_nes
	| Copyright (c) 2017 omegaman, verion, raygun, Sean Wallitsch
	| https://github.com/shidarin/robospin_nes

	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in all
	copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
	SOFTWARE.
