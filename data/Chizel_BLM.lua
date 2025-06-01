-- Original: Motenten / Modified: Arislan

-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ CTRL+F11 ]        Cycle Casting Modes
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ ALT+` ]           Toggle Magic Burst Mode
--              [ WIN+D ]           Toggle Death Casting Mode Toggle
--              [ WIN+C ]           Toggle Capacity Points Mode
--
--  Spells:     [ CTRL+` ]          Stun
--              [ ALT+P ]           Shock Spikes
--
--  Weapons:    [ CTRL+W ]          Toggles Weapon Lock
--
--  WS:         [ CTRL+Numpad0 ]    Myrkr
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
	state.Buff['Sublimation: Acivated'] = buffactive['Sublimation: Activated'] or false
	state.Buff['Mana Wall'] = buffactive['Mana Wall'] or false
    -- state.CP = M(false, "Capacity Points Mode")

    no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
              "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring"}

    degrade_array = {
        ['Aspirs'] = {'Aspir','Aspir II','Aspir III'}
        }
		
    include('Mote-TreasureHunter')
	
	-- For th_action_check():
    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{35, 204}
    -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
    info.default_u_ja_ids = S{201, 202, 203, 205, 207}

    lockstyleset = 27

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.CastingMode:options('Normal','Resistant','OccultAcumen')
    state.IdleMode:options('Normal','ManaWall','DeathMode')
	
	state.WeaponSet = M{['description']='Weapon Set','Laevateinn','LaevateinnAcc','OccultAcumen','Mercurial','SoD','Dagger'}

    state.WeaponLock = M(false, 'Weapon Lock')
    state.MagicBurst = M(false, 'Magic Burst')
    state.DeathMode = M(false, 'Death Mode')
    state.CP = M(false, "Capacity Points Mode")

    lowTierNukes = S{'Stone', 'Water', 'Aero', 'Fire', 'Blizzard', 'Thunder'}

    -- Additional local binds
    include('Chizel_Global_Binds.lua')
    -- include('Global-GEO-Binds.lua') -- OK to remove this line

    send_command('bind @t gs c cycle treasuremode')	
	send_command('bind @e gs c cycleback WeaponSet')
    send_command('bind @r gs c cycle WeaponSet')
	
	if player.sub_job == 'SCH' then
        send_command('bind ^= gs c scholar light')
        send_command('bind != gs c scholar dark')
        send_command('bind ^, gs c scholar speed')
        send_command('bind ^. gs c scholar aoe')
        send_command('bind ^/ gs c scholar cost')
		send_command('bind ^c input /ja "Sublimation" <me>')		
		send_command('bind !c input /ma "Cure III" <me>')
		send_command('bind ^insert input /ma "Sandstorm" <stpt>')		--CTRL+Insert
		send_command('bind ^home input /ma "Windstorm" <stpt>')			--CTRL+Delete
		send_command('bind ^pageup input /ma "Hailstorm" <stpt>')		--CTRL+Home
		send_command('bind ^pagedown input /ma "Firestorm" <stpt>')		--CTRL+End
		send_command('bind ^end input /ma "Rainstorm" <stpt>')			--CTRL+PgUP
		send_command('bind ^delete input /ma "Thunderstorm" <stpt>')	--CTRL+PgDN
		send_command('bind ^numpad/ input /ja "Elemental Seal" <me>')
		send_command('bind ^numpad* input /ma "Voidstorm" <stpt>')
		send_command('bind ^numpad- input /ma "Klimaform" <me>')
		send_command('bind !numpad* input /ma "Aurorastorm" <stpt>')
	elseif player.sub_job == 'RDM' then
		send_command('bind ^c input /ja "Convert" <me>')
		send_command('bind !c input /ma "Cure IV" <me>')
	elseif player.sub_job == 'COR' then
		send_command('bind ^numpad/ input /ja "Corsair\'s Roll" <me>')
		send_command('bind ^numpad* input /ja "Double Up" <me>')
	elseif player.sub_job == 'WAR' then
		send_command('bind ^numpad/ input /ja "Berserk" <me>')
		send_command('bind ^numpad* input /ja "Warcry" <me>')
		send_command('bind ^numpad- input /ja "Aggressor" <me>')
	elseif player.sub_job == 'SAM' then
		send_command('bind ^numpad/ input /ja "Hasso" <me>')
		send_command('bind ^numpad* input /ja "Meditate" <me>')
		send_command('bind !numpad* input /ja "Sekkanoki" <me>')
		send_command('bind ^numpad- input /ja "Seigan" <me>')
		send_command('bind !numpad- input /ja "Third Eye" <me>')
	end

    send_command('bind ^` input /ma Stun <t>')
    send_command('bind !w input /ma "Aspir III" <stnpc>')
    send_command('bind !p input /ma "Shock Spikes" <me>')
	
    send_command('bind @w gs c toggle WeaponLock')
    send_command('bind !` gs c toggle MagicBurst')
    send_command('bind @d gs c toggle DeathMode')
	
    send_command('bind ^numpad0 input /ws "Myrkr" <me>')
	send_command('bind ^numpad1 input /ws "Cataclysm" <t>')
	send_command('bind ^numpad2 input /ws "Shattersoul" <t>')
	send_command('bind ^numpad3 input /ws "Rock Crusher" <t>')
	send_command('bind ^numpad4 input /ws "Shell Crusher" <t>')
	send_command('bind ^numpad5 input /ws "Vidohunir" <t>')
	send_command('bind ^numpad6 input /ws "Earth Crusher" <t>')
	send_command('bind ^numpad7 input /ws "Retribution" <t>')
	send_command('bind ^numpad8 input /ws "Shadow of Death" <t>')
	send_command('bind ^numpad9 input /ws "Infernal Scythe" <t>')
	
    -- send_command('bind @c gs c toggle CP')
	
	send_command('bind @m input /mount "Bomb"')	

    select_default_macro_book()
    set_lockstyle()

    state.Auto_Kite = M(false, 'Auto_Kite')
    moving = false
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind !w')
    send_command('unbind !p')
    send_command('unbind ^,')
    send_command('unbind !.')
    send_command('unbind @d')
    send_command('unbind @c')
    send_command('unbind @w')
	
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
	
	send_command('unbind ^insert')
	send_command('unbind ^home')
	send_command('unbind ^pageup')
	send_command('unbind ^pagedown')
	send_command('unbind ^end')
	send_command('unbind ^delete')
	
	send_command('unbind ^numpad/')
	send_command('unbind ^numpad*')
	send_command('unbind !numpad*')
	send_command('unbind ^numpad-')
	send_command('unbind !numpad-')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    ---- Precast Sets ----

    -- Precast sets to enhance JAs
    sets.precast.JA['Mana Wall'] = {
        feet="Wicce Sabots +3",
        back=gear.BLM_FC_Cape,						--gear.BLM_Death_Cape,
        }

    sets.precast.JA.Manafont = {body="Arch. Coat +3"}

    -- Fast cast sets for spells
    sets.precast.FC = {
        ammo="Sapience Orb", 				--2
        head="Agwu's Cap", 					--5
        body="Agwu's Robe", 				--8
        hands="Agwu's Gages", 				--6
        legs="Agwu's Slops", 				--7
        feet="Regal Pumps +1",		 		--7
        neck="Baetyl Pendant", 				--4
        ear1="Malignance Earring", 			--4
        ear2="Loquacious Earring", 			--2
        ring1="Kishar Ring", 				--4
        ring2="Medada's Ring", 				--10
        back=gear.BLM_FC_Cape, 				--10
        waist="Embla Sash",					--5
		} --FC +74 (Capped with Sub Job and/or appropriate JAs)

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
        waist="Siegel Sash",
        })

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {
		ammo="Staunch Tathlum +1",			-- SIRD -11, DT -3
		head="Wicce Petasos +3",			-- Ele. Cast Time -18, DT -11
		hands="Wicce Gloves +3",			-- DT -12
		feet="Wicce Sabots +3",				-- DT -11
		neck="Loricate Torque +1",			-- SIRD -5, DT -6
		ring1="Defending Ring",				-- DT -10
		})	-- Elemental Celerity V (+30% FC), Dark Arts (+10% FC), Gear FC (+64% FC)
			-- Dark Arts: FC +104/80, Light Arts: FC +94/100 

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
        ear1="Mendi. Earring", --5
        })

    sets.precast.FC.Curaga = sets.precast.FC.Cure
    sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty, body="Crepuscular Cloak", waist="Shinjutsu-no-Obi +1"})
    sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak", sub="Ammurapi Shield", waist="Shinjutsu-no-Obi +1"})
    sets.precast.Storm = set_combine(sets.precast.FC, {ring2="Stikini Ring +1"})

    sets.precast.FC.DeathMode = set_combine(sets.precast.FC, {
		head="Wicce Petasos +3",			--"Almaric Coif +1",
		body="Ros. Jaseran +1",
		ear1="Etiolation Earring",
        ring1="Mephitas's Ring +1",
        ring2="Mephitas's Ring",
		back=gear.BLM_FC_Cape,
        })

    sets.precast.FC.Impact.DeathMode = set_combine(sets.precast.FC.DeathMode, {head=empty, body="Crepuscular Cloak", waist="Shinjutsu-no-Obi +1"})

    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        ammo="Oshasha's Treatise",
        head="Nyame Helm",
        body="Nyame Mail",
        hands="Nyame Gauntlets",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets",
        neck="Fotia Gorget",
        ear1="Moonshade Earring",
        ear2="Ishvara Earring",
        ring1="Epaminondas's Ring",
        ring2="Shukuyu Ring",
        back="Relucent Cape",
        waist="Fotia Belt",
        }

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

    sets.precast.WS['Vidohunir'] = set_combine(sets.precast.WS, {
        ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",
        neck="Src. Stole +2",
        ear2="Wicce Earring +1",
        ring1="Archon Ring",
        ring2="Medada's Ring",
        back=gear.BLM_INT_WS_Cape,
        waist="Orpheus's Sash",
        })	-- INT, Dark Affinity
		
	sets.precast.WS['Shattersoul'] = set_combine(sets.precast.WS, {
		ammo="Pemphredo Tathlum",
		neck="Src. Stole +2",
		ear2="Regal Earring",
		ring1="Metamor. Ring +1",
		ring2="Medada's Ring",
		back=gear.BLM_INT_WS_Cape,
		waist="Acuity Belt +1",
		})	-- INT, WSD

    sets.precast.WS['Myrkr'] = {
        ammo="Ghastly Tathlum +1",
        head="Pixie Hairpin +1",
        body="Ros. Jaseran +1",
        hands="Spae. Gloves +3",
        legs="Spae. Tonban +3",
        feet="Skaoi Boots",
        neck="Sanctity Necklace",
        ear1="Nehalennia Earring",
        ear2="Etiolation Earring",
        ring1="Mephitas's Ring",
        ring2="Mephitas's Ring +1",
        back="Bane Cape",
        waist="Shinjutsu-no-Obi +1",
        }	-- Max MP
		
	sets.precast.WS['Cataclysm'] = set_combine(sets.precast.WS, {
		head="Pixie Hairpin +1",
		neck="Sibyl Scarf",
		ear1="Malignance Earring",
		ring1="Archon Ring",
		ring2="Medada's Ring",
		back=gear.BLM_INT_WS_Cape,
		waist="Orpheus's Sash",
		})	-- MAB/INT, Dark Affinity
		
	sets.precast.WS['Shadow of Death'] = sets.precast.WS['Cataclysm']
	sets.precast.WS['Infernal Scythe'] = sets.precast.WS['Cataclysm']
		
	sets.precast.WS['Earth Crusher'] = set_combine(sets.precast.WS, {
		hands="Jhakri Cuffs +2",
		neck="Sibyl Scarf",
		ear1="Malignance Earring",
		ring1="Metamor. Ring +1",
		ring2="Medada's Ring",
		back=gear.BLM_INT_WS_Cape,
		waist="Orpheus's Sash",
		})	-- INT, WSD
		
	sets.precast.WS['Retribution'] = set_combine(sets.precast.WS, {
		ammo="Amar Cluster",
		neck="Rep. Plat. Medal",
		back="Aurist's Cape +1",
		waist="Grunfeld Rope",
		}) -- MND/STR, WSD

    ---- Midcast Sets ----

    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.Cure = {
		main="Daybreak",
		sub="Ammurapi Shield",
        ammo="Hydrocera",
        body="Vanya Robe",					--Healing Skill +20
        hands=gear.Telchine_ENH_hands, 		--CP1 +10
        feet="Vanya Clogs", 				--CP1 +5, Healing Skill +40
        neck="Loricate Torque +1",
        ear1="Meili Earring", 				--Healing Skill +10
        ear2="Halasz Earring",
        ring1="Menelaus's Ring",			--CP1 +5, Healing Skill +15
        ring2="Haoma's Ring",				--Healing Skill +8
        back="Aurist's Cape +1",
        waist="Bishop's Sash",				--Healing Skill +5
        } --CP1 +50, Healing Skill +98

    sets.midcast.Curaga = set_combine(sets.midcast.Cure, {
        -- neck="Nuna Gorget +1",
        ring1="Metamor. Ring +1",
        ring2="Stikini Ring +1",
        waist="Luminary Sash",
        })

    sets.midcast.Cursna = set_combine(sets.midcast.Cure, {
        head="Vanya Hood",					--Healing +20
        hands="Shrieker's Cuffs",			--"Hieros Mittens",
        neck="Debilis Medallion",			--Cursna +15
        })

    sets.midcast['Enhancing Magic'] = {
		ammo="Staunch Tathlum +1",
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
        waist="Olympus Sash",
        }

    sets.midcast.EnhancingDuration = set_combine(sets.midcast['Enhancing Magic'], {
        waist="Embla Sash",
        })

    sets.midcast.Regen = set_combine(sets.midcast.EnhancingDuration, {
		main="Bolelabunga",
		sub="Ammurapi Shield",
        })

    sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {
        -- head="Amalric Coif +1",
        feet="Inspirited Boots",
        waist="Gishdubar Sash",
        back="Grapevine Cape",
        })

    sets.midcast.Stoneskin = set_combine(sets.midcast.EnhancingDuration, {
		hands="Stone Mufflers",
		legs="Shedir Seraweels",
        neck="Nodens Gorget",
		ear2="Earthcry Earring",
        waist="Siegel Sash",
        })

    sets.midcast.Aquaveil = set_combine(sets.midcast.EnhancingDuration, {
        ammo="Staunch Tathlum +1",
        -- head="Amalric Coif +1",
        hands="Regal Cuffs",
		legs="Shedir Seraweels",
        ear1="Halasz Earring",
        ring1="Freke Ring",
        ring2="Evanescence Ring",
        waist="Emphatikos Rope",
        })

    sets.midcast.Protect = set_combine(sets.midcast.EnhancingDuration, {ring1="Sheltered Ring"})
    sets.midcast.Protectra = sets.midcast.Protect
    sets.midcast.Shell = sets.midcast.Protect
    sets.midcast.Shellra = sets.midcast.Protect

    sets.midcast.MndEnfeebles = {
		main=gear.Grioavolr_Enfeeble,
		sub="Mephitis Grip",
        ammo="Hydrocera",
        head=empty;
        body="Cohort Cloak +1",
        hands="Regal Cuffs",
        legs="Agwu's Slops",
        feet="Skaoi Boots",
        neck="Erra Pendant",
        ear1="Malignance Earring",
        ear2="Vor Earring",
        ring1="Metamor. Ring +1",
        ring2="Stikini Ring +1",
        back="Aurist's Cape +1",
        waist="Luminary Sash",
        } -- MND/Magic accuracy

    sets.midcast.IntEnfeebles = set_combine(sets.midcast.MndEnfeebles, {
		ammo="Pemphredo Tathlum",
		ring2="Medada's Ring",
        waist="Acuity Belt +1",
        }) -- INT/Magic accuracy

    sets.midcast.ElementalEnfeeble = set_combine(sets.midcast.IntEnfeebles, {
		main="Marin Staff +1",
		sub="Enki Strap",
		head="Wicce Petasos +3",
		body="Spaekona's Coat +3",
		hands="Spae. Gloves +3",
		legs="Arch. Tonban +3",
		feet="Arch. Sabots +3",
		neck="Src. Stole +2",
		ear2="Regal Earring",
		})
		
    sets.midcast.Dispelga = set_combine(sets.midcast.IntEnfeebles, {main="Daybreak", sub="Ammurapi Shield", waist="Shinjutsu-no-Obi +1"})

    sets.midcast['Dark Magic'] = {
		main="Rubicundity",
		sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head="Agwu's Cap",
        body="Agwu's Robe",
        hands="Wicce Gloves +3",
        legs="Spae. Tonban +3",
        feet="Agwu's Pigaches",
        neck="Erra Pendant",
        ear1="Malignance Earring",
        ear2="Mani Earring",
        ring1="Archon Ring",
        ring2="Medada's Ring",
        back="Aurist's Cape +1",
        waist="Acuity Belt +1",
        }

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
        head="Pixie Hairpin +1",
		body=gear.Merl_Dark_body,
		hands=gear.Merl_Dark_hands,
		legs="Spae. Tonban +3",
        -- ear1="Hirudinea Earring",
        ring2="Evanescence Ring",
        waist="Fucho-no-obi",
        })

    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Stun = sets.midcast['Dark Magic']

    sets.midcast.Death = {
        ammo="Ghastly Tathlum +1",
        head="Pixie Hairpin +1",
        body="Ros. Jaseran +1",
        hands="Agwu's Gages",
        legs="Agwu's Slops",
        feet="Agwu's Pigaches",
        neck="Sanctity Necklace",
        ear1="Malignance Earring",
        ear2="Regal Earring",
        ring1="Mephitas's Ring",
        ring2="Mephitas's Ring +1",
        back=gear.BLM_FC_Cape,				--gear.BLM_Death_Cape, --5
        waist="Shinjutsu-no-Obi +1",
        }

    sets.midcast.Death.Resistant = set_combine(sets.midcast.Death, {
        -- head="Amalric Coif +1",
		ring1="Archon Ring",
        waist="Acuity Belt +1",
        })

    -- Elemental Magic sets

    sets.midcast['Elemental Magic'] = {
        ammo="Sroda Tathlum",					--MAcc -10, MCrit2 +10%
        head="Wicce Petasos +3",				--INT +39, MAcc +61, MAB +51, MDmg +31, Elemental Skill +35, Haste +6, DT -11
        body="Wicce Coat +3",					--INT +50, MAcc +64, MAB +59, MDmg +34, Elemental Recast -16, Haste +3
        hands="Wicce Gloves +3",				--INT +33, MAcc +52, MAB +52, MDmg +22, MCrit1 +11%, MCritDmg +11%, Haste +3, DT -12
        legs="Wicce Chausses +3",				--INT +48, MAcc +53, MAB +53, MDmg +23, Haste +5
        feet="Wicce Sabots +3",					--INT +36, MAcc +60, MAB +50, MDmg +30, DT -11
        neck="Src. Stole +2",					--INT +12, MAcc +25, MAB +5
        ear1="Malignance Earring",				--INT +8, MAcc +10, MAB +8, FC +4
        ear2="Regal Earring",        			--INT +10, MAcc +0, MAB +7
		ring1="Metamor. Ring +1",				--INT +16, MAcc +15
        ring2="Medada's Ring",					--INT +10, MAcc +20, MAB +10, FC +10
        back=gear.BLM_MAB_Cape,					--INT +30, MAcc +20, MAB +10, MDmg +20, DT -5
        waist="Acuity Belt +1",					--INT +23, MAcc +15
        }

    sets.midcast['Elemental Magic'].DeathMode = set_combine(sets.midcast['Elemental Magic'], {
        ammo="Ghastly Tathlum +1",
        legs="Amalric Slops +1",
        feet="Agwu's Pigaches",
        back=gear.BLM_FC_Cape,			--gear.BLM_Death_Cape,
		})

    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {
        ammo="Pemphredo Tathlum",
        })

    -- sets.midcast['Elemental Magic'].Spaekona = set_combine(sets.midcast['Elemental Magic'], {
        -- ammo="Pemphredo Tathlum",
        -- body="Spaekona's Coat +3",
        -- })
		
	sets.midcast['Elemental Magic'].OccultAcumen = set_combine(sets.midcast['Elemental Magic'], {
		main="Khatvanga",				-- OA+30
		-- sub="Bloodrain Strap",		-- sTP +6
		ammo="Seraphic Ampulla",		-- OA +7
		head="Mall. Chapeau +2",		-- OA +11
		body="Spaekona's Coat +3",		
		hands=gear.Merl_OA_hands,		-- OA +11
		legs="Perdition Slops",			-- OA +30
		feet=gear.Merl_OA_feet,			-- OA +10
		neck="Combatant's Torque",		-- sTP +4
		ear1="Dedition Earring",		-- sTP +8
		ear2="Crep. Earring",			-- sTP +5
		ring1="Chirich Ring +1",		-- sTP +6
		ring2="Crepuscular Ring",		-- sTP +6
		back=gear.BLM_OA_Cape,			-- sTP +10
		waist="Oneiros Rope",			-- OA +20		
		}) -- OA Base 50 (Current: OA +169, sTP +39)
		

    sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {
		ammo="Pemphredo Tathlum",
        head=empty,
        body="Crepuscular Cloak",
		hands="Spae. Gloves +3",
		feet="Spae. Sabots +3",
		back="Aurist's Cape +1",
        })

    sets.midcast.Impact.Resistant = set_combine(sets.midcast['Elemental Magic'].Resistant, {
		head=empty,
        body="Crepuscular Cloak",
		hands="Spae. Gloves +3",
		feet="Spae. Sabots +3",
		neck="Incanter's Torque",
		back="Aurist's Cape +1",
        })
		
	sets.midcast.Impact.OccultAcumen = set_combine(sets.midcast['Elemental Magic'].OccultAcumen, {
		head=empty,
		body="Crepuscular Cloak",
		})

    -- Initializes trusts at iLvl 119
    sets.midcast.Trust = sets.precast.FC

    sets.resting = {
        main="Chatoyant Staff",
		sub="Ariesian Grip",
        waist="Shinjutsu-no-Obi +1",
        }

    -- Idle sets

    sets.idle = {
        ammo="Staunch Tathlum +1",					--DT -3, SAR +11
        head="Wicce Petasos +3",					--Enmity -10, DT -11
        body="Wicce Coat +3",						
        hands="Wicce Gloves +3",					--DT -12
        legs="Agwu's Slops",						--DT -5
        feet="Wicce Sabots +3",						--Enmity -16, DT -11
        neck="Yngvi Choker",						--Enmity -5
        ear1="Lugalbanda Earring",					
        ear2="Sanare Earring",
        ring1="Defending Ring",						--DT -10
        ring2="Shadow Ring",
        back=gear.BLM_Idle_Cape,					--Enmity -10, DT -5 (Maybe needle to "Status ailment resistance" +10)
        waist="Carrier's Sash",
        }	-- Enmity -41/50, DT -57/50

    sets.idle.ManaWall = set_combine(sets.idle, {
        back=gear.BLM_Idle_Cape,
        })

    sets.idle.DeathMode = {
        ammo="Ghastly Tathlum +1",					--MP +35
        head="Wicce Petasos +3",					--MP +86, DT -11
        body="Ros. Jaseran +1",						--MP +144, DT -5
        hands="Nyame Gauntlets",					--MP +73, DT -7
        legs="Spae. Tonban +3",						--MP +158
        feet="Wicce Sabots +3",						--MP +50, DT -11
        neck="Sanctity Necklace",					--MP +35
        ear1="Nehalennia Earring",					--MP +60
        ear2="Etiolation Earring",					--MP +50
        ring1="Mephitas's Ring +1",					--MP +110
        ring2="Mephitas's Ring",					--MP +100
        back=gear.BLM_Idle_Cape,					--MP +60, DT -5
        waist="Shinjutsu-no-Obi +1",				--MP +85
        }	-- MP +1043, DT -39

    -- Defense sets

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT

    sets.Kiting = {feet="Herald's Gaiters", neck="Loricate Torque +1", ear2="Odnowa Earring +1", waist="Plat. Mog. Belt",}	--Idle DT -52, Death DT -34
    sets.latent_refresh = {waist="Fucho-no-obi"}
    sets.latent_dt = {ear2="Sorcerer's Earring"}
	sets.Sublimation = {waist="Embla Sash"}

    sets.magic_burst = {																							--{{USE ENKI STRAP}}--
		ammo="Ghastly Tathlum +1",				--INT +9, MDmg +18
        head="Ea Hat +1", 						--INT +43, MAcc +50, MAB +38, MB1 +7, MB2 +7, Haste +6
        body="Wicce Coat +3",	 				--INT +50, MAcc +64, MAB +59, MB2 +5, Haste +3
        hands="Agwu's Gages",					--INT +33, MAcc +41, MAB +50, MB1 +8, MB2 +4, Haste +3, FC +6
        legs="Wicce Chausses +3",				--INT +53, MAcc +63, MAB +58, MB1 +15, Haste +5
        feet="Wicce Sabots +3",					--INT +36, MAcc +60, MAB +50, Haste +3, Enmity -16
        neck="Src. Stole +2",			 		--INT +15, MAcc +55, MAB +7, MB1 +10
		ear1="Malignance Earring",				--INT +8, MAcc +10, MAB +8, FC +4
		ear2="Regal Earring",					--INT +10, MAB +7
        ring1="Metamor. Ring +1", 				--INT +16, MAcc +15
		ring2="Medada's Ring",					--INT +10, MAcc +20, MAB +10, FC +10
        back=gear.BLM_MAB_Cape, 				--INT +30, MAcc +20, MAB +10, MB1 +5
		waist="Acuity Belt +1",					--INT +23, MAcc +15
        }	--INT +348, MAcc +747, MAB +372 (AM2: +491), MB1 +45, MB2 +16, Haste +20, FC +32
			--Elemental Skill 498 (MAcc 1245, dSTAT >70: 1305)

    sets.magic_burst.Resistant = set_combine(sets.magic_burst, {													--{{USE KHONSU}}--
		ammo="Pemphredo Tathlum",				--INT +4, MAcc +8, MAB +4
		head="Wicce Petasos +3", 				--INT +39, MAcc +61, MAB +51, MDmg +31, Elemental Skill +35
		hands="Arch. Gloves +3",				--INT +36, MAcc +38, MAB +50, MB1 +20, Elemental Skill +23
		feet="Spaekona's Sabots +3",			--INT +32, MAcc +69, MAB +26, MB1 +10
        ring1="Metamor. Ring +1",				--INT +16, MAcc +15
        })	--INT +326, MAcc +803, MAB +360 (AM2: +479), MB1 +40, MB2 +6, Haste +21, FC +31
			--Elemental Skill 556 (MAcc 1359, dSTAT >70: 1419)
		
	-- sets.magic_burst.Spaekona = set_combine(sets.magic_burst, {
		-- main="Bunzi's Rod",						--INT +15, MAcc +40, MAB +35, MB1 +10
		-- sub="Ammurapi Shield",					--INT +13, MAcc +38, MAB +38
		-- body="Spaekona's Coat +3",				--INT +34, MAcc +60, Haste +3
		-- hands="Arch. Gloves +3",					--INT +36, MAcc +38, MAB +50, MB1 +20, Elemental Skill +23
		-- })	--INT +351, MAcc +401, MAB +297, MB1 +40, MB2 +13, Haste +21, FC +24, Elemental Skill +23
				--Elemental Skill 516 (MAcc 1172, dSTAT >70: 1202)

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group

    sets.engaged = {
		ammo="Amar Cluster",					--Acc +10
        head="Nyame Helm",						--DEX +25, Acc +40, Att +55, DA +2, DT -7, Haste +6
        body="Nyame Mail",						--DEX +24, Acc +40, Att +55, DA +3, DT -9, Haste +3
        hands="Gazu Bracelets +1",				--DEX +38, Acc +91, Att -17, Haste +13
        legs="Nyame Flanchard",					--Acc +40, Att +55, DA +3, DT -8, Haste +7
        feet="Nyame Sollerets",					--DEX +26, Acc +40, Att +55, DA +2, DT -7, Haste +3
        neck="Combatant's Torque",				--Staff Skill +15, sTP +4
        ear1="Mache Earring +1",				--DEX +8, Acc +10, DA +2
        ear2="Telos Earring",					--Acc +10, Att +10, DA +1, sTP +5
        ring1="Chirich Ring +1",				--Acc +10, sTP +6
        ring2="Chirich Ring +1",				--Acc +10, sTP +6
        back=gear.BLM_TP_Cape,					--Acc +10, DA +3, sTP +10
		waist="Grunfeld Rope",					--DEX +5, Acc +10, Att +20, DA +2
        } -- DEX +142, Acc +311, Att +233, DA/TA +18/2, sTP +25, Staff Skill +15, DT -31, Haste +32

    sets.buff.Doom = {
        neck="Nicander's Necklace", 	--Cursna +20, Holy Water +30
        ring1="Purity Ring", 			--Cursna +7, Holy Water +7
        ring2="Saida Ring", 			--Cursna +15
        waist="Gishdubar Sash", 		--Cursna +10
        }
		
	sets.buff['Mana Wall'] = sets.precast.JA['Mana Wall']

    sets.DarkAffinity = {head="Pixie Hairpin +1",ring2="Archon Ring"}
    sets.Obi = {waist="Hachirin-no-Obi"}
    -- sets.CP = {back="Mecisto. Mantle"}
	
	sets.TreasureHunter = {
		ammo="Perfect Lucky Egg", 	-- +1
		body="Volte Jupon",			-- +2
		legs="Volte Hose",			-- +1
		} --TH +4
	
	sets.midcast['Sleepga'] = sets.TreasureHunter

	--weapon sets
	sets.Laevateinn = {main="Laevateinn", sub="Enki Strap"}
	sets.LaevateinnAcc = {main="Laevateinn", sub="Khonsu"}
	sets.OccultAcumen = {main="Khatvanga", sub="Khonsu"}
	sets.Mercurial = {main="Mercurial Pole", sub="Khonsu"}
	sets.SoD = {main="Drepanum", sub="Khonsu"}
	sets.Dagger = {main="Malevolence", sub="Ammurapi Shield"}
	
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Magic' and state.DeathMode.value then
        eventArgs.handled = true
        equip(sets.precast.FC.DeathMode)
        if spell.english == "Impact" then
            equip(sets.precast.FC.Impact.DeathMode)
        end
    end
    if spell.name:startswith('Aspir') then
        refine_various_spells(spell, action, spellMap, eventArgs)
    end
    if buffactive['Mana Wall'] then
        equip(sets.precast.JA['Mana Wall'])
    end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.name == 'Impact' then
        equip(sets.precast.FC.Impact)
    end
	if spell.skill == 'Elemental Magic' then
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

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Magic' and state.DeathMode.value then
        eventArgs.handled = true
        if spell.skill == 'Elemental Magic' then
            equip(sets.midcast['Elemental Magic'].DeathMode)
        else
            if state.CastingMode.value == "Resistant" then
                equip(sets.midcast.Death.Resistant)
			else
                equip(sets.midcast.Death)
            end
        end
    end
    if buffactive['Mana Wall'] then
        equip(sets.precast.JA['Mana Wall'])
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Enhancing Magic' and classes.NoSkillSpells:contains(spell.english) and not state.DeathMode.value then
        equip(sets.midcast.EnhancingDuration)
        if spellMap == 'Refresh' then
            equip(sets.midcast.Refresh)
        end
    end
    if spell.skill == 'Elemental Magic' and spell.english == "Comet" then
        equip(sets.DarkAffinity)
    end
    if spell.skill == 'Elemental Magic' and spellMap ~= 'ElementalEnfeeble' then
        if state.MagicBurst.value and spell.english ~= 'Death' then
            if state.CastingMode.value == "Resistant" then
                equip(sets.magic_burst.Resistant)
			elseif state.CastingMode.value == "Spaekona" then
				equip(sets.magic_burst.Spaekona)
            else
                equip(sets.magic_burst)
            end
            if spell.english == "Impact" then
                equip(sets.midcast.Impact)
            end
        end
        if (spell.element == world.day_element or spell.element == world.weather_element) then
            equip(sets.Obi)
        end
    end
    if buffactive['Mana Wall'] then
        equip(sets.precast.JA['Mana Wall'])
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.english == "Sleep II" or spell.english == "Sleepga II" then
            send_command('@timers c "Sleep II ['..spell.target.name..']" 90 down spells/00259.png')
        elseif spell.english == "Sleep" or spell.english == "Sleepga" then -- Sleep & Sleepga Countdown --
            send_command('@timers c "Sleep ['..spell.target.name..']" 60 down spells/00253.png')
        elseif spell.english == "Break" or spell.english == "Breakga" then
            send_command('@timers c "Break ['..spell.target.name..']" 30 down spells/00255.png')
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
function job_buff_change(buff, gain)
    -- Unlock armor when Mana Wall buff is lost.
    if buff== "Mana Wall" then
        if gain then
            --send_command('gs enable all')
            equip(sets.precast.JA['Mana Wall'])
            --send_command('gs disable all')
        else
            --send_command('gs enable all')
            handle_equipping_gear(player.status)
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

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if state.WeaponLock.value == true then
        disable('main','sub')
    else
        enable('main','sub')
    end
	
	check_weaponset()
end

-- latent DT set auto equip on HP% change
    windower.register_event('hpp change', function(new, old)
        if new<=25 then
            equip(sets.latent_dt)
        end
    end)


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_handle_equipping_gear(playerStatus, eventArgs)
    check_gear()
    check_moving()
end

function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
end

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if spell.skill == "Enfeebling Magic" then
            if spell.type == "WhiteMagic" then
                return "MndEnfeebles"
            else
                return "IntEnfeebles"
            end
        end
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if state.DeathMode.value then
        idleSet = sets.idle.DeathMode
    end
    if player.mp < 845 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
	if buffactive['Sublimation: Activated'] then
		idleSet = set_combine(idleSet, sets.Sublimation)
	end
    if player.hpp <= 25 then
        idleSet = set_combine(idleSet, sets.latent_dt)
    end
    -- if state.CP.current == 'on' then
    --     equip(sets.CP)
    --     disable('back')
    -- else
    --     enable('back')
    -- end
    if buffactive['Mana Wall'] then
        idleSet = set_combine(idleSet, sets.precast.JA['Mana Wall'])
    end
    if state.Auto_Kite.value == true and not buffactive['Mana Wall'] then
	   idleSet = set_combine(idleSet, sets.Kiting)
    end

    return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if buffactive['Mana Wall'] then
        meleeSet = set_combine(meleeSet, sets.precast.JA['Mana Wall'])
    end
	if state.TreasureMode.value == 'Fulltime' then
        meleeSet = set_combine(meleeSet, sets.TreasureHunter)
    end
	
    check_weaponset()

    return meleeSet
end

function customize_defense_set(defenseSet)
    if buffactive['Mana Wall'] then
        defenseSet = set_combine(defenseSet, sets.precast.JA['Mana Wall'])
    end

    return defenseSet
end


-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)

    local c_msg = state.CastingMode.value

    local d_msg = 'None'
    if state.DefenseMode.value ~= 'None' then
        d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end

    local i_msg = state.IdleMode.value

    local msg = ''
    if state.MagicBurst.value then
        msg = ' Burst: On |'
    end
    if state.DeathMode.value then
        msg = msg .. ' Death: On |'
    end
    if state.Kiting.value then
        msg = msg .. ' Kiting: On |'
    end

    add_to_chat(060, '| Magic: ' ..string.char(31,001)..c_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end

function refine_various_spells(spell, action, spellMap, eventArgs)
    local aspirs = S{'Aspir','Aspir II','Aspir III'}

    local newSpell = spell.english
    local spell_recasts = windower.ffxi.get_spell_recasts()
    local cancelling = 'All '..spell.english..' are on cooldown. Cancelling.'

    local spell_index

    if spell_recasts[spell.recast_id] > 0 then
        if aspirs:contains(spell.name) then
            spell_index = table.find(degrade_array['Aspirs'],spell.name)
            if spell_index > 1 then
                newSpell = degrade_array['Aspirs'][spell_index - 1]
                send_command('@input /ma '..newSpell..' '..tostring(spell.target.raw))
                eventArgs.cancel = true
            end
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function job_self_command(cmdParams, eventArgs)
	if cmdParams[1]:lower() == 'scholar' then
        handle_strategems(cmdParams)
        eventArgs.handled = true
	end
	
    gearinfo(cmdParams, eventArgs)
end

function gearinfo(cmdParams, eventArgs)
    if cmdParams[1] == 'gearinfo' then
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

function update_sublimation()
    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
end

function handle_strategems(cmdParams)
    -- cmdParams[1] == 'scholar'
    -- cmdParams[2] == strategem to use

    if not cmdParams[2] then
        add_to_chat(123,'Error: No strategem command given.')
        return
    end
    local strategem = cmdParams[2]:lower()

    if strategem == 'light' then
        if buffactive['light arts'] then
            send_command('input /ja "Addendum: White" <me>')
        elseif buffactive['addendum: white'] then
            add_to_chat(122,'Error: Addendum: White is already active.')
        else
            send_command('input /ja "Light Arts" <me>')
        end
    elseif strategem == 'dark' then
        if buffactive['dark arts'] then
            send_command('input /ja "Addendum: Black" <me>')
        elseif buffactive['addendum: black'] then
            add_to_chat(122,'Error: Addendum: Black is already active.')
        else
            send_command('input /ja "Dark Arts" <me>')
        end
    elseif buffactive['light arts'] or buffactive['addendum: white'] then
        if strategem == 'cost' then
            send_command('input /ja Penury <me>')
        elseif strategem == 'speed' then
            send_command('input /ja Celerity <me>')
        elseif strategem == 'aoe' then
            send_command('input /ja Accession <me>')
        elseif strategem == 'addendum' then
            send_command('input /ja "Addendum: White" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    elseif buffactive['dark arts']  or buffactive['addendum: black'] then
        if strategem == 'cost' then
            send_command('input /ja Parsimony <me>')
        elseif strategem == 'speed' then
            send_command('input /ja Alacrity <me>')
        elseif strategem == 'aoe' then
            send_command('input /ja Manifestation <me>')
        elseif strategem == 'addendum' then
            send_command('input /ja "Addendum: Black" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    else
        add_to_chat(123,'No arts has been activated yet.')
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
    set_macro_page(2, 12)
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset ' .. lockstyleset)
end