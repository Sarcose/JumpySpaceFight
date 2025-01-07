# Jumpy Space Fight (Redux)
Jumpy Space Fight (Redux) is a platforming arcade game with a planned soundtrack by [Sarah Wallin HUff](https://www.youtube.com/@sjwallin) (never implemented, but the soundtrack was created nonetheless). Originally designed in Bump, now being remade in Slick!

At this time, no gameplay or screenshots, or even a playable build, of the original Jumpy Space Fight exist. The code was all over the place, version control was awful, and I would have to figure out which version of Love to download, or update the original codebase, to make it work. The closest I have of the original gameplay is this gif I recorded where I was using the Jumpy Space Fight character and the one enemy, Boxguy, to prototype a *different game* I had started:

<img src="https://github.com/user-attachments/assets/2cf8d278-0c75-4ea8-a651-0dbe80610e3c" width="500">


The goal of this project is to completely recode it from scratch and from memory (the game was simple, that shouldn't be a problem), using erinmaus' new collision library, [Slick](https://github.com/erinmaus/slick)

## ToDo List:
  * [ ] Implement basic gameloop, state engine, baton controller
  * [ ] Game States -> Placeholder Menu | Game | Silo test states
  * [ ] Prototype entity class which can accept and manipulate multiple bodyparts
    * [ ] Get these moving around and drawn with basic rects for now
    * [ ] Player entity
  * [ ] Include and test Slick
  * [ ] Prototype different basic shapes
  * [ ] Attach polygons to entities, use love.draw.line to render shapes accurately
  * [ ] Start *designing gameplay*

## Plans
  * Unified neon lineart visual style
  * Arcade style gameplay
  * Multiple weapons, items, pickups
  * Map generation
  * Implement and build around the soundtrack that I literally paid for and never used, lol
