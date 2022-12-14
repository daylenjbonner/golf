# Golf
A simple game with surprising depth that mixes inspiration from mini-golf and "The World's Hardest Game".

![Course Selection](https://github.com/daylenjbonner/golf/blob/main/Assets/CourseSelect.png?raw=true)

## How to play
1. Download zip file. (or clone respository to easily pull upadates)
2. Unzip to convenient location on local disk.
3. Download Godot for your platform (around 30 MB).
4. Open the project.godot file with Godot.
5. Play using the button in the top-right or by pressing F5.

## Objective
Get the ball in the hole with as few strokes you can.

## Controls

### Mouse
Use mouse to aim. Hold left click to increase stroke power reflected by the progress bar in the bottom-left corner. Release to swing (metaphorically). If you would like to cancel your shot before release then move the mouse close to the ball, or hold the right mouse button while letting go of the left mouse button before the right (may take some practice). 

### Numbers
The numbers 1 through 6 switch to a particular ball type.
1. Normal
2. Bouncy: Impulse applied upon collision.
3. Jumpy: Attempts to teleport forward upon collision (not on edges).
4. Randy: Moves in Brownian motion (randomly).
5. Skippy: Moves on water without sinking.
6. Sticky: Stops quickly upon collision.

## Ball switching
Every hole in golf can be completed without switches, though switches are required on many maps to achieve the full three star score (by going under par).

### Skippy before entering water
If you are about to dive into the blue press 5 to survive.

### Bouncy, jumpy, and randy as energy sources
Bouncy will automatically switch to normal after two bounces, and jumpy will automatically switch to normal after two jumps. Randy has a chance to automatically switch to normal based upon a weighted coin toss in each frame. Bounces and jumps reset after each stroke. It is possible to use bouncy, jumpy, and randy during the same stroke to cover more ground.

### Sticky precision
While sticky is technically an energy sink, it is also quite helpful for getting around narrow corners and concave obstacles (hint: try sticking to a cave with the hole just around the spokes).
