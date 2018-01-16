# Sonic Forces Mod Installer

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


- *How do I make my mods compatible with Forces Mod Installer?*

If they were already compatible with HedgeModManager, then your mods are already fully compatible with the installer!

If you're making a mod from scratch, then it's simple. Set up your mod like this:
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
```
The Main part isn't used, but that makes your mod compatible with other mod loaders (HedgeModManager).

You can create a separate file called "sfmi.ini" alongside "mod.ini" with the following parameters:
```
"CPK=": Specify a custom CPK to install to by inserting the CPK name in "cpk=".

"CustomInstall=": Can be True of False, depending if you specify a custom installation bat or not.

"CustomInstallBAT=": Location of the custom installation bat inside the mod's directory. Be careful while doing this, because you need to type the whole instalation process on your bat!
```

-  *I'm having problems. How do I troubleshoot?*

It's easy. You can type "!status" or "!debug" on the main menu to access the debug screen. There you'll find a bunch of information
that may be usefull for troubleshooting. If the script doesn't boot for any reason, just change "IsDebugStart" to True in the sfmi.config file.
These are the meaning of all the error codes:
```
ERROR//CODE=01
You're running the installed from an incompatible folder. Try and install it in either
the "exec" folder, or in the SonicForces folder.

ERROR//CODE=02
You don't have both PackCPK.exe nor CpkMaker.dll. Please put those files in the same
folder as the bat installer and try again.

ERROR//CODE=03
You don't have CpkMaker.dll. Please put that file in the same folder as the bat installer and
try again.

ERROR//CODE=04
You don't have PackCPK.exe. Please put that file in the same folder as the bat installer and
try again.

OK//CODE=05
You have HedgeModManager installed. The mod installer can work, but some mods may work incorrectly
this way.

OK//CODE=00
Everything is working as it should!
```

If you need any help troubleshooting, send me a Twitter message (@PTKickass) including a screenshot of the status screen!

## Credits
- PackCPK.exe by Skyth
