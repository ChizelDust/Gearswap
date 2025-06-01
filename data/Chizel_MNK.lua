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
	state.Buff.Boost = buffactive.boost or false
	state.Buff.Impetus = buffactive.impetus or false
	state.Buff.Dodge = buffactive.dodge or false
	state.Buff.Focus = buffactive.focus or false
	state.Buff.Counterstance = buffactive.counterstance or false
	state.Buff.Doom = buffactive.doom or false
	
	elemental_ws = S{'Cataclysm'} 
    no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
              "Trizek Ring", "Echad Ring", "Reraise Earring", "Nexus Cape"}

    include('Mote-TreasureHunter')

    -- For th_action_check():
    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{35, 204}
    -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
    info.default_u_ja_ids = S{201, 202, 203, 205, 207}

    lockstyleset = 24

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

function user_setup()
    state.OffenseMode:options('Normal', 'Accuracy', 'HighAcc')
    state.WeaponskillMode:options('Normal')
    state.HybridMode:options('Normal', 'DT', 'CTR')
    state.IdleMode:options('Normal','Dynamis', 'DT', 'Regen')
	
	state.WeaponSet = 	M{['description']='Weapon Set','Godhands','Karambit','Xoanon','Staff'}
	
	state.Schere = M(false, "Schere")
	state.SubtleBlow = M(false, "Subtle Blow Set")
	
    state.WeaponLock = M(false, 'Weapon Lock')
    state.CP = M(false, "Capacity Points Mode")

    -- Additional local binds
	include('Chizel_Global_Binds.lua')
    -- include('Global-GEO-Binds.lua') -- OK to remove this line

    send_command('bind @t gs c cycle treasuremode')
    send_command('bind @c gs c toggle CP')
	send_command('bind @w gs c toggle WeaponLock')
    send_command('bind @e gs c cycleback WeaponSet')
    send_command('bind @r gs c cycle WeaponSet')
	send_command('bind !- gs c toggle Schere')
    send_command('bind != gs c toggle SubtleBlow')

	
	send_command('bind ^b input /ja "Boost" <me>')

    if player.sub_job == 'WAR' then
		send_command('bind ^numpad/ input /ja "Berserk" <me>')
		send_command('bind ^numpad* input /ja "Warcry" <me>')
		send_command('bind ^numpad- input /ja "Aggressor" <me>')
		send_command('bind ^numpad+ input /ja "Provoke" <stnpc>')
	elseif player.sub_job == 'DNC' then
		send_command('bind ^numpad/ input /ja "Haste Samba" <me>')
		send_command('bind ^numpad* input /ja "Quickstep" <t>')
		send_command('bind ^numpad- input /ja "Box Step" <t>')
		send_command('bind ^numpad+ input /ja "Animated Flourish" <stnpc>')
		send_command('bind !numpad/ input /ja "Curing Waltz III" <stpt>')
		send_command('bind !numpad* input /ja "Divine Waltz" <me>')
		send_command('bind !numpad- input /ja "Healing Waltz" <stpt>')
	elseif player.sub_job == 'DRG' then
		send_command('bind ^numpad/ input /ja "Jump" <t>')
		send_command('bind ^numpad* input /ja "High Jump" <t>')
		send_command('bind ^numpad- input /ja "Super Jump" <t>')
	elseif player.sub_job == 'RUN' then
		send_command('bind ^numpad/ input /ja "Swordplay" <me>')
		send_command('bind ^numpad* input /ja "Pflug" <me>')
		send_command('bind ^numpad- input /ja "Valiance" <me>')
		send_command('bind !numpad- input /ja "Vallation" <me>')
		send_command('bind ^numpad+ input /ma "Flash" <stnpc>')
	elseif player.sub_job == 'COR' then
		send_command('bind ^numpad/ input /ja "Corsair\'s Roll" <me>')
		send_command('bind ^numpad* input /ja "Double Up" <me>')
	end

	--H2H--
	send_command('bind ^numpad6 input /ws "Asuran Fists" <t>')
    send_command('bind ^numpad5 input /ws "Raging Fists" <t>')
    send_command('bind ^numpad4 input /ws "Dragon Kick" <t>')
    send_command('bind ^numpad3 input /ws "Howling Fist" <t>')
    send_command('bind ^numpad2 input /ws "Victory Smite" <t>')
    send_command('bind ^numpad1 input /ws "Shijin Spiral" <t>')
	send_command('bind ^numpad0 input /ws "Tornado Kick" <t>')
	--Staff--
    send_command('bind !numpad4 input /ws "Retribution" <t>')
    send_command('bind !numpad3 input /ws "Full Swing" <t>')
    send_command('bind !numpad2 input /ws "Earth Crusher" <t>')
    send_command('bind !numpad1 input /ws "Shattersoul" <t>')
	send_command('bind !numpad0 input /ws "Cataclysm" <t>')
	
	send_command('bind @m input /mount "Byakko"')

    select_default_macro_book()
    set_lockstyle()
	
    state.Auto_Kite = M(false, 'Auto_Kite')
    Haste = 0
    DW_needed = 0
    DW = false
    moving = false
    update_combat_form()
    determine_haste_group()
	
	state.Schere:toggle()

end

function user_unload()
    send_command('unbind ^`')
    send_command('unbind @c')
	send_command('unbind @w')
    send_command('unbind @e')
    send_command('unbind @r')	
	send_command('unbind ^b')
	send_command('unbind !,')
	send_command('unbind !.')
    send_command('unbind ^numpad/')
    send_command('unbind ^numpad*')
    send_command('unbind ^numpad-')
	send_command('unbind ^numpad7')
	send_command('unbind ^numpad6')
    send_command('unbind ^numpad5')
    send_command('unbind ^numpad4')
    send_command('unbind ^numpad3')
    send_command('unbind ^numpad2')
    send_command('unbind ^numpad1')
    send_command('unbind ^numpad0')
	send_command('unbind !numpad4')
    send_command('unbind !numpad3')
    send_command('unbind !numpad2')
    send_command('unbind !numpad1')
    send_command('unbind !numpad0')
    send_command('unbind ^numpad.')
	send_command('unbind @m')
end

-- Define sets and vars used by this job file.
function init_gear_sets()

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Fast cast sets for spells
    sets.precast.FC = {
        ammo="Sapience Orb",						--2
        head=gear.Herc_FC_head, 					--7
        body=gear.Taeon_FC_body, 					--9
        hands="Leyline Gloves", 					--8
		waist="Windbuffet Belt +1",
        legs="Rawhide Trousers", 					--5
        feet="Mummu Gamashes +2", 					--2
		neck="Baetyl Pendant", 						--4
        ear1="Loquacious Earring", 					--2
		ear2="Etiolation Earring",					--1
		ring1="Medada's Ring",						--10
        ring2="Weatherspoon Ring", 					--5 "Weather. Ring +1", --6(4)
        } --FC +53%

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
        body="Passion Jacket",
		neck="Magoraga Beads",
        })

    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.WS = {
        ammo="Coiste Bodhar",
        head=gear.Adhemar_B_head,
        body="Bhikku Cyclas +3",
        hands="Mpaca's Gloves",
        legs="Mpaca's Hose",
        feet="Mpaca's Boots",
        neck="Fotia Gorget",
        ear1="Sherida Earring",
        ear2="Odr Earring",
        ring1="Niqmaddu Ring",
        ring2="Gere Ring",
        back=gear.MNK_STR_WS_Cape,
        waist="Moonbow Belt +1",
        } -- default set
	
	sets.precast.WS['Shijin Spiral'] = set_combine(sets.precast.WS, {
		head="Mpaca's Cap",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		ear2="Mache Earring +1",
		back="Sacro Mantle",
		})
		
	sets.precast.WS['Victory Smite'] = set_combine(sets.precast.WS, {
		body="Mpaca's Doublet",
		hands="Mummu Wrists +2",
		})
	
	sets.precast.WS.Critical = set_combine(sets.precast.WS['Victory Smite'], {
		body="Bhikku Cyclas +3",
		})
		
	sets.precast.WS['Howling Fist'] = set_combine(sets.precast.WS, {
		ammo="Knobkierrie",
		head="Mpaca's Cap",
		body="Mpaca's Doublet",
		ear1="Moonshade Earring",
		ear2="Schere Earring",
		})
	
	sets.precast.WS['Tornado Kick'] = set_combine(sets.precast.WS, {
		head="Mpaca's Cap",
		body="Mpaca's Doublet",
		feet="Anch. Gaiters +3",
		neck="Monk's Nodowa +1",
		ear2="Moonshade Earring",
		})
		
	sets.precast.WS['Dragon Kick'] = sets.precast.WS['Tornado Kick']
	
	sets.precast.WS.Footwork = set_combine(sets.precast.WS['Tornado Kick'], {
		feet="Shukuyu Sune-Ate",
		})
	
	sets.precast.WS['Raging Fists'] = set_combine(sets.precast.WS, {
		head="Mpaca's Cap",
		body="Mpaca's Doublet",
		hands="Mummu Wrists +2",
		})
		
	sets.precast.WS['Cataclysm'] = set_combine(sets.precast.WS, {
		ammo="Ghastly Tathlum +1",
		head="Pixie Hairpin +1",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Sibyl Scarf",
		ear1="Friomisi Earring",
		ear2="Moonshade Earring",
		ring1="Medada's Ring",
		ring2="Archon Ring",
		back="Sacro Mantle",
		waist="Orpheus's Sash",
		})
		
    ------------------------------------------------------------------------------------------------
    ------------------------------------- Job Ability Sets -----------------------------------------
    ------------------------------------------------------------------------------------------------
	
	sets.precast.JA['Boost'] = {
		ammo="Staunch Tathlum +1",
		ead=empty,
		body=empty,
		hands=empty,
		legs=empty,
		feet=empty,
		neck="Loricate Torque +1",
		ring1="Sljor Ring",
		ring2="Defending Ring",
		ear1="Eabani Earring",
		ear2="Odnowa Earring +1",
		waist="Ask Sash",
		back="Moonbeam Cape",
		}
	
	sets.precast.JA['Chakra'] = {
		ammo="Aurgelmir Orb",
		head="Mpaca's Cap",
		body="Anch. Cyclas +2",
		hands="Hes. Gloves +3",
		legs="Tatena. Haidate +1",
		feet="Nyame Sollerets",
		neck="Unmoving Collar +1",
		ear1="Odnowa Earring +1",
		ear2="Tuisto Earring",
		ring1="Niqmaddu Ring",
		ring2="Gelatinous Ring +1",
		back="Moonbeam Cape",																		--gear.MNK_Chakra_Cape,
		waist="Plat. Mog. Belt",																	--"Latria Sash",
		}
	
	sets.precast.JA['Chi Blast'] = {
		ammo="Hydrocera",
		head="Hes. Crown +2",
		body="Nyame Mail",
		hands="Anchor. Gloves +2",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Monk's Nodowa +1",
		ear1="Influx Earring",
		ring1="Metamor. Ring +1",
		ring2="Stikini Ring +1",
		back=gear.MNK_ChiBlast_Cape,
		waist="Rumination Sash",
		}
		
	sets.precast.JA['Mantra'] = {feet="Hes. Gaiters +3", back="Moonbeam Cape", waist="Plat. Mog. Belt"}
	sets.precast.JA['Formless Strikes'] = {body="Hes. Cyclas +3"}
	sets.precast.JA['Perfect Counter'] = {head="Bhikku Crown +2"}
	sets.precast.JA['Focus'] = {head="Anch. Crown +2"}
	sets.precast.JA['Dodge'] = {feet="Anch. Gaiters +3"}
	sets.precast.JA['Footwork'] = {feet="Bhikku Gaiters +2"}
	sets.precast.JA['Hundred Fists'] = {legs="Hes. Hose +3"}
	
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.idle = {
        ammo="Staunch Tathlum +1",					--DT 3
        head="Bhikku Crown +2",						--Evasion +81, DT 10
        body="Mpaca's Doublet",						--Evasion +102, PDT 10
        hands="Mpaca's Gloves",						--Evasion +80, PDT 8
        legs="Bhikku Hose +3",						--Evasion +109, DT 13
        feet="Bhikku Gaiters +2",					--Evasion +112, DT 9
        neck="Bathy Choker +1",						--Evasion +15
        ear1="Eabani Earring",						--Evasion +15
        ear2="Infused Earring",						--Evasion +10
        ring1="Warden's Ring",						--PDT 3, EnemyCrit -5, Resist Death +10
        ring2="Defending Ring",						--DT 10
        back="Relucent Cape",						--Evasion +20
        waist="Moonbow Belt +1",					--DT 5
        }
	--Evasion 1113, Defense 1288, DT 52, PDT 21
	
	sets.idle.Dynamis = set_combine(sets.idle, {
		neck="Mnk. Nodowa +1",
		})
	
	sets.idle.DT = set_combine(sets.idle, {
		ammo="Staunch Tathlum +1",
        neck="Warder's Charm +1",
		ear2="Odnowa Earring +1",
        ring1="Warden's Ring",
		ring2="Shadow Ring",
		waist="Engraved Belt",
        })
	--DT 50, Resist Death +35%, Absorb Magic +18%, Eva +496, MEva +575
	
	sets.idle.Regen = set_combine(sets.idle.DT, {
		head="Rao Kabuto",							--Regen +2										--head="Rao Kabuto +1",
		body="Hiza. Haramaki +2",					--Regen +12
																									--hands="Rao Kote +1",
		legs="Rao Haidate +1",						--Regen +3
		feet="Rao Sune-Ate",						--Regen +1										--"Rao Sune-Ate +1",
																									--ear1="Dawn Earring",
		ring1="Chirich Ring +1",					--Regen +2
		ring2="Chirich Ring +1",					--Regen +2
		})
	--Regen +21

    sets.idle.Weak = sets.idle.DT
	sets.Kiting = {feet="Herald's Gaiters", ring2="Defending Ring"}

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.engaged = {
        ammo="Coiste Bodhar",
        head="Mpaca's Cap",
        body="Mpaca's Doublet",
        hands="Mpaca's Gloves",
        legs="Bhikku Hose +3",
        feet="Anch. Gaiters +3",
        neck="Monk's Nodowa +1",
        ear1="Sherida Earring",
        ear2="Bhikku Earring +1",
        ring1="Niqmaddu Ring",
        ring2="Gere Ring",
        back=gear.MNK_TP_Cape,
        waist="Moonbow Belt +1",
        }	-- Haste 256/1024, DEX+241, Acc 1291, Att 1596, Subtle Blow I +43, Subtle Blow II +25, DT -25, PDT -17
			-- Evasion 980, Defense 1287, MDB +40
		
	sets.engaged.Accuracy = set_combine(sets.engaged, {
		ammo="Voluspa Tathlum",
		hands="Gazu Bracelets +1",
		ear1="Telos Earring",
		ring2="Chirich Ring +1",
		})	-- Haste 256/1024, DEX+229, Acc 1354, Att 1521, Subtle Blow I +45, Subtle Blow II +20, DT -25, PDT -17
			-- Evasion 969, Defense 1303, MDB +40
		
	sets.engaged.HighAcc = set_combine(sets.engaged.Accuracy, {
		head="Anch. Crown +2",
		body="Bhikku Cyclas +3",
		})	-- Haste 256/1024, DEX+226, Acc 1388, Att 1510, Subtle Blow I +46, Subtle Blow II +20, DT -25
			-- Evasion 937, Defense 1260, MDB +26
	
	--Martial Arts sets
	sets.engaged.MA = set_combine(sets.engaged, {
		ear2="Mache Earring +1",
        }) 	-- Haste 256/1024, DEX+228, Acc 1235, Att 1540, Subtle Blow I +42, Subtle Blow II +25, DT -25, PDT -17
			-- Evasion 975, Defense 1254, MDB +40

    sets.engaged.MA.Accuracy = set_combine(sets.engaged.MA, {
		ammo="Voluspa Tathlum",
		hands="Gazu Bracelets +1",
		ear1="Telos Earring",
		ring2="Chirich Ring +1",
        })	-- Haste 256/1024, DEX+217, Acc 1316, Att 1473, Subtle Blow I +45, Subtle Blow II +20, DT -25, PDT -17
			-- Evasion 969, Defense 1273, MDB +40

    sets.engaged.MA.HighAcc = set_combine(sets.engaged.MA.Accuracy, {
		head="Anch. Crown +2",
		body="Bhikku Cyclas +3",
        })	-- Haste 256/1024, DEX+214, Acc 1350, Att 1461, Subtle Blow I +45, Subtle Blow II +20, DT -25
			-- Evasion 937, Defense 1230, MDB +26
			
	--Staff sets
	sets.engaged.STAFF = set_combine(sets.engaged, {
		legs="Tatena. Haidate +1",
		feet="Malignance Boots",
		neck="Combatant's Torque",
		ear2="Dedition Earring",		
        }) 	-- Haste 256/1024, DEX+229, Acc 1220, Att 1515, Subtle Blow I +43, Subtle Blow II +25, DT -15, PDT -17
			-- Evasion 954, Defense 1243, MDB +36

    sets.engaged.STAFF.Accuracy = set_combine(sets.engaged.STAFF, {
		ammo="Voluspa Tathlum",
		hands="Gazu Bracelets +1",
		ear1="Telos Earring",
		ring2="Chirich Ring +1",
        })	-- Haste 256/1024, DEX+217, Acc 1285, Att 1443, Subtle Blow I +45, Subtle Blow II +20, DT -15, PDT -17
			-- Evasion 945, Defense 1261, MDB +36

    sets.engaged.STAFF.HighAcc = set_combine(sets.engaged.STAFF.Accuracy, {
		head="Malignance Chapeau",
		body="Bhikku Cyclas +3",
        })	-- Haste 256/1024, DEX+229, Acc 1328, Att 1412, Subtle Blow I +45, Subtle Blow II +20, DT -21
			-- Evasion 958, Defense 1217, MDB +23

	--Subtle Blow sets
	sets.engaged.SB = set_combine(sets.engaged, {
		head="Bhikku Crown +2",
		hands="Hes. Gloves +3",
        })	-- Haste 256/1024, DEX+236, Acc 1288, Att 1690, Subtle Blow I +58, Subtle Blow II +25, DT -35, PDT -10
			-- Evasion 982, Defense 1282, MDB +36

    sets.engaged.SB.Accuracy = set_combine(sets.engaged.SB, {
		ammo="Voluspa Tathlum",
		head="Mpaca's Cap",
		ear1="Telos Earring",
		ring2="Chirich Ring +1",
        })	-- Haste 256/1024, DEX+226, Acc 1308, Att 1639, Subtle Blow I +55, Subtle Blow II +20, DT -25, PDT -17
			-- Evasion 989, Defense 1302, MDB +41
			
    sets.engaged.SB.HighAcc = set_combine(sets.engaged.SB.Accuracy, {
		body="Bhikku Cyclas +3",
		hands="Gazu Bracelets +1",
        })	-- Haste 256/1024, DEX+231, Acc 1379, Att 1561, Subtle Blow I +45, Subtle Blow II +20, DT -25, PDT -7
			-- Evasion 978, Defense 1291, MDB +34
		
	--Subtle Blow + MA sets
	sets.engaged.MASB = set_combine(sets.engaged, {
		head="Bhikku Crown +2",
		hands="Hes. Gloves +3",
		ear2="Mache Earring +1",
        })	-- Haste 256/1024, DEX+224, Acc 1255, Att 1635, Subtle Blow I +58, Subtle Blow II +25, DT -35, PDT -10
			-- Evasion 980, Defense 1250, MDB +36

    sets.engaged.MASB.Accuracy = set_combine(sets.engaged.MASB, {
		ammo="Voluspa Tathlum",
		head="Mpaca's Cap",
		ear1="Telos Earring",
		ring2="Chirich Ring +1",
        })	-- Haste 252/1024, DEX+219, Acc 1270, Att 1591, Subtle Blow I +55, Subtle Blow II +20, DT -25, PDT -17
			-- Evasion 989, Defense 1272, MDB +41

    sets.engaged.MASB.HighAcc = set_combine(sets.engaged.MASB.Accuracy, {
		body="Bhikku Cyclas +3",
		hands="Gazu Bracelets +1",
        })	-- Haste 256/1024, DEX+219, Acc 1341, Att 1513, Subtle Blow I +45, Subtle Blow II +20, DT -25, PDT -7
			-- Evasion 978, Defense 1261, MDB +34
	
	--Subtle Blow + STAFF sets
	sets.engaged.STAFFSB = set_combine(sets.engaged.STAFF, {
		head="Bhikku Crown +2",
        })	-- Haste 256/1024, DEX+224, Acc 1228, Att 1523, Subtle Blow I +56, Subtle Blow II +25, DT -25, PDT -10
			-- Evasion 945, Defense 1222, MDB +32

    sets.engaged.STAFFSB.Accuracy = set_combine(sets.engaged.STAFFSB, {
		ammo="Voluspa Tathlum",
		hands="Malignance Gloves",
		ear2="Schere Earring",
		ring2="Chirich Ring +1",
        })	-- Haste 256/1024, DEX+231, Acc 1276, Att 1499, Subtle Blow I +61, Subtle Blow II +25, DT -30, PDT -10
			-- Evasion 998, Defense 1241, MDB +33

    sets.engaged.STAFFSB.HighAcc = set_combine(sets.engaged.STAFFSB.Accuracy, {
		body="Bhikku Cyclas +3",
		hands="Gazu Bracelets +1",
        })	-- Haste 256/1024, DEX+219, Acc 1337, Att 1514, Subtle Blow I +61, Subtle Blow II +25, DT -25
			-- Evasion 945, Defense 1228, MDB +25

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

	sets.engaged.Hybrid = {
		head="Bhikku Crown +2",
		feet="Mpaca's Boots",
		ring2="Defending Ring",
		}
		
    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.Accuracy.DT = set_combine(sets.engaged.Accuracy, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT = set_combine(sets.engaged.HighAcc, sets.engaged.Hybrid)
	
    sets.engaged.MA.DT = set_combine(sets.engaged.MA, sets.engaged.Hybrid)
    sets.engaged.MA.Accuracy.DT = set_combine(sets.engaged.MA.Accuracy, sets.engaged.Hybrid)
    sets.engaged.MA.HighAcc.DT = set_combine(sets.engaged.MA.HighAcc, sets.engaged.Hybrid)
	
	sets.engaged.STAFF.DT = set_combine(sets.engaged.STAFF, sets.engaged.Hybrid)
    sets.engaged.STAFF.Accuracy.DT = set_combine(sets.engaged.STAFF.Accuracy, sets.engaged.Hybrid)
    sets.engaged.STAFF.HighAcc.DT = set_combine(sets.engaged.STAFF.HighAcc, sets.engaged.Hybrid)
	
	sets.engaged.SB.DT = set_combine(sets.engaged.SB, sets.engaged.Hybrid)
    sets.engaged.SB.Accuracy.DT = set_combine(sets.engaged.SB.Accuracy, sets.engaged.Hybrid)
    sets.engaged.SB.HighAcc.DT = set_combine(sets.engaged.SB.HighAcc, sets.engaged.Hybrid)
	
    sets.engaged.MASB.DT = set_combine(sets.engaged.MASB, sets.engaged.Hybrid)
    sets.engaged.MASB.Accuracy.DT = set_combine(sets.engaged.MASB.Accuracy, sets.engaged.Hybrid)
    sets.engaged.MASB.HighAcc.DT = set_combine(sets.engaged.MASB.HighAcc, sets.engaged.Hybrid)
	
	sets.engaged.STAFFSB.DT = set_combine(sets.engaged.STAFFSB, sets.engaged.Hybrid)
    sets.engaged.STAFFSB.Accuracy.DT = set_combine(sets.engaged.STAFFSB.Accuracy, sets.engaged.Hybrid)
    sets.engaged.STAFFSB.HighAcc.DT = set_combine(sets.engaged.STAFFSB.HighAcc, sets.engaged.Hybrid)
	
	sets.engaged.Counter = {
		ammo="Amar Cluster", 						--Counter +2
		body="Hes. Cyclas +3",						--Counter +5, Counter Crit +30%
		hands=gear.Herc_Counter_hands,				--Counter +5
		legs="Anch. Hose +3",						--Counter +6, Counter Att +20
		feet="Hes. Gaiters +3",						--Counter Att +24, Counter Crit +15%
		neck="Bathy Choker +1",						--Counter +10
		ear1="Odr Earring",							--Crit +5%
		ear2="Bhikku Earring +1",					--Counter +8
		ring1="Ilabrat Ring",
		ring2="Defending Ring",
		back=gear.MNK_Counter_Cape,					--Crit +10%, (Counter +10)
		}	-- Counter +63 (+73 with finished cape, +87 with finished Spharai), Crit +20%, Counter Crit +45%, Counter Att +34
		
	sets.engaged.CTR = set_combine(sets.engaged, sets.engaged.Counter)
    sets.engaged.Accuracy.CTR = set_combine(sets.engaged.Accuracy, sets.engaged.Counter)
    sets.engaged.HighAcc.CTR = set_combine(sets.engaged.HighAcc, sets.engaged.Counter)
	
    sets.engaged.MA.CTR = set_combine(sets.engaged.MA, sets.engaged.Counter)
    sets.engaged.MA.Accuracy.CTR = set_combine(sets.engaged.MA.Accuracy, sets.engaged.Counter)
    sets.engaged.MA.HighAcc.CTR = set_combine(sets.engaged.MA.HighAcc, sets.engaged.Counter)
	
	sets.engaged.STAFF.CTR = set_combine(sets.engaged.STAFF, sets.engaged.Counter)
    sets.engaged.STAFF.Accuracy.CTR = set_combine(sets.engaged.STAFF.Accuracy, sets.engaged.Counter)
    sets.engaged.STAFF.HighAcc.CTR = set_combine(sets.engaged.STAFF.HighAcc, sets.engaged.Counter)
	
	sets.engaged.SB.CTR = set_combine(sets.engaged.SB, sets.engaged.Counter)
	-- Haste 242/1024, DEX+218, Acc 1222, Att 1596, Subtle Blow I +46, Subtle Blow II +15, DT -21, PDT -15
	-- Evasion 997, Defense 1280, MDB +37
    sets.engaged.SB.Accuracy.CTR = set_combine(sets.engaged.SB.Accuracy, sets.engaged.Counter)
    sets.engaged.SB.HighAcc.CTR = set_combine(sets.engaged.SB.HighAcc, sets.engaged.Counter)
	
    sets.engaged.MASB.CTR = set_combine(sets.engaged.MASB, sets.engaged.Counter)
    sets.engaged.MASB.Accuracy.CTR = set_combine(sets.engaged.MASB.Accuracy, sets.engaged.Counter)
    sets.engaged.MASB.HighAcc.CTR = set_combine(sets.engaged.MASB.HighAcc, sets.engaged.Counter)
	
	sets.engaged.STAFFSB.CTR = set_combine(sets.engaged.STAFFSB, sets.engaged.Counter)
    sets.engaged.STAFFSB.Accuracy.CTR = set_combine(sets.engaged.STAFFSB.Accuracy, sets.engaged.Counter)
    sets.engaged.STAFFSB.HighAcc.CTR = set_combine(sets.engaged.STAFFSB.HighAcc, sets.engaged.Counter)
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------
	
	sets.buff.Counterstance = set_combine(sets.engaged, sets.engaged.Counter)
	--Counter (Base with Counterstance: 45%) +39% = 84% [Cap = 80%]
	
	sets.buff.Impetus = {body="Bhikku Cyclas +3"}
	
	sets.buff.Boost = {
	ammo="Staunch Tathlum +1",
	head=empty,
	body=empty,
	hands=empty,
	legs=empty,
	feet=empty,
	neck="Loricate Torque +1",
	ring1="Sljor Ring",
	ring2="Defending Ring",
	ear1="Eabani Earring",
	ear2="Odnowa Earring +1",
	waist="Ask Sash",
	back="Moonbeam Cape",
	}
	
    sets.buff.Doom = {
		neck="Nicander's Necklace", 		--20
        ring1="Saida Ring", 				--15
        ring2="Purity Ring", 				--7
        waist="Gishdubar Sash", 			--10
        }
	--Cursna +32

    -- sets.CP = {back="Mecisto. Mantle"}
    sets.TreasureHunter = { 
		ammo="Perfect Lucky Egg",	-- +1
		body="Volte Jupon",		-- +2
		legs="Volte Hose",		-- +1
		} -- +4
		
    -- sets.Reive = {neck="Ygnas's Resolve +1"}
	sets.Schere ={right_ear="Schere Earring"}
	
	-- Weapon Sets
	sets.Godhands = {main="Godhands", sub=empty}
	sets.Karambit = {main="Karambit", sub=empty}
	sets.Xoanon = {main="Xoanon", sub="Rigorous Grip +1"}
	sets.Staff = {main="Mercurial Pole", sub="Alber Strap"}


end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

function job_buff_change(buff,gain)
    -- If we gain or lose any haste buffs, adjust which gear set we target.
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

end

function job_post_precast(spell, action, spellMap, eventArgs)
    if state.Buff.Impetus and spell.english == 'Victory Smite' then
            equip(sets.precast.WS.Critical)
    end
    if state.Buff.Footwork and (spell.english == 'Tornado Kick' or spell.english == 'Dragon Kick' )then
            equip(sets.precast.WS.Footwork)
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
	if player.equipment.main == 'Godhands' then
		MA = true
	else
		MA = false
	end
	
	if player.equipment.main == 'Xoanon' or player.equipment.main == 'Mercurial Pole' then
		STAFF = true
	else
		STAFF = false
	end
	
	if MA == true and state.SubtleBlow.value == true then
        state.CombatForm:set('MASB')
	elseif STAFF == true and state.SubtleBlow.value == true then
		state.CombatForm:set('STAFFSB')
    elseif state.SubtleBlow.value == true then
        state.CombatForm:set('SB')
    elseif MA == true then
        state.CombatForm:set('MA')
	elseif STAFF == true then
		state.CombatForm:set('STAFF')
    else
        state.CombatForm:reset()
    end
end

function get_custom_wsmode(spell, action, spellMap)
    local wsmode
    if state.OffenseMode.value == 'HighAcc' then
        wsmode = 'Acc'
    end

    return wsmode
end

-- Modify the default idle set after it was constructed.
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
    --     equip(sets.CP)
    --     disable('back')
    -- else
    --     enable('back')
    -- end
    if state.Buff.Boost then
       idleSet = set_combine(idleSet, sets.buff.Boost)
    end
	if state.Auto_Kite.value == true then
       idleSet = set_combine(idleSet, sets.Kiting)
    end

    return idleSet
end


-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
	-- if state.Buff.Dodge then
		-- meleeSet = set_combine(meleeSet, sets.buff.Dodge)
	-- end
	-- if state.Buff.Focus then
		-- meleeSet = set_combine(meleeSet, sets.buff.Focus)
	-- end
	if state.Buff.Counterstance then
		meleeSet = set_combine(meleeSet, sets.buff.Counterstance)
	end
	if state.Buff.Impetus then
		meleeSet = set_combine(meleeSet, sets.buff.Impetus)
	end
	if state.Buff.Boost then
		meleeSet = set_combine(meleeSet, sets.buff.Boost)
	end
    if state.TreasureMode.value == 'Fulltime' then
        meleeSet = set_combine(meleeSet, sets.TreasureHunter)
    end
	if state.Schere.value == true then
		 meleeSet = set_combine(meleeSet, sets.Schere)
	end

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
	-- if no_swap_gear:contains(player.equipment.main) then
		-- disable("main")
	-- else
		-- enable("main")
	-- end
	-- if no_swap_gear:contains(player.equipment.sub) then
		-- disable("sub")
	-- else
		-- enable("sub")
	-- end
	-- if no_swap_gear:contains(player.equipment.ranged) then
		-- disable("ranged")
	-- else
		-- enable("ranged")
	-- end
	-- if no_swap_gear:contains(player.equipment.ammo) then
		-- disable("ammo")
	-- else
		-- enable("ammo")
	-- end
	if no_swap_gear:contains(player.equipment.head) then
		disable("head")
	else
		enable("head")
	end
	if no_swap_gear:contains(player.equipment.neck) then
		disable("neck")
	else
		enable("neck")
	end
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
	if no_swap_gear:contains(player.equipment.body) then
		disable("body")
	else
		enable("body")
	end
	if no_swap_gear:contains(player.equipment.hands) then
		disable("hands")
	else
		enable("hands")
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
	if no_swap_gear:contains(player.equipment.waist) then
		disable("waist")
	else
		enable("waist")
	end
	if no_swap_gear:contains(player.equipment.legs) then
		disable("legs")
	else
		enable("legs")
	end
	if no_swap_gear:contains(player.equipment.feet) then
		disable("feet")
	else
		enable("feet")
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
    if player.sub_job == 'WAR' then
        set_macro_page(1, 9)
    elseif player.sub_job == 'DNC' then
        set_macro_page(2, 9)
    elseif player.sub_job == 'DRG' then
        set_macro_page(3, 9)
	elseif player.sub_job == 'NIN' then
        set_macro_page(4, 9)
	else set_macro_page(3, 9)
    end
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset ' .. lockstyleset)
end
