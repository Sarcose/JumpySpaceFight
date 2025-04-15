To imagine how savedata needs to be handled, and how it *can* be handled agnostic of mode, we must first examine how each mode might store saved data:

jsf - also considered the "story mode". See below under "JSF"
classic - Definitely beaten levels. Probably high scores, gameplay style tracking, and player stats.
bossrush - Player state, bosses beaten. A linear mode
randomizer - The random seed, the generated maps... jsf (above) but with randomizer elements
splash  - no save data, so it simply has a static set of stuff it loads
title   - meta save data - loads settings into the global space



...so really we have two divisions: Meta and Internal, and within internal we have Global and Local.


......okay so I think this is what happens. Each mode looks in specific places for this information.