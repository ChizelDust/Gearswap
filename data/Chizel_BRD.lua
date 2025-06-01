-- Original: Motenten / Modified: Arislan

-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F9 ]              Cycle Offense Mode
--              [ CTRL+F9 ]         Cycle Hybrid Modes
--              [ WIN+F9 ]          Cycle Weapon Skill Modes
--              [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ CTRL+F11 ]        Cycle Casting Modes
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ WIN+C ]           Toggle Capacity Points Mode
--
--  Abilities:  [ CTRL+` ]          Cycle SongMode
--
--  Songs:      [ ALT+` ]           Chocobo Mazurka
--              [ WIN+, ]           Utsusemi: Ichi
--              [ WIN+. ]           Utsusemi: Ni
--
--  Weapons:    [ CTRL+W ]          Toggles Weapon Lock
--
--  WS:         [ CTRL+Numpad7 ]    Mordant Rime
--              [ CTRL+Numpad4 ]    Evisceration
--              [ CTRL+Numpad5 ]    Rudra's Storm
--              [ CTRL+Numpad1 ]    Aeolian Edge
--
--
--              (Global-Binds.lua contains additional non-job-related keybinds)


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
    Custom commands:
    SongMode may take one of three values: None, Placeholder, FullLength
    You can set these via the standard 'set' and 'cycle' self-commands.  EG:
    gs c cycle SongMode
    gs c set SongMode Placeholder
    The Placeholder state will equip the bonus song instrument and ensure non-duration gear is equipped.
    The FullLength state will simply equip the bonus song instrument on top of standard gear.
    Simple macro to cast a placeholder Daurdabla song:
    /console gs c set SongMode Placeholder
    /ma "Shining Fantasia" <me>
    To use a Terpander rather than Daurdabla, set the info.ExtraSongInstrument variable to
    'Terpander', and info.ExtraSongs to 1.
--]]

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
    res = require 'resources'
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.SongMode = M{['description']='Song Mode', 'None', 'Placeholder', 'Enmity'}

    state.Buff['Pianissimo'] = buffactive['pianissimo'] or false

    no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
              "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring", "Nexus Cape"}
    elemental_ws = S{"Aeolian Edge"}

    include('Mote-TreasureHunter')

    -- For th_action_check():
    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{35, 204}
    -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
    info.default_u_ja_ids = S{201, 202, 203, 205, 207}

    lockstyleset = 26
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'DT')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'DT', 'MEva', 'Tank')

    state.LullabyMode = M{['description']='Lullaby Instrument', 'Harp', 'Horn'}

    state.Carol = M{['description']='Carol',
        'Fire Carol', 'Fire Carol II', 'Ice Carol', 'Ice Carol II', 'Wind Carol', 'Wind Carol II',
        'Earth Carol', 'Earth Carol II', 'Lightning Carol', 'Lightning Carol II', 'Water Carol', 'Water Carol II',
        'Light Carol', 'Light Carol II', 'Dark Carol', 'Dark Carol II',
        }

    state.Threnody = M{['description']='Threnody',
        'Fire Threnody II', 'Ice Threnody II', 'Wind Threnody II', 'Earth Threnody II',
        'Ltng. Threnody II', 'Water Threnody II', 'Light Threnody II', 'Dark Threnody II',
        }

    state.Etude = M{['description']='Etude', 'Sinewy Etude', 'Herculean Etude', 'Learned Etude', 'Sage Etude',
        'Quick Etude', 'Swift Etude', 'Vivacious Etude', 'Vital Etude', 'Dextrous Etude', 'Uncanny Etude',
        'Spirited Etude', 'Logical Etude', 'Enchanting Etude', 'Bewitching Etude'}

    state.WeaponSet = M{['description']='Weapon Set','NaeglingDPS','Aeneas','DW_Malevolence','Tauret','Refresh','NaeglingTP'}
    state.WeaponLock = M(false, 'Weapon Lock')
    state.CP = M(false, "Capacity Points Mode")

    -- Additional local binds
	include('Chizel_Global_Binds.lua')
    -- include('Global-GEO-Binds.lua') -- OK to remove this line

    -- Adjust this if using the Terpander (new +song instrument)
    info.ExtraSongInstrument = 'Daurdabla'
    -- How many extra songs we can keep from Daurdabla/Terpander
    info.ExtraSongs = 2
	
    send_command('bind @t gs c cycle treasuremode')
	
	if player.sub_job == 'SCH' then
        send_command('bind ^= gs c scholar light')
        send_command('bind != gs c scholar dark')
        send_command('bind ^, gs c scholar speed')
        send_command('bind ^. gs c scholar aoe')
        send_command('bind ^/ gs c scholar cost')
	elseif player.sub_job == 'COR' then
		send_command('bind ^numpad/ input /ja "Corsair\'s Roll" <me>')
		send_command('bind ^numpad- input /ja "Chaos Roll" <me>')
		send_command('bind !numpad/ input /ja "Samurai Roll" <me>')
		send_command('bind !numpad- input /ja "Hunter\'s Roll" <me>') 
		send_command('bind ^numpad* input /ja "Double Up" <me>')
	elseif player.sub_job == 'WHM' then
		send_command('bind ^numpad/ input /ma "Cure IV" <stal>')
		send_command('bind ^numpad* input /ma "Curaga III" <stal>')
		send_command('bind ^numpad- input /ma "Erase" <stpt>')
		send_command('bind ^numpad+ input /ma "Silence" <stnpc>')
		send_command('bind !numpad/ input /ma "Paralyna" <stal>')
		send_command('bind !numpad* input /ma "Stona" <stal>')
		send_command('bind !numpad- input /ma "Silena" <stal>')
	elseif player.sub_job == 'PLD' then
		send_command('bind ^numpad/ input /ja "Sentinel" <me>')
		send_command('bind ^numpad* input /ma "Shield Bash" <stnpc>')
		send_command('bind ^numpad- input /ma "Banishga" <stnpc>')
		send_command('bind ^numpad+ input /ma "Flash" <stnpc>')
	end

    send_command('bind ^` gs c cycle SongMode')
    send_command('bind !` input /ma "Chocobo Mazurka" <me>')
    send_command('bind !p input /ja "Pianissimo" <me>')
	
	send_command('bind ^- input /ja "Marcato" <me>')
	send_command('bind !- input /ja "Clarion Call" <me>')
	send_command('bind @- input /ja "Soul Voice" <me>')
	send_command('bind @[ input /jobemote BRD <p1>')
	send_command('bind @] input /jobemote RUN <p1>')
	send_command('bind ^[ input /ja "Nightingale" <me>')
	send_command('bind ^] input /ja "Troubadour" <me>')

    send_command('bind ^insert gs c cycleback Etude')
    send_command('bind ^delete gs c cycle Etude')
    send_command('bind ^home gs c cycleback Carol')
    send_command('bind ^end gs c cycle Carol')
    send_command('bind ^pageup gs c cycleback Threnody')
    send_command('bind ^pagedown gs c cycle Threnody')

    send_command('bind @` gs c cycle LullabyMode')
    send_command('bind @w gs c toggle WeaponLock')
    send_command('bind @c gs c toggle CP')
    send_command('bind @e gs c cycleback WeaponSet')
    send_command('bind @r gs c cycle WeaponSet')

    send_command('bind ^numpad4 input /ws "Aeolian Edge" <t>')
    send_command('bind ^numpad3 input /ws "Mordant Rime" <t>')
    send_command('bind ^numpad2 input /ws "Evisceration" <t>')
    send_command('bind ^numpad1 input /ws "Rudra\'s Storm" <t>')
    send_command('bind ^numpad0 input /ws "Savage Blade" <t>')

	send_command('bind @m input /mount "Ixion"')	

    select_default_macro_book()
    set_lockstyle()

    state.Auto_Kite = M(false, 'Auto_Kite')
    Haste = 0
    DW_needed = 0
    DW = false
    moving = false
    update_combat_form()
    determine_haste_group()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
	send_command('unbind @t')
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind ^backspace')
    send_command('unbind !insert')
    send_command('unbind !delete')
    send_command('unbind ^insert')
    send_command('unbind ^delete')
    send_command('unbind ^home')
    send_command('unbind ^end')
    send_command('unbind ^pageup')
    send_command('unbind ^pagedown')
    send_command('unbind @`')
    send_command('unbind @w')
    send_command('unbind @c')
    send_command('unbind @e')
    send_command('unbind @r')
    send_command('unbind ^numpad3')
    send_command('unbind ^numpad2')
    send_command('unbind ^numpad1')
    send_command('unbind ^numpad0')
	send_command('unbind ^=')
    send_command('unbind !=')
    send_command('unbind ^,')
    send_command('unbind ^.')
    send_command('unbind ^/')
	send_command('unbind ^[')
	send_command('unbind ^]')
	send_command('unbind @[')
	send_command('unbind @]')
	
end


-- Define sets and vars used by this job file.
function init_gear_sets()

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Fast cast sets for spells
    sets.precast.FC = {
		range=gear.Linos_FC,										--6
        head="Bunzi's Hat", 										--10
        body="Inyanga Jubbah +2", 									--14
        hands=gear.Gende_SongCast_hands, 							--7, Song Cast -4%
        legs="Volte Brais", 										--8
        feet=gear.Chironic_FC_feet,									--5						--"Volte Gaiters", --6
        neck="Baetyl Pendant", 										--4
        ear1="Loquac. Earring", 									--2
        ear2="Fili Earring +1",																--"Etiolation Earring", --1
        ring1="Medada's Ring", 										--10
        ring2="Kishar Ring", 										--4
        back=gear.BRD_Song_Cape, 									--10
        waist="Carrier's Sash",
        } --Fast Cast +80%

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
        feet="Kaykaus Boots +1", 									--7
        ear2="Mendi. Earring", 										--5
		ring2="Moonlight Ring",
		back="Solemnity Cape",
        }) -- Cure Cast -12%, Fast Cast +68% (80%)

    sets.precast.FC.BardSong = set_combine(sets.precast.FC, {
        head="Fili Calot +2", 										--SC -15%, DT -10
        body="Brioso Justau. +2", 									--SC -8%
		legs="Nyame Flanchard",										--DT -8
        feet=gear.Telchine_SongCast_feet, 							--SC -13%
        neck="Loricate Torque +1",									--DT -6
        ear1="Odnowa Earring +1",									--DT -3
		ear2="Fili Earring +1",										--DT -5
        ring1="Defending Ring",										--DT -10
		ring2="Moonlight Ring",										--DT -5
        }) -- Song Cast -40%, Fast Cast +41% (80%), PDT -4, DT -50
		
	sets.precast.FC['Honor March'] = set_combine(sets.precast.FC.BardSong, {
		range="Marsyas",
		})

    sets.precast.FC.SongPlaceholder = set_combine(sets.precast.FC.BardSong, {range=info.ExtraSongInstrument})
    sets.precast.FC.SongEnmity = sets.precast.FC.BardSong

    sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak", sub="Ammurapi Shield", waist="Shinjutsu-no-Obi +1"})

    -- Precast sets to enhance JAs

    sets.precast.JA.Nightingale = {feet="Bihu Slippers +2"}
    sets.precast.JA.Troubadour = {body="Bihu Jstcorps. +3"}
    sets.precast.JA['Soul Voice'] = {legs="Bihu Cannions +2"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}


    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        range=gear.Linos_SavageBlade,
        head="Nyame Helm",
        body="Nyame Mail",
        hands="Nyame Gauntlets",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets",
        neck="Fotia Gorget",
        ear1="Ishvara Earring",
        ear2="Moonshade Earring",
        ring1="Epaminondas's Ring",
        ring2="Ilabrat Ring",
        back=gear.BRD_Savage_Cape,
        waist="Fotia Belt",
        }

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
        range=gear.Linos_Evisceration,
        head="Blistering Sallet +1",
        body="Ayanmo Corazza +2",
        hands="Bunzi's Gloves",														--"Bihu Cuffs +1",
        legs="Jokushu Haidate",														--"Zoar Subligar +1",
        feet="Aya. Gambieras +2",													--"Lustra. Leggings +1",
        ear1="Mache Earring +1",
		ear2="Mache Earring +1",
        ring1="Begrudging Ring",
        back=gear.BRD_Rudras_Cape,													--gear.BRD_WS2_Cape,
        })

    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {
        range=gear.Linos_TP,
		head="Volte Tiara",
        body="Ayanmo Corazza +2",													--"Bihu Roundlet +1",
        hands="Bunzi's Gloves",														--"Bihu Cuffs +1",
		legs="Nyame Flanchard",
		feet="Aya. Gambieras +2",
		ear1="Crepuscular Earring",
        ear2="Brutal Earring",
        ring1="Chirich Ring +1",													--"Shukuyu Ring",
        back="Vespid Mantle",
        })

    sets.precast.WS['Mordant Rime'] = set_combine(sets.precast.WS, {
        neck="Bard's Charm +1",
        ear2="Regal Earring",
        ring2="Metamor. Ring +1",
        waist="Grunfeld Rope",
        })

    sets.precast.WS['Rudra\'s Storm'] = set_combine(sets.precast.WS, {
		range=gear.Linos_RudrasStorm,
        neck="Bard's Charm +1",
        waist="Grunfeld Rope",
        back=gear.BRD_Rudras_Cape,
        })

    sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {
        neck="Baetyl Pendant",
        ring1="Medada's Ring",
		ring2="Mephitas's Ring +1",
        ear1="Friomisi Earring",
        back="Toro Cape",															--"Argocham. Mantle",
        waist="Orpheus's Sash",
        })

    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
		range=gear.Linos_SavageBlade,
        neck="Rep. Plat. Medal",
		ring2="Shukuyu Ring",
        waist="Sailfi Belt +1",
        back=gear.BRD_Savage_Cape,
        })
		
	sets.precast.WS['Shellcrusher'] = set_combine(sets.precast.WS, {
		range=gear.Linos_TP,
		neck="Combatant's Torque",
		waist="Eschan Stone",
		ear1="Crep. Earring",
		ear2="Fili Earring +1",
		ring1="Chirich Ring +1",
		ring2="Chirich Ring +1",
		back=gear.BRD_Rudras_Cape,
		})


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- General set for recast times.
    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.SpellInterrupt = {
        ammo="Staunch Tathlum +1", 													--11, DT -3
        body="Ros. Jaseran +1", 													--25, DT -5
        hands="Chironic Gloves",	 												--20
		legs="Bunzi's Pants", 														--20, DT -9
        neck="Loricate Torque +1", 													--5, DT -6
        ear1="Magnetic Earring", 													--8
        ear2="Fili Earring +1",														--DT -5
        ring2="Evanescence Ring", 													--5
        waist="Rumination Sash", 													--10
        } -- SIRD 1030/1024 + MERITS 100/1024 = 1130/1024 (97.7% base|107.4% cap)

    sets.midcast.Utsusemi = sets.midcast.SpellInterrupt

    -- Gear to enhance certain classes of songs.
    -- sets.midcast.Ballad = {legs="Fili Rhingrave +2"}									--Probably okay to remove
    sets.midcast.Carol = {hands="Mousai Gages"}											--All Songs +7, Carol +1
    sets.midcast.Etude = {head="Mousai Turban", feet="Fili Cothurnes +2"}				--All Songs +7, Etude +1
    sets.midcast.Prelude = {feet="Fili Cothurnes +2"}									--All Songs +7
    sets.midcast['Honor March'] = {range="Marsyas", hands="Fili Manchettes +2"}
    sets.midcast.Lullaby = {hands="Brioso Cuffs +3"} 									--All Songs +7, Lullaby +2
    sets.midcast.Madrigal = {head="Fili Calot +2", feet="Fili Cothurnes +2"}			--All Songs +7, Madrigal +1
    sets.midcast.Mambo = {feet="Mousai Crackows"}										--All Songs +7, Mambo +1
    sets.midcast.March = {hands="Fili Manchettes +2"}									--All Songs +7, March +1
    -- sets.midcast.Minne = {legs="Mou. Seraweels"}										--Swap back in when you acquire Mou. Seraweels +1
    sets.midcast.Minuet = {body="Fili Hongreline +2", legs="Inyanga Shalwar"}			--All Songs +7, Minuet +1
    sets.midcast.Paeon = {head="Brioso Roundlet +2"}									--All Songs +7, Paeon +1
    sets.midcast.Threnody = {body="Mousai Manteel"}										--All Songs +7, Threnody +1
    sets.midcast["Adventurer\'s Dirge"] = {legs="Inyanga Shalwar"}
    sets.midcast['Foe Sirvente'] = {head="Bihu Roundlet +1"}							--Song Skill +14
    sets.midcast['Magic Finale'] = {legs="Fili Rhingrave +2"}
    sets.midcast["Sentinel\'s Scherzo"] = {feet="Fili Cothurnes +2"}					--All Songs +7, Scherzo +1
    sets.midcast['Chocobo Mazurka'] = {range="Marsyas"}

    -- For song buffs (duration and AF3 set bonus)
    sets.midcast.SongEnhancing = {
        main=gear.Kali_Song,														--"Carnwenhan",
        range="Gjallarhorn",
        head="Fili Calot +2",
        body="Fili Hongreline +2",
        hands="Fili Manchettes +2",
        legs="Inyanga Shalwar +2",
        feet="Brioso Slippers +3",
        neck="Mnbw. Whistle +1",
        ear1="Odnowa Earring +1",
        ear2="Fili Earring +1",
        ring1="Defending Ring",
        ring2="Moonlight Ring",
        waist="Flume Belt +1",
        back=gear.BRD_Song_Cape,
        }

    -- For song defbuffs (duration primary, accuracy secondary)
    sets.midcast.SongEnfeeble = {
        main=gear.Kali_Skill,														--"Carnwenhan",
        sub="Ammurapi Shield",
        range="Gjallarhorn",
        head="Brioso Roundlet +2",
        body="Brioso Justau. +2",
        hands="Fili Manchettes +2",
        legs="Brioso Cannions +2",
        feet="Brioso Slippers +3",
        neck="Mnbw. Whistle +1",
        ear1="Regal Earring",
        ear2="Fili Earring +1",
		ring1="Metamor. Ring +1",
        ring2="Stikini Ring +1",
        waist="Acuity Belt +1",
        back=gear.BRD_Song_Cape,
        }

    -- For song defbuffs (accuracy primary, duration secondary)
    sets.midcast.SongEnfeebleAcc = set_combine(sets.midcast.SongEnfeeble, {
		ear1="Crepuscular Earring",
		})

    -- For Horde Lullaby maxiumum AOE range.
    sets.midcast.SongStringSkill = set_combine(sets.midcast.SongEnfeeble, {
		hands="Inyan. Dastanas +2",
		legs="Inyanga Shalwar +2",
		feet="Bihu Slippers +2",
        ear1="Gersemi Earring",
        ear2="Darkside Earring",
        ring1="Stikini Ring",
        })

    -- Placeholder song; minimize duration to make it easy to overwrite.
    sets.midcast.SongPlaceholder = set_combine(sets.midcast.SongEnhancing, {range=info.ExtraSongInstrument})
	
    sets.midcast.SongEnmity = set_combine(sets.midcast.SongEnhancing, {
		head="Halitus Helm",
		body="Emet Harness +1",
		hands="Nyame Gauntlets",
		legs="Zoar Subligar +1",
		ear1="Cryptic Earring",
		ear2="Tuisto Earring",
		ring2="Eihwaz Ring",
		waist="Kasiri Belt",
		back="Reiki Cloak",
		})

    -- Other general spells and classes.
    sets.midcast.Cure = {
        main="Daybreak", 															--CP1 +30, MND +30
        sub="Ammurapi Shield",														--MND +13
        head="Bunzi's Hat",															--MND +33, Enmity -7, DT -7
        body="Bunzi's Robe",														--CP1 +15, MND +43, Enmity -10, DT -10
        hands="Bunzi's Gloves", 													--MND +47, Enmity -8, DT -8
        legs="Bunzi's Pants", 														--MND +38, Enmity -9, DT -9
        feet="Bunzi's Sabots", 														--MND +33, Enmity -6, DT -6
        neck="Incanter's Torque",													--Healing Skill +10
        ear1="Meili Earring",														--Healing Skill +10
        ear2="Fili Earring +1",														--DT -5
        ring1="Menelaus's Ring",													--CP1 +5, Healing Skill +15
        ring2="Haoma's Ring",														--Healing Skill +8
        back="Vates Cape +1", 														--Healing Skill +6, Enmity -8
        waist="Bishop's Sash",														--Healing Skill +5
        } --CP1 +50, Healing Skill +54 (BRD/WHM = 204 + [ML - 49]), Enmity -48, DT -45, MND +237

    sets.midcast.Curaga = set_combine(sets.midcast.Cure, {
																					-- neck="Nuna Gorget +1",
        ring1="Stikini Ring +1",
        ring2="Metamor. Ring +1",
		waist="Luminary Sash",
        })

    sets.midcast.StatusRemoval = {
        head="Vanya Hood",
        body="Vanya Robe",
        legs="Aya. Cosciales +2",
        feet="Vanya Clogs",
        neck="Incanter's Torque",
        ear2="Meili Earring",
        ring1="Menelaus's Ring",
        ring2="Haoma's Ring",
        back=gear.BRD_Song_Cape,
        waist="Bishop's Sash",
        }

    sets.midcast.Cursna = set_combine(sets.midcast.StatusRemoval, {
																					-- hands="Hieros Mittens",
        neck="Debilis Medallion",
        -- ear1="Beatific Earring",
        })

    sets.midcast['Enhancing Magic'] = {
        main="Pukulatmuj +1",														--"Carnwenhan",
        sub="Ammurapi Shield",
        head=gear.Telchine_ENH_head,
        body=gear.Telchine_ENH_body,
        hands=gear.Telchine_ENH_hands,
        legs=gear.Telchine_ENH_legs,
        feet=gear.Telchine_ENH_feet,
        neck="Incanter's Torque",
        ear1="Mimir Earring",
        ear2="Andoaa Earring",
        ring1="Stikini Ring +1",
        ring2="Stikini Ring",
        back="Fi Follet Cape +1",
        waist="Embla Sash",
        }

    sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {head="Inyanga Tiara +2"})
    sets.midcast.Haste = sets.midcast['Enhancing Magic']
    sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {waist="Gishdubar Sash", back="Grapevine Cape"})
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
		hands="Stone Mufflers",
		legs="Shedir Seraweels",
        neck="Nodens Gorget",
		ear2="Earthcry Earring",
        waist="Siegel Sash",
		})
    sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {head=gear.Chironic_AV_head, waist="Emphatikos Rope"})
    sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
    sets.midcast.Protectra = sets.midcast.Protect
    sets.midcast.Shell = sets.midcast.Protect
    sets.midcast.Shellra = sets.midcast.Shell

    sets.midcast['Enfeebling Magic'] = {
        main="Tauret",																--"Carnwenhan",
        sub="Ammurapi Shield",
        head=empty;
        body="Cohort Cloak +1",
        hands="Fili Manchettes +2",													--"Kaykaus Cuffs +1",
        legs="Brioso Cannions +2",
        feet="Brioso Slippers +3",
        neck="Mnbw. Whistle +1",
        ear1="Vor Earring",
        ear2="Fili Earring +1",
		ring1="Medada's Ring",
        ring2="Metamor. Ring +1",
        waist="Acuity Belt +1",
        back="Aurist's Cape +1",
        }

    sets.midcast.Dispelga = set_combine(sets.midcast['Enfeebling Magic'], {main="Daybreak", sub="Ammurapi Shield", waist="Shinjutsu-no-Obi +1"})

    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.idle = {
        range=gear.Linos_DT,
        head="Volte Beret",												--M.Eva +104
        body="Bunzi's Robe",											--M.Eva +139, DT -10%
        hands="Fili Manchettes +2",										--M.Eva +83, DT -10%
        legs="Inyanga Shalwar +2",										--M.Eva +147, MDT -6%
        feet="Bunzi's Sabots",											--M.Eva +150, DT -6%
        neck="Sibyl Scarf",
        ear1="Eabani Earring",											--M.Eva +8
        ear2="Fili Earring +1",											--DT -5%
        ring1="Stikini Ring +1",
        ring2="Moonlight Ring",											--DT -4%
        back="Solemnity Cape",											--DT -4%
        waist="Flume Belt +1",											--PDT -4%
        } --DT -39%, PDT -4% (Genmei Shield: PDT -10%), MDT -6%

    sets.idle.DT = set_combine(sets.idle, {
        head="Fili Calot +2",											--M.Eva +120, DT -10%		--"Bihu Roundlet +1", --6/0
		legs="Fili Rhingrave +2",										--M.Eva +147, DT -12%
        neck="Warder's Charm +1",										--Absorbs Magic Damage +5%
		ear2="Arete Del Luna +1",										--Stun|Bind|Gravity Resist +20
        ring1="Fortified Ring", 										--Enemy Crit -7%
		ring2="Warden's Ring",											--Enemy Crit -5%
		waist="Carrier's Sash",											
        }) --DT -52%, PDT -3% (Genmei Shield: PDT -10%), MDT -5% 

    sets.idle.MEva = set_combine(sets.idle, {
        head="Fili Calot +2", 											--M.Eva +120, DT -10%
		hands="Bunzi's Gloves",											--M.Eva +112, DT -8%
        legs="Bunzi's Pants", 											--M.Eva +150, DT -9%
        neck="Warder's Charm +1",										--Absorbs Magic Damage +5%
		ear2="Arete Del Luna +1",										--Stun|Bind|Gravity Resist +20, Light Resist +25
        ring1="Inyanga Ring",											--M.Eva +12
        ring2="Shadow Ring",											--Death Resistance +25%, Annuls Magic Damage +13%
        waist="Carrier's Sash",											--All Elements Resist +15
        }) --M.Eva +691, DT -47%
		
    sets.idle.Tank = set_combine(sets.idle, {
        head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
        legs="Nyame Flanchard",
		feet="Nyame Sollerets",
        neck="Unmoving Collar +1",
		ear2="Tuisto Earring",
        ring1="Defending Ring",
		back="Shadow Mantle",
        }) --Make an idle DT Linos of some kind

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT

    sets.Kiting = {feet="Fili Cothurnes +2", ring1="Defending Ring", back="Shadow Mantle"}
    sets.latent_refresh = {waist="Fucho-no-obi"}

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    sets.engaged = {
        range=gear.Linos_TP,
        head="Bunzi's Hat",
        body="Ayanmo Corazza +2",
        hands="Gazu Bracelets +1",
        legs="Volte Tights",
        feet="Nyame Sollerets",
        neck="Bard's Charm +1",
        ear1="Cessance Earring",
        ear2="Telos Earring",
        ring1="Chirich Ring +1",
        ring2="Hetairoi Ring",
        back=gear.BRD_TP_Cape,
        waist="Windbuffet Belt +1",
        }

    sets.engaged.Acc = set_combine(sets.engaged, {
        feet="Bihu Slippers +2",
        waist="Kentarch Belt +1",
        })

    -- * DNC Subjob DW Trait: +15%
    -- * NIN Subjob DW Trait: +25%

    -- No Magic Haste (74% DW to cap, 59% needed /DNC, 49% needed /NIN)
    sets.engaged.DW = {
        range=gear.Linos_TP,
        head="Bunzi's Hat",
        body="Ayanmo Corazza +2",
        hands="Gazu Bracelets +1",
        legs="Volte Tights",
        feet="Nyame Sollerets",
        neck="Bard's Charm +1",
        ear1="Suppanomimi", 													--4
        ear2="Eabani Earring", 													--5
        ring1="Chirich Ring +1",
        ring2="Hetairoi Ring",
        back=gear.BRD_TP_Cape, 													--10
        waist="Reiki Yotai", 													--7
        } -- 26% (-23%)

    sets.engaged.DW.Acc = set_combine(sets.engaged.DW, {
		feet="Bihu Slippers +2",
        })

    -- 15% Magic Haste (67% DW to cap)
    sets.engaged.DW.LowHaste = sets.engaged.DW
    sets.engaged.DW.Acc.LowHaste = sets.engaged.DW.Acc
	-- (-16%)

    -- 30% Magic Haste (56% DW to cap)
    sets.engaged.DW.MidHaste = sets.engaged.DW
    sets.engaged.DW.Acc.MidHaste = sets.engaged.DW.Acc
	-- (-5%)

    -- 35% Magic Haste (51% DW to cap)
    sets.engaged.DW.HighHaste = sets.engaged.DW
    sets.engaged.DW.Acc.HighHaste = sets.engaged.DW.Acc
	-- (0%)

    -- 45% Magic Haste (36% DW to cap, 21% needed /DNC, 11% needed /NIN)
    sets.engaged.DW.MaxHaste = {
        range=gear.Linos_TP,
        head="Bunzi's Hat",
        body="Ayanmo Corazza +2",
        hands="Gazu Bracelets +1",
        legs="Volte Tights",
        feet="Nyame Sollerets",
        neck="Bard's Charm +1",
        ear1="Telos Earring", 													
        ear2="Eabani Earring",													--4
        ring1="Chirich Ring +1",
        ring2="Hetairoi Ring",
        back=gear.BRD_TP_Cape,
        waist="Reiki Yotai", 													--7
        } -- 11% (0%), Use BRD DW Cape if /DNC

    sets.engaged.DW.MaxHaste.Acc = set_combine(sets.engaged.DW.MaxHaste, {
        head="Bunzi's Hat",
		legs="Fili Rhingrave +2",
		feet="Nyame Sollerets",
        ear2="Fili Earring +1",
		ring2="Moonlight Ring",
        back=gear.BRD_TP_Cape,
        waist="Kentarch Belt +1",
        })

    sets.engaged.DW.MaxHastePlus = set_combine(sets.engaged.DW.MaxHaste, {ear1="Cessance Earring", back=gear.BRD_DW_Cape})
    sets.engaged.DW.Acc.MaxHastePlus = set_combine(sets.engaged.DW.Acc.MaxHaste, {ear1="Cessance Earring", back=gear.BRD_DW_Cape})

    sets.engaged.Aftermath = {
																				-- head="Volte Tiara",
																				-- body="Ashera Harness",
																				-- legs="Aya. Cosciales +2",
																				-- feet="Volte Spats",
																				-- neck="Bard's Charm +1",
																				-- ring1={name="Chirich Ring +1", bag="wardrobe3"},
																				-- ring2={name="Chirich Ring +1", bag="wardrobe4"},
																				-- back=gear.BRD_STP_Cape,
        }

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.engaged.Hybrid = {
        neck="Loricate Torque +1", 												--DT -6
        ring1="Defending Ring", 												--DT -10
        ring2="Moonlight Ring", 												--DT -5
		body="Nyame Mail",														--DT -9
        }


    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.Acc.DT = set_combine(sets.engaged.Acc, sets.engaged.Hybrid)

    sets.engaged.DW.DT = set_combine(sets.engaged.DW, sets.engaged.Hybrid)
    sets.engaged.DW.Acc.DT = set_combine(sets.engaged.DW.Acc, sets.engaged.Hybrid)

    sets.engaged.DW.DT.LowHaste = set_combine(sets.engaged.DW.LowHaste, sets.engaged.Hybrid)
    sets.engaged.DW.Acc.DT.LowHaste = set_combine(sets.engaged.DW.Acc.LowHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.MidHaste = set_combine(sets.engaged.DW.MidHaste, sets.engaged.Hybrid)
    sets.engaged.DW.Acc.DT.MidHaste = set_combine(sets.engaged.DW.Acc.MidHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.HighHaste = set_combine(sets.engaged.DW.HighHaste, sets.engaged.Hybrid)
    sets.engaged.DW.Acc.DT.HighHaste = set_combine(sets.engaged.DW.Acc.HighHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.DW.Acc.DT.MaxHaste = set_combine(sets.engaged.DW.Acc.MaxHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.MaxHastePlus = set_combine(sets.engaged.DW.MaxHastePlus, sets.engaged.Hybrid)
    sets.engaged.DW.Acc.DT.MaxHastePlus = set_combine(sets.engaged.DW.Acc.MaxHastePlus, sets.engaged.Hybrid)


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- sets.SongDWDuration = {main=gear.Kali_Song, sub=gear.Kali_Skill}

    sets.buff.Doom = {
		neck="Nicander's Necklace", 					--20
		ring1="Purity Ring", 							--7
		ring2="Saida Ring", 							--15
		waist="Gishdubar Sash", 						--10
		}
	
	sets.buff.Sleep = {range="Loughnashade"}

    sets.Obi = {waist="Hachirin-no-Obi"}
    sets.CP = {back="Mecisto. Mantle"}
    -- sets.Reive = {neck="Ygnas's Resolve +1"}
	
    sets.TreasureHunter = {
		body="Volte Jupon",			-- +2
		legs="Volte Hose",			-- +1
		feet="Volte Boots",			-- +1
	} --TH +4


    -- sets.Carnwenhan = {main="Carnwenhan", sub="Gleti's Knife"}
	sets.NaeglingDPS = {main="Naegling", sub="Gleti's Knife"}
    sets.Aeneas = {main="Aeneas", sub="Gleti's Knife"}
	sets.DW_Malevolence = {main="Aeneas", sub="Malevolence"}
    sets.Tauret = {main="Tauret", sub="Gleti's Knife"}
	sets.Refresh = {main="Daybreak", sub="Gleti's Knife"}
    sets.NaeglingTP = {main="Naegling", sub="Centovente"}
    

    sets.DefaultShield = {sub="Genmei Shield"}

end



-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'BardSong' then
        --Auto-Pianissimo
        if ((spell.target.type == 'PLAYER' and not spell.target.charmed) or (spell.target.type == 'NPC' and spell.target.in_party)) and
            not state.Buff['Pianissimo'] then
            local spell_recasts = windower.ffxi.get_spell_recasts()
            if spell_recasts[spell.recast_id] < 2 then
                send_command('@input /ja "Pianissimo" <me>; wait 1.7; input /ma "'..spell.name..'" '..spell.target.name)
                eventArgs.cancel = true
                return
            end
        end
        if spell.name == 'Honor March' then
            equip({range="Marsyas"})
        end
        if string.find(spell.name,'Lullaby') then
            if buffactive.Troubadour then
                equip({range="Marsyas"})
            elseif state.LullabyMode.value == 'Harp' and spell.english:contains('Horde') then
                equip({range="Daurdabla"})
            else
                equip({range="Gjallarhorn"})
            end
        end
    end
    if spellMap == 'Utsusemi' then
        if buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)'] then
            cancel_spell()
            add_to_chat(123, '**!! '..spell.english..' Canceled: [3+ IMAGES] !!**')
            eventArgs.handled = true
            return
        elseif buffactive['Copy Image'] or buffactive['Copy Image (2)'] then
            send_command('cancel 66; cancel 444; cancel Copy Image; cancel Copy Image (2)')
        end
    end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' then
        if elemental_ws:contains(spell.name) then
            -- Matching double weather (w/o day conflict).
            if spell.element == world.weather_element and (get_weather_intensity() == 2 and spell.element ~= elements.weak_to[world.day_element]) then
                equip({waist="Hachirin-no-Obi"})
            -- Target distance under 1.7 yalms.
            elseif spell.target.distance < (1.7 + spell.target.model_size) then
                equip({waist="Orpheus's Sash"})
            -- Matching day and weather.
            elseif spell.element == world.day_element and spell.element == world.weather_element then
                equip({waist="Hachirin-no-Obi"})
            -- Target distance under 8 yalms.
            elseif spell.target.distance < (8 + spell.target.model_size) then
                equip({waist="Orpheus's Sash"})
            -- Match day or weather.
            elseif spell.element == world.day_element or spell.element == world.weather_element then
                equip({waist="Hachirin-no-Obi"})
            end
        end
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
    if spell.type == 'BardSong' then
        -- layer general gear on first, then let default handler add song-specific gear.
        local generalClass = get_song_class(spell)
        if generalClass and sets.midcast[generalClass] then
            equip(sets.midcast[generalClass])
        end
        if spell.name == 'Honor March' then
            equip({range="Marsyas"})
        end
        if string.find(spell.name,'Lullaby') then
            if buffactive.Troubadour then
                equip({range="Marsyas"})
            elseif state.LullabyMode.value == 'Harp' and spell.english:contains('Horde') then
                equip(sets.midcast.SongStringSkill)
                equip({range="Daurdabla"})
            else
                equip({range="Gjallarhorn"})
            end
        end
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.type == 'BardSong' then
        if player.status ~= 'Engaged' and state.WeaponLock.value == false and (player.sub_job == 'DNC' or player.sub_job == 'NIN') then
            equip(sets.SongDWDuration)
        end
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.english:contains('Lullaby') and not spell.interrupted then
        get_lullaby_duration(spell)
    end
    if player.status ~= 'Engaged' and state.WeaponLock.value == false then
        check_weaponset()
    end
end

function job_buff_change(buff,gain)

   if buffactive['Reive Mark'] then
       if gain then
           equip(sets.Reive)
           disable('neck')
       else
           enable('neck')
       end
   end

    if buff == "doom" then
        if gain then
            equip(sets.buff.Doom)
            send_command('@input /p Doomed.')
            disable('neck','ring1','ring2','waist')
        else
            enable('neck','ring1','ring2','waist')
            handle_equipping_gear(player.status)
        end
    end
	
	if buff == "sleep" then
		if gain then
			equip(sets.buff.Sleep)
			disable('range')
		else
			enable('range')
			handle_equipping_gear(player.status)
		end
	end

end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if state.WeaponLock.value == true then
        disable('main','sub')
    else
        enable('main','sub')
    end

    check_weaponset()
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_handle_equipping_gear(playerStatus, eventArgs)
    check_gear()
    update_combat_form()
    determine_haste_group()
    check_moving()
end

function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
end

function update_combat_form()
    if DW == true then
        state.CombatForm:set('DW')
    elseif DW == false then
        state.CombatForm:reset()
    end
end

-- Called for direct player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'etude' then
        send_command('@input /ma '..state.Etude.value..' <stpc>')
    elseif cmdParams[1]:lower() == 'carol' then
        send_command('@input /ma '..state.Carol.value..' <stpc>')
    elseif cmdParams[1]:lower() == 'threnody' then
        send_command('@input /ma '..state.Threnody.value..' <stnpc>')
    end

    gearinfo(cmdParams, eventArgs)
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if buffactive['Aftermath: Lv.3'] and player.equipment.main == "Carnwenhan" then
        meleeSet = set_combine(meleeSet, sets.engaged.Aftermath)
    end
	if state.TreasureMode.value == 'Fulltime' then
        meleeSet = set_combine(meleeSet, sets.TreasureHunter)
    end

    check_weaponset()

    return meleeSet
end

function get_custom_wsmode(spell, action, spellMap)
    local wsmode
    if state.OffenseMode.value == 'MidAcc' or state.OffenseMode.value == 'HighAcc' then
        wsmode = 'Acc'
    end

    return wsmode
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if state.CP.current == 'on' then
        equip(sets.CP)
        disable('back')
    else
        enable('back')
    end
    if player.mpp < 51 and (player.sub_job == 'WHM' or player.sub_job == 'PLD') then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    if state.Auto_Kite.value == true then
       idleSet = set_combine(idleSet, sets.Kiting)
    end

    return idleSet
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    local cf_msg = ''
    if state.CombatForm.has_value then
        cf_msg = ' (' ..state.CombatForm.value.. ')'
    end

    local m_msg = state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        m_msg = m_msg .. '/' ..state.HybridMode.value
    end

    local ws_msg = state.WeaponskillMode.value

    local c_msg = state.CastingMode.value

    local d_msg = 'None'
    if state.DefenseMode.value ~= 'None' then
        d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end

    local i_msg = state.IdleMode.value

    local msg = ''
    if state.Kiting.value then
        msg = msg .. ' Kiting: On |'
    end

    add_to_chat(002, '| ' ..string.char(31,210).. 'Melee' ..cf_msg.. ': ' ..string.char(31,001)..m_msg.. string.char(31,002)..  ' |'
        ..string.char(31,207).. ' WS: ' ..string.char(31,001)..ws_msg.. string.char(31,002)..  ' |'
        ..string.char(31,060).. ' Magic: ' ..string.char(31,001)..c_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Determine the custom class to use for the given song.
function get_song_class(spell)
    -- Can't use spell.targets:contains() because this is being pulled from resources
    if set.contains(spell.targets, 'Enemy') then
        if state.CastingMode.value == 'Resistant' then
            return 'SongEnfeebleAcc'
        else
            return 'SongEnfeeble'
        end
    elseif state.SongMode.value == 'Placeholder' then
        return 'SongPlaceholder'
	elseif state.SongMode.value == 'Enmity' then
		return 'SongEnmity'
    else
        return 'SongEnhancing'
    end
end

function get_lullaby_duration(spell)
    local self = windower.ffxi.get_player()

    local troubadour = false
    local clarioncall = false
    local soulvoice = false
    local marcato = false

    for i,v in pairs(self.buffs) do
        if v == 348 then troubadour = true end
        if v == 499 then clarioncall = true end
        if v == 52 then soulvoice = true end
        if v == 231 then marcato = true end
    end

    local mult = 1

    if player.equipment.range == "Daurdabla" then mult = mult + 0.3 end -- 0.25 with Lv.90 or less Daurdabla, 0.3 with Lv.95+ Daurdabla
    if player.equipment.range == "Gjallarhorn" then mult = mult + 0.4 end -- 0.3 with Lv.95 or less Gjallarhorn, 0.4 with Lv.99 Gjallarhorn
    if player.equipment.range == "Marsyas" then mult = mult + 0.5 end

    if player.equipment.main == "Carnwenhan" then mult = mult + 0.5 end -- 0.1 for 75, 0.4 for 95, 0.5 for 99/119
    if player.equipment.main == "Legato Dagger" then mult = mult + 0.05 end
    if player.equipment.main == "Kali" then mult = mult + 0.05 end
    if player.equipment.sub == "Kali" then mult = mult + 0.05 end
    if player.equipment.sub == "Legato Dagger" then mult = mult + 0.05 end
    if player.equipment.neck == "Aoidos' Matinee" then mult = mult + 0.1 end
    if player.equipment.neck == "Mnbw. Whistle" then mult = mult + 0.2 end
    if player.equipment.neck == "Mnbw. Whistle +1" then mult = mult + 0.3 end
    if player.equipment.body == "Fili Hongreline +1" then mult = mult + 0.12 end
	if player.equipment.body == "Fili Hongreline +2" then mult = mult + 0.13 end
	if player.equipment.body == "Fili Hongreline +3" then mult = mult + 0.14 end
    if player.equipment.legs == "Inyanga Shalwar" then mult = mult + 0.12 end
    if player.equipment.legs == "Inyanga Shalwar +1" then mult = mult + 0.15 end
    if player.equipment.legs == "Inyanga Shalwar +2" then mult = mult + 0.17 end
    if player.equipment.feet == "Brioso Slippers" then mult = mult + 0.1 end
    if player.equipment.feet == "Brioso Slippers +1" then mult = mult + 0.11 end
    if player.equipment.feet == "Brioso Slippers +2" then mult = mult + 0.13 end
    if player.equipment.feet == "Brioso Slippers +3" then mult = mult + 0.15 end
    if player.equipment.hands == "Brioso Cuffs +1" then mult = mult + 0.1 end
    if player.equipment.hands == "Brioso Cuffs +2" then mult = mult + 0.1 end
    if player.equipment.hands == "Brioso Cuffs +3" then mult = mult + 0.2 end

    --JP Duration Gift
    if self.job_points.brd.jp_spent >= 1200 then
        mult = mult + 0.05
    end

    if troubadour then
        mult = mult * 2
    end

    if spell.en == "Foe Lullaby II" or spell.en == "Horde Lullaby II" then
        base = 60
    elseif spell.en == "Foe Lullaby" or spell.en == "Horde Lullaby" then
        base = 30
    end

    totalDuration = math.floor(mult * base)

    -- Job Points Buff
    totalDuration = totalDuration + self.job_points.brd.lullaby_duration
    if troubadour then
        totalDuration = totalDuration + self.job_points.brd.lullaby_duration
        -- adding it a second time if Troubadour up
    end

    if clarioncall then
        if troubadour then
            totalDuration = totalDuration + (self.job_points.brd.clarion_call_effect * 2 * 2)
            -- Clarion Call gives 2 seconds per Job Point upgrade.  * 2 again for Troubadour
        else
            totalDuration = totalDuration + (self.job_points.brd.clarion_call_effect * 2)
            -- Clarion Call gives 2 seconds per Job Point upgrade.
        end
    end

    if marcato and not soulvoice then
        totalDuration = totalDuration + self.job_points.brd.marcato_effect
    end

    -- Create the custom timer
    if spell.english == "Foe Lullaby II" or spell.english == "Horde Lullaby II" then
        send_command('@timers c "Lullaby II ['..spell.target.name..']" ' ..totalDuration.. ' down spells/00377.png')
    elseif spell.english == "Foe Lullaby" or spell.english == "Horde Lullaby" then
        send_command('@timers c "Lullaby ['..spell.target.name..']" ' ..totalDuration.. ' down spells/00376.png')
    end
end

function determine_haste_group()
    classes.CustomMeleeGroups:clear()
    if DW == true then
        if DW_needed <= 12 then
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif DW_needed > 12 and DW_needed <= 21 then
            classes.CustomMeleeGroups:append('MaxHastePlus')
        elseif DW_needed > 21 and DW_needed <= 27 then
            classes.CustomMeleeGroups:append('HighHaste')
        elseif DW_needed > 27 and DW_needed <= 31 then
            classes.CustomMeleeGroups:append('MidHaste')
        elseif DW_needed > 31 and DW_needed <= 42 then
            classes.CustomMeleeGroups:append('LowHaste')
        elseif DW_needed > 42 then
            classes.CustomMeleeGroups:append('')
        end
    end
end

function gearinfo(cmdParams, eventArgs)
    if cmdParams[1] == 'gearinfo' then
        if type(tonumber(cmdParams[2])) == 'number' then
            if tonumber(cmdParams[2]) ~= DW_needed then
            DW_needed = tonumber(cmdParams[2])
            DW = true
            end
        elseif type(cmdParams[2]) == 'string' then
            if cmdParams[2] == 'false' then
                DW_needed = 0
                DW = false
            end
        end
        if type(tonumber(cmdParams[3])) == 'number' then
            if tonumber(cmdParams[3]) ~= Haste then
                Haste = tonumber(cmdParams[3])
            end
        end
        if type(cmdParams[4]) == 'string' then
            if cmdParams[4] == 'true' then
                moving = true
            elseif cmdParams[4] == 'false' then
                moving = false
            end
        end
        if not midaction() then
            job_update()
        end
    end
end

function check_moving()
    if state.DefenseMode.value == 'None'  and state.Kiting.value == false then
        if state.Auto_Kite.value == false and moving then
            state.Auto_Kite:set(true)
        elseif state.Auto_Kite.value == true and moving == false then
            state.Auto_Kite:set(false)
        end
    end
end

function check_gear()
    if no_swap_gear:contains(player.equipment.left_ring) then
        disable("ring1")
    else
        enable("ring1")
    end
    if no_swap_gear:contains(player.equipment.right_ring) then
        disable("ring2")
    else
        enable("ring2")
    end
	if no_swap_gear:contains(player.equipment.back) then
        disable("back")
    else
        enable("back")
    end
end

function check_weaponset()
    equip(sets[state.WeaponSet.current])
    if player.sub_job ~= 'NIN' and player.sub_job ~= 'DNC' then
       equip(sets.DefaultShield)
    end
end

windower.register_event('zone change',
    function()
        if no_swap_gear:contains(player.equipment.left_ring) then
            enable("ring1")
            equip(sets.idle)
        end
        if no_swap_gear:contains(player.equipment.right_ring) then
            enable("ring2")
            equip(sets.idle)
        end
		if no_swap_gear:contains(player.equipment.back) then
            enable("back")
            equip(sets.idle)
        end
    end
)

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 11)
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset ' .. lockstyleset)
end