## Sonic Forces Mod Installer

Sonic Forces Mod Installer simplifies the process of installing Sonic Forces mods by doing the extraction and repacking
of wars_patch.cpk (or other cpk's if specified by the mod) for you!

It comes with a simple command line GUI-like interface that the end user can understand easily. It also automaticaly backups your original cpk file aswell, so no worries about corrupting your game files!

NOTE: Use this only as a second option, since HedgeModManager is always your best bet for loading mods into the game.
In any case, if HedgeModManager isn't working, you can use this mod installer


## FAQ
- *How do I use this?*

Watch this for a video tutorial: https://www.youtube.com/watch?v=VsGYZ-UmM6Q

In any case, put your mods in the mod folder (SonicForces/mods), and they'll be ready for instalation.
If you want, you can also drag and drop the mod's folder into the program (or start the bat with a folder specified) to
install a mod automatically!


- *How do I make my mod compatible with Forces Mod Installer?*

It's simple. Set up your mod like this:
```
modfolder\disk\%thecpk%\%modfilesgohere%
modfolder\mod.ini
```
Your mod.ini should be setup like this:

```
[Main]
IncludeDir0="."
IncludeDirCount=1

[Desc]
Title="Mod's Name"
Version="Your version"
Date="Date here"
Author="Your name goes here"

[Sonic_FMI]
cpk=wars_patch
custominstall=false
custominstallbat=
```
The Main part isn't used, but that makes your mod compatible with other mod loaders in the future.

From Sonic_FMI onward, you **ABSOLUTELY NEED** to add everything, otherwise the installer will crash.
You can specify custom CPK installation by inserting the CPK name in "cpk=". Most of the times you'll want
to use wars_patch, so do that.

You can also specify custom instalation bats after that. Be careful while doing this, because you need to
type the whole instalation process on your bat!

## Credits
- PackCPK.exe by Skyth
