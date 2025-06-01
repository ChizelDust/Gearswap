-- Original: Motenten / Modified: Arislan
-- Haste/DW Detection Requires Gearinfo Addon

-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F9 ]              Cycle Offense Modes
--              [ CTRL+F9 ]         Cycle Hybrid Modes
--              [ WIN+F9 ]          Cycle Weapon Skill Modes
--              [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ WIN+C ]           Toggle Capacity Points Mode
--
--  Abilities:  [ CTRL+- ]          Chain Affinity
--              [ CTRL+= ]          Burst Affinity
--              [ CTRL+[ ]          Efflux
--              [ ALT+[ ]           Diffusion
--              [ ALT+] ]           Unbridled Learning
--              [ CTRL+Numpad/ ]    Berserk
--              [ CTRL+Numpad* ]    Warcry
--              [ CTRL+Numpad- ]    Aggressor
--
--  Spells:     [ CTRL+` ]          Blank Gaze
--              [ ALT+Q ]           Nature's Meditation/Fantod
--              [ ALT+W ]           Cocoon/Reactor Cool
--              [ ALT+E ]           Erratic Flutter
--              [ ALT+R ]           Battery Charge/Refresh
--              [ ALT+T ]           Occultation
--              [ ALT+Y ]           Barrier Tusk/Phalanx
--              [ ALT+U ]           Diamondhide/Stoneskin
--              [ ALT+P ]           Mighty Guard/Carcharian Verve
--              [ WIN+, ]           Utsusemi: Ichi
--              [ WIN+. ]           Utsusemi: Ni
--
--  WS:         [ CTRL+Numpad7 ]    Savage Blade
--              [ CTRL+Numpad9 ]    Chant Du Cygne
--              [ CTRL+Numpad4 ]    Requiescat
--              [ CTRL+Numpad5 ]    Expiacion
--
--
--              (Global-Binds.lua contains additional non-job-related keybinds)


--------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff['Burst Affinity'] = buffactive['Burst Affinity'] or false
    state.Buff['Chain Affinity'] = buffactive['Chain Affinity'] or false
    state.Buff.Convergence = buffactive.Convergence or false
    state.Buff.Diffusion = buffactive.Diffusion or false
    state.Buff.Efflux = buffactive.Efflux or false

    state.Buff['Unbridled Learning'] = buffactive['Unbridled Learning'] or false
    blue_magic_maps = {}

    -- Mappings for gear sets to use for various blue magic spells.
    -- While Str isn't listed for each, it's generally assumed as being at least
    -- moderately signficant, even for spells with other mods.

    -- Physical spells with no particular (or known) stat mods
    blue_magic_maps.Physical = S{'Bilgestorm'}

    -- Spells with heavy accuracy penalties, that need to prioritize accuracy first.
    blue_magic_maps.PhysicalAcc = S{'Heavy Strike'}

    -- Physical spells with Str stat mod
    blue_magic_maps.PhysicalStr = S{'Battle Dance','Bloodrake','Death Scissors','Dimensional Death',
        'Empty Thrash','Quadrastrike','Saurian Slide','Sinker Drill','Spinal Cleave','Sweeping Gouge',
        'Uppercut','Vertical Cleave'}

    -- Physical spells with Dex stat mod
    blue_magic_maps.PhysicalDex = S{'Amorphic Spikes','Asuran Claws','Barbed Crescent','Claw Cyclone',
        'Disseverment','Foot Kick','Frenetic Rip','Goblin Rush','Hysteric Barrage','Paralyzing Triad',
        'Seedspray','Sickle Slash','Smite of Rage','Terror Touch','Thrashing Assault','Vanity Dive'}

    -- Physical spells with Vit stat mod
    blue_magic_maps.PhysicalVit = S{'Body Slam','Cannonball','Delta Thrust','Glutinous Dart','Grand Slam',
        'Power Attack','Quad. Continuum','Sprout Smack','Sub-zero Smash'}

    -- Physical spells with Agi stat mod
    blue_magic_maps.PhysicalAgi = S{'Benthic Typhoon','Feather Storm','Helldive','Hydro Shot','Jet Stream',
        'Pinecone Bomb','Spiral Spin','Wild Oats'}

    -- Physical spells with Int stat mod
    blue_magic_maps.PhysicalInt = S{'Mandibular Bite','Queasyshroom'}

    -- Physical spells with Mnd stat mod
    blue_magic_maps.PhysicalMnd = S{'Ram Charge','Screwdriver','Tourbillion'}

    -- Physical spells with Chr stat mod
    blue_magic_maps.PhysicalChr = S{'Bludgeon'}

    -- Physical spells with HP stat mod
    blue_magic_maps.PhysicalHP = S{'Final Sting'}

    -- Magical spells with the typical Int mod
    blue_magic_maps.Magical = S{'Anvil Lightning','Blastbomb','Blazing Bound','Bomb Toss','Cursed Sphere',
        'Droning Whirlwind','Embalming Earth','Entomb','Firespit','Foul Waters','Ice Break','Leafstorm',
        'Maelstrom','Molting Plumage','Nectarous Deluge','Regurgitation','Rending Deluge','Scouring Spate',
        'Silent Storm','Spectral Floe','Subduction','Tem. Upheaval','Water Bomb'}

    blue_magic_maps.MagicalDark = S{'Dark Orb','Death Ray','Eyes On Me','Evryone. Grudge','Palling Salvo',
        'Tenebral Crush'}

    blue_magic_maps.MagicalLight = S{'Blinding Fulgor','Diffusion Ray','Radiant Breath','Rail Cannon',
        'Retinal Glare'}

    -- Magical spells with a primary Mnd mod
    blue_magic_maps.MagicalMnd = S{'Acrid Stream','Magic Hammer','Mind Blast'}

    -- Magical spells with a primary Chr mod
    blue_magic_maps.MagicalChr = S{'Mysterious Light'}

    -- Magical spells with a Vit stat mod (on top of Int)
    blue_magic_maps.MagicalVit = S{'Thermal Pulse'}

    -- Magical spells with a Dex stat mod (on top of Int)
    blue_magic_maps.MagicalDex = S{'Charged Whisker','Gates of Hades'}

    -- Magical spells (generally debuffs) that we want to focus on magic accuracy over damage.
    -- Add Int for damage where available, though.
    blue_magic_maps.MagicAccuracy = S{'1000 Needles','Absolute Terror','Actinic Burst','Atra. Libations',
        'Auroral Drape','Awful Eye', 'Blank Gaze','Blistering Roar','Blood Saber','Chaotic Eye',
        'Cimicine Discharge','Cold Wave','Corrosive Ooze','Demoralizing Roar','Digest','Dream Flower',
        'Enervation','Feather Tickle','Filamented Hold','Frightful Roar','Geist Wall','Hecatomb Wave',
        'Infrasonics','Jettatura','Light of Penance','Lowing','Mind Blast','Mortal Ray','MP Drainkiss',
        'Osmosis','Reaving Wind','Sandspin','Sandspray','Sheep Song','Soporific','Sound Blast','Stinking Gas',
		'Sub-zero Smash','Venom Shell','Voracious Trunk','Yawn'}

    -- Breath-based spells
    blue_magic_maps.Breath = S{'Bad Breath','Flying Hip Press','Frost Breath','Heat Breath','Hecatomb Wave',
        'Magnetite Cloud','Poison Breath','Self-Destruct','Thunder Breath','Vapor Spray','Wind Breath'}

    -- Stun spells
    blue_magic_maps.StunPhysical = S{'Frypan','Head Butt','Sudden Lunge','Tail slap','Whirl of Rage'}
    blue_magic_maps.StunMagical = S{'Blitzstrahl','Temporal Shift','Thunderbolt'}

    -- Healing spells
    blue_magic_maps.Healing = S{'Healing Breeze','Magic Fruit','Plenilune Embrace','Pollen','Restoral',
        'Wild Carrot'}

    -- Buffs that depend on blue magic skill
    blue_magic_maps.SkillBasedBuff = S{'Barrier Tusk','Diamondhide','Magic Barrier','Metallic Body',
        'Plasma Charge','Pyric Bulwark','Reactor Cool','Occultation'}

    -- Other general buffs
    blue_magic_maps.Buff = S{'Amplification','Animating Wail','Carcharian Verve','Cocoon',
        'Erratic Flutter','Exuviation','Fantod','Feather Barrier','Harden Shell','Memento Mori',
        'Nat. Meditation','Orcish Counterstance','Refueling','Regeneration','Saline Coat','Triumphant Roar',
        'Warm-Up','Winds of Promyvion','Zephyr Mantle'}

    blue_magic_maps.Refresh = S{'Battery Charge'}

    -- Spells that require Unbridled Learning to cast.
    unbridled_spells = S{'Absolute Terror','Bilgestorm','Blistering Roar','Bloodrake','Carcharian Verve','Cesspool',
        'Crashing Thunder','Cruel Joke','Droning Whirlwind','Gates of Hades','Harden Shell','Mighty Guard',
        'Polar Roar','Pyric Bulwark','Tearing Gust','Thunderbolt','Tourbillion','Uproot'}

    no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
              "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring"}
    elemental_ws = S{'Flash Nova', 'Sanguine Blade'}

    include('Mote-TreasureHunter')

    -- For th_action_check():
    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{35, 204}
    -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
    info.default_u_ja_ids = S{201, 202, 203, 205, 207}

    lockstyleset = 25
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'MidAcc', 'HighAcc')
    state.HybridMode:options('Normal', 'DT', 'EVA')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'PDL')
    state.CastingMode:options('Normal', 'Resistant')
    state.PhysicalDefenseMode:options('PDT', 'MDT')
    state.IdleMode:options('Normal', 'MDT', 'PDT', 'Evasion', 'Zeni','Fish')

    state.WeaponSet = M{['description']='Weapon Set','SavageDPS','SavageDT','SavageTP','PrimeDPS','MaxentiusDPS','MaxentiusDT','MaxentiusTP','Nuking'}
    state.WeaponLock = M(false, 'Weapon Lock')
    state.MagicBurst = M(false, 'Magic Burst')
    state.CP = M(false, "Capacity Points Mode")

    -- Additional local binds
	include('Chizel_Global_Binds.lua')
	-- include('Global-GEO-Binds.lua') -- OK to remove this line

    -- send_command('lua l azureSets')

    send_command('bind @t gs c cycle treasuremode')
    send_command('bind @w gs c toggle WeaponLock')
    send_command('bind @e gs c cycleback WeaponSet')
    send_command('bind @r gs c cycle WeaponSet')
	
	send_command('bind @insert input //aset set dps-savage')
	send_command('bind @home input //aset set macro-orb')	
	send_command('bind @pageup input //aset set mboze')
	send_command('bind @delete input //aset set cruel-joke')
	send_command('bind @end input //aset set dynamis')
	send_command('bind @pagedown input //aset set salvage')
	
	send_command('bind ^insert input /ma "Mighty Guard" <me>')
	send_command('bind ^home input /ma "Harden Shell" <me>')	
	send_command('bind ^pageup input /ma "Carcharian Verve" <me>')
	send_command('bind ^pagedown input /ma "Thunderbolt" <t>')
	send_command('bind ^end input /ma "Droning Whirlwind" <t>')
	send_command('bind ^delete input /ma "Cruel Joke" <t>')
	
    send_command('bind !` gs c toggle MagicBurst')
    send_command('bind ^- input /ja "Diffusion" <me>')
    send_command('bind ^= input /ja "Burst Affinity" <me>')
    send_command('bind ^[ input /ja "Efflux" <me>')
    send_command('bind ^] input /ja "Chain Affinity" <me>')
    send_command('bind ^, input /ma "Erratic Flutter" <me>')
    send_command('bind ^. input /ma "Occultation" <me>')

    send_command('bind @c gs c toggle CP')

    if player.sub_job == 'WAR' then
        send_command('bind ^numpad/ input /ja "Berserk" <me>')
        send_command('bind ^numpad* input /ja "Warcry" <me>')
        send_command('bind ^numpad- input /ja "Aggressor" <me>')
		send_command('bind ^numpad+ input /ja "Provoke" <stnpc>')
    elseif player.sub_job == 'DRG' then
		send_command('bind ^numpad/ input /ja "Jump" <stnpc>')
        send_command('bind ^numpad* input /ja "High Jump" <stnpc>')
        send_command('bind ^numpad- input /ja "Super Jump" <stnpc>')
		send_command('bind ^numpad+ input /ja "Ancient Circle" <me>')
	elseif player.sub_job == 'RDM' then
        send_command('bind ^numpad/ input /ma "Stoneskin" <me>')
        send_command('bind !numpad/ input /ma "Aquaveil" <me>')
        send_command('bind ^numpad* input /ma "Phalanx" <me>')
        send_command('bind ^numpad- input /ma "Refresh" <me>')		
		send_command('bind ^numpad+ input /ma "Diaga" <stnpc>')
	elseif player.sub_job == 'RUN' then
        send_command('bind ^numpad/ input /ma "Swordplay" <me>')
        send_command('bind !numpad/ input /ma "Aquaveil" <me>')
        send_command('bind ^numpad* input /ma "Pflug" <me>')
        send_command('bind !numpad* input /ma "Stoneskin" <me>')
        send_command('bind ^numpad- input /ma "Valiance" <me>')
        send_command('bind !numpad- input /ma "Vallation" <me>')				
		send_command('bind ^numpad+ input /ma "Flash" <stnpc>')
    elseif player.sub_job == 'THF' then
		send_command('bind ^numpad/ input /ja "Sneak Attack" <me>')
        send_command('bind ^numpad* input /ja "Trick Attack" <me>')
        send_command('bind ^numpad- input /ja "Steal" <stnpc>')
	elseif player.sub_job == 'DRK' then
		send_command('bind ^numpad/ input /ja "Last Resort" <me>')
		send_command('bind ^numpad* input /ma "Absorb-STR" <stnpc>')
		send_command('bind ^numpad- input /ma "Absorb-TP" <stnpc>')
		send_command('bind ^numpad+ input /ma "Stun" <stnpc>')		
	end

    send_command('bind ^numpad0 input /ws "Savage Blade" <t>')
    send_command('bind ^numpad1 input /ws "Chant du Cygne" <t>')
    send_command('bind ^numpad2 input /ws "Sanguine Blade" <t>')
    send_command('bind ^numpad3 input /ws "Requiescat" <t>')
    send_command('bind ^numpad4 input /ws "Expiacion" <t>')
    send_command('bind ^numpad5 input /ws "Black Halo" <t>')
    send_command('bind ^numpad6 input /ws "Judgment" <t>')
    send_command('bind ^numpad7 input /ws "Seraph Strike" <t>')
    send_command('bind ^numpad8 input /ws "Flash Nova" <t>')
    send_command('bind ^numpad9 input /ws "Realmrazer" <t>')
	
	send_command('bind @m input /mount "Red Crab"')

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
    send_command('unbind !`')
    send_command('unbind ^-')
    send_command('unbind ^=')
    send_command('unbind ^[')
	send_command('unbind ^]')
    send_command('unbind !q')
    send_command('unbind !w')
    send_command('unbind !p')
    send_command('unbind ^,')
    send_command('unbind @w')
    send_command('unbind @c')
    send_command('unbind @e')
    send_command('unbind @r')
	send_command('unbind @-')
	send_command('unbind @=')
    send_command('unbind ^numpad/')
	send_command('unbind !numpad/')
    send_command('unbind ^numpad*')
    send_command('unbind ^numpad-')
    send_command('unbind !numpad-')
	send_command('unbind ^numpad+')
    send_command('unbind ^numpad0')
    send_command('unbind ^numpad1')
    send_command('unbind ^numpad2')
    send_command('unbind ^numpad3')
    send_command('unbind ^numpad4')
    send_command('unbind ^numpad5')
    send_command('unbind ^numpad6')
    send_command('unbind ^numpad7')
    send_command('unbind ^numpad8')
    send_command('unbind ^numpad9')
    send_command('unbind @m')
	send_command('unbind ^insert')
	send_command('unbind ^home')
	send_command('unbind ^pageup')
	send_command('unbind ^pagedown')
	send_command('unbind ^end')
	send_command('unbind ^delete')
	send_command('unbind @insert')
	send_command('unbind @home')
	send_command('unbind @pageup')
	send_command('unbind @pagedown')
	send_command('unbind @end')
	send_command('unbind @delete')

    -- send_command('lua u azureSets')
end

-- Define sets and vars used by this job file.
function init_gear_sets()

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Precast sets to enhance JAs

    -- Enmity set
    sets.Enmity = {
        ammo="Sapience Orb", 												-- +2
        head="Halitus Helm", 												-- +8
        body="Emet Harness +1", 											-- +10
        hands="Kurys Gloves", 												-- +9
																						-- feet="Ahosi Leggings", --7
        neck="Moonlight Necklace", 											-- +15
        ear1="Cryptic Earring", 											-- +4
		ear2="Friomisi Earring",											-- +2		-- "Trux Earring", --5
        ring1="Supershear Ring", 											-- +5
        ring2="Eihwaz Ring", 												-- +5
        waist="Kasiri Belt", 												-- +3
		back=gear.BLU_Idle_Cape,											-- +10
        }	-- Enmity +72
		
	sets.BlueEnmity = {
		ammo="Sapience Orb",												-- +2
		body="Emet Harness +1",												-- +10
		neck="Warder's Charm +1",											-- +8
		back=gear.BLU_Idle_Cape,											-- +10
		}	-- Enmity +30

    sets.precast.JA['Provoke'] = sets.Enmity

    sets.buff['Burst Affinity'] = {legs="Assim. Shalwar +3", feet="Hashi. Basmak +2"}
    sets.buff['Diffusion'] = {feet="Luhlaza Charuqs +3"}
    sets.buff['Efflux'] = {legs="Hashishin Tayt +3"}

    sets.precast.JA['Azure Lore'] = {hands="Luh. Bazubands +3"}
    sets.precast.JA['Chain Affinity'] = {head="Hashishin Kavuk +3", feet="Assim. Charuqs +3"}
    sets.precast.JA['Convergence'] = {head="Luh. Keffiyeh +3"}
    sets.precast.JA['Enchainment'] = {body="Luhlaza Jubbah +3"}

    sets.precast.FC = {
        -- Sakpata 10
        ammo="Staunch Tathlum +1", 											--DT -3
        head="Carmine Mask +1", 											--FC 14
        body="Hashishin Mintan +2", 										--DT -12
        hands="Hashi. Bazu. +2", 											--DT -9
        legs="Pinga Pants",		 											--FC 11
        feet="Carmine Greaves +1", 											--FC 8
        neck="Baetyl Pendant",												--FC 4			--"Orunmila's Torque", --5
        ear1="Loquacious Earring",											--FC 2			--"Enchntr. Earring +1", --2
        ear2="Odnowa Earring +1",	 										--DT -3
        ring1="Defending Ring", 											--DT -10
        ring2="Medada's Ring",	 											--FC 10
        back=gear.BLU_FC_Cape,												--FC 10
        } --Base set = 59% FC (FC III = 20%, FC IV = 25%)

    sets.precast.FC['Blue Magic'] = set_combine(sets.precast.FC, {body="Hashishin Mintan +2"})
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
    sets.precast.FC.Cure = set_combine(sets.precast.FC, {ear1="Mendi. Earring"})

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
		body="Passion Jacket",
        waist="Rumination Sash",
        })


    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.WS = {
        ammo="Oshasha's Treatise",
        head="Hashishin Kavuk +3",
        body="Nyame Mail",
        hands="Nyame Gauntlets",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets",
        neck="Fotia Gorget",
        ear1="Moonshade Earring",
        ear2="Ishvara Earring",
        ring1="Epaminondas's Ring",
        ring2="Ilabrat Ring",
        back=gear.BLU_STR_Cape,
        waist="Fotia Belt",
        }

    sets.precast.WS.PDL = set_combine(sets.precast.WS, {
        ammo="Crepuscular Pebble",
        legs="Gleti's Breeches",
        ear2="Regal Earring",
        })

    sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {
		ammo="Coiste Bodhar",
        head="Gleti's Mask",
        body="Gleti's Cuirass",
        hands="Gleti's Gauntlets",
        legs="Gleti's Breeches",
		neck="Mirage Stole +1",
        ear1="Mache Earring +1",
		ear2="Odr Earring",
        ring1="Begrudging Ring",
        back=gear.BLU_CDC_Cape,
        })

    sets.precast.WS['Chant du Cygne'].PDL = set_combine(sets.precast.WS['Chant du Cygne'], sets.precast.WS.PDL)

    sets.precast.WS['Vorpal Blade'] = sets.precast.WS['Chant du Cygne']
    sets.precast.WS['Vorpal Blade'].PDL = sets.precast.WS['Chant du Cygne'].PDL

    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
		ammo="Coiste Bodhar",
        neck="Mirage Stole +1",
        ring2="Shukuyu Ring",
        waist="Sailfi Belt +1",
        })

    sets.precast.WS['Savage Blade'].PDL = set_combine(sets.precast.WS['Savage Blade'], sets.precast.WS.PDL)

    sets.precast.WS['Requiescat'] = {
		ammo="Amar Cluster",
        head="Malignance Chapeau",
        body="Hashishin Mintan +2",
        hands="Malignance Gloves",
        legs="Hashishin Tayt +3",
        feet="Hashi. Basmak +2",
        neck="Fotia Gorget",
        ear1="Moonshade Earring",
        ear2="Brutal Earring",
        ring2="Rufescent Ring",
        back="Vespid Mantle",																	--gear.BLU_WS1_Cape,
        waist="Fotia Belt",
        }

    sets.precast.WS['Requiescat'].PDL = set_combine(sets.precast.WS['Requiescat'], sets.precast.WS.PDL)

    sets.precast.WS['Expiacion'] = set_combine(sets.precast.WS['Savage Blade'], {
		ring2="Ilabrat Ring",
		})

    sets.precast.WS['Expiacion'].PDL = set_combine(sets.precast.WS['Expiacion'], sets.precast.WS.PDL)

    sets.precast.WS['Sanguine Blade'] = {
        ammo="Ghastly Tathlum +1",
        head="Pixie Hairpin +1",
        body="Nyame Mail",
        hands="Nyame Gauntlets",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets",
        neck="Baetyl Pendant",
        ear1="Moonshade Earring",
        ear2="Regal Earring",
        ring1="Archon Ring",
        ring2="Medada's Ring",
        back=gear.BLU_MAB_Cape,
        waist="Orpheus's Sash",
        }

    sets.precast.WS['True Strike'] = sets.precast.WS['Savage Blade']
    sets.precast.WS['True Strike'].PDL = sets.precast.WS['Savage Blade'].PDL
    sets.precast.WS['Judgment'] = sets.precast.WS['Savage Blade']
    sets.precast.WS['Judgment'].PDL = sets.precast.WS['Savage Blade'].PDL
    sets.precast.WS['Black Halo'] = sets.precast.WS['Savage Blade']
    sets.precast.WS['Black Halo'].PDL = sets.precast.WS['Savage Blade'].PDL

    sets.precast.WS['Realmrazer'] = sets.precast.WS['Requiescat']
    sets.precast.WS['Realmrazer'].PDL = sets.precast.WS['Requiescat'].PDL

    sets.precast.WS['Flash Nova'] = set_combine(sets.precast.WS['Sanguine Blade'], {
        head="Nyame Helm",
        ring2="Weather. Ring",
        })

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.SpellInterrupt = {
		ammo="Staunch Tathlum +1",								-- SIRD 11
		head="Malignance Chapeau",								-- DT -6
		body="Hashishin Mintan +2",								-- DT -12
		hands="Rawhide Gloves",									-- SIRD 15
		legs="Assim. Shalwar +3",								-- SIRD 24
		feet="Amalric Nails", 									-- SIRD 15
		neck="Loricate Torque +1",								-- DT -6, SIRD 5
		waist="Rumination Sash",								-- SIRD 10
		ear1="Halasz Earring",									-- SIRD 5
		ear2="Magnetic Earring",								-- SIRD 8
		ring1="Defending Ring",									-- DT -10
		ring2="Medada's Ring",									
		back=gear.BLU_FC_Cape,									-- DT -5
        }	-- SIRD (Merits) 100/1024, (Gear) 930/1024 = 100%

    sets.midcast.Utsusemi = sets.midcast.SpellInterrupt

    sets.midcast['Blue Magic'] = {
        ammo="Mavi Tathlum",
        head="Luh. Keffiyeh +3",
        body="Assim. Jubbah +3",
        hands="Rawhide Gloves",
        legs="Hashishin Tayt +3",
        feet="Luhlaza Charuqs +3",
        neck="Mirage Stole +1",
        ear1="Njordr Earring",
		ear2="Hashishin Earring +1",
        ring1="Stikini Ring +1",
        ring2="Stikini Ring",
        back="Cornflower Cape",
        }

    sets.midcast['Blue Magic'].Physical = {
        ammo="Crepuscular Pebble",
        head="Luh. Keffiyeh +3",
        body="Luhlaza Jubbah +3",
        hands="Hashi. Bazu. +2",
        legs="Hashishin Tayt +3",
        feet="Luhlaza Charuqs +3",
        neck="Rep. Plat. Medal",
        ring1="Shukuyu Ring",
        ring2="Ilabrat Ring",
        back="Cornflower Cape",																--gear.BLU_WS2_Cape,
        waist="Sailfi Belt +1",
        }

    sets.midcast['Blue Magic'].PhysicalAcc = set_combine(sets.midcast['Blue Magic'].Physical, {
        ammo="Amar Cluster",
        head="Carmine Mask +1",
        hands="Gazu Bracelets +1",
        legs="Carmine Cuisses +1",
        neck="Mirage Stole +1",
        ear2="Telos Earring",
        back="Cornflower Cape",
        waist="Grunfeld Rope",
        })

    sets.midcast['Blue Magic'].PhysicalStr = sets.midcast['Blue Magic'].Physical

    sets.midcast['Blue Magic'].PhysicalDex = set_combine(sets.midcast['Blue Magic'].Physical, {
        ear2="Odr Earring",
        ring2="Ilabrat Ring",
        back=gear.BLU_CDC_Cape,
        waist="Grunfeld Rope",
        })

    sets.midcast['Blue Magic'].PhysicalVit = sets.midcast['Blue Magic'].Physical

    sets.midcast['Blue Magic'].PhysicalAgi = set_combine(sets.midcast['Blue Magic'].Physical, {
        -- hands=gear.Adhemar_B_hands,
        ring2="Ilabrat Ring",
        })

    sets.midcast['Blue Magic'].PhysicalInt = set_combine(sets.midcast['Blue Magic'].Physical, {
        ammo="Ghastly Tathlum +1",
        ear2="Regal Earring",
        ring1="Metamor. Ring +1",		
        ring2="Medada's Ring",
        back="Aurist's Cape +1",
        waist="Acuity Belt +1",
        })

    sets.midcast['Blue Magic'].PhysicalMnd = set_combine(sets.midcast['Blue Magic'].Physical, {
        ear2="Regal Earring",
        ring1="Stikini Ring +1",
        ring2="Stikini Ring",
        back="Aurist's Cape +1",
        })

    -- sets.midcast['Blue Magic'].PhysicalChr = set_combine(sets.midcast['Blue Magic'].Physical, {ear1="Regal Earring", ear2="Enchntr. Earring +1"})
    sets.midcast['Blue Magic'].PhysicalChr = set_combine(sets.midcast['Blue Magic'].Physical, {ear2="Regal Earring"})
	
    sets.midcast['Blue Magic'].Magical = {
        ammo="Pemphredo Tathlum",
        head="Hashishin Kavuk +3",
        body="Hashishin Mintan +2",
        hands="Hashi. Bazu. +2",
        legs="Hashishin Tayt +3",
        feet="Hashi. Basmak +2",
        neck="Baetyl Pendant",
        ear1="Friomisi Earring",
        ear2="Regal Earring",
        ring1="Metamor. Ring +1",
        ring2="Medada's Ring",
        back=gear.BLU_MAB_Cape,
        waist="Orpheus's Sash",
        }

    sets.midcast['Blue Magic'].Magical.Resistant = set_combine(sets.midcast['Blue Magic'].Magical, {
        neck="Mirage Stole +1",
        ear1="Crepuscular Earring", 														--"Digni. Earring",
        ring1="Stikini Ring +1",
        waist="Acuity Belt +1",
        })

    sets.midcast['Blue Magic'].MagicalDark = set_combine(sets.midcast['Blue Magic'].Magical, {
        head="Pixie Hairpin +1",
        ring1="Archon Ring",
        })

    sets.midcast['Blue Magic'].MagicalLight = set_combine(sets.midcast['Blue Magic'].Magical, {
        ring2="Weather. Ring"
        })

    sets.midcast['Blue Magic'].MagicalMnd = set_combine(sets.midcast['Blue Magic'].Magical, {
        ring1="Stikini Ring +1",
        ring2="Stikini Ring",
        back="Aurist's Cape +1",
        })

    sets.midcast['Blue Magic'].MagicalDex = set_combine(sets.midcast['Blue Magic'].Magical, {
        ammo="Coiste Bodhar",
        ear2="Odr Earring",
        ring2="Ilabrat Ring",
        })

    sets.midcast['Blue Magic'].MagicalVit = set_combine(sets.midcast['Blue Magic'].Magical, {
        ammo="Aurgelmir Orb",
        })

    sets.midcast['Blue Magic'].MagicalChr = set_combine(sets.midcast['Blue Magic'].Magical, {
        ammo="Amar Cluster",
        ear1="Regal Earring",
        -- ear2="Enchntr. Earring +1",
        })

    sets.midcast['Blue Magic'].MagicAccuracy = set_combine(sets.midcast['Blue Magic'].Magical.Resistant, {
        ammo="Pemphredo Tathlum",
        head="Assim. Keffiyeh +3",
        body="Assim. Jubbah +3",
        hands="Hashi. Bazu. +2",
        legs="Assim. Shalwar +3",
        feet="Malignance Boots",
        ear2="Regal Earring",
        back="Aurist's Cape +1",
        })

    sets.midcast['Blue Magic'].Breath = set_combine(sets.midcast['Blue Magic'].Magical, {head="Luh. Keffiyeh +3"})

    sets.midcast['Blue Magic'].StunPhysical = set_combine(sets.midcast['Blue Magic'].MagicAccuracy, {
        ammo="Amar Cluster",
        neck="Mirage Stole +1",
        })

    sets.midcast['Blue Magic'].StunMagical = sets.midcast['Blue Magic'].MagicAccuracy

    sets.midcast['Blue Magic'].Healing = {
        ammo="Hydrocera",
        head="Hashishin Kavuk +3",
        body="Vrikodara Jupon", 																-- 13
        hands=gear.Telchine_ENH_hands, 															-- 10
        legs="Pinga Pants",
        feet="Hashi. Basmak +2",																--"Medium's Sabots", -- 12
        neck="Incanter's Torque", 																--"Nuna Gorget +1",
        ear1="Mendi. Earring", 																	-- 5
        ear2="Regal Earring",
        ring1="Stikini Ring +1", 																-- 3
        ring2="Stikini Ring",
        back="Solemnity Cape",																	--7
        waist="Rumination Sash", 																--"Luminary Sash",
        }

    sets.midcast['Blue Magic'].HealingSelf = set_combine(sets.midcast['Blue Magic'].Healing, {
																								--legs="Gyve Trousers", -- 10
        neck="Unmoving Collar +1",																--"Phalaina Locket", -- 4(4)
        ring2="Kunaji Ring", 																	--3
        back="Solemnity Cape", 																	--7
        waist="Gishdubar Sash", 																--10
        })

    sets.midcast['Blue Magic']['White Wind'] = set_combine(sets.midcast['Blue Magic'].Healing, {
        neck="Unmoving Collar +1",
        ear1="Tuisto Earring",
		ear2="Odnowa Earring +1",
        ring2="Eihwaz Ring",
        back="Moonbeam Cape",
        waist="Kasiri Belt",
        })

    sets.midcast['Blue Magic'].Buff = sets.midcast['Blue Magic']
    sets.midcast['Blue Magic'].Refresh = set_combine(sets.midcast['Blue Magic'], {head="Amalric Coif", waist="Gishdubar Sash", back="Grapevine Cape"})
    sets.midcast['Blue Magic'].SkillBasedBuff = sets.midcast['Blue Magic']

    sets.midcast['Blue Magic']['Occultation'] = set_combine(sets.midcast['Blue Magic'], {
		sub="Iris",
        hands="Hashi. Bazu. +2",
        ear1="Njordr Earring",
        ear2="Hashi. Earring +1",
		ring2="Medada's Ring",
		back=gear.BLU_FC_Cape,
        }) -- 1 shadow per 50 skill (Current 650: 13 shadows)

    sets.midcast['Blue Magic']['Carcharian Verve'] = set_combine(sets.midcast['Blue Magic'].Buff, {
        head="Amalric Coif",
        waist="Emphatikos Rope",
        })

    sets.midcast['Enhancing Magic'] = {
        ammo="Pemphredo Tathlum",
        head="Carmine Mask +1",
        body=gear.Telchine_ENH_body,
        hands=gear.Telchine_ENH_hands,
        legs="Carmine Cuisses +1",
        feet=gear.Telchine_ENH_feet,
        neck="Incanter's Torque",
        ear1="Mimir Earring",
        ear2="Andoaa Earring",
        ring1="Stikini Ring +1",
        ring2="Stikini Ring",
        back="Fi Follet Cape +1",
        waist="Olympus Sash",
        }

    sets.midcast.EnhancingDuration = {
        head=gear.Telchine_ENH_head,
        body=gear.Telchine_ENH_body,
        hands=gear.Telchine_ENH_hands,
        legs=gear.Telchine_ENH_legs,
        feet=gear.Telchine_ENH_feet,
        }

    sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {head="Amalric Coif", waist="Gishdubar Sash", back="Grapevine Cape"})
    sets.midcast.Stoneskin = set_combine(sets.midcast.EnhancingDuration, {
		hands="Stone Mufflers",
		legs="Shedir Seraweels",
        neck="Nodens Gorget",
		ear2="Earthcry Earring",
        waist="Siegel Sash",
		})

    sets.midcast.Phalanx = set_combine(sets.midcast.EnhancingDuration, {
		main="Sakpata's Sword",
        body=gear.Taeon_Phalanx_body, --3(10)
        hands=gear.Taeon_Phalanx_hands, --3(10)
        legs=gear.Taeon_Phalanx_legs, --3(10)
        feet=gear.Taeon_Phalanx_feet, --3(10)
        })

    sets.midcast.Aquaveil = set_combine(sets.midcast.EnhancingDuration, {
        head="Amalric Coif",
		hands="Regal Cuffs",
        waist="Emphatikos Rope",
        })

    sets.midcast.Protect = set_combine(sets.midcast.EnhancingDuration, {ring1="Sheltered Ring"})
    sets.midcast.Protectra = sets.midcast.Protect
    sets.midcast.Shell = sets.midcast.Protect
    sets.midcast.Shellra = sets.midcast.Protect

    sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast['Blue Magic'].MagicAccuracy, {
        head=empty;
        body="Cohort Cloak +1",
        ear2="Vor Earring",
        })

    sets.midcast.Utsusemi = sets.midcast.SpellInterrupt
	
	sets.midcast['Actinic Burst'] = set_combine(sets.midcast['Blue Magic'].MagicAccuracy, sets.BlueEnmity)
	sets.midcast['Temporal Shift'] = set_combine(sets.midcast['Blue Magic'].StunMagical, sets.BlueEnmity)
	sets.midcast['Jettatura'] = set_combine(sets.midcast['Blue Magic'].MagicAccuracy, sets.BlueEnmity)
	sets.midcast['Blank Gaze'] = set_combine(sets.midcast['Blue Magic'].MagicAccuracy, sets.BlueEnmity)
	sets.midcast['Fantod'] = set_combine(sets.midcast['Blue Magic'].Buff, sets.BlueEnmity)
	sets.midcast['Geist Wall'] = set_combine(sets.midcast['Blue Magic'].MagicAccuracy, sets.BlueEnmity)
	sets.midcast['Exuviation'] = set_combine(sets.midcast['Blue Magic'].Buff, sets.BlueEnmity)

    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Resting sets
    sets.resting = {}


    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

    sets.idle = {
        ammo="Staunch Tathlum +1",
        head="Rawhide Mask",
        body="Hashishin Mintan +2",
        hands="Hashi. Bazu. +2",
        legs="Hashishin Tayt +3",
        feet="Gleti's Boots",
        neck="Loricate Torque +1",
        ear1="Eabani Earring",
        ear2="Odnowa Earring +1",												--"Sanare Earring",
        ring1="Stikini Ring +1",
        ring2="Shadow Ring",
        back=gear.BLU_Idle_Cape,
        waist="Carrier's Sash",
        }
		
	sets.idle.MDT = set_combine(sets.idle, {
        head="Hashishin Kavuk +3",
		neck="Warder's Charm +1",
		ring1="Warden's Ring",
		})
		
    sets.idle.PDT = set_combine(sets.idle, {
		ammo="Staunch Tathlum +1",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		ear1="Tuisto Earring",
		ring1="Defending Ring",
		ring2="Fortified Ring",
		waist="Cornelia's Belt",
		back=gear.BLU_Idle_Cape,
        })
		
	sets.idle.Evasion = {
		ammo="Staunch Tathlum +1",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Gleti's Boots",
		neck="Bathy Choker +1",
		ear1="Eabani Earring",
		ear2="Infused Earring",
		ring1="Vengeful Ring",
		ring2="Fortified Ring",
		waist="Svelt. Gouriz +1",
		back=gear.BLU_Idle_Cape,
		}
		
	sets.idle.Zeni = set_combine(sets.idle, {
        head="Hashishin Kavuk +3",
		ranged="Soultrapper 2000",
		ammo="H.S. Soul Plate",
		})
		
	sets.idle.Fish = set_combine(sets.idle.MDT, {
		ranged="Lu Shang's F. Rod",
		ammo="Fly Lure",
		})

    sets.idle.Weak = sets.idle.DT

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    sets.engaged = {
        ammo="Coiste Bodhar",
        head="Malignance Chapeau",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        legs="Malignance Tights",
        feet="Malignance Boots",
        neck="Mirage Stole +1",
        ear1="Cessance Earring",
        ear2="Hashi. Earring +1",
        ring1="Hetairoi Ring",
        ring2="Epona's Ring",
        back=gear.BLU_TP_Cape,
        waist="Windbuffet Belt +1",
        }

    sets.engaged.MidAcc = set_combine(sets.engaged, {
        ammo="Amar Cluster",
        ear1="Telos Earring",
        ring1="Chirich Ring +1",
        ring2="Ilabrat Ring",
        waist="Kentarch Belt +1",
        })

    sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {
        head="Carmine Mask +1",
        hands="Gazu Bracelets +1",
		-- ring1="Regal Ring",
        legs="Carmine Cuisses +1",
        -- waist="Olseni Belt",
        })

    -- Base Dual-Wield Values:
    -- * DW6: +37%
    -- * DW5: +35%
    -- * DW4: +30%
    -- * DW3: +25% (NIN Subjob)
    -- * DW2: +15% (DNC Subjob)
    -- * DW1: +10%

    -- No Magic Haste (74% DW to cap, DW3 = 25%, 49% to cap)
    sets.engaged.DW = {
        ammo="Hasty Pinion +1",									--Haste 20/1024
        head=gear.Taeon_DW_head,								--DW 5, Haste 80/1024
        body=gear.Adhemar_A_body,								--DW 6, Haste 40/1024
        hands="Gleti's Gauntlets",								--Haste 30/1024
        legs="Carmine Cuisses +1", 								--DW 6, Haste 60/1024
        feet=gear.Taeon_DW_feet, 								--DW 8, Haste 40/1024
        neck="Mirage Stole +1",
        ear1="Eabani Earring", 									--DW 4
        ear2="Suppanomimi", 									--DW 5
        ring1="Hetairoi Ring",
        ring2="Epona's Ring",
        back=gear.BLU_DW_Cape,									--DW 10
        waist="Reiki Yotai", 									--DW 7
        } -- 51% (+2%), Haste 270/1024

    sets.engaged.DW.MidAcc = set_combine(sets.engaged.DW, {
        ammo="Amar Cluster",
        ear1="Telos Earring",
        ring1="Chirich Ring +1",
        ring2="Ilabrat Ring",
        waist="Kentarch Belt +1",
        })

    sets.engaged.DW.HighAcc = set_combine(sets.engaged.DW.MidAcc, {
        head="Carmine Mask +1",
        hands="Gazu Bracelets +1",
		ring1="Regal Ring",
        legs="Carmine Cuisses +1",
        -- waist="Olseni Belt",
        })		

    -- 15% Magic Haste (67% DW to cap, DW3 = 25%, 42% to cap)
    sets.engaged.DW.LowHaste = set_combine(sets.engaged.DW, {
        body="Gleti's Cuirass",									--Haste 30/1024
        ear1="Telos Earring",
        }) -- 41% (-1%), Haste 260/1024

    sets.engaged.DW.MidAcc.LowHaste = set_combine(sets.engaged.DW.LowHaste, {
        ammo="Amar Cluster",
        ear1="Telos Earring",
        ring1="Chirich Ring +1",
        ring2="Ilabrat Ring",
        waist="Kentarch Belt +1",
        })

    sets.engaged.DW.HighAcc.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, {
        head="Carmine Mask +1",
        hands="Gazu Bracelets +1",
		ring1="Regal Ring",
        legs="Carmine Cuisses +1",
        -- waist="Olseni Belt",
        })

    -- 30% Magic Haste (56% DW to cap, DW3 = 25%, 31% to cap)
    sets.engaged.DW.MidHaste = set_combine(sets.engaged.DW, {
        head=gear.Adhemar_B_head,								--Haste 80/1024
        body="Gleti's Cuirass",									--Haste 30/1024
        ear1="Telos Earring",
        ear2="Hashi. Earring +1",
        }) -- 31% (-0%), Haste 260/1024

    sets.engaged.DW.MidAcc.MidHaste = set_combine(sets.engaged.DW.MidHaste, {
        ammo="Amar Cluster",
        ear1="Telos Earring",
        ring1="Chirich Ring +1",
        ring2="Ilabrat Ring",
        waist="Kentarch Belt +1",
        })

    sets.engaged.DW.HighAcc.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, {
        head="Carmine Mask +1",
        hands="Gazu Bracelets +1",
		ring1="Regal Ring",
        legs="Carmine Cuisses +1",
        -- waist="Olseni Belt",
        })

    -- 45% Magic Haste (36% DW to cap, DW3 = 25%, 11% to cap)
    sets.engaged.DW.MaxHaste = set_combine(sets.engaged.DW, {
        ammo="Coiste Bodhar",
        head=gear.Adhemar_B_head,								--Haste 80/1024
        body="Gleti's Cuirass",									--Haste 30/1024
        legs="Gleti's Breeches",								--Haste 50/1024
        feet="Malignance Boots",								--Haste 30/1024
        ear2="Hashi. Earring +1",
        back=gear.BLU_TP_Cape,
        }) -- 11% (-0%), Haste 210/1024

    sets.engaged.DW.MidAcc.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, {
        ammo="Amar Cluster",
        ear1="Telos Earring",
        ring1="Chirich Ring +1",
        ring2="Ilabrat Ring",
        waist="Kentarch Belt +1",
        })

    sets.engaged.DW.HighAcc.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, {
        head="Carmine Mask +1",
        hands="Gazu Bracelets +1",
		ring1="Regal Ring",
        legs="Carmine Cuisses +1",
        -- waist="Olseni Belt",
        })

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.engaged.Hybrid = {
		ammo="Coiste Bodhar",
        head="Malignance Chapeau", 				--DT 6
        body="Malignance Tabard", 				--DT 9
		legs="Malignance Tights",				--DT 7
        feet="Malignance Boots", 				--DT 4
        ring1="Defending Ring", 				--10/10
        } --DT -29

    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.MidAcc.DT = set_combine(sets.engaged.MidAcc, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT = set_combine(sets.engaged.HighAcc, sets.engaged.Hybrid)

    sets.engaged.DW.DT = set_combine(sets.engaged.DW, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT = set_combine(sets.engaged.DW.MidAcc, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT = set_combine(sets.engaged.DW.HighAcc, sets.engaged.Hybrid)

    sets.engaged.DW.DT.LowHaste = set_combine(sets.engaged.DW.LowHaste, sets.Hybrid)
    sets.engaged.DW.MidAcc.DT.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, sets.Hybrid)
    sets.engaged.DW.HighAcc.DT.LowHaste = set_combine(sets.engaged.DW.HighAcc.LowHaste, sets.Hybrid)

    sets.engaged.DW.DT.MidHaste = set_combine(sets.engaged.DW.MidHaste, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.MidHaste = set_combine(sets.engaged.DW.HighAcc.MidHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.MaxHaste = set_combine(sets.engaged.DW.HighAcc.MaxHaste, sets.engaged.Hybrid)
	
	sets.engaged.Evasion = {
		ammo="Staunch Tathlum +1",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Bathy Choker +1",
		ear1="Eabani Earring",
		ear2="Infused Earring",
		ring1="Defending Ring",
		ring2="Fortified Ring",
		waist="Kasiri Belt",
		back=gear.BLU_Idle_Cape,
		}
	
    sets.engaged.EVA = set_combine(sets.engaged, sets.engaged.Evasion)
    sets.engaged.MidAcc.EVA = set_combine(sets.engaged.MidAcc, sets.engaged.Evasion)
    sets.engaged.HighAcc.EVA = set_combine(sets.engaged.HighAcc, sets.engaged.Evasion)

    sets.engaged.DW.EVA = set_combine(sets.engaged.DW, sets.engaged.Evasion)
    sets.engaged.DW.MidAcc.EVA = set_combine(sets.engaged.DW.MidAcc, sets.engaged.Evasion)
    sets.engaged.DW.HighAcc.EVA = set_combine(sets.engaged.DW.HighAcc, sets.engaged.Evasion)

    sets.engaged.DW.EVA.LowHaste = set_combine(sets.engaged.DW.LowHaste, sets.engaged.Evasion)
    sets.engaged.DW.MidAcc.EVA.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, sets.engaged.Evasion)
    sets.engaged.DW.HighAcc.EVA.LowHaste = set_combine(sets.engaged.DW.HighAcc.LowHaste, sets.engaged.Evasion)

    sets.engaged.DW.EVA.MidHaste = set_combine(sets.engaged.DW.MidHaste, sets.engaged.Evasion)
    sets.engaged.DW.MidAcc.EVA.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, sets.engaged.Evasion)
    sets.engaged.DW.HighAcc.EVA.MidHaste = set_combine(sets.engaged.DW.HighAcc.MidHaste, sets.engaged.Evasion)

    sets.engaged.DW.EVA.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, sets.engaged.Evasion)
    sets.engaged.DW.MidAcc.EVA.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, sets.engaged.Evasion)
    sets.engaged.DW.HighAcc.EVA.MaxHaste = set_combine(sets.engaged.DW.HighAcc.MaxHaste, sets.engaged.Evasion)

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.magic_burst = set_combine(sets.midcast['Blue Magic'].Magical, {
		ammo="Ghastly Tathlum +1",
		head="Nyame Helm", 												--MAB +30, MB1 +5
        body="Nyame Mail", 												--MAB +30, MB1 +7
        hands="Nyame Gauntlets", 										--MAB +30, MB1 +5
        legs="Nyame Flanchard", 										--MAB +30, MB1 +6
        feet="Hashi. Basmak +2", 										--MAB +50, MB1 +10
        neck="Baetyl Pendant",											--MAB +13						--"Warder's Charm +1", --10
        ear1="Halasz Earring",											--MAB +14
		ear2="Regal Earring",											--MAB +7
        ring1="Metamor. Ring +1",
        ring2="Medada's Ring", 											--MAB +10
        back="Seshaw Cape", 											--MAB +11, MB1 +5
        }) -- MAB +215, MB1 +38

    sets.Kiting = {legs="Carmine Cuisses +1", neck="Loricate Torque +1", ring1="Defending Ring"}
    sets.Learning = {hands="Assim. Bazu. +2"}
	sets.Zeni = {range="Soultrapper 2000", ammo="H.S. Soul Plate"}
    sets.latent_refresh = {neck="Sibyl Scarf", ring2="Stikini Ring +1", waist="Fucho-no-obi"}

    sets.buff.Doom = {
        neck="Nicander's Necklace", 					--20
		ring1="Purity Ring", 							--7
		ring2="Saida Ring", 							--15
		waist="Gishdubar Sash", 						--10
        }

    sets.CP = {back="Mecisto. Mantle"}
	
    sets.TreasureHunter = {
		body="Volte Jupon", 		-- +2
		legs="Volte Hose",			-- +1
		ammo="Perfect Lucky Egg", 	-- +1
		} --TH +4
		
    sets.midcast.Dia = sets.TreasureHunter
    sets.midcast.Diaga = sets.TreasureHunter
    sets.midcast.Bio = sets.TreasureHunter
	sets.midcast['Sound Blast'] = sets.TreasureHunter
    -- sets.Reive = {neck="Ygnas's Resolve +1"}

    -- sets.Almace = {main="Almace", sub="Sequence"}
    sets.SavageDPS = {main="Naegling", sub="Zantetsuken"}
	sets.SavageDT = {main="Naegling", sub="Sakpata's Sword"}	
	sets.SavageTP = {main="Naegling", sub="Thibron"}
	sets.PrimeDPS = {main="Caliburnus", sub="Sakpata's Sword"}
    sets.MaxentiusDPS = {main="Maxentius", sub="Zantetsuken"}
	sets.MaxentiusDT = {main="Maxentius", sub="Sakpata's Sword"}
	sets.MaxentiusTP = {main="Maxentius", sub="Thibron"}
	sets.Nuking = {main="Maxentius", sub="Bunzi's Rod"}
	-- sets.Lv1Daggers = {main="Esikuva", sub="Infiltrator"}
	

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if unbridled_spells:contains(spell.english) and not state.Buff['Unbridled Learning'] then
        eventArgs.cancel = true
        windower.send_command('@input /ja "Unbridled Learning" <me>; wait 1.8; input /ma "'..spell.name..'" '..spell.target.name)
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

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Add enhancement gear for Chain Affinity, etc.
    if spell.skill == 'Blue Magic' then
        for buff,active in pairs(state.Buff) do
            if active and sets.buff[buff] then
                equip(sets.buff[buff])
            end
        end
        if spellMap == 'Magical' then
            if spell.element == world.weather_element and (get_weather_intensity() == 2 and spell.element ~= elements.weak_to[world.day_element]) then
                equip({waist="Hachirin-no-Obi"})
            end
        end
        if spellMap == 'Healing' and spell.target.type == 'SELF' then
            equip(sets.midcast['Blue Magic'].HealingSelf)
        end
    end

    if spell.skill == 'Enhancing Magic' and classes.NoSkillSpells:contains(spell.english) then
        equip(sets.midcast.EnhancingDuration)
        if spellMap == 'Refresh' then
            equip(sets.midcast.Refresh)
        end
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.english == "Dream Flower" then
            send_command('@timers c "Dream Flower ['..spell.target.name..']" 90 down spells/00098.png')
        elseif spell.english == "Soporific" then
            send_command('@timers c "Sleep ['..spell.target.name..']" 90 down spells/00259.png')
        elseif spell.english == "Sheep Song" then
            send_command('@timers c "Sheep Song ['..spell.target.name..']" 60 down spells/00098.png')
        elseif spell.english == "Yawn" then
            send_command('@timers c "Yawn ['..spell.target.name..']" 60 down spells/00098.png')
        elseif spell.english == "Entomb" then
            send_command('@timers c "Entomb ['..spell.target.name..']" 60 down spells/00547.png')
        end
    end
    if player.status ~= 'Engaged' and state.WeaponLock.value == false then
        check_weaponset()
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff,gain)

--    if buffactive['Reive Mark'] then
--        if gain then
--            equip(sets.Reive)
--            disable('neck')
--        else
--            enable('neck')
--        end
--    end

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
    th_update(cmdParams, eventArgs)
end

function update_combat_form()
    if DW == true then
        state.CombatForm:set('DW')
    elseif DW == false then
        state.CombatForm:reset()
    end
end

-- Custom spell mapping.
-- Return custom spellMap value that can override the default spell mapping.
-- Don't return anything to allow default spell mapping to be used.
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Blue Magic' then
        for category,spell_list in pairs(blue_magic_maps) do
            if spell_list:contains(spell.english) then
                return category
            end
        end
    end
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
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
	if player.mp < 738 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end	
    if state.CP.current == 'on' then
        equip(sets.CP)
        disable('back')
    else
        enable('back')
    end
    -- if state.IdleMode.value == 'Learning' then
       -- equip(sets.idle.Learning)
       -- disable('hands')
    -- else
       -- enable('hands')
    -- end
	if state.IdleMode == 'Zeni' then
		equip(sets.idle.Zeni)
		disable('ranged')
		disable('ammo')
	else
		enable('ranged')
		enable('ammo')
	end
    if state.Auto_Kite.value == true then
       idleSet = set_combine(idleSet, sets.Kiting)
    end

    return idleSet
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
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
    if state.TreasureMode.value == 'Tag' then
        msg = msg .. ' TH: Tag |'
    end
    if state.MagicBurst.value then
        msg = ' Burst: On |'
    end
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


function determine_haste_group()
    classes.CustomMeleeGroups:clear()
	if DW == true then
			if DW_needed <= 11 then
				classes.CustomMeleeGroups:append('MaxHaste')
			elseif DW_needed > 11 and DW_needed <= 31 then
				classes.CustomMeleeGroups:append('MidHaste')
			elseif DW_needed > 31 and DW_needed <= 42 then
				classes.CustomMeleeGroups:append('LowHaste')
			elseif DW_needed > 42 then
				classes.CustomMeleeGroups:append('')
			end
	end
end

function job_self_command(cmdParams, eventArgs)
    gearinfo(cmdParams, eventArgs)
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



function update_active_abilities()
    state.Buff['Burst Affinity'] = buffactive['Burst Affinity'] or false
    state.Buff['Efflux'] = buffactive['Efflux'] or false
    state.Buff['Diffusion'] = buffactive['Diffusion'] or false
end

-- State buff checks that will equip buff gear and mark the event as handled.
function apply_ability_bonuses(spell, action, spellMap)
    if state.Buff['Burst Affinity'] and (spellMap == 'Magical' or spellMap == 'MagicalLight' or spellMap == 'MagicalDark' or spellMap == 'Breath') then
        if state.MagicBurst.value then
            equip(sets.magic_burst)
        end
        equip(sets.buff['Burst Affinity'])
    end
    if state.Buff.Efflux and spellMap == 'Physical' then
        equip(sets.buff['Efflux'])
    end
    if state.Buff.Diffusion and (spellMap == 'Buffs' or spellMap == 'BlueSkill') then
        equip(sets.buff['Diffusion'])
    end

    if state.Buff['Burst Affinity'] then equip (sets.buff['Burst Affinity']) end
    if state.Buff['Efflux'] then equip (sets.buff['Efflux']) end
    if state.Buff['Diffusion'] then equip (sets.buff['Diffusion']) end
end

-- Check for various actions that we've specified in user code as being used with TH gear.
-- This will only ever be called if TreasureMode is not 'None'.
-- Category and Param are as specified in the action event packet.
function th_action_check(category, param)
    if category == 2 or -- any ranged attack
        --category == 4 or -- any magic action
        (category == 3 and param == 30) or -- Aeolian Edge
        (category == 6 and info.default_ja_ids:contains(param)) or -- Provoke, Animated Flourish
        (category == 14 and info.default_u_ja_ids:contains(param)) -- Quick/Box/Stutter Step, Desperate/Violent Flourish
        then return true
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
    end
)

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
	set_macro_page(1, 10)
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset ' .. lockstyleset)
end