
Intro:
Terminal AR City Builder Game

This game is built entirely for the terminal. All of the graphics are rendered in ASCII and the screen is dynamically sized and scaled to your screen size.

The player is geo-located via their GPS, or their WiFi. The GPS is far more accurate than WiFi geolocating, but Wifi is more than close enough for the scale of the game, and more importantly, allows a player to play on a PC or GPS-enabled phone.

The user interacts with the game's RestAPI to create a 'home base', and other locations to begin gathering resources. Other types of locations are made. Forest outposts can be made near wooded areas. Mines can be made near mountains. Ports can be made near an ocean, etc.. This functionality is driven in part with the help of OpenStreetMaps API, to gather data on the user's local terrain data.

The user meets the characters of the game, "prismkin", who's main functionality comes with the ability to travel across roads created by users to / between locations. The can be assigned a task, like building a road, building a building on the 'home base'. 

Other specialized tasks can only be done at certain locations-types. At a forest outpost, a prismkin can do 'woodcutting'. The amount of yield, and what the yield is, varies based on the stats of the prismkin.

When a prismkin returns to the 'homebase', to deliver resources, such as wood, iron, stone, the prismkin may deliver small bits of lore. Revealing the locations of important places near the user, that the user could not previously see. What the prismkin brings back is based on a check. Such as, a prismkin with a high intelligence statistic, who was geographically near a celestial event, such as within the bounds of an eclipse, may deliver information about the location of a dungeon, and lore about the dungeon.

When resources are delivered to the homebase, they are added to the user's pool of resources they can use to perform actions. The user can build items, if a prismkin has delivered a 'blueprint'. A blueprint gives details on a large investment of certain resources, and time to research the item. Once researched, the object can be built. Such as boats for faster / safer travel on the ocean. 

Many locations exist in Prism, that any user can see & access, but the user must be near the physical location to access it. Locations such as high mountain peaks, historical monuments, places of spiritual importance, deep forests, large lakes, and many more, have special mechanics, and resources that can only be farmed by prismkins. Special blueprints that can only hope to be discovered if the user connects to them.

The world is a mystery. The lore is deeply hidden. It cannot be understated how many bits of lore, secret blueprints, dungeons, and much more exist hidden in Prism. No one user will ever unlock a fraction of what this world is and how it works. The goal is to give people a reason to travel the world, a reason to see, and connect to real people, in real places. Giving people fun rewards, and community events that require the efforts of many players to defeat public events.

How to Play:

1 download the public repo: https://github.com/JeffMuter/prism 

2 install any terminal application you use.

3 install Golang: https://go.dev/doc/install

4 navigate in your terminal to the prism directory(folder)

5 run the command: go run main.go

