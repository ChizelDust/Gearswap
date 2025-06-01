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
              "Trizek Ring", "Echad Ring", "Reraise Earring","Nexus Cape"}
	
    include('Mote-TreasureHunter')

    -- For th_action_check():
    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{35, 204}
    -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
    info.default_u_ja_ids = S{201, 202, 203, 205, 207}
	
	-- Healing Breath trigger info
    info.MageSubs = S{'WHM', 'BLM', 'RDM', 'BLU', 'SCH', 'GEO'}
    info.HybridSubs = S{'PLD', 'DRK', 'BRD', 'NIN', 'RUN'}

    lockstyleset = 22

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

function user_setup()
    state.OffenseMode:options('Normal','Accuracy','Critical')
    state.WeaponskillMode:options('Normal','Crit')
    state.HybridMode:options('Normal', 'DT')
    state.IdleMode:options('Normal','Regain','DT')
	
	state.WeaponSet = 	M{['description']='Weapon Set','Trishula','ShiningOne','Naegling','StaffWSD','Cataclysm','Gozuki','Quint','GaeBuide'}
	
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

    if player.sub_job == 'WAR' then
		send_command('bind ^numpad/ input /ja "Berserk" <me>')
		send_command('bind ^numpad* input /ja "Warcry" <me>')
		send_command('bind ^numpad- input /ja "Aggressor" <me>')
		send_command('bind ^numpad+ input /ja "Provoke" <stnpc>')
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

    send_command('bind ^numpad9 input /ws "Full Swing" <t>')
    send_command('bind ^numpad8 input /ws "Drakesbane" <t>')
    send_command('bind ^numpad7 input /ws "Camlann\'s Torment" <t>')
    send_command('bind ^numpad6 input /ws "Impulse Drive" <t>')
    send_command('bind ^numpad5 input /ws "Wheeling Thrust" <t>')
    send_command('bind ^numpad4 input /ws "Stardiver" <t>')
    send_command('bind ^numpad3 input /ws "Shell Crusher" <t>')
    send_command('bind ^numpad2 input /ws "Leg Sweep" <t>')
    send_command('bind ^numpad1 input /ws "Sonic Thrust" <t>')
    send_command('bind ^numpad0 input /ws "Savage Blade" <t>')
	
    -- send_command('bind !numpad9 input /ws "Full Swing" <t>')
    -- send_command('bind !numpad8 input /ws "Drakesbane" <t>')
    -- send_command('bind !numpad7 input /ws "Camlann\'s Torment" <t>')
    -- send_command('bind !numpad6 input /ws "Impulse Drive" <t>')
    -- send_command('bind !numpad5 input /ws "Geirskogul" <t>')
    -- send_command('bind !numpad4 input /ws "Stardiver" <t>')
    send_command('bind !numpad3 input /ws "Penta Thrust" <t>')
    send_command('bind !numpad2 input /ws "Double Thrust" <t>')
    send_command('bind !numpad1 input /ws "Earth Crusher" <t>')
    send_command('bind !numpad0 input /ws "Cataclysm" <t>')

	send_command('bind @m input /mount "Spectral Chair"')	

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
	-- send_command('unbind !numpad9')
	-- send_command('unbind !numpad8')
	-- send_command('unbind !numpad7')
	-- send_command('unbind !numpad6')
    -- send_command('unbind !numpad5')
    -- send_command('unbind !numpad4')
    send_command('unbind !numpad3')
    send_command('unbind !numpad2')
    send_command('unbind !numpad1')
    send_command('unbind !numpad0')
	send_command('unbind !w')
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
													-- ear2="Enchntr. Earring +1", --2
		ring1="Medada's Ring",						--10
        ring2="Weatherspoon Ring", 					--5 "Weather. Ring +1", --6(4)
    } --FC +52%

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
        body="Passion Jacket",
		neck="Magoraga Beads",
    })

    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

	-- WS Sets
	sets.precast.WS = {
		ammo="Coiste Bodhar",
		head="Peltast's Mezail +3",
		body="Nyame Mail",						--"Gleti's Cuirass", R20+?
		hands="Nyame Gauntlets",
		legs="Ptero. Brais +3",
		feet="Nyame Sollerets",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		ear1="Sherida Earring",
		ear2="Moonshade Earring",
		ring1="Shukuyu Ring",
		ring2="Niqmaddu Ring",						--"Regal Ring",
		back=gear.DRG_Stardiver_Cape,
		}
	
	sets.Crit = {
		body="Hjarrandi Breast.",
		legs="Pelt. Brais +3",
		back=gear.DRG_Crit_Cape,
		}

	sets.precast.WS['Stardiver'] = set_combine(sets.precast.WS, {
		hands="Pel. Vambraces +2",
		})
	
	sets.precast.WS['Stardiver'].Crit = set_combine(sets.precast.WS['Stardiver'], sets.Crit)

	sets.precast.WS["Camlann's Torment"] = set_combine(sets.precast.WS, {
		ammo="Knobkierrie",
		hands="Ptero. Fin. G. +3",
		legs="Vishap Brais +3",
		neck="Dgn. Collar +1",						--"Rep. Plat. Medal",
		ear2="Thrud Earring",
		back=gear.DRG_WSD_Cape,
		})
	
	sets.precast.WS["Camlann's Torment"].Crit = set_combine(sets.precast.WS["Camlann's Torment"], sets.Crit)

	sets.precast.WS["Impulse Drive"] = set_combine(sets.precast.WS, {
		ammo="Knobkierrie",
		body="Hjarrandi Breast.",
		hands="Ptero. Fin. G. +3",
		legs="Pelt. Cuissots +3",
		feet="Nyame Sollerets",
		neck="Dgn. Collar +1",
		waist="Sailfi Belt +1",
		ear2="Thrud Earring",
		ring1="Begrudging Ring",
		back=gear.DRG_Crit_Cape,
		})
	
	sets.precast.WS["Impulse Drive"].Crit = sets.precast.WS["Impulse Drive"]

	sets.precast.WS["Drakesbane"] = set_combine(sets.precast.WS, {
		ammo="Knobkierrie",
		body="Hjarrandi Breast.",
		hands="Gleti's Gauntlets",
		legs="Pelt. Cuissots +3",
		neck="Dgn. Collar +1",						--"Rep. Plat. Medal",
		waist="Sailfi Belt +1",
		ear2="Thrud Earring",
		back=gear.DRG_Crit_Cape,
		})
	
	sets.precast.WS["Drakesbane"].Crit = sets.precast.WS["Drakesbane"]

	sets.precast.WS['Sonic Thrust'] = set_combine(sets.precast.WS, {
		ammo="Knobkierrie",
		hands="Ptero. Fin. G. +3",
		legs="Vishap Brais +3",
		neck="Dgn. Collar +1",						--"Rep. Plat. Medal",
		ear2="Thrud Earring",
		back=gear.DRG_WSD_Cape,
		})
	
	sets.precast.WS['Sonic Thrust'].Crit = set_combine(sets.precast.WS['Sonic Thrust'], sets.Crit)

	sets.precast.WS['Wheeling Thrust'] = set_combine(sets.precast.WS, {
		ammo="Knobkierrie",
		hands="Ptero. Fin. G. +3",
		legs="Vishap Brais +3",
		neck="Dgn. Collar +1",						--"Rep. Plat. Medal",
		ear2="Thrud Earring",
		back=gear.DRG_WSD_Cape,
		})
	
	sets.precast.WS['Wheeling Thrust'].Crit = set_combine(sets.precast.WS['Wheeling Thrust'], sets.Crit)

	sets.precast.WS['Leg Sweep'] = set_combine(sets.precast.WS, {
		ammo="Pemphredo Tathlum",
		body="Pelt. Plackart +2",
		hands="Pel. Vambraces +2",
		legs="Pelt. Cuissots +3",
		feet="Pelt. Schyn. +2",
		ear1="Digni. Earring",					--"Crep. Earring",
		ring1="Stikini Ring",					--"Crepuscular Ring",
		ring2="Metamor. Ring +1",
		back=gear.DRG_TP_Cape,
		})
	
	sets.precast.WS['Leg Sweep'].Crit = sets.precast.WS['Leg Sweep']

	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
		ammo="Knobkierrie",
		hands="Ptero. Fin. G. +3",
		legs="Nyame Flanchard",
		neck="Dgn. Collar +1",						--"Rep. Plat. Medal",
		waist="Sailfi Belt +1",
		ring2="Epaminondas's Ring",					--"Regal Ring",
		back=gear.DRG_WSD_Cape,
		})
	
	sets.precast.WS['Savage Blade'].Crit = set_combine(sets.precast.WS['Savage Blade'], sets.Crit)

	sets.precast.WS['Shell Crusher'] = set_combine(sets.precast.WS, {
		ammo="Knobkierrie",
		hands="Ptero. Fin. G. +3",
		legs="Vishap Brais +3",
		neck="Dgn. Collar +1",						--"Rep. Plat. Medal",
		waist="Sailfi Belt +1",
		ear2="Digni. Earring",
		ring1="Flamma Ring",
		ring2="Stikini Ring",
		back=gear.DRG_WSD_Cape,
		})
	
	sets.precast.WS['Shell Crusher'].Crit = sets.precast.WS['Shell Crusher']
	
	sets.precast.WS['Full Swing'] = set_combine(sets.precast.WS, {
		ammo="Knobkierrie",
		hands="Ptero. Fin. G. +3",
		legs="Vishap Brais +3",
		neck="Dgn. Collar +1",						--"Rep. Plat. Medal",
		waist="Sailfi Belt +1",
		ear1="Crep. Earring",
		ring2="Epaminondas's Ring",
		back=gear.DRG_WSD_Cape,
		})
	
	sets.precast.WS['Full Swing'].Crit = set_combine(sets.precast.WS['Full Swing'], sets.Crit)
	
	sets.precast.WS['Cataclysm'] = set_combine(sets.precast.WS, {
		ammo="Knobkierrie",
		head="Pixie Hairpin +1",
		legs="Nyame Flanchard",
		neck="Baetyl Pendant",						--"Rep. Plat. Medal",
		waist="Sailfi Belt +1",
		ear1="Friomisi Earring",
		ring1="Archon Ring",
		ring2="Epaminondas's Ring",
		back=gear.DRG_WSD_Cape,
		})
	
	sets.precast.WS['Cataclysm'].Crit = sets.precast.WS['Cataclysm']
	
    ------------------------------------------------------------------------------------------------
    ------------------------------------- Job Ability Sets -----------------------------------------
    ------------------------------------------------------------------------------------------------
	
	sets.precast.JA.Angon = {ammo="Angon", hands="Ptero. Fin. G. +3"}

	sets.Jump = {
		ammo="Aurgelmir Orb",
		head="Flam. Zucchetto +2",
		body="Ptero. Mail +3",
		hands="Crusher Gauntlets",					--"Vis. Fng. Gaunt. +3"
		legs="Ptero. Brais +3",
		feet="Vishap Greaves +3",
		neck="Vim Torque +1",
		waist="Ioskeha Belt +1",
		ear1="Sherida Earring",
		ear2="Cessance Earring",
		ring1="Petrov Ring",
		ring2="Niqmaddu Ring",
		back=gear.DRG_TP_Cape,
	}
	
	sets.precast.JA.Jump = sets.Jump
	sets.precast.JA['High Jump'] = set_combine(sets.Jump, {feet="Ostro Greaves",})
	sets.precast.JA['Spirit Jump'] = set_combine(sets.Jump, {feet="Pelt. Schyn. +2",})

	sets.precast.JA['Soul Jump'] = set_combine(sets.Jump, {
		body="Vishap Mail +2",
		hands=gear.Acro_TP_hands,
		legs="Pelt. Cuissots +3",
		feet="Ostro Greaves",
	})

	sets.precast.JA['Super Jump'] = {}
	sets.precast.JA['Spirit Link'] = {head="Vishap Armet +2", hands="Pel. Vambraces +2", feet="Ptero. Greaves +2", ear2="Pratik Earring",}
	sets.precast.JA['Call Wyvern'] = {body="Ptero. Mail +3"}
	sets.precast.JA['Spirit Surge'] = {body="Ptero. Mail +3"}
	sets.precast.JA['Ancient Circle'] = {legs="Vishap Brais +3"}
	
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.idle = {
		ammo="Staunch Tathlum",
		head="Hjarrandi Helm",
		body="Hjarrandi Breast.",
		hands="Gleti's Gauntlets",
		legs="Pelt. Cuissots +3",
		feet="Gleti's Boots",
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		ear1="Enmerkar Earring",
		ear2="Odnowa Earring +1",
		ring1="Moonbeam Ring",
		ring2="Warden's Ring",
		back=gear.DRG_Idle_Cape,
	}
	
	sets.idle.Regain = set_combine(sets.idle, {
		head="Gleti's Mask",
		body="Gleti's Cuirass",
		hands="Gleti's Gauntlets",
		legs="Gleti's Breeches",
		feet="Gleti's Boots",
	})
	
	sets.idle.DT = set_combine(sets.idle, {
        neck="Loricate Torque +1",
		ear1="Eabani Earring",
    })

    sets.idle.Weak = sets.idle.DT
	sets.Kiting = {ring1="Defending Ring", ring2="Shneddick Ring"}

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

	--To-Do: Make combat forms that play with the following: (Normal, Quint Spear, Naegling, Gozuki Mezuki)--
	
    sets.engaged = {
		ammo="Coiste Bodhar",
		head="Flam. Zucchetto +2",
		body="Hjarrandi Breastplate",	--"Gleti's Cuirass", (R20+)
		hands="Pel. Vambraces +2",
		legs="Ptero. Brais +3",			--"Gleti's Breeches", (R20+)
		feet=gear.Valorous_TP_feet,		--"Flamma Gambieras +2",
		neck="Vim Torque +1",
		waist="Ioskeha Belt +1",
		ear1="Sherida Earring",
		ear2="Brutal Earring",
		ring1="Lehko's Ring",
		ring2="Niqmaddu Ring",
		back=gear.DRG_TP_Cape,
	} -- STP +50, DT -36|PDT -36|MDT -38, Haste +242/1024, Acc +1188|Att +1414, DEF +1200
	
	sets.Accuracy = {}
	sets.engaged.Accuracy = set_combine(sets.engaged, sets.Accuracy)
	
	--sets.Quint = {}
	--sets.engaged.Quint = set_combine(sets.engaged, sets.Quint)
	--sets.engaged.Quint.Accuracy = set_combine(sets.engaged.Quint, sets.Accuracy)
	
	--sets.Naegling = {}
	--sets.engaged.Naegling = set_combine(sets.engaged, sets.Naegling)
	--sets.engaged.Naegling.Accuracy = set_combine(sets.engaged.Naegling, sets.Accuracy)
	
	--sets.Gozuki = {}
	--sets.engaged.Gozuki = set_combine(sets.engaged, sets.Gozuki)
	--sets.engaged.Gozuki.Accuracy = set_combine(sets.engaged.Gozuki, sets.Accuracy)
	
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

	sets.engaged.Hybrid = {
		head="Hjarrandi Helm",			--DT -10
		legs="Nyame Flanchard",			--DT -8
		feet="Nyame Sollerets",			--DT -7		
	}
		
    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
	-- STP +39, DT -41|PDT -44|MDT -41, Haste +256/1024, Acc +1117|Att +1436, DEF +1248
    sets.engaged.Accuracy.DT = set_combine(sets.engaged.Accuracy, sets.engaged.Hybrid)
	
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

	sets.buff.Doom = {
		neck="Nicander's Necklace", 		--20
        ring1="Saida Ring", 				--15
        ring2="Purity Ring", 				--7
        waist="Gishdubar Sash", 			--10
    }
	--Cursna +32

    sets.CP = {back="Mecisto. Mantle"}
    sets.TreasureHunter = { 
		ammo="Perfect Lucky Egg",	-- +1
		body="Volte Jupon",		-- +2
		legs="Volte Hose",		-- +1
	} -- +4
		
    -- sets.Reive = {neck="Ygnas's Resolve +1"}
	
	-- breath sets!
    sets.midcast.BreathTrigger = {
        head="Vishap Armet +2",
		body=gear.Acro_Breath_body,
        hands="Gleti's Gauntlets",
        legs="Vishap Brais +3",
        feet="Ptero. Greaves +2",
    }

    sets.midcast.Pet['Restoring Breath'] = {
        head="Ptero. Armet +2",
		body=gear.Acro_Breath_body,
        hands="Gleti's Gauntlets",
        legs="Vishap Brais +3",
        feet="Ptero. Greaves +2",
    }

    sets.midcast.Pet['Elemental Breath'] = {
        head="Ptero. Armet +2",
		body=gear.Acro_Breath_body,
        hands="Gleti's Gauntlets",
        legs="Pelt. Cuissots +3",
        feet="Pelt. Schyn. +2",
		neck="Adad Amulet",
		waist="Incarnation Sash",
    }
	
	-- Weapon Sets
	sets.Trishula = {main="Trishula", sub="Utu Grip"}
	sets.ShiningOne = {main="Shining One", sub="Utu Grip"}
	sets.Naegling = {main="Naegling", sub="Regis"}
	sets.StaffWSD = {main="Exalted Staff +1", sub="Utu Grip"}
	sets.Gozuki = {main="Gozuki Mezuki", sub="Utu Grip"}
	sets.Cataclysm = {main="Blurred Staff +1", sub="Utu Grip"}
	sets.Quint = {main="Quint Spear", sub="Utu Grip"}
	sets.GaeBuide = {main="Gae Buide", sub="Utu Grip"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
function job_precast(spell, action, spellMap, eventArgs)
    refine_jump(spell, action, spellMap, eventArgs)
end

-- Run after the general midcast() set is constructed.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if is_healing_breath_trigger(spell) then
        equip(sets.midcast.BreathTrigger)
    end
end

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
    if DW == true then
        state.CombatForm:set('DW')
    elseif DW == false then
        state.CombatForm:reset()
    end
end

function get_custom_wsmode(spell, action, spellMap)
    local wsmode
    if state.OffenseMode.value == 'Critical' or player.equipment.main == 'Shining One' then
        wsmode = 'Crit'
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

-- Function to check whether we are able to trigger healing breath on this cast.
function is_healing_breath_trigger(spell)
    if spell.action_type == 'Magic' then
        if info.MageSubs:contains(player.sub_job) then -- player.hpp <= 50 and 
            return true
        elseif player.hpp <= 33 then --and info.HybridSubs:contains(player.sub_job) then
            return true
        end
    end

    return false
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
    if player.sub_job == 'WAR' then
        set_macro_page(1, 2)
    elseif player.sub_job == 'SAM' then
        set_macro_page(2, 2)
    elseif player.sub_job == 'DNC' then
        set_macro_page(3, 2)
	elseif player.sub_job == 'NIN' then
        set_macro_page(4, 2)
	else set_macro_page(1, 2)
    end
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset ' .. lockstyleset)
end
