-- Original: Motenten / Modified: Arislan

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

-- Setup vars that are user-independent.
function job_setup()
	
	elemental_ws = S{'Raiden Thrust'} 
    no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
              "Trizek Ring", "Echad Ring", "Reraise Earring", "Nexus Cape"}
	
    include('Mote-TreasureHunter')

    -- For th_action_check():
    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{35, 204}
    -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
    info.default_u_ja_ids = S{201, 202, 203, 205, 207}

    lockstyleset = 29

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

function user_setup()
    state.OffenseMode:options('Normal','Accuracy','Damage Limit')
    state.WeaponskillMode:options('Normal','pdl')
    state.HybridMode:options('Normal','DT')
    state.IdleMode:options('Normal','Phalanx','DT')
	
	state.WeaponSet = 	M{['description']='Weapon Set','Sword','Club','Polearm','GreatAxe','GreatSword','Staff','Axe','AxeDW','SwordDW'}
	state.SubtleBlow = M(false, "Subtle Blow Set")
	
    state.WeaponLock = M(false, 'Weapon Lock')
    state.CP = M(false, "Capacity Points Mode")

    -- Additional local binds
	include('Chizel_Global_Binds.lua')
    -- include('Global-GEO-Binds.lua') -- OK to remove this line

    send_command('bind @t gs c cycle treasuremode')
    -- send_command('bind @c gs c toggle CP')
	send_command('bind @w gs c toggle WeaponLock')
    send_command('bind @e gs c cycleback WeaponSet')
    send_command('bind @r gs c cycle WeaponSet')
    send_command('bind != gs c toggle SubtleBlow')
	send_command('bind ^t input /ja "Tomahawk" <stnpc>')
	send_command('bind ^= input /ra <stnpc>')
	send_command('bind ^- input /ja "Provoke" <stnpc>')
	
	gear.RAbullet = "Dart"

    if player.sub_job == 'DRG' then
		send_command('bind ^numpad/ input /ja "High Jump" <t>')
		send_command('bind ^numpad* input /ja "Super Jump" <t>')
		send_command('bind ^numpad- input /ja "Ancient Circle" <me>')
	elseif player.sub_job == 'SAM' then
		send_command('bind ^numpad/ input /ja "Hasso" <me>')
		send_command('bind ^numpad* input /ja "Meditate" <me>')
		send_command('bind ^numpad- input /ja "Sekkanoki" <me>')
		send_command('bind ^numpad+ input /ja "Third Eye" <stnpc>')
		send_command('bind !numpad/ input /ja "Seigan" <me>')
	elseif player.sub_job == 'DNC' then
		send_command('bind ^numpad/ input /ja "Haste Samba" <me>')
		send_command('bind ^numpad* input /ja "Quickstep" <t>')
		send_command('bind ^numpad- input /ja "Box Step" <t>')
		send_command('bind ^numpad+ input /ja "Animated Flourish" <stnpc>')
		send_command('bind !numpad/ input /ja "Curing Waltz III" <stpt>')
		send_command('bind !numpad* input /ja "Divine Waltz" <me>')
		send_command('bind !numpad- input /ja "Healing Waltz" <stpt>')
	end
	
    send_command('bind !w input /ja "Jump" <stnpc>')

    send_command('bind ^numpad8 input /ws "Decimation" <t>')
    send_command('bind ^numpad9 input /ws "Full Break" <t>')
    send_command('bind ^numpad8 input /ws "Armor Break" <t>')
    send_command('bind ^numpad7 input /ws "Fell Cleave" <t>')
    send_command('bind ^numpad6 input /ws "Steel Cyclone" <t>')
    send_command('bind ^numpad5 input /ws "Ukko\'s Fury" <t>')
    send_command('bind ^numpad4 input /ws "Upheaval" <t>')
    send_command('bind ^numpad3 input /ws "Flat Blade" <t>')
    send_command('bind ^numpad2 input /ws "Requiescat" <t>')
    send_command('bind ^numpad1 input /ws "Sanguine Blade" <t>')
    send_command('bind ^numpad0 input /ws "Savage Blade" <t>')
	
    send_command('bind !numpad9 input /ws "Cataclysm" <t>')
    send_command('bind !numpad8 input /ws "Full Swing" <t>')
    send_command('bind !numpad7 input /ws "Judgment" <t>')
    send_command('bind !numpad6 input /ws "Sonic Thrust" <t>')
    send_command('bind !numpad5 input /ws "Stardiver" <t>')
    send_command('bind !numpad4 input /ws "Impulse Drive" <t>')
    send_command('bind !numpad3 input /ws "Mistral Axe" <t>')
    send_command('bind !numpad2 input /ws "Cloudsplitter" <t>')
    send_command('bind !numpad1 input /ws "Calamity" <t>')
    send_command('bind !numpad0 input /ws "Decimation" <t>')

	send_command('bind @m input /mount "Raaz"')	

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

function user_unload()
    send_command('unbind @t')
    send_command('unbind @c')
	send_command('unbind @w')
    send_command('unbind @e')
    send_command('unbind @r')
    send_command('unbind ^numpad/')
    send_command('unbind ^numpad*')
    send_command('unbind ^numpad-')
    send_command('unbind ^numpad+')
    send_command('unbind !numpad/')
    send_command('unbind !numpad*')
    send_command('unbind !numpad-')
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
	send_command('unbind !numpad9')
	send_command('unbind !numpad8')
	send_command('unbind !numpad7')
	send_command('unbind !numpad6')
    send_command('unbind !numpad5')
    send_command('unbind !numpad4')
    send_command('unbind !numpad3')
    send_command('unbind !numpad2')
    send_command('unbind !numpad1')
    send_command('unbind !numpad0')
	send_command('unbind !=')
	send_command('unbind ^t')
	send_command('unbind ^=')
	send_command('unbind ^-')
	send_command('unbind !w')
	send_command('unbind @m')
end

-- Define sets and vars used by this job file.
function init_gear_sets()

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------
	sets.Enmity = {
		ammo="Sapience Orb",
		head="Halitus Helm",
		body="Souv. Cuirass +1",
		hands=gear.Souveran_Enmity_Hands,
		legs="Zoar Subligar +1",
		neck="Moonlight Necklace",
		ear1="Cryptic Earring",
		ear2="Trux Earring",
		ring1="Apeile Ring +1",
		ring2="Apeile Ring",
		back="Agema Cape",
		}

    -- Fast cast sets for spells
    sets.precast.FC = {
        ammo="Sapience Orb",						--2
        head="Sakpata's Helm", 						--8
        body=gear.Odyssean_CureFC_Body, 			--11
        hands="Leyline Gloves", 					--8
		waist="Ioskeha Belt +1",
        legs="Rawhide Trousers", 					--5
        feet=gear.Odyssean_CurePot_Feet, 			--5
		neck="Baetyl Pendant", 						--4
        ear1="Loquacious Earring", 					--2
		ear2="Etiolation Earring", 					--1
		ring1="Medada's Ring",						--10
        ring2="Weatherspoon Ring", 					--5 "Weather. Ring +1", --6(4)
		} --FC +56%

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
		neck="Magoraga Beads",
		})

    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

	-- WS Sets
	sets.precast.WS = {
		ammo="Knobkierrie",
		head="Agoge Mask +3",
		body="Nyame Mail",	
		hands="Boii Mufflers +3",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="War. Beads +1",
		waist="Sailfi Belt +1",
		ear1="Moonshade Earring",
		ear2="Thrud Earring",
		ring1="Niqmaddu Ring",
		ring2="Epaminondas's Ring",
		back=gear.WAR_Savage_Cape,
		}
		
	sets.pdl = {
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Boii Cuisses +3",
		ring1="Beithir Ring",
		ring2="Regal Ring",
		}

	--Sword--
	sets.precast.WS['Savage Blade'] = sets.precast.WS		
	sets.precast.WS['Savage Blade'].pdl = set_combine(sets.precast.WS['Savage Blade'], sets.pdl)
	
	sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS, {
        ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",
        body="Nyame Mail",
        hands="Nyame Gauntlets",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets",
        neck="Sanctity Necklace",
        ear1="Crematio Earring",
        ring1="Medada's Ring",
        ring2="Archon Ring",
        back="Toro Cape",
		waist="Orpheus's Sash",
        })

	sets.precast.WS['Sanguine Blade'].pdl = sets.precast.WS['Sanguine Blade']
	
	sets.precast.WS['Flat Blade'] = set_combine(sets.precast.WS, {
		ammo="Pemphredo Tathlum",
		head="Sakpata's Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Boii Cuisses +3",
		feet="Sakpata's Leggings",
		neck="Moonlight Necklace",
		ear1="Digni. Earring",
		ring1="Stikini Ring +1",
		ring2="Metamor. Ring +1",
		waist="Eschan Stone",
		})
		
	sets.precast.WS['Flat Blade'].pdl = sets.precast.WS['Flat Blade']
	
	--Club--
	sets.precast.WS['Judgement'] = sets.precast.WS['Savage Blade']
	sets.precast.WS['Judgement'].pdl = sets.precast.WS['Savage Blade'].pdl
	sets.precast.WS['Black Halo'] = sets.precast.WS['Savage Blade']
	sets.precast.WS['Black Halo'].pdl = sets.precast.WS['Savage Blade'].pdl
	
	--1-H Axe--
	sets.precast.WS['Decimation'] = set_combine(sets.precast.WS, {
		head="Sakpata's Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Flam. Gambieras +2",
		ring2="Regal Ring",
		})
	
	sets.precast.WS['Decimation'].pdl = set_combine(sets.precast.WS['Decimation'], sets.pdl)
	sets.precast.WS['Mistral Axe'] = sets.precast.WS['Savage Blade']
	sets.precast.WS['Mistral Axe'].pdl = sets.precast.WS['Savage Blade'].pdl
	sets.precast.WS['Calamity'] = sets.precast.WS['Savage Blade']
	sets.precast.WS['Calamity'].pdl = sets.precast.WS['Savage Blade'].pdl
	
	sets.precast.WS['Cloudsplitter'] = set_combine(sets.precast.WS, {
		neck="Sanctity Necklace",
		back=gear.WAR_Savage_Cape,
		waist="Orpheus's Sash",
		})
	
	sets.precast.WS['Cloudsplitter'].pdl = sets.precast.WS['Cloudsplitter']
	
	--2-H Axe--
	sets.precast.WS['Upheaval'] = set_combine(sets.precast.WS, {
		ring2="Gelatinous Ring +1",
		back=gear.WAR_Upheaval_Cape,
		})
		
	sets.precast.WS['Upheaval'].pdl = set_combine(sets.precast.WS['Upheaval'], sets.pdl, {
		head="Sakpata's Helm",
		feet="Sakpata's Leggings",
		})
	
	sets.precast.WS['Steel Cyclone'] = sets.precast.WS['Upheaval']
	sets.precast.WS['Steel Cyclone'].pdl = sets.precast.WS['Upheaval'].pdl
	sets.precast.WS['Fell Cleave'] = sets.precast.WS['Upheaval']
	sets.precast.WS['Fell Cleave'].pdl = sets.precast.WS['Upheaval'].pdl
	
	sets.precast.WS["Ukko's Fury"] = set_combine(sets.precast.WS, {
		ammo="Yetshila +1",
		head="Boii Mask +3",
		body="Hjarrandi Breast.",
		hands="Flam. Manopolas +2",
		legs="Boii Cuisses +3",
		feet="Boii Calligae +2",
		ear2="Boii Earring +1",
		ring2="Regal Ring",
		})
		
	sets.precast.WS["Ukko's Fury"].pdl = sets.precast.WS["Ukko's Fury"]
	
	sets.precast.WS['Armor Break'] = set_combine(sets.precast.WS, {
		ammo="Pemphredo Tathlum",
		head="Sakpata's Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Boii Cuisses +3",
		feet="Sakpata's Leggings",
		neck="Moonlight Necklace",
		ear1="Digni. Earring",
		ring1="Stikini Ring +1",
		ring2="Metamor. Ring +1",
		waist="Eschan Stone",
		})
		
	sets.precast.WS['Armor Break'].pdl = sets.precast.WS['Armor Break']
	sets.precast.WS['Weapon Break'] = sets.precast.WS['Armor Break']
	sets.precast.WS['Weapon Break'].pdl = sets.precast.WS['Armor Break']
	sets.precast.WS['Full Break'] = sets.precast.WS['Armor Break']
	sets.precast.WS['Full Break'].pdl = sets.precast.WS['Armor Break']

	--Polearm--
	sets.precast.WS["Impulse Drive"] = sets.precast.WS["Ukko's Fury"]	
	sets.precast.WS["Impulse Drive"].pdl = sets.precast.WS["Impulse Drive"]
	sets.precast.WS['Stardiver'] = sets.precast.WS['Savage Blade']
	sets.precast.WS['Stardiver'].pdl = sets.precast.WS['Savage Blade'].pdl
	sets.precast.WS['Sonic Thrust'] = sets.precast.WS['Savage Blade']
	sets.precast.WS['Sonic Thrust'].pdl = sets.precast.WS['Savage Blade'].pdl
	
	--Staff--
	sets.precast.WS['Cataclysm'] = set_combine(sets.precast.WS, {
		ammo="Ghastly Tathlum +1",
		head="Pixie Hairpin +1",
		hands="Nyame Gauntlets",
		neck="Sibyl Scarf",
		ear2="Crematio Earring",
		ring1="Medada's Ring",
		ring2="Archon Ring",
        back="Toro Cape",
		waist="Orpheus's Sash",
		})

	sets.precast.WS['Cataclysm'].pdl = sets.precast.WS['Cataclysm']
	
	sets.precast.WS['Earth Crusher'] = sets.precast.WS['Cataclysm']
	sets.precast.WS['Earth Crusher'].pdl = sets.precast.WS['Cataclysm']
	sets.precast.WS['Shell Crusher'] = sets.precast.WS['Savage Blade']
	sets.precast.WS['Shell Crusher'].pdl = sets.precast.WS['Savage Blade'].pdl
	sets.precast.WS['Full Swing'] = sets.precast.WS['Savage Blade']
	sets.precast.WS['Full Swing'].pdl = sets.precast.WS['Savage Blade'].pdl
	
	--Great Sword--
	sets.precast.WS['Shockwave'] = sets.precast.WS['Armor Break']
	sets.precast.WS['Shockwave'].pdl = sets.precast.WS['Armor Break']
	sets.precast.WS['Ground Strike'] = sets.precast.WS['Savage Blade']
	sets.precast.WS['Ground Strike'].pdl = sets.precast.WS['Savage Blade'].pdl
	sets.precast.WS['Herculean Slash'] = sets.precast.WS['Upheaval']
	sets.precast.WS['Herculean Slash'].pdl = sets.precast.WS['Upheaval'].pdl
	sets.precast.WS['Resolution'] = sets.precast.WS['Savage Blade']
	sets.precast.WS['Resolution'].pdl = sets.precast.WS['Savage Blade'].pdl
	
    ------------------------------------------------------------------------------------------------
    ------------------------------------- Job Ability Sets -----------------------------------------
    ------------------------------------------------------------------------------------------------

	sets.precast.JA['Jump'] = {
		ammo="Aurgelmir Orb",
		head="Flam. Zucchetto +2",
		body="Boii Lorica +3",
		hands="Sakpata's Gauntlets",
		legs="Tatena. Haidate +1",
		feet="Flam. Gambieras +2",
		neck="Vim Torque +1",
		waist="Ioskeha Belt +1",
		ear1="Schere Earring",
		ear2="Telos Earring",
		ring1="Moonlight Ring",
		ring2="Chirich Ring +1",
		back=gear.WAR_TP_Cape,
		}
	
	sets.precast.JA['High Jump'] = set_combine(sets.Jump, {neck="Yngvi Choker"})
	sets.precast.JA['Super Jump'] = {neck="Yngvi Choker"}
	sets.precast.JA['Ancient Circle'] = {neck="Yngvi Choker"}
	
	sets.precast.JA['Provoke'] = sets.Enmity
	
    sets.precast.JA['Restraint'] = {hands="Boii Mufflers +3"}
    sets.precast.JA['Mighty Strikes'] = {hands="Agoge Mufflers +1"}
    sets.precast.JA['Blood Rage'] = {body="Boii Lorica +3" }
    sets.precast.JA['Warcry'] = {head="Agoge Mask +3"}
    sets.precast.JA['Retaliation'] = {feet = "Boii Calligae +2"}
	sets.precast.JA['Aggressor'] = {body="Agoge Lorica +3", head= "Pummeler's Mask +1"}
		
	sets.precast.JA['Berserk'] = {
		back=gear.WAR_TP_Cape,			-- Berserk dur. +15
		feet="Agoge Calligae +3",		-- Berserk dur. +30
		body="Pummeler's Lorica +2"		-- Berserk dur. +16 >> +18
		}	-- Berserk dur. +61 >> +63
		
	sets.precast.JA['Tomahawk'] ={ammo="Throwing Tomahawk", feet="Agoge Calligae +3"}
	
	sets.precast.RA = set_combine(sets.idle, {ammo=gear.RAbullet})
	
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.SpellInterrupt = set_combine(sets.precast.FC, {
        ammo="Staunch Tathlum +1", 								-- SIRD 11
        hands=gear.Souveran_ShieldSkill_Hands, 					-- SIRD 20
        legs="Founder's Hose", 									-- SIRD 30
		feet=gear.Odyssean_CurePot_Feet,						-- SIRD 20
        neck="Moonlight Necklace", 								-- SIRD 15
		ear2="Odnowa Earring +1",
        ring1="Defending Ring",
        })	-- SIRD (Merits) 100/1024, (Gear) 960/1024 = 106%

    sets.midcast.Utsusemi = sets.midcast.SpellInterrupt
	
	sets.midcast.RA = set_combine(sets.idle, {ammo=gear.RAbullet})

    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.idle = {
		ammo="Staunch Tathlum +1",
		head="Sakpata's Helm", 
		body="Sakpata's Plate", 
		hands="Sakpata's Gauntlets", 
		legs="Sakpata's Cuisses", 
		feet="Sakpata's Leggings", 
		neck="Warder's Charm +1", 
		waist="Engraved Belt",
		ear1="Arete del Luna +1",
		ear2="Odnowa Earring +1", 
		ring1="Shadow Ring",
		ring2="Warden's Ring",
		back="Philidor Mantle",
		}
		
	-- sets.idle.Dynamis = set_combine(sets.idle, {
		-- neck="War. Beads +1",
		-- })
	
	sets.idle.Phalanx = set_combine(sets.idle.DT, {
		main="Deacon Sword",
		head=gear.Odyssean_Phalanx_Head,
		body=gear.Odyssean_Phalanx_Body,
		hands=gear.Souveran_ShieldSkill_Hands,
		legs="Sakpata's Cuisses",
		feet="Souveran Schuhs +1",
		})
	
	sets.idle.DT = set_combine(sets.idle, {
        neck="Loricate Torque +1",
		})

    sets.idle.Weak = sets.idle.DT
	sets.Kiting = {feet="Hermes' Sandals", ring2="Defending Ring"}

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------
	
    sets.engaged = {
		ammo="Coiste Bodhar",				-- DA+3
		head="Sakpata's Helm",				-- DA+5
		body="Hjarrandi Breast.",			
		hands="Sakpata's Gauntlets",		-- DA+6
		legs="Pumm. Cuisses +2",			-- DA+8		
		feet="Pumm. Calligae +3",			-- DA+8		
		neck="War. Beads +1",				-- DA+5
		waist="Ioskeha Belt +1",			-- DA+9
		ear1="Schere Earring",				-- DA+6
		ear2="Boii Earring +1",				-- DA+8
		ring1="Niqmaddu Ring",				
		ring2="Petrov Ring",				-- DA+1
		back=gear.WAR_TP_Cape,				-- DA+10
		}	-- DA+67 (Trait +28) (Merit +5) = DA (100), Acc 1245, Att 1613
	
	sets.Accuracy = {
		ammo="Seeth. Bomblet +1",			-- +13
		body="Boii Lorica +3",				-- +54
		legs="Pumm. Cuisses +2",			-- +46
		feet="Pumm. Calligae +3",			-- +36
		ring2="Regal Ring",					-- +30
		}	-- Accuracy +171 (1277), Att 1675
		
	sets.engaged.Accuracy = set_combine(sets.engaged, sets.Accuracy)
	
	sets.engaged.SW = set_combine(sets.engaged, {
		body="Boii Lorica +3",
		legs="Boii Cuisses +3",
		waist="Sailfi Belt +1",
		}) --Acc 1262, Att 1398
		
	sets.engaged.SW.Accuracy = set_combine(sets.engaged.SW, sets.Accuracy) --Acc 1301, Att 1457
	
	sets.engaged.GA = set_combine(sets.engaged, {
		body="Boii Lorica +3",
		})	-- DA+65 (98). Acc 1324, Att 1781
	
	sets.engaged.GA.Accuracy = set_combine(sets.engaged.GA, sets.Accuracy)	
			-- Acc 1339, Att 1828
	
	sets.engaged.GASB = set_combine(sets.engaged.GA, {
		feet="Sakpata's Leggings",			-- SB1 +10
		ring2="Chirich Ring +1",			-- SB1 +10
		})	-- DA+63 (96), Acc 1314, Att 1837, SB1 +37, SB2 +5
	
	sets.engaged.GASB.Accuracy = set_combine(sets.engaged.GASB, sets.Accuracy)	
			-- Acc 1339, Att 1828, SB1 +17, SB2 +5
	
	sets.engaged.DW = set_combine(sets.engaged, {
		body="Agoge Lorica +3",
		ear1="Eabani Earring",
		waist="Reiki Yotai",
		})	-- DA+55 (88), Acc (1277/1282), Att (1435/1281)
		
	sets.engaged.DW.Accuracy = set_combine(sets.engaged.DW, sets.Accuracy)	
			-- Acc (1319/1324), Att (1484/1327)
	
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

	sets.engaged.Hybrid = {
		head="Sakpata's Helm",
		body="Sakpata's Plate",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
		ear2="Odnowa Earring +1",
		ring2="Moonlight Ring"
		}
		
    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.Accuracy.DT = sets.engaged.DT
    sets.engaged.SW.DT = set_combine(sets.engaged.SW, sets.engaged.Hybrid) --Acc 1255, Att 1548
    sets.engaged.SW.Accuracy.DT = sets.engaged.SW.DT
    sets.engaged.GA.DT = set_combine(sets.engaged.GA, sets.engaged.Hybrid)
    sets.engaged.GA.Accuracy.DT = sets.engaged.GA.DT
    sets.engaged.GASB.DT = set_combine(sets.engaged.GASB, sets.engaged.Hybrid)
    sets.engaged.GASB.Accuracy.DT = sets.engaged.GASB.DT
    sets.engaged.DW.DT = set_combine(sets.engaged.DW, sets.engaged.Hybrid)
    sets.engaged.DW.Accuracy.DT = sets.engaged.DW.DT
	
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

	sets.buff.Doom = {
		legs="Shabti Cuisses +1",			--15
		neck="Nicander's Necklace", 		--20
        ring1="Saida Ring", 				--15
        ring2="Purity Ring", 				--7
        waist="Gishdubar Sash", 			--10
		} --Cursna +47

    -- sets.CP = {back="Mecisto. Mantle"}
	
    sets.TreasureHunter = { 
		ammo="Perfect Lucky Egg",	-- +1
		body="Volte Jupon",			-- +2
		legs="Volte Hose",			-- +1
		} -- +4
		
    -- sets.Reive = {neck="Ygnas's Resolve +1"}
	
	-- Weapon Sets
	sets.Sword = {main="Naegling", sub="Blurred Shield +1"}
	sets.Club = {main="Loxotic Mace +1", sub="Blurred Shield +1"}
	sets.Polearm = {main="Shining One", sub="Utu Grip"}
	sets.GreatAxe = {main="Bunzi's Chopper", sub="Utu Grip"}
	sets.GreatSword = {main="Agwu's Claymore", sub="Utu Grip"}
	sets.Staff = {main="Xoanon", sub="Utu Grip"}
	sets.Axe = {main="Dolichenus", sub="Blurred Shield +1"}
	sets.AxeDW = {main="Dolichenus", sub="Ikenga's Axe"}
	sets.SwordDW = {main="Naegling", sub="Zantetsuken"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
function job_precast(spell, action, spellMap, eventArgs)
    refine_jump(spell, action, spellMap, eventArgs)
end
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

function job_buff_change(buff,gain)
    -- If we gain or lose any haste buffs, adjust which gear set we target.
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
            disable('legs','neck','ring1','ring2','waist')
        else
            enable('legs','neck','ring1','ring2','waist')
            handle_equipping_gear(player.status)
        end
    end

end

function job_aftercast(spell, action, spellMap, eventArgs)
    if player.status ~= 'Engaged' and state.WeaponLock.value == false then
        check_weaponset()
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------
function job_state_change(stateField, newValue, oldValue)
    if state.WeaponLock.value == true then
        disable('main','sub') 
    else
        enable('main','sub')
    end

    check_weaponset()
end

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
	if player.equipment.sub == 'Blurred Shield +1' then
		SW = true
	else
		SW = false
	end
	
	if player.equipment.sub == "Utu Grip" then
		GA = true
	else
		GA = false
	end
	
	if SW == true then
        state.CombatForm:set('SW')
    elseif GA == true then
		state.CombatForm:set('GA')
	elseif GA == true and state.SubtleBlow.value == true then
        state.CombatForm:set('GASB')
    elseif DW == true then
        state.CombatForm:set('DW')
    elseif DW == false then
        state.CombatForm:reset()
    end
end

function get_custom_wsmode(spell, action, spellMap)
    local wsmode
    if state.OffenseMode.value == 'Damage Limit' then
        wsmode = 'pdl'
    end

    return wsmode
end

function refine_jump(spell, action, spellMap, eventArgs)
    if spell.name ~= "Jump" then
        return
    end

    local abil_recasts = windower.ffxi.get_ability_recasts()
    if (abil_recasts[spell.recast_id] > 0) then
        eventArgs.cancel = true

        -- ID 166 is Spirit Jump, 167 is Soul Jump.
        local newJump = nil
        if (abil_recasts[166] == 0) then
            newJump = "Spirit Jump"
        elseif (abil_recasts[167] == 0) then
            newJump = "Soul Jump"
        end
        
        if (newJump ~= nil) then
            send_command('@input /ja "'..newJump..'" '..tostring(spell.target.raw))
        else
            add_to_chat(123,'Abort: Ability waiting on recast.')
        end
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if state.CP.current == 'on' then
        equip(sets.CP)
        disable('back')
    else
        enable('back')
    end
	
	if state.Auto_Kite.value == true then
       idleSet = set_combine(idleSet, sets.Kiting)
    end

    return idleSet
end

-- Function to display the current relevant user state when doing an update.
-- Set eventArgs.handled to true if display was handled, and you don't want the default info shown.
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
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

function customize_idle_set(idleSet)
    -- if state.CP.current == 'on' then
        -- equip(sets.CP)
        -- disable('back')
    -- else
        -- enable('back')
    -- end
	if state.Auto_Kite.value == true then
       idleSet = set_combine(idleSet, sets.Kiting)
    end

    return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.TreasureMode.value == 'Fulltime' then
        meleeSet = set_combine(meleeSet, sets.TreasureHunter)
    end

    check_weaponset()

    return meleeSet
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

function determine_haste_group()
    classes.CustomMeleeGroups:clear()
    if DW == true then
        if DW_needed <= 1 then
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif DW_needed > 1 and DW_needed <= 16 then
            classes.CustomMeleeGroups:append('HighHaste')
        elseif DW_needed > 16 and DW_needed <= 21 then
            classes.CustomMeleeGroups:append('MidHaste')
        elseif DW_needed > 21 and DW_needed <= 34 then
            classes.CustomMeleeGroups:append('LowHaste')
        elseif DW_needed > 34 then
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

-- Determine whether we have sufficient ammo for the action being attempted.
function do_bullet_checks(spell, spellMap, eventArgs)
    local bullet_name
    local bullet_min_count = 1

    if spell.action_type == 'Ranged Attack' then
        bullet_name = gear.RAbullet
    end

    local available_bullets = player.inventory[bullet_name] or player.wardrobe4[bullet_name]

    -- If no ammo is available, give appropriate warning and end.
    if not available_bullets then
            add_to_chat(104, 'No ammo ('..tostring(bullet_name)..') available for that action.')
            eventArgs.cancel = true
            return
    end

    -- Low ammo warning.
    if spell.action_type == 'Ranged Attack' and state.warned.value == false
        and available_bullets.count > 1 and available_bullets.count <= options.ammo_warning_limit then
        local msg = '*****  LOW AMMO WARNING: '..bullet_name..' *****'
        --local border = string.repeat("*", #msg)
        local border = ""
        for i = 1, #msg do
            border = border .. "*"
        end

        add_to_chat(104, border)
        add_to_chat(104, msg)
        add_to_chat(104, border)

        state.warned:set()
    elseif available_bullets.count > options.ammo_warning_limit and state.warned then
        state.warned:reset()
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
        -- elseif spellMap == 'ElementalNinjutsu' then
            -- ninja_tool_name = "Inoshishinofuda"
        -- elseif spellMap == 'EnfeeblingNinjutsu' then
            -- ninja_tool_name = "Chonofuda"
        -- elseif spellMap == 'EnhancingNinjutsu' then
            -- ninja_tool_name = "Shikanofuda"
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
	if no_swap_gear:contains(player.equipment.ear1) then
		disable("ear1")
	else
		enable("ear1")
	end
	if no_swap_gear:contains(player.equipment.ear2) then
		disable("ear2")
	else
		enable("ear2")
	end
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
    -- Default macro set/book: (set, book)
    if player.sub_job == 'SAM' then
        set_macro_page(1, 3)
    elseif player.sub_job == 'DNC' then
        set_macro_page(2, 3)
	elseif player.sub_job == 'NIN' then
        set_macro_page(3, 3)
	else set_macro_page(1, 3)
    end
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset ' .. lockstyleset)
end
