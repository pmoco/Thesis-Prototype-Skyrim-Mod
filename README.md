# Role-based Audio Feedback Modulation for Digital Games — Skyrim Prototype

This repository contains the experimental Skyrim mod prototype developed for the Master's thesis **Role-based Audio Feedback Modulation for Digital Games**.



---



## Important: Skyrim Instalation & Version

**A working, official installation of Skyrim Special Edition is required. This prototype was built and tested for the Steam version of Skyrim Special Edition runtime `1.6.1170`.**

The prototype is intended to be installed on top of a legitimate, fully functional copy of the game and does not include the base game files.

The repository includes the SKSE files required by the prototype, corresponding to **SKSE 2.2.6 for Skyrim runtime 1.6.1170**. You therefore do **not** need to install SKSE separately.

Do not assume that the prototype will work correctly with another Skyrim runtime.

Before installing:

1. Locate `SkyrimSE.exe`.
2. Right-click it and open **Properties → Details**.
3. Confirm that the game version is **1.6.1170**.

The bundled SKSE build is intended for the Steam runtime. The GOG release uses a different Skyrim runtime and SKSE build.

---

## Repository Structure

The repository is intended to be copied directly over a clean Skyrim installation.

```text
/
├── Data/       # Prototype files and required mod data
├── Maps/       # Detailed annotated maps of the tutorial and experimental zones
├── ...         # Skyrim/SKSE files required at game-root level
└── README.md
```

The `Maps/` directory is not required to run the prototype. It contains detailed edited maps documenting the structure and purpose of the different experimental zones.

---

## Requirements

- A clean installation of **The Elder Scrolls V: Skyrim Special Edition**
- **Steam runtime 1.6.1170**
- Windows
- Headphones are strongly recommended when experiencing the prototype, as the experimental manipulation is primarily auditory.

SKSE does not need to be installed separately because the required files are already included in the repository.

---

# Installation

## 1. Run Skyrim Once

If Skyrim has just been installed, launch it normally once and wait until the main menu appears.

Then exit the game.

This creates the configuration directory and the initial `.ini` files.

The configuration directory is normally:

```text
Documents\My Games\Skyrim Special Edition\
```

---

## 2. Copy the Repository into Skyrim

Locate the Skyrim installation directory. This is the folder containing:

```text
SkyrimSE.exe
SkyrimSELauncher.exe
```

Copy **all contents of this repository** into that directory.

Allow Windows to:

- merge folders;
- replace files where requested.

After copying, the repository's `Data/` folder should have been merged with Skyrim's existing `Data/` folder.

### Optional Backup

Before copying the prototype, you may back up the clean Skyrim installation or at minimum the original `Data/` folder.

Using a clean installation is strongly recommended.

---

# Configuration

## 3. Configure `Skyrim.ini`

Go to:

```text
Documents\My Games\Skyrim Special Edition\
```

Open `Skyrim.ini`.

### Important INI Warning

Before adding the configuration below, search the Skyrim configuration files for existing versions of the following sections:

```ini
[Papyrus]
[Gameplay]
[VATS]
[Interface]
```

Check:

```text
Skyrim.ini
SkyrimPrefs.ini
SkyrimCustom.ini
```

**Do not create duplicate copies of the same section header inside an INI file.**

If one of these sections already exists, add or configure the required settings to the existing section instead of creating a second `[Papyrus]`, `[Gameplay]`, `[VATS]`, or `[Interface]` block.

This is important because duplicate sections can cause Skyrim to read the earlier section and ignore settings placed in a later duplicate.

Add or merge the following settings into `Skyrim.ini`:

```ini
[Papyrus]
bEnableLogging=1
bEnableTrace=1
bLoadDebugInformation=1
fPostLoadUpdateTimeMS=500.0

[Gameplay]
bDisableAutoAim=1
bHealthBarShowing=1

[VATS]
bVATSDisable=1
fKillMoveChance=0.0
fKillMoveRandom=0.0
bDisableAutoAim=1

[Interface]
bShowCompass=0
bShowInventory3D=0
bShowHUDMessages=0
```

---

# Verify the Installed Mods

## 4. Launch Through SKSE

From the Skyrim installation directory, run:

```text
skse64_loader.exe
```

**Always launch the prototype through `skse64_loader.exe`.**

Do not use `SkyrimSE.exe` or `SkyrimSELauncher.exe` when running the experiment.

---

## 5. Check the Load Order

From the Skyrim main menu:

1. Open **Creations**.
2. Press **T** to open the load order.
3. Confirm that the prototype plugins are present and enabled.

Plugin names may differ slightly from the names below depending on how Skyrim displays them.

Expected entries include:

```text
Destructible Skyrim

RLO - Effects
RLO - Exteriors
RLO - Interiors
RLO - Illuminated Spells

Immersive Sounds
Improved Combat Sounds

Feanor4 - TheMonarch

NW_STEEL_PLATE_ARMOR
DIS_Realistic Armor
NW_STEEL PLATE ARMORS
NW_STEEL PLATE REPLACER

Realistic AI Detection - Medium
No Heavy Breathing
EVE - KillMove Fixes - KillMoves

Thesis Prototype
```

Make sure that all required entries are active.

> The list above contains plugin entries rather than necessarily one entry per external mod package. Some mods provide multiple plugins.

---

# Load Order

Use the following order:

```text
1. Destructible Skyrim

2. Realistic Lighting Overhaul
   - RLO - Effects
   - RLO - Exteriors
   - RLO - Interiors
   - RLO - Illuminated Spells

3. Immersive Sounds

4. Improved Combat Sounds

5. Armour / Weapon Mods
   - Feanor4 - TheMonarch
   - NW_STEEL_PLATE_ARMOR
   - DIS_Realistic Armor
   - NW_STEEL PLATE ARMORS
   - NW_STEEL PLATE REPLACER

6. Realistic AI Detection

7. No Heavy Breathing

8. EVE - KillMove Fixes - KillMoves

9. Thesis Prototype
```

Inside Skyrim's load-order interface:

```text
X          Select / deselect a plugin for relocation
Up / Down  Move the selected plugin
```

The **Thesis Prototype** plugin should remain after the supporting mods so that prototype-specific changes take precedence where required.

---

# Running the Prototype

## 6. Start the Experiment

Launch the game using:

```text
skse64_loader.exe
```

At the main menu, open the developer console.

The console key depends on the keyboard layout and may be:

```text
`
~
\
```

Enter:

```text
coc riverwood
```

A new game state will load using the prototype's base character.

After a short delay, a message box will appear allowing **Version A** or **Version B** to be selected, corresponding to _**A- Warrior**_ and _**B- Rogue**_. 

For the original experimental procedure, the researcher determines which version the participant should use.

After the version is selected, wait briefly while the corresponding experimental level loads.

The prototype can then be played normally.

---

# Resetting the Experiment

To restart the prototype from the beginning, you have to quit the game completely and restart the process, this is to ensure all initialization occurs in a sanitized environment!

_Skyrim_ when trying to reload a save or a new state doesnt garantee that all processes will run again. 

---

# Exiting the Game

You can exit normally through:

```text
ESC → System → Quit to Desktop
```

Alternatively, open the console and enter:

```text
qqq
```

This immediately closes Skyrim.

---

# Maps and Experimental Zones

The `Maps/` directory contains annotated maps documenting the prototype's level structure.

These maps identify the different experimental areas and provide additional information about the purpose, available interactions, and relevant gameplay or auditory systems associated with each zone.

They are intended primarily for documentation and replication of the experimental setup and are not required to run the prototype.

---

# Third-Party Mods and Credits

The prototype was developed using several community-created Skyrim mods and assets. Full credit belongs to their respective authors.

The links below point to the original project pages and should be consulted for author credits, documentation, permissions, and the original releases.

| Mod / Tool | Original Project |
|---|---|
| Skyrim Script Extender (SKSE) | https://skse.silverlock.org/ |
| Destructible Skyrim - Breakable Objects SE (Beta) | https://www.nexusmods.com/skyrimspecialedition/mods/28291 |
| Realistic Lighting Overhaul SSE | https://www.nexusmods.com/skyrimspecialedition/mods/844 |
| Immersive Sounds - Compendium | https://www.nexusmods.com/skyrimspecialedition/mods/523 |
| Improved Combat Sounds SE | https://www.nexusmods.com/skyrimspecialedition/mods/28415 |
| The Monarch - Custom Sword | https://www.nexusmods.com/skyrimspecialedition/mods/163868 |
| Realistic Armor | https://www.nexusmods.com/skyrimspecialedition/mods/36151 |
| Steel Plate Armors | https://www.nexusmods.com/skyrimspecialedition/mods/154073 |
| NordwarUA Steel Plate Armors - Replacers | https://www.nexusmods.com/skyrimspecialedition/mods/154456 |
| Realistic AI Detection (RAID) | https://www.nexusmods.com/skyrimspecialedition/mods/2345 |
| No Heavy Breathing Sound | https://www.nexusmods.com/skyrimspecialedition/mods/24205 |
| Killmove Fixes | https://www.nexusmods.com/skyrimspecialedition/mods/140398 |

The **Thesis Prototype** itself contains the custom implementation developed for this research project.

---

# Research Context

This prototype was developed as part of the Master's thesis:

**Role-based Audio Feedback Modulation for Digital Games**

The study investigates whether a playable character's identity, characteristics, and perceived capabilities can be communicated through character-based auditory feedback while keeping the underlying visual representation and gameplay systems constant.

Two audio profiles based on the **Warrior** and **Rogue** archetypes were implemented within the same gameplay environment.

---

# Troubleshooting

### The game does not launch through SKSE

Confirm that:

- Skyrim is runtime **1.6.1170**;
- `skse64_loader.exe` is located in the same directory as `SkyrimSE.exe`;
- the repository was copied into the **game root**, not only into `Data/`.

### The prototype does not start after `coc riverwood`

Confirm that:

- **Thesis Prototype** is active in the Creations load order;
- all required supporting plugins are enabled;
- the load order follows the order described above;
- Skyrim was launched using `skse64_loader.exe`.

### Papyrus or interface settings do not appear to work

Check `Skyrim.ini`, `SkyrimPrefs.ini`, and `SkyrimCustom.ini` for duplicate or conflicting:

```ini
[Papyrus]
[Gameplay]
[VATS]
[Interface]
```

Merge settings into the existing section instead of adding duplicate section headers.

### Mods appear to be missing

Open:

```text
Main Menu → Creations → Load Order
```

and confirm that every required plugin is present and active.

---

## Notes for Reproduction

For results comparable to the original experiment:

- use the specified Skyrim runtime;
- preserve the provided mod versions and load order;
- use headphones;
- do not change gameplay statistics, equipment, or prototype configuration;
- use the provided Version A / Version B selection rather than manually modifying the character setup.
