-- Original (NIN): Motenten / Modified (NIN): Arislan / Ported for PLD: Chizel
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
    state.Buff.Sentinel = buffactive.Sentinel or false
    state.Buff.Doom = buffactive.doom or false
    state.Buff.Rampart = buffactive.Rampart or false
    state.Buff.Fealty = buffactive.Fealty or false
    state.Buff.Palisade = buffactive.Palisade or false
	state.Buff.Cover = buffactive.Cover or false

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
    state.OffenseMode:options('Normal','ShieldSkill','Magic','DPS','Phalanx')
    state.HybridMode:options('Normal')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'SIRD')
    state.IdleMode:options('Normal','Phalanx','Refresh','Shield','Magical','AzureAilments')
    state.PhysicalDefenseMode:options('DEF','BlockRate')

    state.WeaponSet = M{['description']='Weapon Set','BurtSrivatsa','BurtAegis','BurtDuban','AzureAilments','ExcalSrivatsa','ExcalAegis','ExcalDuban','ExcalPriwen','CalibSrivatsa',
	'CalibAegis','CalibDuban','DPS','ShiningOne','Cataclysm','Aeolian'}
    state.WeaponLock = M(false, 'Weapon Lock')
    state.MagicBurst = M(false, 'Magic Burst')
    -- state.CP = M(false, "Capacity Points Mode")
	
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
    send_command('bind @e gs c cycleback WeaponSet')
    send_command('bind @r gs c cycle WeaponSet')
	
	--Job Commands
	send_command('bind ^- input /ja "Majesty" <me>')
	send_command('bind @- input //aset set sblu-tank')

	send_command('bind ^, input /ma "Protect V" <stal>')
	send_command('bind ^. input /ma "Crusade" <me>')
	send_command('bind ^/ input /ma "Phalanx" <me>')
	send_command('bind ^numpad+ input /ma "Flash" <stnpc>')
	send_command('bind !numpad/ input /ma "Banishga" <stnpc>')

	--Subjob Commands
    if player.sub_job == 'WAR' then
		send_command('bind ^numpad/ input /ja "Provoke" <stnpc>')
		send_command('bind ^numpad* input /ja "Warcry" <me>')
		send_command('bind ^numpad- input /ja "Defender" <me>')
	elseif player.sub_job == 'BLU' then
		send_command('bind ^numpad/ input /ma "Frightful Roar" <stnpc>')
		send_command('bind ^numpad* input /ma "Geist Wall" <stnpc>')
		send_command('bind ^numpad- input /ma "Jettatura" <stnpc>')
		send_command('bind !. input /ja "Burst Affinity" <me>')
	elseif player.sub_job == 'RUN' then
		send_command('bind ^numpad/ input /ja "Swordplay" <me>')
		send_command('bind ^numpad* input /ja "Pflug" <me>')
		send_command('bind ^numpad- input /ja "Valiance" <me>')
		send_command('bind !numpad- input /ja "Vallation" <me>')
		send_command('bind !numpad+ input /ma "Foil" <me>')
	elseif player.sub_job == 'RDM' then
		send_command('bind ^numpad/ input /ma "Stoneskin" <me>')
		send_command('bind ^numpad* input /ma "Aquaveil" <me>')
		send_command('bind ^numpad- input /ma "Refresh" <stpt>')
		send_command('bind !numpad+ input /ma "Diaga" <stnpc>')
	elseif player.sub_job == 'DRG' then
		send_command('bind ^numpad/ input /ja "Jump" <t>')
		send_command('bind ^numpad* input /ja "High Jump" <t>')
		send_command('bind ^numpad- input /ja "Super Jump" <me>')
    end
	
	--Weaponskills
	
    send_command('bind ^numpad0 input /ws "Savage Blade" <t>')
    send_command('bind ^numpad1 input /ws "Chant du Cygne" <t>')
    send_command('bind ^numpad2 input /ws "Sanguine Blade" <t>')
    send_command('bind ^numpad3 input /ws "Requiescat" <t>')
    send_command('bind ^numpad4 input /ws "Knights of Round" <t>')
	send_command('bind ^numpad5 input /ws "Atonement" <t>')
	send_command('bind ^numpad6 input /ws "Flat Blade" <t>')
	send_command('bind ^numpad7 input /ws "Impulse Drive" <t>')
	send_command('bind ^numpad8 input /ws "Cataclysm" <t>')
	send_command('bind ^numpad9 input /ws "Aeolian Edge" <t>')
	
	send_command('bind @m input /mount "Hippogryph"')

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
	
	send_command('unbind @m')

    send_command('unbind #`')
    send_command('unbind #1')
    send_command('unbind #2')
    send_command('unbind #3')
    send_command('unbind #4')
    send_command('unbind #5')
    send_command('unbind #6')
    send_command('unbind #7')
    send_command('unbind #8')
    send_command('unbind #9')
    send_command('unbind #0')
	
	-- Appearance Clear
	-- send_command('du clear self')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Precast sets
    --------------------------------------

    sets.Enmity = {
		ammo="Sapience Orb",						--	 	+2
		head="Loess Barbuta +1",					-- 		+24
		neck="Unmoving Collar +1",					--		+10
		ear1="Cryptic Earring",						--		+4
		ear2="Trux Earring",						--		+5
		body="Souveran Cuirass +1",					--		+20
		hands=gear.Souveran_Enmity_Hands,			--		+9
		ring1="Apeile Ring +1",						--		+9
		ring2="Eihwaz Ring",						--		+5
		back=gear.PLD_DEF_Cape,						--		+10
		waist="Creed Baudrier", 					--		+5
		legs="Caballarius Breeches +3",				--		+9
		feet="Chevalier's Sabatons +3",				--		+15
	}	-- 3249 HP, Burtgang/Srivatsa: Enmity +165, Excalibur/Srivatsa: Enmity +144

    sets.precast.JA['Provoke'] = sets.Enmity																				-- Base: 1/1800 * 2.62 (2/4716)
	sets.precast.JA['Warcry'] = sets.Enmity																					-- Base: 0/320 * 2.58 (0/825)
    sets.precast.JA['Palisade'] = sets.Enmity																				-- Base: 900/1800 * 2.58 (2322/4644)
	sets.precast.JA['Pflug'] = sets.Enmity																					-- Base: 450/900 * 2.58 (1161/2322)
	sets.precast.JA['Valiance'] = sets.Enmity																				-- Base: 450/900 * 2.58 (1161/2322)
	sets.precast.JA['Vallation'] = sets.Enmity																				-- Base: 450/900 * 2.58 (1161/2322)
	sets.precast.JA['Swordplay'] = sets.Enmity																				-- Base: 160/320 * 2.58 (412/825)
    sets.precast.JA['Sentinel'] = set_combine(sets.Enmity, {feet="Caballarius Leggings +3"}) 								-- Base: 0/900 * 2.53 (0/2322)
    sets.precast.JA['Chivalry'] = set_combine(sets.Enmity, {hands="Caballarius Gauntlets +3"}) 								-- Base: 0/320 * 2.58 (0/825)
    sets.precast.JA['Fealty'] = set_combine(sets.Enmity, {body="Caballarius Surcoat +3"})									-- Base: 0/320 * 2.48 (0/793)
	sets.precast.JA['Rampart'] = set_combine(sets.Enmity, {head="Caballarius Coronet +3"})									-- Base: 320/320 * 2.43 (777/777)
    sets.precast.JA['Majesty'] = sets.Enmity																				-- Base: 0/340 * 2.58 (0/877)
	sets.precast.JA['Shield Bash'] = set_combine(sets.Enmity, {hands="Caballarius Gauntlets +3", ear2="Knightly Earring"})	-- Base: 450/900 * 2.54 (1161/2322*)
	sets.precast.JA['Cover'] = {head="Reverence Coronet +3", body="Caballarius Surcoat +3"}									-- Base: 0/1 * 2.31 (0/2)
	sets.precast.JA['Invincible'] = set_combine(sets.Enmity, {legs="Caballarius Breeches +3"})								-- Base: 0/7200 * 2.58 (0/18576)
	sets.precast.JA['Divine Emblem'] = sets.Enmity																			-- Base: 0/320 * 2.58 (0/825)
	sets.precast.JA['Burst Affinity'] = sets.Enmity																			-- Base: 1/300 * 2.58 (2/774)

-- Fast cast sets for spells

    sets.precast.FC = {
		ammo="Sapience Orb",						--2
		head="Carmine Mask +1",						--14
		neck="Baetyl Pendant",						--4 							"Orunmila's Torque", --5
		ear1="Odnowa Earring +1",					--HP +110 						"Enchanter's Earring +1", --2
		ear2="Loquacious Earring",					--2
		body="Reverence Surcoat +3", 				--10
		hands="Leyline Gloves",						--7
		ring1="Gelatinous Ring +1",					--HP +135
		ring2="Medada's Ring",						--10
		back=gear.PLD_FC_Cape,						--10
		waist="Plat. Mog. Belt",					--HP +10%
		legs="Enif Cosciales",						--8
		feet="Chevalier's Sabatons +3", 			--13
        } --FC = 80%, 3014 HP
		
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {
		ammo="Staunch Tathlum +1",						
		hands=gear.Souveran_ShieldSkill_Hands,		--HP +199
		legs="Reverence Breeches +3",				--HP +163
		neck="Diemer Gorget",						--Cure Cast Time -4%
		ear1="Mendi. Earring",						--Cure Cast Time -5%
		ear2="Nourishing Earring +1",				--Cure Cast Time -4%
		ring1="Gelatinous Ring +1",					--HP +135
		waist="Acerbic Sash +1",					--Cure Cast Time -8%
		}) --FC 54%, Cure Cast Time -21% (FC 75%), 2927 HP
		
	sets.precast.FC.CureSelf = set_combine(sets.precast.FC, {
		body=gear.Odyssean_CureFC_Body,
		neck="Diemer Gorget",
		waist="Acerbic Sash +1",
		ear1="Mendi. Earring",
		ear2="Influx Earring",
		ring1="Mephitas's Ring +1",
		ring2="Mephitas's Ring",
		feet=gear.Odyssean_CurePot_Feet,
		}) --FC 58%, Cure Cast Time -17% (FC  75%), 2020 HP
		

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        ammo="Oshasha's Treatise",
		head="Nyame Helm",
		neck="Fotia Gorget",
		ear1="Thrud Earring",
		ear2="Moonshade Earring",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		ring1="Epaminondas's Ring",
		ring2="Regal Ring",
		back=gear.PLD_STR_Cape,
		waist="Fotia Belt",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
        } -- 2548 HP

    sets.precast.WS.Acc = set_combine(sets.precast.WS, {
		neck="Combatant's Torque",
		ring1="Beithir Ring",
		back=gear.PLD_TP_Cape,
		waist="Kentarch Belt +1",
        })
		
	sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {
		ammo="Coiste Bodhar",
		head="Sakpata's Helm",
		body="Hjarrandi Breast.",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
		ear1="Mache Earring +1",
		ring1="Begrudging Ring",
		back=gear.PLD_DEX_Cape,
		})
	
	sets.precast.WS['Chant du Cygne'].Acc = set_combine(sets.precast.WS['Chant du Cygne'], {
		hands="Chevalier's Gauntlets +3",
		neck="Combatant's Torque",
		ear2="Telos Earring",
		ring1="Beithir Ring",
		waist="Kentarch Belt +1",
		})

    sets.precast.WS['Atonement'] = set_combine(sets.Enmity, {
		neck="Loricate Torque +1",
		ear2="Chevalier's Earring +1",
		waist="Plat. Mog. Belt",
		})
		
	sets.precast.WS['Atonement'].Acc = sets.precast.WS['Atonement']
	-- 3225 HP, Enmity +200 (CE: 600/VE: 1800)

    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
		ammo="Coiste Bodhar",
		neck="Rep. Plat. Medal",
		waist="Sailfi Belt +1",
		}) -- 2548 HP
	
	sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS['Savage Blade'], {ring1="Beithir Ring"})
	sets.precast.WS['Knights of Round'] = sets.precast.WS['Savage Blade']
	sets.precast.WS['Knights of Round'].Acc = sets.precast.WS['Savage Blade'].Acc
	sets.precast.WS['Judgement'] = sets.precast.WS['Savage Blade']
	sets.precast.WS['Judgement'].Acc = sets.precast.WS['Savage Blade'].Acc
	sets.precast.WS['Black Halo'] = sets.precast.WS['Savage Blade']
	sets.precast.WS['Black Halo'].Acc = sets.precast.WS['Savage Blade'].Acc
	sets.precast.WS['Impulse Drive'] = sets.precast.WS['Savage Blade']
	sets.precast.WS['Impulse Drive'].Acc = sets.precast.WS['Savage Blade'].Acc
	-- 2548 HP

    sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS, {
        ammo="Ghastly Tathlum +1",
        head="Pixie Hairpin +1",
        neck="Sibyl Scarf",
        ear1="Halasz Earring", 						--"Crematio Earring",
        ear2="Ishvara Earring",
        ring1="Archon Ring",
		ring2="Medada's Ring",
        back="Toro Cape",
        waist="Orpheus's Sash",
        }) -- 2442 HP
	
	sets.precast.WS['Sanguine Blade'].Acc = set_combine(sets.precast.WS['Sanguine Blade'], {
		neck="Erra Pendant",
		})
		
	sets.precast.WS['Cataclysm'] = sets.precast.WS['Sanguine Blade']
	sets.precast.WS['Cataclysm'].Acc = sets.precast.WS['Sanguine Blade'].Acc
	
	sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS['Sanguine Blade'], {
		head="Nyame Helm",
		ring1="Mephitas's Ring +1",
		}) -- 2442 HP
	
	sets.precast.WS['Aeolian Edge'].Acc = set_combine(sets.precast.WS['Aeolian Edge'], {
		neck="Sanctity Necklace",
		})
		
	sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {
		ammo="Coiste Bodhar",
		head="Sakpata's Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
		ear1="Cessance Earring",
		ring1="Beithir Ring",
		back="Vespid Mantle",
		})	-- 2548 HP
	
	sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS['Requiescat'], {
		neck="Combatant's Torque",
		waist="Kentarch Belt +1",
		})		

    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = sets.Enmity

	sets.midcast.SIRDRampart = sets.Enmity
			--SIRD 1050/1024, 3216 HP, Enmity +162
		
    sets.midcast.SpellInterrupt = set_combine(sets.Enmity, {
        ammo="Staunch Tathlum +1", 					--110
		head="Souveran Schaller +1",				--200, Enmity +9
        body="Reverence Surcoat +3",				--Enmity +10
        legs="Founder's Hose", 						--300
		feet="Chevalier's Sabatons +3",				--Enmity +15
		neck="Moonlight Necklace",					--150, Enmity +15
		ear1="Magnetic Earring",					--80
        ear2="Knightly Earring",					--90
		ring2="Moonlight Ring",
		waist="Plat. Mog. Belt",
        }) 	--SIRD 90.8% + 10% Merits = 1006/1024, 3208 HP, DEF: 1703, Enmity (Burt/Sriv) +62; (Excal/Sriv) +39
		
	sets.midcast.Cure = set_combine(sets.midcast.SpellInterrupt, {
		neck="Sacro Gorget",						-- CP1 +10
		ear2="Chev. Earring +1",					-- CP1 +11
		ring2="Gelatinous Ring +1",
		body="Souveran Cuirass +1",					-- CP1 +11
		hands=gear.Souveran_ShieldSkill_Hands,
		back=gear.PLD_CurePot_Cape,					-- CP1 +10
		feet=gear.Odyssean_CurePot_Feet,			-- CP1 +10
		}) 	--3089 HP
		
	sets.midcast.CureSelf = set_combine(sets.Enmity, {
		ammo="Egoist's Tathlum",					--	+45 HP
		head="Souveran Schaller +1",				-- 	CPR +15%, +9 Enmity, +280 HP, SIRD -20
		neck="Sacro Gorget",						--	CP1 +10%, +5 Enmity, +50 HP
		ear2="Chev. Earring +1",					--	CP1 +11%, DT -5
		body="Souveran Cuirass +1",					--	CP1 +11%, CPR +15%, +20 Enmity, +171 HP, DT -10
		hands="Macabre Gauntlets +1",				--	CP1 +11%, +89 HP, PDT -4
		ring2="Moonlight Ring",						--	+100 HP, DT -4
		back="Moonbeam Cape",						--	+250 HP, DT -5
		waist="Plat. Mog. Belt", 					--	+10% HP, DT -3
		legs="Chevalier's Cuisses +3",				--	+163 HP, Enmity Retention, DT -13
		feet=gear.Odyssean_CurePot_Feet,			--	CP1 +10%, SIRD -20
		}) --HP 3610, CP1 +50%, CPR +30%, Enmity +64 (Srivatsa), DT -50 (Srivatsa), PDT2 -18, SIRD -40
		
    -- Specific spells
    sets.midcast.Utsusemi = sets.midcast.SpellInterrupt
	sets.midcast['Crusade'] = set_combine(sets.midcast.SpellInterrupt, {
		body="Shabti Cuirass +1",
		hands="Regal Gauntlets",
		}) -- 3169 HP
		
	sets.midcast['Flash'] = sets.Enmity							-- 3225 HP, 471/3353
	sets.midcast['Diaga'] = sets.Enmity
	sets.midcast['Reprisal'] = sets.midcast['Crusade']			-- 3169 HP
	sets.midcast['Protect V'] = sets.midcast['Crusade']			-- 3169 HP
	sets.midcast['Blue Magic'] = sets.midcast.SpellInterrupt	-- 3230 HP
	
	-- Blue Magic Enmity: 	Geist Wall, Soporific, Sheep Song, Blank Gaze (672/672)
	--						Frightful Roar, Chaotic Eye (1/672)
	--						Jettatura (378/2142)
		
	sets.midcast['Phalanx'] = set_combine(sets.midcast.SpellInterrupt, {
		main="Sakpata's Sword",						--5
		sub="Priwen",								--2
		head=gear.Odyssean_Phalanx_Head,			--5
		ear1="Mimir Earring",						
		body=gear.Odyssean_Phalanx_Body,			--5
		hands=gear.Souveran_ShieldSkill_Hands,		--5
		legs="Sakpata's Cuisses",					--5
		feet="Souveran Schuhs +1",					--5
		back=gear.PLD_Phalanx_Cape,					--4
		}) --Phalanx +36, 3214 HP
		
	sets.midcast['Stoneskin'] = set_combine(sets.midcast.SpellInterrupt, {
		hands="Stone Mufflers",
		ear2="Earthcry Earring",
        waist="Siegel Sash",
		})

    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------

    -- Resting sets
--    sets.resting = {}

    -- Idle sets
	sets.idle = {
		ammo="Staunch Tathlum +1",
		head="Chevalier's Armet +3",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Chevalier's Cuisses +3",
		feet="Sakpata's Leggings",
		neck="Unmoving Collar +1",
		ear1="Foresti Earring",
		ear2="Chev. Earring +1",
		ring1="Warden's Ring",
		ring2="Fortified Ring",
		back=gear.PLD_MEva_Cape,
		waist="Plat. Mog. Belt",
		} -- 3205 HP
		
	sets.idle.Phalanx = sets.midcast['Phalanx']
	
	sets.idle.Refresh = set_combine(sets.idle, {
		feet="Shabti Sabatons",
		waist="Gishdubar Sash",
		})

	sets.idle.Shield = set_combine(sets.idle, {
		hands=gear.Souveran_ShieldSkill_Hands,
		neck="Combatant's Torque",
		ring2="Moonlight Ring",
		}) -- 3179 HP
		
	sets.idle.Magical = set_combine(sets.idle, {
		feet="Sakpata's Leggings",
		neck="Warder's Charm +1",
		ear1="Sanare Earring",
		ear2="Hearty Earring",
		ring2="Shadow Ring",
		back=gear.PLD_MEva_Cape,
        }) -- 3033 HP
		
	sets.idle.AzureAilments = set_combine(sets.idle, {
		ammo="Homiliary",
		head="Rev. Coronet +3",
		body="Rev. Surcoat +3",
		hands="Rev. Gauntlets +3",
		legs="Cab. Breeches +3",
		feet="Rev. Leggings +3",
		back="Moonbeam Cape",
		waist="Audumbla Sash",
		})
		
    -- Defense sets
    sets.defense.PDT = sets.idle.PDT
    sets.defense.MDT = sets.idle.MDT

    sets.Kiting = {legs="Carmine Cuisses +1", feet="Sakpata's Leggings", ring2="Defending Ring", back="Shadow Mantle"}	-- 3028 HP, DT -50, PDT2 -18, DEF: 1728

    --------------------------------------
    -- Engaged sets
    --------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
	
    sets.engaged = {								-- 	DEF		DT		PDT			MDT			MDB			Shield			BlockChance		HP			VIT			Enmity
		ammo="Staunch Tathlum +1",					-- 			2
		head="Chevalier's Armet +3",				-- 	138		10								+5			+13								+135		+53
		body="Sakpata's Plate",						-- 	194		10*								+10											+136		+42
		hands="Sakpata's Gauntlets",				-- 	146		8								+6											+91 		+46
		legs="Chevalier's Cuisses +3",				--	160		13								+7											+127		+43
		feet="Sakpata's Leggings",					-- 	125		6								+7											+68			+30
		neck="Unmoving Collar +1",		 			--	41																					+200		+9			+10
		ear1="Foresti Earring",						-- 	20													+10
		ear2="Chev. Earring +1",					-- 	22		5											+11
		ring1="Warden's Ring",						-- 					3
		ring2="Fortified Ring",						-- 								5
		back=gear.PLD_DEF_Cape,						-- 	70																	+3				+60						+10
		waist="Plat. Mog. Belt",					-- 			3																			+10%
		} 	-- 3228 HP, 654 Shield Skill, DEF: 1869, DT -50, PDT2 -18
			-- DEF: 	(Majesty/Protect V) Srivatsa +390(2203), Duban +395(2208), Minne V +387(2590~), 
			--			Cocoon: +1295(3885~), Dunna/Barrier: +1626(4216~), Idris/Barrier: +2222(4812~)
	
	sets.engaged.ShieldSkill = set_combine(sets.engaged, {
		hands=gear.Souveran_ShieldSkill_Hands,		--	112				4			5			+1			+15								+199		+34			
		neck="Combatant's Torque",					--														+15
		ring2="Moonlight Ring",
		}) -- 3144 HP, 684 Shield Skill, DEF: 1742, DT -50, PDT2 -18
		
	sets.engaged.Magic = set_combine(sets.engaged, {
		hands="Sakpata's Gauntlets",
		feet="Sakpata's Leggings",
		neck="Warder's Charm +1",
		ear1="Sanare Earring",
		ear2="Hearty Earring",
		ring2="Shadow Ring",
		back=gear.PLD_MEva_Cape,
		}) -- 2895 HP, 483 Shield Skill, DEF: 1662, DT -50, PDT2 -18, MDT -87, M.Evasion +688, MDB +36, Ailments -22
		
	sets.engaged.DPS = set_combine(sets.engaged, {
		ammo="Coiste Bodhar",						--Att +12, sTP +3, DA +3%
		head="Sakpata's Helm",						--Acc +40, Att +53, DA +5%, DT -7, Haste +4, PDL +5%, DA Dmg +7%
		legs="Sakpata's Cuisses",					--Acc +40, Att +40, DT -9, Haste +4, DA +7%, PDL +7%
		feet="Sakpata's Leggings",					--Acc +40, Att +40, DA +4%, DT -6, Haste +2
		neck="Combatant's Torque",					--Combat Skills +15, sTP +4
		ear1="Telos Earring",						--Acc +10, Att +10, DA +1%, sTP +5
		ear2="Cessance Earring",					--Acc +6, DA +3%, sTP +3
		ring1="Chirich Ring +1",					--Acc +10, sTP +6
		ring2="Moonlight Ring",						--Acc +5, Att +5, sTP +3, DT -4
		back=gear.PLD_TP_Cape,						--Acc +23, Att +20, sTP +10
		waist="Sailfi Belt +1",						--Att +15, DA +5%, TA +2%, Haste +9
		}) -- 2619 HP, 603 Shield Skill, DEF: 1759, DT -48, Att +340, Acc +329, DA +33%, TA +2%, Haste 263/1024, sTP +30
		
	sets.engaged.Phalanx = sets.midcast['Phalanx']

    --------------------------------------
    -- Custom buff sets
    --------------------------------------

    sets.buff.Cover = {body="Caballarius Surcoat +3"}
	sets.buff.Rampart = {head="Caballarius Coronet +3"}
	sets.buff.Reprisal = {}

    sets.buff.Doom = {
		body="Reverence Surcoat +3",
		hands=gear.Souveran_ShieldSkill_Hands,
		legs="Shabti Cuisses +1",						--15
		ear1="Odnowa Earring +1",
		neck="Nicander's Necklace", 					--20
		ring1="Purity Ring", 							--7
		ring2="Saida Ring", 							--15
		back="Moonbeam Cape",
		waist="Gishdubar Sash", 						--10
		} -- 3164 HP, Cursna Received Potency +67%
		
    sets.TreasureHunter = {
		ammo="Perfect Lucky Egg", 
		body="Volte Jupon",
		legs="Volte Hose",
		} -- 3196 HP*

	sets.latent_refresh = {
		ear1="Odnowa Earring +1",
		ring1="Moonlight Ring",
		ring2="Apeile Ring +1",
		waist="Fucho-no-Obi",
		} -- 3190 HP
		
    -- sets.Reive = {neck="Ygnas's Resolve +1"}

	sets.BurtSrivatsa = {main="Burtgang", sub="Srivatsa"}
	sets.BurtAegis = {main="Burtgang", sub="Aegis"}
    sets.BurtDuban = {main="Burtgang", sub="Duban"}
	sets.AzureAilments = {main="Burtgang", sub=empty,}
	
	sets.ExcalSrivatsa = {main="Excalibur", sub="Srivatsa"}
	sets.ExcalAegis = {main="Excalibur", sub="Aegis"}
	sets.ExcalDuban = {main="Excalibur", sub="Duban"}
	sets.ExcalPriwen = {main="Excalibur", sub="Priwen"}
	
	sets.CalibSrivatsa = {main="Caliburnus", sub="Srivatsa"}
	sets.CalibAegis = {main="Caliburnus", sub="Aegis"}
	sets.CalibDuban = {main="Caliburnus", sub="Duban"}
	
    sets.DPS = {main="Naegling", sub="Blurred Shield +1"}
	sets.ShiningOne = {main="Shining One", sub="Alber Strap"}
	sets.Cataclysm = {main="Malignance Pole", sub="Alber Strap"} 
	sets.Aeolian = {main="Malevolence", sub="Duban"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_post_precast(spell, action, spellMap, eventArgs)
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
		if 	state.CastingMode.value == "SIRD" and buffactive.Rampart then
			equip(sets.midcast.SIRDRampart)
		elseif state.CastingMode.value == "SIRD" then
			equip(sets.midcast.SpellInterrupt)
			return
		end
	end
	if spellMap == 'Cure' and spell.target.type == 'SELF' then
		equip(sets.midcast.CureSelf)
	end
	if spell.english:startswith('banish') then
		equip(sets.Enmity)
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
    if state.Buff.Cover then
       idleSet = set_combine(idleSet, sets.buff.Cover)
    end
	if player.mp < 727 then
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
    if state.Buff.Cover then
        meleeSet = set_combine(meleeSet, sets.buff.Cover)
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
    if player.sub_job ~= 'NIN' and player.sub_job ~= 'DNC' then
       equip(sets.DefaultShield)
    end
end

-- function job_self_command(cmdParams, eventArgs)
    -- warps(cmdParams, eventArgs)
-- end

windower.register_event('zone change',
    -- function()
        -- send_command('gi ugs true')
    -- end

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
        set_macro_page(1, 6)
    elseif player.sub_job == 'BLU' then
        set_macro_page(2, 6)
    elseif player.sub_job == 'RUN' then
        set_macro_page(3, 6)
	elseif player.sub_job == 'RDM' then
		set_macro_page(4, 6)
	else
		set_macro_page(5, 6)
    end
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset ' .. lockstyleset)
end