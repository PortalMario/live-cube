# live-cube
A set of scripts which uses the kali linux live image builder to pre-install the dolphin emulator along with your own games and some pre-configured gameINIs. This project aims to provide a live usb stick.

## Requirements
- Up to date Kali Linux System (Can be done on a VM aswell)

- The image needs to be built on the same CPU architecutre as the target system from which you want to boot the image (USB stick).

## Usage
### Games
Create a directory path at `/opt/games`:
```
$ sudo mkdir -p /opt/games
```
Afterwards, you can place your games within the newly created directory. 

#### [OPTIONAL] Copy `IPL` file
If you have a suitable PAL "IPL" you should also move it to the "games" directory. (Make sure to name the file exactly)

### Start Script
**The script can take up to one hour to finish.** (Depending on the amount of games.)
```
$ sudo bash main.sh
```
Once the script finishs, it will print the file location of the newly created image. **Games are going to be located at `/opt/games` within the image aswell.**

Now you just need to write the `.iso` file onto a USB Stick. (High speed USB recommended)

You can now boot from the newly created USB stick and open dolphin either via application library (gui) or via cli: `dolphin-emu`.

# Pre-Configured Games (PAL-DE)
These games are optimized and configured for the best possible experience.
```
Disney's Donald Duck PK
Eternal Darkness - Sanity's Requiem
F-Zero GX
Mario Golf - Toadstool Tour
Mario Kart - Double Dash
Mario Party 4
Mario Party 5
Mario Party 6
Mario Smash Football
Metroid Prime
Paper Mario - The Thousand Year Door
Pikmin 2
Pikmin
Super Smash Bros. Melee
The Legend of Zelda - Collector's Edition
The Legend of Zelda - The Wind Waker
```
The games are all pre-configured with following base settings, if achievable:
```
Game Resolution:        1080p
Framerate:              60Hz/FPS 
MSAA ( Antialiasing ):  x4
VSync:                  Active
``` 

## Credits | Copyright Notice
I do not hope to violate any copyrights, licenses, trademarks or patents with my work neither do i intend in making any profit or distributing any copyrighted material. I chose the MIT-License just to make my work "open source" and accessible/usable to everyone. **This project is intended for fun and joy.**

All rights regarding the name of the videogames as well as the name of the videogame consoles belong completely to Nintendo and the corresponding developers/publishers. I do not own any content created by Nintendo and/or the corresponding developers/publishers, it belongs to them. 

Credits/Rights go to: Nintendo and/or the corresponding developers/publishers, Dolphin, Kali-Linux and/or any other party for their corresponding property.
