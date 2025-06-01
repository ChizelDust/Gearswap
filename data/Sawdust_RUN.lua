-- Original (NIN): Motenten / Modified (NIN): Arislan / Ported for RUN: Sawdust
-- Haste/DW Detection Requires Gearinfo Addon

-------------------------------------------------------------------------------------------------------------------
--  Keybinds (PLD)
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F9 ]              Cycle Offense Modes (Normal, PhysTanking, MagicTanking, Acc)
--              [ CTRL+F9 ]         Cycle Hybrid Modes (Normal, DT)
--              [ WIN+F9 ]          Cycle Weapon Skill Modes (Normal, Acc)
--              [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ CTRL+F11 ]        Cycle Casting Modes (Normal, SIRD)
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes (Normal, PDT, MDT)
--              [ ALT+F12 ]         Cancel Emergency PDT/MDT Mode
--              [ CTRL+` ]          Toggle Treasure Hunter Mode
--              [ ALT+` ]           Toggle Magic Burst Mode
--              [ WIN+C ]           Toggle Capacity Points Mode
-------------------------------------------------------------------------------------------------------------------
--  Abilities:  [ CTRL+- ]          Sentinel			[ WIN+9 ]			Flash			[ CTRL+. ]			Fealty			[ ALT+, ]			Shield Bash
--              [ CTRL+= ]          Palisade			[ CTRL+, ]			Chivalry		[ CTRL+/ ]			Majesty			[ ALT+. ]			Cover
--				
--				/WAR:									/BLU:
--              [ CTRL+Numlock ]    Berserk				[ CTRL+Numlock ]    Cocoon
--				[ ALT+Numlock ]		Defender			[ ALT+Numlock ]		Healing Breeze
--              [ CTRL+Numpad/ ]    Provoke				[ CTRL+Numpad/ ]    Wild Carrot
--              [ CTRL+Numpad* ]    Warcry				[ CTRL+Numpad* ]    Refueling
--				[ CTRL+Numpad- ]    Aggressor
-------------------------------------------------------------------------------------------------------------------
--  Spells:		Ninja									Paladin								Blue Mage
--				[ WIN+, ]           Utsusemi: Ichi		[ CTRL+Numpad+ ]	Cure IV			[ CTRL+9 ]			Blank Gaze
--              [ WIN+. ]           Utsusemi: Ni		[ ALT+Numpad+ ]		Phalanx			[ CTRL+0 ]			Jettatura
--														[ CTRL+Numpad0 ]	Reprisal		[ ALT+9 ]			Sheep Song
--														[ ALT+Numpad0 ]		Crusade			[ ALT+0 ]			Geist Wall
--														[ WIN+Numpad+ ]		Enlight
-------------------------------------------------------------------------------------------------------------------				
--  WS:         [ CTRL+Numpad7 ]    Judgement			[ CTRL+Numpad8 ]    Black Halo		[ CTRL+Numpad9 ]    Aeolian Edge
--              [ CTRL+Numpad4 ]    Sanguine Blade		[ CTRL+Numpad5 ]    KotR			[ CTRL+Numpad6 ]    Requiescat
--              [ CTRL+Numpad1 ]    Atonement			[ CTRL+Numpad2 ]    CDC				[ CTRL+Numpad3 ]    Savage Blade
--
--
--              (Global-Binds.lua contains additional non-job-related keybinds)


-------------------------------------------------------------------------------------------------------------------
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
    state.Buff.Doom = buffactive.doom or false
	-- Buffs using gear FOR DURATION
    state.Buff.Pflug = buffactive.Pflug or false				--Runeist Bottes +2 (AF): For duration

    no_swap_gear = 	S{"Warp Ring", "Dim. Ring (Dem)", "Reraise Earring", "Nexus Cape"}

    include('Mote-TreasureHunter')

    -- For th_action_check():
    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{35, 204}
    -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
    info.default_u_ja_ids = S{201, 202, 203, 205, 207}

    lockstyleset = 23
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal','Parry','Magic','DPS','Phalanx','Dynamis')
    state.HybridMode:options('Normal')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'SIRD')
    state.IdleMode:options('Normal','Phalanx','Turtle','Magical','Dynamis')
    state.PhysicalDefenseMode:options('DEF','BlockRate')

    state.WeaponSet = M{['description']='Weapon Set','Aettir','AettirDPS','FullBreak','FellCleave','Naegling','Malignance','Regain','Onion','Staff'}
    state.WeaponLock = M(false, 'Weapon Lock')
    state.MagicBurst = M(false, 'Magic Burst')
    state.CP = M(false, "Capacity Points Mode")
	
	-- Appearance
	-- send_command('du self race elvaan male')
	-- send_command('du self face 4b')

    options.ninja_tool_warning_limit = 10

    -- Additional local binds
	include('Chizel_Global_Binds.lua')
    -- include('Global-GEO-Binds.lua') -- OK to remove this line

    send_command('bind @t gs c cycle treasuremode')
    send_command('bind !` gs c toggle MagicBurst')

	--WeaponCycle
    send_command('bind @w gs c toggle WeaponLock')
    send_command('bind @c gs c toggle CP')
    send_command('bind @e gs c cycleback WeaponSet')
    send_command('bind @r gs c cycle WeaponSet')
	
	--Job Commands
	send_command('bind ^- input /ja "Tenebrae" <me>')
	send_command('bind !- input /ja "Lux" <me>')
	send_command('bind ^[ input /ja "Gambit" <t>')
	send_command('bind ^] input /ja "Rayke" <t>')
	send_command('bind @- input //aset set sblu-tank')

	send_command('bind ^, input /ma "Regen IV" <me>')
	send_command('bind ^. input /ma "Crusade" <me>')
	send_command('bind ^/ input /ma "Phalanx" <me>')
	send_command('bind ^numpad+ input /ma "Flash" <stnpc>')
	send_command('bind !numpad+ input /ma "Foil" <me>')

	--Subjob Commands
    if player.sub_job == 'WAR' then
		send_command('bind ^numpad/ input /ja "Provoke" <stnpc>')
		send_command('bind ^numpad* input /ja "Warcry" <me>')
		send_command('bind ^numpad- input /ja "Defender" <me>')
	elseif player.sub_job == 'SAM' then
		send_command('bind ^numpad/ input /ja "Hasso" <me>')
		send_command('bind ^numpad* input /ja "Meditate" <me>')
		send_command('bind ^numpad- input /ja "Sekkanoki" <me>')
		send_command('bind !numpad/ input /ja "Seigan" <me>')
		send_command('bind !numpad* input /ja "Third Eye" <me>')
	elseif player.sub_job == 'BLU' then
		send_command('bind ^numpad/ input /ma "Frightful Roar" <stnpc>')
		send_command('bind ^numpad* input /ma "Geist Wall" <stnpc>')
		send_command('bind ^numpad- input /ma "Jettatura" <stnpc>')
		send_command('bind !. input /ja "Burst Affinity" <me>')
    end
	
	--Weaponskills
	
    send_command('bind ^numpad0 gs c use Alternate')
    send_command('bind ^numpad1 input /ws "Dimidiation" <t>')
    send_command('bind ^numpad2 input /ws "Resolution" <t>')
    send_command('bind ^numpad3 input /ws "Herculean Slash" <t>')
    send_command('bind ^numpad4 input /ws "Ground Strike" <t>')
	send_command('bind ^numpad5 input /ws "Shockwave" <t>')
	send_command('bind ^numpad6 input /ws "Upheaval" <t>')
	send_command('bind ^numpad7 input /ws "Steel Cyclone" <t>')
	send_command('bind ^numpad8 input /ws "Armor Break" <t>')
	send_command('bind ^numpad9 input /ws "Fell Cleave" <t>')
	
	send_command('bind ^insert input /ja "Tellus" <me>')			--CTRL+Insert
	send_command('bind ^home input /ja "Flabra" <me>')				--CTRL+Delete
	send_command('bind ^pageup input /ja "Gelus" <me>')				--CTRL+Home
	send_command('bind ^pagedown input /ja "Ignis" <me>')			--CTRL+End
	send_command('bind ^end input /ja "Unda" <me>')					--CTRL+PgUP
	send_command('bind ^delete input /ja "Sulpor" <me>')			--CTRL+PgDN
	
	send_command('bind @insert input /ma "Barthunder" <me>')		--WIN+Insert
	send_command('bind @home input /ma "Barstone" <me>')			--WIN+Delete
	send_command('bind @pageup input /ma "Baraero" <me>')			--WIN+Home
	send_command('bind @pagedown input /ma "Barblizzard" <me>')		--WIN+End
	send_command('bind @end input /ma "Barfire" <me>')				--WIN+PgUP
	send_command('bind @delete input /ma "Barwater" <me>')			--WIN+PgDN
	
	send_command('bind !insert input /ma "Barpetrify" <me>')		--ALT+Insert
	send_command('bind !home input /ma "Barsleep" <me>')			--ALT+Delete
	send_command('bind !pageup input /ma "Barsilence" <me>')		--ALT+Home
	send_command('bind !pagedown input /ma "Barparalyze" <me>')		--ALT+End
	send_command('bind !end input /ma "Baramnesia" <me>')			--ALT+PgUP
	send_command('bind !delete input /ma "Barpoison" <me>')			--ALT+PgDN
	
	send_command('bind @m input /mount "Ixion"')

    -- Whether a warning has been given for low ninja tools
    state.warned = M(false)

    select_default_macro_book()
    set_lockstyle()

    state.Auto_Kite = M(false, 'Auto_Kite')
    Haste = 0
    DW_needed = 0
    DW = false
    moving = false
    update_combat_form()
end

function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind ^-')
	send_command('unbind @-')
	send_command('unbind @p')
	send_command('unbind @y')
	send_command('unbind @s')
	send_command('unbind @h')
    send_command('unbind ^=')
    send_command('unbind @/')
    send_command('unbind @w')
    -- send_command('unbind @c')
    send_command('unbind @e')
    send_command('unbind @r')
    send_command('unbind @t')
	send_command('unbind ^[')
	send_command('unbind ^]')
	send_command('unbind ^,')
	send_command('unbind ^.')
	send_command('unbind ^/')
	send_command('unbind !,')
	send_command('unbind !.')
	send_command('unbind !/')
    send_command('unbind ^numlock')
    send_command('unbind !numlock')
    send_command('unbind ^numpad/')
    send_command('unbind !numpad/')
	send_command('unbind !numpad*')
    send_command('unbind ^numpad*')
    send_command('unbind ^numpad-')
    send_command('unbind ^numpad+')
    send_command('unbind !numpad+')
    send_command('unbind ^numpad9')
    send_command('unbind ^numpad8')
    send_command('unbind ^numpad7')
    send_command('unbind ^numpad6')
    send_command('unbind ^numpad5')
    send_command('unbind ^numpad4')
	send_command('unbind ^numpad3')
	send_command('unbind ^numpad2')
	send_command('unbind ^numpad1')
	send_command('unbind ^numpad0')
	
	send_command('unbind ^insert')
	send_command('unbind ^home')
	send_command('unbind ^pageup')
	send_command('unbind ^pagedn')
	send_command('unbind ^end')
	send_command('unbind ^delete')	
	send_command('unbind @insert')
	send_command('unbind @home')
	send_command('unbind @pageup')
	send_command('unbind @pagedn')
	send_command('unbind @end')
	send_command('unbind @delete')
	send_command('unbind !insert')
	send_command('unbind !home')
	send_command('unbind !pageup')
	send_command('unbind !pagedn')
	send_command('unbind !end')
	send_command('unbind !delete')
	
	send_command('unbind @m')
	
	-- Appearance Clear
	-- send_command('du clear self')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Precast sets
    --------------------------------------

--ENMITY SETS--
    sets.Enmity = {
		ammo="Sapience Orb",				-- +2
		head="Halitus Helm",				-- +8
		body="Emet Harness +1",				-- +10
		hands="Futhark Mitons +1",			-- +6
		legs="Erilaz Leg Guards +2",		-- +12
		feet="Ahosi Leggings",				-- +7
		neck="Moonbeam Necklace",			-- +10
		ear1="Friomisi Earring",			-- +2
		-- ear2="Trux Earring",				-- +5
		ring1="Vengeful Ring",				-- +3
		ring2="Provocare Ring",				-- +5
		back="Ogma's Cape",					-- +10
	} -- Enmity (with Aettir: +85, with Epeolatry: +98)

    sets.precast.JA['Provoke'] = sets.Enmity																				-- Base: 1/1800 * 1.79 (1/3222)
	sets.precast.JA['Warcry'] = sets.Enmity																					-- Base: 0/320 * 1.79 (0/572)
	sets.precast.JA['Pflug'] = sets.Enmity																					-- Base: 450/900 * 1.79 (805/1611)
	sets.precast.JA['Valiance'] = set_combine(sets.Enmity, {body="Runeist Coat +2",})										-- Base: 450/900 * 1.69 (760/1521)
	sets.precast.JA['Vallation'] = sets.precast.JA['Valiance']																-- Base: 450/900 * 1.69 (760/1521)
	sets.precast.JA['Swordplay'] = sets.Enmity																				-- Base: 160/320 * 1.79 (286/572)
	sets.precast.JA['Elemental Sforzo'] = set_combine(sets.Enmity, {body="Futhark Coat +1"})								-- Base: 0/7200 * 1.69 (0/12168)
	sets.precast.JA['Burst Affinity'] = sets.Enmity																			-- Base: 1/300 * 1.79 (1/537)
	
--RUN JOB ABILITIES--
	sets.precast.JA['Gambit'] = {feet = "Runeist Mitons +2"}

-- Fast cast sets for spells

    sets.precast.FC = {
		ammo="Sapience Orb", 				--2
		head="Runeist Bandeau +2", 			--12
		body="Erilaz Surcoat +2",			--10
		hands="Agwu's Gloves",				--6
		legs="Agwu's Slops",				--7
		feet="Agwu's Pigaches",				--4 "Carmine Greaves +1"
		neck="Voltsurge Torque",			--4
		ear1="Odnowa Earring +1",
		ear2="Etiolation Earring",			--1
		ring1="Kishar Ring",				--4
		ring2="Moonbeam Ring",
		back="Solemnity Cape",
		waist="Shinjutsu-no-Obi +1",		--4*
		} 	-- FC +54/RC +27
	
	sets.precast['Enhancing Magic'] = set_combine(sets.precast.FC, {
		neck="Moonbeam Necklace",			--"Unmoving Collar +1" with RP
		ear1="Loquacious Earring",			--2
		legs="Futhark Trousers +2",			--14
		waist="Siegel Sash",				--Enh. Cast Time -8
		}) 	-- FC +63/RC +31
		
	sets.precast.FC.Val = set_combine(sets.precast.FC, {
		ammo="Staunch Tathlum",				-- (-2)
		body="Nyame Mail",					-- (-8)
		legs="Futhark Trousers +2",			-- (-7)
		neck="Loricate Torque +1",			-- (-4)
		ear2="Eabani Earring",				-- (-1)
		ring1="Warden's Ring",
		waist="Carrier's Sash",
		})	-- FC +30/RC +15 (Inspiration FC +80/RC +65)
		
	sets.precast.FC.ValEnhancing = set_combine(sets.precast.FC.Val, {
		}) 	-- FC +30/RC +15 (Inspiration FC +80/RC +65)
		
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {}) --FC 54%, Cure Cast Time -21% (FC 75%), 2927 HP		
	sets.precast.FC.CureSelf = set_combine(sets.precast.FC, {}) --FC 58%, Cure Cast Time -17% (FC  75%), 2020 HP

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		ammo="Knobkierrie",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Eri. Leg Guards +2",
		feet="Nyame Sollerets",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		ear1="Sherida Earring",
		ear2="Moonshade Earring",
		ring1="Shukuyu Ring",
		ring2="Epaminondas's Ring",
		back="Vespid Mantle",
		}
	
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {
		ring1="Rufescent Ring",
		})
		
	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
		neck="Combatant's Torque",
		waist="Sailfi Belt +1",
		})
	
	sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS['Savage Blade'], sets.precast.WS.Acc)

    sets.precast.WS['Dimidiation'] = set_combine(sets.precast.WS, {
		ammo="Coiste Bodhar",
		ring1="Niqmaddu Ring",
		})
	
	sets.precast.WS['Dimidiation'].Acc = set_combine(sets.precast.WS['Dimidiation'], sets.precast.WS.Acc)
	
	sets.precast.WS['Resolution'] = sets.precast.WS['Savage Blade']
	sets.precast.WS['Resolution'].Acc = sets.precast.WS['Savage Blade'].Acc
	
	sets.precast.WS['Herculean Slash'] = set_combine(sets.precast.WS, {
		ammo="Yamarang",
		hands="Nyame Gauntlets",
		neck="Sanctity Necklace",
		waist="Eschan Stone",
		ear1="Digni. Earring",
		ear2="Erilaz Earring +1",
		ring1="Stikini Ring",
		ring2="Stikini Ring",
		back="Relucent Cape",
		})
	
	sets.precast.WS['Ground Strike'] = sets.precast.WS['Savage Blade']
	sets.precast.WS['Ground Strike'].Acc = sets.precast.WS['Savage Blade'].Acc
	
	sets.precast.WS['Shockwave'] = sets.precast.WS['Savage Blade']
	sets.precast.WS['Shockwave'].Acc = sets.precast.WS['Savage Blade'].Acc
	
	sets.precast.WS['Upheaval'] = set_combine(sets.precast.WS, {
		ammo="Coiste Bodhar",
		neck="Unmoving Collar +1",
		waist="Sailfi Belt +1",
		ear1="Sherida Earring",
		ear2="Moonshade Earring",
		ring1="Niqmaddu Ring",
		})
	
	sets.precast.WS['Upheaval'].Acc = set_combine(sets.precast.WS['Upheaval'], sets.precast.WS.Acc)	
	
	sets.precast.WS['Steel Cyclone'] = sets.precast.WS['Savage Blade']
	sets.precast.WS['Steel Cyclone'].Acc = sets.precast.WS['Savage Blade'].Acc
	
	sets.precast.WS['Armor Break'] = sets.precast.WS['Savage Blade']
	sets.precast.WS['Armor Break'].Acc = sets.precast.WS['Savage Blade'].Acc
	
	sets.precast.WS['Fell Cleave'] = sets.precast.WS['Savage Blade']
	sets.precast.WS['Fell Cleave'].Acc = sets.precast.WS['Savage Blade'].Acc	

    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = sets.precast.FC
	sets.midcast.FCInspiration = set_combine(sets.precast.FC, {legs="Futhark Trousers +2"})
		
    sets.midcast.SpellInterrupt = set_combine(sets.Idle, {
		head="Erilaz Galea +2",				--SIRD 150/1024
		body=gear.Taeon_Phalanx_body,		--SIRD 100/1024
		hands=gear.Taeon_Phalanx_hands,		--SIRD 40/1024
		legs=gear.Taeon_Phalanx_legs,		--SIRD 50/1024
		feet=gear.Taeon_Regen_feet,			--SIRD 70/1024
		neck="Moonbeam Necklace",			--SIRD 100/1024
		ear1="Halasz Earring",				--SIRD 50/1024
		ear2="Magnetic Earring",			--SIRD 80/1024
											--SIRD 50/1024 "Evanescence Ring",
											--SIRD 100/1024 "Audumbla Sash",
											--SIRD 100/1024 gear.RUN_FC_cape,
		}) 	--SIRD 740/1024 (72.2%)
		
	sets.midcast.Cure = set_combine(sets.midcast.SpellInterrupt, {}) 	--3089 HP
	sets.midcast.CureSelf = set_combine(sets.Enmity, {}) --HP 3610, CP1 +50%, CPR +30%, Enmity +64 (Srivatsa), DT -50 (Srivatsa), PDT2 -18, SIRD -40
		
    -- Specific spells
	
    sets.midcast.Utsusemi = set_combine(sets.midcast.SpellInterrupt, {
		body="Passion Jacket",
		neck="Magoraga Beads",
		})
		
	-- Enhancing Magic	
	sets.midcast['Enhancing Magic'] = set_combine(sets.midcast.SpellInterrupt, {
		ammo="Staunch Tathlum",
		head="Erilaz Galea +2",
		body="Nyame Mail",
		hands="Runeist Mitons +2",
		legs="Futhark Trousers +2",
		neck="Incanter's Torque",
		ring2="Stikini Ring",
		waist="Olympus Sash",
		})
		
	sets.midcast['Regen IV'] = set_combine(sets.midcast['Enhancing Magic'], {
		head="Runeist Bandeau +2",		--Regen Dur. +24
		body=gear.Taeon_Regen_body,		--Regen +3
										--Regen +10, Regen Dur. +20% "Regal Gauntlets"
		feet=gear.Taeon_Regen_feet,		--Regen +3
		neck="Sacro Gorget",			--Regen Pot. +10% 
		ear2="Erilaz Earring +1",		--Regen +10
		waist="Sroda Belt",				--Regen Pot. +20%, Regen Dur. +15
		})-- Regen 60HP/Tick, Duration ~2 min (118 sec)
		
	sets.midcast['Phalanx'] = set_combine(sets.midcast['Enhancing Magic'], {
		head="Futhark Bandeau +1",
		body=gear.Taeon_Phalanx_body,
		hands=gear.Taeon_Phalanx_hands,
		legs=gear.Taeon_Phalanx_legs,
		feet=gear.Taeon_Phalanx_feet,
		}) --Phalanx +15
	
	-- Enmity
	
	sets.midcast['Flash'] = sets.Enmity							-- 3225 HP, 471/3353
	sets.midcast['Foil'] = sets.Enmity
	
		
	sets.midcast['Blue Magic'] = sets.midcast.SpellInterrupt	-- 3230 HP
	
	-- Blue Magic Enmity: 	Geist Wall, Soporific, Sheep Song, Blank Gaze (672/672)
	--						Frightful Roar, Chaotic Eye (1/672)
	--						Jettatura (378/2142)
		

    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------

    -- Resting sets
--    sets.resting = {}

    -- Idle sets
	sets.idle = {
		ammo="Staunch Tathlum",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Loricate Torque +1",
		waist="Ioskeha Belt +1",
		ear1="Odnowa Earring +1",
		ear2="Erilaz Earring +1",
		ring1="Warden's Ring",
		ring2="Moonbeam Ring",
		back="Shadow Mantle",
		} -- 3205 HP
		
	sets.idle.Phalanx = set_combine(sets.midcast['Phalanx'], {
		waist="Gishdubar Sash",
		})

	sets.idle.Turtle = set_combine(sets.idle, {}) -- 3179 HP		
	sets.idle.Magical = set_combine(sets.idle, {}) -- 3033 HP
	sets.idle.Dynamis = set_combine(sets.idle, {neck="Futhark Torque +1",})
		
    -- Defense sets
    sets.defense.PDT = sets.idle.PDT
    sets.defense.MDT = sets.idle.MDT

    sets.Kiting = {ring2="Shneddick Ring", back="Shadow Mantle"}	-- 3028 HP, DT -50, PDT2 -18, DEF: 1728

    --------------------------------------
    -- Engaged sets
    --------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
	
    sets.engaged = {
		ammo="Staunch Tathlum",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Erilaz Leg Guards +2",
		feet="Nyame Sollerets",
		neck="Loricate Torque +1",
		waist="Ioskeha Belt +1",
		ear1="Odnowa Earring +1",
		ear2="Erilaz Earring +1",
		ring1="Warden's Ring",
		ring2="Moonbeam Ring",
		back="Shadow Mantle",
		}
	
	sets.engaged.Parry = set_combine(sets.engaged, {
		hands="Turms Mitts",
		neck="Combatant's Torque",
		})
		
	sets.engaged.Magic = set_combine(sets.engaged, {
		feet="Erilaz Greaves +2",
		neck="Warder's Charm +1",
		ear1="Eabani Earring",
		ring2="Shadow Ring",
		})
		
	sets.engaged.DPS = set_combine(sets.engaged, {
		ammo="Coiste Bodhar",
		head="Aya. Zucchetto +1",
		body="Ayanmo Corazza +2",
		hands="Nyame Gauntlets",
		feet="Erilaz Greaves +2",
		neck="Anu Torque",
		waist="Ioskeha Belt +1",
		ear1="Sherida Earring",
		ear2="Digni. Earring",
		ring1="Petrov Ring",
		ring2="Moonbeam Ring",
		back="Relucent Cape",
		})
		
	sets.engaged.Phalanx = sets.midcast['Phalanx']
	sets.engaged.Dynamis = set_combine(sets.engaged, {neck="Futhark Torque +1",})

    --------------------------------------
    -- Custom buff sets
    --------------------------------------
	-- CHANGE THESE TO RUN JAs --
    sets.buff.Pflug = {feet="Runeist Bottes +2"}
	sets.buff.Battuta = {}

    sets.buff.Doom = {
		neck="Nicander's Necklace",
		ring2="Purity Ring",
		}
		
    sets.TreasureHunter = {} -- 3196 HP
    sets.CP = {back="Mecisto. Mantle"}

	sets.latent_refresh = {waist="Fucho-no-Obi"} -- 3190 HP
		
    -- sets.Reive = {neck="Ygnas's Resolve +1"}

	sets.Aettir = {main="Aettir", sub="Refined Grip +1"}
	sets.AettirDPS = {main="Aettir", sub="Utu Grip"}
	sets.FullBreak = {main="Hepatizon Axe +1", sub="Refined Grip +1"}
	sets.FellCleave = {main="Lycurgos", sub="Utu Grip"}
	sets.Naegling = {main="Naegling", sub="Regis"}
	sets.Malignance = {main="Malignance Sword", sub="Regis"}
	sets.Regain = {main="Reikiko", sub="Regis"}
	sets.Onion = {main="Onion Sword III", sub="Reikiko"}
	sets.Staff = {main="Gozuki Mezuki", sub="Utu Grip"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_post_precast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Magic' then
        if buffactive['Vallation'] or buffactive['Valiance'] then
            if spell.skill == 'Enhancing Magic' then
                equip(sets.precast.FC.ValEnhancing)
            else equip(sets.precast.FC.Val)
            end
        elseif spell.skill == 'Enhancing Magic' then
            equip(sets.precast['Enhancing Magic'])
        end
    end
    ----JAs that do not overwrite-----
    if spell.name == 'Valiance' or spell.name == 'Vallation' or spell.name == 'Liement' then
        if buffactive['Valiance']  then
            cast_delay(0.2)
            windower.ffxi.cancel_buff(535)
        elseif buffactive['Vallation']  then
            cast_delay(0.2)
            windower.ffxi.cancel_buff(531)
        elseif buffactive['Liement'] then
            cast_delay(0.2)
            windower.ffxi.cancel_buff(537)
        end
    end
	if spellMap == 'Cure' and spell.target.type == 'SELF' then
		equip(sets.precast.FC.CureSelf)
	end
	if spell.name == 'Spectral Jig' and buffactive.sneak then
		windower.ffxi.cancel_buff(71)
	end
end

-- Run after the general midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Blue Magic' then
		if 	state.CastingMode.value == "SIRD" and (buffactive['Vallation'] or buffactive['Valiance']) then
			equip(sets.midcast.FCInspiration)
		elseif state.CastingMode.value == "SIRD" then
			equip(sets.midcast.SpellInterrupt)
			return
		end
	end
	if spellMap == 'Cure' and spell.target.type == 'SELF' then
		equip(sets.midcast.CureSelf)
	end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
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
function job_buff_change(buff, gain)
   -- if buffactive['Reive Mark'] then
       -- if gain then
           -- equip(sets.Reive)
           -- disable('neck')
       -- else
           -- enable('neck')
       -- end
   -- end

	if buff == "doom" then
        if gain then
            equip(sets.buff.Doom)
            send_command('@input /p Doomed.')
            disable('body','hands','legs','ear1','back','neck','ring1','ring2','waist')
        else
            enable('body','hands','legs','ear1','back','neck','ring1','ring2','waist')
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
    -- determine_haste_group()
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

function get_custom_wsmode(spell, action, spellMap)
    local wsmode
    if state.OffenseMode.value == 'Acc' then
        wsmode = 'Acc'
    end

    return wsmode
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if state.Buff.Pflug then
       idleSet = set_combine(idleSet, sets.buff.Pflug)
    end
	if state.CP.current == 'on' then
		equip(sets.CP)
        disable('back')
    else
        enable('back')
    end
	if player.mp < 488 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end	
	if state.Auto_Kite.value == true then
       idleSet = set_combine(idleSet, sets.Kiting)
    end
    -- if state.CP.current == 'on' then
    --     equip(sets.CP)
    --     disable('back')
    -- else
    --     enable('back')
    -- end

    return idleSet
end


-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.Buff.Pflug then
        meleeSet = set_combine(meleeSet, sets.buff.Pflug)
    end
	if state.Buff.Battuta then
		meleeSet = set_combine(meleeSet, sets.buff.Battuta)
	end
    if state.TreasureMode.value == 'Fulltime' then
        meleeSet = set_combine(meleeSet, sets.TreasureHunter)
    end

    check_weaponset()

    return meleeSet
end


-- Function to display the current relevant user state when doing an update.
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

function check_moving()
    if state.DefenseMode.value == 'None'  and state.Kiting.value == false then
        if state.Auto_Kite.value == false and moving then
            state.Auto_Kite:set(true)
        elseif state.Auto_Kite.value == true and moving == false then
            state.Auto_Kite:set(false)
        end
    end
end

function job_self_command(cmdParams, eventArgs)
    gearinfo(cmdParams, eventArgs)
	if cmdParams[1]=="use" then
        --[[
        dagger          = 2
        sword           = 3
        ]]
        if cmdParams[2] == 'Alternate' then
            if player.equipment.main ~= 'empty' and player.equipment.main == 'Onion Sword III' then
                send_command('input /ws "Fast Blade II" <t>')
            elseif player.equipment.main ~= 'empty' and player.equipment.main == 'Naegling' then
                send_command('input /ws "Savage Blade" <t>')
            end
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
-- Determine whether we have sufficient tools for the spell being attempted.
function do_ninja_tool_checks(spell, spellMap, eventArgs)
    local ninja_tool_name
    local ninja_tool_min_count = 1

    -- Only checks for universal tools and shihei
    if spell.skill == "Ninjutsu" then
        if spellMap == 'Utsusemi' then
            ninja_tool_name = "Shihei"
        else
            return
        end
    end

    local available_ninja_tools = player.inventory[ninja_tool_name] or player.wardrobe[ninja_tool_name]

    -- If no tools are available, end.
    if not available_ninja_tools then
        if spell.skill == "Ninjutsu" then
            return
        end
    end

    -- Low ninja tools warning.
    if spell.skill == "Ninjutsu" and state.warned.value == false
        and available_ninja_tools.count > 1 and available_ninja_tools.count <= options.ninja_tool_warning_limit then
        local msg = '*****  LOW TOOLS WARNING: '..ninja_tool_name..' *****'
        --local border = string.repeat("*", #msg)
        local border = ""
        for i = 1, #msg do
            border = border .. "*"
        end

        add_to_chat(104, border)
        add_to_chat(104, msg)
        add_to_chat(104, border)

        state.warned:set()
    elseif available_ninja_tools.count > options.ninja_tool_warning_limit and state.warned then
        state.warned:reset()
    end
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

function check_gear()
	if no_swap_gear:contains(player.equipment.ear2) then
		disable("ear2")
	else
		enable("ear2")
	end
	if no_swap_gear:contains(player.equipment.ear1) then
		disable("ear1")
	else
		enable("ear1")
	end
    if no_swap_gear:contains(player.equipment.ring2) then
        disable("ring2")
    else
        enable("ring2")
    end
if no_swap_gear:contains(player.equipment.ring1) then
        disable("ring1")
    else
        enable("ring1")
    end
	if no_swap_gear:contains(player.equipment.back) then
		disable("back")
	else
		enable("back")
	end	
end

function check_weaponset()
    equip(sets[state.WeaponSet.current])
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
    if player.sub_job == 'WAR' then
        set_macro_page(1, 3)
    elseif player.sub_job == 'BLU' then
        set_macro_page(2, 3)
    elseif player.sub_job == 'SCH' then
        set_macro_page(3, 3)
	elseif player.sub_job == 'WHM' then
		set_macro_page(4, 3)
	elseif player.sub_job == 'SAM' then
		set_macro_page(5, 3)
	elseif player.sub_job == 'DRK' then
		set_macro_page(6, 3)
    end
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset ' .. lockstyleset)
end