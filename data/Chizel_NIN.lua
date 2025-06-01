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
--              [ CTRL+F11 ]        Cycle Casting Modes
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ CTRL+` ]          Toggle Treasure Hunter Mode
--              [ ALT+` ]           Toggle Magic Burst Mode
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


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff.Migawari = buffactive.migawari or false
    state.Buff.Doom = buffactive.doom or false
    state.Buff.Yonin = buffactive.Yonin or false
    state.Buff.Innin = buffactive.Innin or false
    state.Buff.Futae = buffactive.Futae or false
    state.Buff.Sange = buffactive.Sange or false

    no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
              "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring", "Reraise Earring", 
			  "Cassie's Cap", "Korrigan Masque", "Korrigan Suit", "Nexus Cape", "Worm Masque +1"}
	no_shoot_ammo = S{"Seki Shuriken"}

    include('Mote-TreasureHunter')

    -- For th_action_check():
    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{35, 204}
    -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
    info.default_u_ja_ids = S{201, 202, 203, 205, 207}

    lugra_ws = S{'Blade: Kamu', 'Blade: Shun', 'Blade: Ten'}

    lockstyleset = 21
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal','LowAcc','HighAcc')
    state.HybridMode:options('Normal','DT')
    state.WeaponskillMode:options('Normal','SC','PDL')
    state.CastingMode:options('Normal','Resistant')
    state.IdleMode:options('Normal','Evasion')
    state.PhysicalDefenseMode:options('PDT','Evasion')

	if player.sub_job == 'WAR' then
		state.WeaponSet = 	M{['description']='Weapon Set','HeishiTA','KikokuTA','GokotaiTA','TauretAE',
							'GreatSwordProc','DaggerProc','SwordProc','ScytheProc','KatanaProc','GKProc','ClubProc','PoleProc','StaffProc'}
		else
		state.WeaponSet = 	M{['description']='Weapon Set','HeishiSC','HeishiTP','HeishiTA','HeishiYag','KikokuSC','KikokuTP','KikokuTA','KikokuYag','FudoSC','FudoTP','FudoTA','FudoTank',
		'FuckPLD','NaeglingSC','NaeglingTP','NaeglingTA','NaeglingYag','GokotaiSC','GokotaiTP','GokotaiTA', 'GokotaiMB2','TauretAE', 'TauretCrit','TauretYag','Lv1','Karambit','Hachimonji'}
	end
	
    state.WeaponLock = M(false, 'Weapon Lock')
    state.MagicBurst = M(false, 'Magic Burst')
    -- state.CP = M(false, "Capacity Points Mode")

    options.ninja_tool_warning_limit = 10
	
	gear.RAShuriken = "Date Shuriken"
	options.ammo_warning_limit = 5

    -- Additional local binds
    include('Chizel_Global_Binds.lua')
    -- include('Global-GEO-Binds.lua') -- OK to remove this line

    send_command('bind @t gs c cycle treasuremode')
    send_command('bind !` gs c toggle MagicBurst')
    
	send_command('bind ^- input /ja "Yonin" <me>')
    send_command('bind ^= input /ja "Innin" <me>')
	send_command('bind @f input /ja "Futae" <me>')
	--Enmity Tools (Yonin Stance)
	send_command('bind ^, input /ma "Gekka: Ichi" <me>')
    send_command('bind ^. input /ma "Kakka: Ichi" <me>')
    send_command('bind ^/ input /ma "Myoshu: Ichi" <me>')
	--Pax Tools (Innin Stance)
	send_command('bind !, input /ma "Yain: Ichi" <me>')

    send_command('bind @w gs c toggle WeaponLock')
    -- send_command('bind @c gs c toggle CP')
    send_command('bind @e gs c cycleback WeaponSet')
    send_command('bind @r gs c cycle WeaponSet')

    if player.sub_job == 'WAR' then
        send_command('bind ^numpad/ input /ja "Berserk" <me>')
        send_command('bind ^numpad* input /ja "Warcry" <me>')
        send_command('bind ^numpad- input /ja "Aggressor" <me>')
		send_command('bind ^numpad+ input /ja "Provoke" <stnpc>')
	elseif player.sub_job == 'DNC' then
		send_command('bind ^numpad/ input /ja "Quickstep" <t>')
		send_command('bind ^numpad* input /ja "Box Step" <t>')
		send_command('bind ^numpad- input /ja "Stutter Step" <t>')
		send_command('bind ^numpad+ input /ja "Animated Flourish" <stnpc>')
	elseif player.sub_job == 'RDM' then
		send_command('bind ^numpad/ input /ma "Refresh" <stpt>')
		send_command('bind ^numpad* input /ma "Stoneskin" <me>')
		send_command('bind ^numpad- input /ma "Aquaveil" <me>')
		send_command('bind ^numpad+ input /ma "Dia" <stnpc>')
		send_command('bind @/ input /nin "Utsusemi: San" <me>')
	elseif player.sub_job == 'BLM' then
		send_command('bind ^numpad/ input /ma "Burn" <t>')
		send_command('bind ^numpad* input /ma "Frost" <t>')
		send_command('bind ^numpad- input /ma "Shock" <t>')
		send_command('bind ^numpad+ input /ja "Elemental Seal" <stnpc>')
	elseif player.sub_job == 'RNG' then
		send_command('bind ^numpad/ input /ja "Sharpshot" <me>')
		send_command('bind ^numpad* input /ja "Shadowbind" <me>')
		send_command('bind ^numpad- input /ja "Camouflage" <me>')
	elseif player.sub_job == 'MNK' then
		send_command('bind ^numpad/ input /ja "Boost" <me>')
		send_command('bind ^numpad* input /ja "Focus" <me>')
		send_command('bind ^numpad- input /ja "Chakra" <me>')
		send_command('bind ^numpad+ input /ja "Counterstance" <me>')
	elseif player.sub_job == 'RUN' then
		send_command('bind ^numpad/ input /ja "Swordplay" <me>')
		send_command('bind ^numpad* input /ja "Pflug" <me>')
		send_command('bind ^numpad- input /ja "Valiance" <me>')
		send_command('bind !numpad- input /ja "Vallation" <me>')
		send_command('bind ^numpad+ input /ma "Flash" <stnpc>')
	elseif player.sub_job == 'DRK' then
		send_command('bind ^numpad/ input /ja "Last Resort" <me>')
		send_command('bind ^numpad* input /ma "Absorb-STR" <stnpc>')
		send_command('bind ^numpad- input /ma "Absorb-TP" <stnpc>')
		send_command('bind ^numpad+ input /ma "Stun" <t>')
    elseif player.sub_job == 'DRG' then
		send_command('bind ^numpad/ input /ja "Jump" <t>')
		send_command('bind ^numpad* input /ja "High Jump" <t>')
		send_command('bind ^numpad- input /ja "Super Jump" <t>')
		send_command('bind ^numpad+ input /ma "Ancient Circle" <me>')
	elseif player.sub_job == 'SAM' then
		send_command('bind ^numpad/ input /ja "Hasso" <me>')
		send_command('bind ^numpad* input /ja "Meditate" <me>')
		send_command('bind ^numpad- input /ja "Sekkanoki" <me>')
		send_command('bind !numpad/ input /ja "Seigan" <me>')
		send_command('bind !numpad- input /ja "Third Eye" <me>')
	end

	send_command('bind ^numpad0 input /ws "Blade: Ten" <t>')
	send_command('bind ^numpad1 input /ws "Blade: Chi" <t>')
	send_command('bind ^numpad2 input /ws "Blade: Shun" <t>')
	send_command('bind ^numpad3 input /ws "Blade: Metsu" <t>')
	send_command('bind ^numpad4 input /ws "Blade: Kamu" <t>')
	send_command('bind ^numpad5 input /ws "Blade: Teki" <t>')
	send_command('bind ^numpad6 input /ws "Blade: To" <t>')
    send_command('bind ^numpad7 input /ws "Blade: Ei" <t>')
    send_command('bind ^numpad8 input /ws "Blade: Retsu" <t>')
	send_command('bind ^numpad9 input /ws "Savage Blade" <t>')
	send_command('bind !numpad0 input /ws "Tachi: Kasha" <t>')
	send_command('bind !numpad1 input /ws "Tachi: Jinpu" <t>')
	send_command('bind !numpad2 input /ws "Tachi: Kagero" <t>')
	send_command('bind !numpad3 input /ws "Tachi: Ageha" <t>')
	send_command('bind !numpad4 input /ws "Tachi: Koki" <t>')
	send_command('bind !numpad8 input /ws "Aeolian Edge" <t>')
	send_command('bind !numpad9 input /ws "Evisceration" <t>')	
	
	send_command('bind @m input /mount "Tulfaire"')
	
	--Elemental Wheel: Earth - Wind - Ice - Fire - Water - Thunder	
		send_command('bind ^insert input /nin "Doton: Ichi" <stnpc>')	--CTRL+Insert
		send_command('bind ^home input /nin "Huton: Ichi" <stnpc>')		--CTRL+Delete
		send_command('bind ^pageup input /nin "Hyoton: Ichi" <stnpc>')	--CTRL+Home
		send_command('bind ^pagedown input /nin "Katon: Ichi" <stnpc>')	--CTRL+End
		send_command('bind ^end input /nin "Suiton: Ichi" <stnpc>')		--CTRL+PgUP
		send_command('bind ^delete input /nin "Raiton: Ichi" <stnpc>')	--CTRL+PgDN

		send_command('bind @insert input /nin "Doton: Ni" <stnpc>')		--WIN+Insert
		send_command('bind @home input /nin "Huton: Ni" <stnpc>')		--WIN+Delete
		send_command('bind @pageup input /nin "Hyoton: Ni" <stnpc>')	--WIN+Home
		send_command('bind @pagedown input /nin "Katon: Ni" <stnpc>')	--WIN+End
		send_command('bind @end input /nin "Suiton: Ni" <stnpc>')		--WIN+PgUP
		send_command('bind @delete input /nin "Raiton: Ni" <stnpc>')	--WIN+PgDN
	
		send_command('bind !insert input /nin "Doton: San" <stnpc>')	--ALT+Insert
		send_command('bind !home input /nin "Huton: San" <stnpc>')		--ALT+Delete
		send_command('bind !pageup input /nin "Hyoton: San" <stnpc>')	--ALT+Home
		send_command('bind !pagedown input /nin "Katon: San" <stnpc>')	--ALT+End
		send_command('bind !end input /nin "Suiton: San" <stnpc>')		--ALT+PgUP
		send_command('bind !delete input /nin "Raiton: San" <stnpc>')	--ALT+PgDN

    -- Whether a warning has been given for low ninja tools
    state.warned = M(false)

    select_default_macro_book()
    set_lockstyle()

    state.Auto_Kite = M(false, 'Auto_Kite')
    Haste = 0
    DW_needed = 0
    DW = true
    moving = false
    update_combat_form()
    determine_haste_group()
end

function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind ^-')
    send_command('unbind ^=')
    send_command('unbind @/')
	send_command('unbind @f')
	send_command('unbind @q')
    send_command('unbind @w')
    -- send_command('unbind @c')
    send_command('unbind @e')
    send_command('unbind @r')
    send_command('unbind @t')
	send_command('unbind ^,')
	send_command('unbind ^.')
	send_command('unbind ^/')
	send_command('unbind !,')
    send_command('unbind ^numpad/')
    send_command('unbind ^numpad*')
    send_command('unbind ^numpad-')
    send_command('unbind ^numpad+')
    send_command('unbind !numpad+')
	send_command('unbind !numpad/')
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
	send_command('unbind !numpad4')
	send_command('unbind !numpad3')
	send_command('unbind !numpad2')
	send_command('unbind !numpad1')
	send_command('unbind !numpad0')
	
	send_command('unbind @m')
	
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
	
	-- Appearance Clear
	-- send_command('du clear self')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Precast sets
    --------------------------------------

    -- Enmity set
    sets.Enmity = {
		ammo="Date Shuriken", 						--3
        body="Emet Harness +1", 					--10
		hands="Kurys Gloves", 						--9
		legs="Zoar Subligar +1",					--6
        feet="Mochi. Kyahan +3", 					--8
        neck="Moonlight Necklace", 					--15
		ear1="Cryptic Earring", 					--4
		ear2="Trux Earring", 						--5
		ring1="Supershear Ring", 					--5
		ring2="Eihwaz Ring", 						--5
		back="Reiki Cloak",							--6
        waist="Kasiri Belt", 						--3
        }
		--Enmity +86, with Fudo Masamune (+10 per shadow) +10~70, with Tsuru +15, Enmity Range +86 (non-tank Katanas); +101~171 (Fudo Masamune)
		--Yonin stance: +96~116 (non-Tank Katanas); +111~201 (Fudo Masamune)

    sets.precast.JA['Provoke'] = sets.Enmity
	sets.precast.JA['Swordplay'] = sets.Enmity
	sets.precast.JA['Pflug'] = sets.Enmity
	sets.precast.JA['Vallation'] = sets.Enmity
	sets.precast.JA['Valiance'] = sets.Enmity
	
    sets.precast.JA['Mijin Gakure'] = {legs="Mochi. Hakama +3"} --{legs="Mochi. Hakama +3"}
    sets.precast.JA['Futae'] = {hands="Hattori Tekko +3"}

    sets.precast.Waltz = {
        ammo="Yamarang",
		head="Mummu Bonnet +2",
		neck="Unmoving Collar +1",
		body="Passion Jacket",
													-- hands="Slither Gloves +1",
													-- legs="Dashing Subligar",
		feet="Rawhide Boots",
		ring1="Asklepian Ring",
        waist="Gishdubar Sash",
        }

    sets.precast.Waltz['Healing Waltz'] = {}
	
	sets.precast.JA['Jump'] = {
		ammo="Aurgelmir Orb",
		head="Malignance Chapeau",
		body="Mpaca's Doublet",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Ninja Nodowa +2",
		ear1="Crepuscular Earring",
		ear2="Hattori Earring +1",
		ring1="Chirich Ring +1",
		ring2="Chirich Ring +1",
		back=gear.NIN_STP_Cape,
		waist="Kentarch Belt +1",
		}
	
	sets.precast.JA['High Jump'] = set_combine(sets.precast.JA['Jump'], {neck="Yngvi Choker"})

    -- Fast cast sets for spells

    sets.precast.FC = {
        ammo="Sapience Orb", 						--2
        head=gear.Herc_FC_head, 					--11
        body=gear.Taeon_FC_body, 					--9
        hands="Leyline Gloves", 					--7
        legs="Rawhide Trousers", 					--5
        feet="Malignance Boots", 					--DT -4
		neck="Baetyl Pendant",						--4
        ear1="Eabani Earring", 						--2
        ear2="Loquacious Earring", 					--"Enchntr. Earring +1", --2
        ring1="Kishar Ring", 						--4
        ring2="Medada's Ring", 						--10 "Weather. Ring +1", --6
        back=gear.NIN_FC_Cape, 						--10
        } --/RDM FCII (15%) + Gear (56%), Total Current FC: 76%

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
		neck="Magoraga Beads",						--10
		body="Mochi. Chainmail +3", 				--14
        })

    sets.precast.RA = {
		ammo=gear.RAShuriken
		}

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        ammo="Seeth. Bomblet +1",
        head="Nyame Helm",
        body="Nyame Mail",
        hands="Nyame Gauntlets", 					--gear.Adhemar_B_hands,
        legs="Nyame Flanchard",
        feet="Hattori Kyahan +3",
        neck="Fotia Gorget",
        ear1="Moonshade Earring",
        ear2="Ishvara Earring",
        ring1="Regal Ring",
        ring2="Epaminondas's Ring",
        back=gear.NIN_WSD_STR_Cape,
        waist="Fotia Belt",
        } -- default set

	sets.precast.WS.SC = set_combine(sets.precast.WS, {
		head="Mpaca's Cap",
		back="Sacro Mantle",
		})
		
    sets.precast.WS.PDL = set_combine(sets.precast.WS, {
		ammo="Crepuscular Pebble",
		legs="Mpaca's Hose",
		neck="Ninja Nodowa +2",
		ear2="Hattori Earring +1",
        })
		
	sets.precast.WS['Asuran Fists'] = set_combine(sets.precast.WS, {
		ammo="Coiste Bodhar",
		head="Mpaca's Cap",
		body="Mpaca's Doublet",
		hands="Mpaca's Gloves",
		legs="Mpaca's Hose",
		feet="Mpaca's Boots",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Telos Earring",
		right_ear="Hattori Earring +1",
		left_ring="Regal Ring",
		right_ring="Ilabrat Ring",
		back=gear.NIN_TP_Cape,
		})
		
	sets.precast.WS['Asuran Fists'].SC = set_combine(sets.precast.WS['Asuran Fists'], sets.precast.WS.SC)		
	sets.precast.WS['Asuran Fists'].PDL = set_combine(sets.precast.WS['Asuran Fists'], sets.precast.WS.PDL)
		
	sets.precast.WS['Raging Fists'] = sets.precast.WS['Asuran Fists']
	sets.precast.WS['Raging Fists'].SC = sets.precast.WS['Asuran Fists'].SC
	sets.precast.WS['Raging Fists'].PDL = sets.precast.WS['Asuran Fists'].PDL
	
	sets.precast.WS['Tornado Kick'] = set_combine(sets.precast.WS['Asuran Fists'], {
		head="Mpaca's Cap",
		neck="Combatant's Torque",
		waist="Sailfi Belt +1",
		feet="Shukuyu Sune-Ate",
		})

	sets.precast.WS['Tornado Kick'].SC = set_combine(sets.precast.WS['Tornado Kick'], sets.precast.WS.SC)	
	sets.precast.WS['Tornado Kick'].PDL = set_combine(sets.precast.WS['Tornado Kick'], sets.precast.WS.PDL)	

    sets.precast.WS['Blade: Hi'] = set_combine(sets.precast.WS, {
        ammo="Yetshila +1",
        head="Blistering Sallet +1",
		body="Nyame Mail",
        hands="Nyame Gauntlets",
        neck="Ninja Nodowa +2",
        ear1="Odr Earring",
		ear2="Lugra Earring +1",
		back="Sacro Mantle",
		waist="Sailfi Belt +1",
        })

	sets.precast.WS['Blade: Hi'].SC = set_combine(sets.precast.WS['Blade: Hi'], sets.precast.WS.SC)
    sets.precast.WS['Blade: Hi'].PDL = set_combine(sets.precast.WS['Blade: Hi'], sets.precast.WS.PDL)

    sets.precast.WS['Blade: Metsu'] = set_combine(sets.precast.WS, {
        ammo="Coiste Bodhar",
        neck="Ninja Nodowa +2",
        ear1="Odr Earring",
        ear2="Lugra Earring +1",
        waist="Sailfi Belt +1",
        back="Sacro Mantle", 						--gear.NIN_WS3_Cape,
        })

	sets.precast.WS['Blade: Metsu'].SC = set_combine(sets.precast.WS['Blade: Metsu'], sets.precast.WS.SC)
    sets.precast.WS['Blade: Metsu'].PDL = set_combine(sets.precast.WS['Blade: Metsu'], sets.precast.WS.PDL)

    sets.precast.WS['Blade: Ten'] = set_combine(sets.precast.WS, {
		ammo="Seeth. Bomblet +1",
		head="Mpaca's Cap",
        neck="Rep. Plat. Medal",
		ear1="Lugra Earring +1",
        back=gear.NIN_WSD_STR_Cape,
        waist="Sailfi Belt +1",
        })
		
	sets.precast.WS['Blade: Ten'].SC = set_combine(sets.precast.WS['Blade: Ten'], sets.precast.WS.SC)
    sets.precast.WS['Blade: Ten'].PDL = set_combine(sets.precast.WS['Blade: Ten'], sets.precast.WS.PDL)
	
	sets.precast.WS['Savage Blade'] = sets.precast.WS['Blade: Ten']
	sets.precast.WS['Savage Blade'].SC = sets.precast.WS['Blade: Ten'].SC
	sets.precast.WS['Savage Blade'].PDL = sets.precast.WS['Blade: Ten'].PDL

    sets.precast.WS['Blade: Shun'] = set_combine(sets.precast.WS, {
		ammo="C. Palug Stone",
		head="Mpaca's Cap",
        body="Mpaca's Doublet",
        hands="Mpaca's Gloves",
        legs="Mpaca's Hose",
		neck="Ninja Nodowa +2",
		ear1="Odr Earring",
        ear2="Hattori Earring +1",
		ring2="Ilabrat Ring",
        back="Sacro Mantle",
        })
		
	sets.precast.WS['Blade: Shun'].SC = set_combine(sets.precast.WS['Blade: Shun'], sets.precast.WS.SC)
    sets.precast.WS['Blade: Shun'].PDL = set_combine(sets.precast.WS['Blade: Shun'], sets.precast.WS.PDL)

    sets.precast.WS['Blade: Ku'] = set_combine(sets.precast.WS['Blade: Shun'], {
		ammo="Coiste Bodhar",
		head="Mpaca's Cap",
		body="Nyame Mail",
		hands="Malignance Gloves",
		ear1="Lugra Earring +1",
		})
	
	sets.precast.WS['Blade: Ku'].SC = set_combine(sets.precast.WS['Blade: Ku'], sets.precast.WS.SC)
    sets.precast.WS['Blade: Ku'].PDL = set_combine(sets.precast.WS['Blade: Ku'], sets.precast.WS.PDL)

    sets.precast.WS['Blade: Kamu'] = set_combine(sets.precast.WS, {
		ammo="Crepuscular Pebble",
		neck="Ninja Nodowa +2",
		ear1="Lugra Earring +1",
		ear2="Hattori Earring +1",
		waist="Sailfi Belt +1",
		legs="Mpaca's Hose",
        })

	sets.precast.WS['Blade: Kamu'].SC = set_combine(sets.precast.WS['Blade: Kamu'], sets.precast.WS.SC)	
	sets.precast.WS['Blade: Kamu'].PDL = set_combine(sets.precast.WS['Blade: Kamu'], sets.precast.WS.PDL)

    sets.precast.WS['Blade: Yu'] = set_combine(sets.precast.WS, {
        ammo="Seeth. Bomblet +1",
        head="Hachiya Hatsu. +3",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets",	
        neck="Sibyl Scarf",
        ear2="Friomisi Earring",					--"Crematio Earring",
        ring1="Metamor. Ring +1",
		ring2="Medada's Ring",
		back=gear.NIN_MAB_Cape,
        waist="Orpheus's Sash",
        })
		
	sets.precast.WS['Blade: Yu'].SC = set_combine(sets.precast.WS['Blade: Yu'], sets.precast.WS.SC)		
	sets.precast.WS['Blade: Yu'].PDL = sets.precast.WS['Blade: Yu']
		
	sets.precast.WS['Blade: Ei'] = sets.precast.WS['Blade: Yu']	
	sets.precast.WS['Blade: Ei'].SC = set_combine(sets.precast.WS['Blade: Ei'], sets.precast.WS.SC)	
	sets.precast.WS['Blade: Ei'].PDL = sets.precast.WS['Blade: Ei']

	sets.precast.WS['Blade: Teki'] = set_combine(sets.precast.WS, {
		ammo="Seething Bomblet +1",
		head="Mochi. Hatsuburi +3",
		feet="Nyame Sollerets",
		ear1="Lugra Earring +1",
		back=gear.NIN_WSD_STR_Cape,
		waist="Orpheus's Sash",
		})
	
	sets.precast.WS['Blade: Teki'].SC = set_combine(sets.precast.WS['Blade: Teki'], sets.precast.WS.SC)	
	sets.precast.WS['Blade: Teki'].PDL = set_combine(sets.precast.WS['Blade: Teki'], sets.precast.WS.PDL)
	
	sets.precast.WS['Blade: To'] = sets.precast.WS['Blade: Teki']
	sets.precast.WS['Blade: To'].SC = sets.precast.WS['Blade: Teki'].SC
	sets.precast.WS['Blade: To'].PDL = sets.precast.WS['Blade: Teki'].PDL

	sets.precast.WS['Blade: Chi'] = sets.precast.WS['Blade: Teki']
	sets.precast.WS['Blade: Chi'].SC = sets.precast.WS['Blade: Teki'].SC
	sets.precast.WS['Blade: Chi'].PDL = sets.precast.WS['Blade: Teki'].PDL
	
	sets.precast.WS['Tachi: Jinpu'] = sets.precast.WS['Blade: Teki']
	sets.precast.WS['Tachi: Jinpu'].SC = sets.precast.WS['Blade: Teki'].SC
	sets.precast.WS['Tachi: Jinpu'].PDL = sets.precast.WS['Blade: Teki'].PDL

	sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
		head="Mpaca's Cap",
		body="Mpaca's Doublet",
		ear1="Odr Earring",
		ear2="Lugra Earring +1",
		hands="Mpaca's Gloves",
		ring1="Begrudging Ring",
		ring2="Ilabrat Ring",
		legs="Mpaca's Hose",
		feet="Mpaca's Boots",
		})

	sets.precast.WS['Evisceration'].SC = set_combine(sets.precast.WS['Evisceration'], sets.precast.WS.SC)
	sets.precast.WS['Evisceration'].PDL = set_combine(sets.precast.WS['Evisceration'], sets.precast.WS.PDL)
	
	sets.precast.WS['Aeolian Edge'] = sets.precast.WS['Blade: Yu']
	sets.precast.WS['Aeolian Edge'].SC = set_combine(sets.precast.WS['Aeolian Edge'], sets.precast.WS.PDL)
	sets.precast.WS['Aeolian Edge'].Acc = sets.precast.WS['Aeolian Edge']

    sets.Lugra = {ear2="Lugra Earring +1"}

    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = sets.precast.FC
	
	sets.midcast['Flash'] = sets.Enmity

    sets.midcast.SpellInterrupt = {
        ammo="Staunch Tathlum +1", 					--11
		head=gear.Herc_FC_head,
        body="Hachiya Chain. +3", 					--Shock Spikes
        hands="Rawhide Gloves", 					--15
        legs=gear.Taeon_Phalanx_legs, 				--2
        feet=gear.Taeon_Phalanx_feet, 				--3
        neck="Moonlight Necklace", 					--15
        ear1="Halasz Earring", 						--5
        ear2="Magnetic Earring",					--8
        ring1="Evanescence Ring", 					--5
		ring2="Medada's Ring",
        back=gear.NIN_MAB_Cape, 					--10
        waist="Audumbla Sash", 						--10
        } --Gear SIRD 840/1024 + Merits 100/1024, Total SIRD = 91.8% (940/1024)

    -- Specific spells
    sets.midcast.Utsusemi = set_combine(sets.precast.FC, {
		head="Malignance Chapeau", --*change for null masque once acquired
		ear2="Loquacious Earring",
													-- legs=gear.Herc_FC_pants,
		feet="Hattori Kyahan +3",
		back=gear.NIN_FC_Cape,
		})
		
	sets.midcast.Utsusemi.enmity = set_combine(sets.precast.FC, {
		ammo="Date Shuriken", 						--3
        body="Emet Harness +1", 					--10
		legs="Hattori Hakama +2",
		feet="Hattori Kyahan +3",
		ear1="Cryptic Earring", 					--4
		ear2="Trux Earring", 						--5
		ring1="Supershear Ring", 					--5
		ring2="Eihwaz Ring", 						--5
		back=gear.NIN_FC_Cape,
        })

    sets.midcast.ElementalNinjutsu = {
        ammo="Ghastly Tathlum +1",					--INT +6, Mag.Dmg. 11
        head="Mochi. Hatsuburi +3", 				--INT +32, MAB 61, NIN Dmg 21
        body="Gyve Doublet",						--INT +39, MAB 52
        hands="Nyame Gauntlets",					--INT +28, MAB 30, MB1 +5
        legs="Nyame Flanchard",						--INT +44, MAB 30, MB1 +6
        feet="Mochi. Kyahan +3",					--MAB 25*, Ninjutsu Skill +23
        neck="Sibyl Scarf",							--INT +10, MAB 10
        ear1="Crematio Earring",					--MAB +6, Mag.Dmg. 6
        ear2="Friomisi Earring",					--MAB +10
        ring1="Metamor. Ring +1",					--INT +16, M.Acc +15
        ring2="Medada's Ring",						--INT +10, M.Acc +20, MAB 10
        back=gear.NIN_MAB_Cape,						--INT +23, Mag.Dmg. 20, MAB 10
        waist="Orpheus's Sash",
        } --INT +208, Mag.Dmg. +37, MAB+244, MB1+16, Ninjutsu Dmg. +21, Ninjutsu Skill 490

    sets.midcast.ElementalNinjutsu.Resistant = set_combine(sets.midcast.Ninjutsu, {
		ammo="Pemphredo Tathlum",
        neck="Sanctity Necklace",
		hands="Hattori Tekko +3",
													-- ear1="Enchntr. Earring +1",
        })

    sets.midcast.EnfeeblingNinjutsu = {
        ammo="Yamarang",							--M.Acc +15
        head="Hachiya Hatsu. +3",					--INT +31, M.Acc +54, Ninjutsu +17
        body="Hattori Ningi +2",					--INT +31, M.Acc +54
        hands="Hattori Tekko +3",					--INT +22, M.Acc +52				
        legs="Hattori Hakama +2",					--INT +40, M.Acc +53
        feet="Hachiya Kyahan +3", 					--INT +20, M.Acc +52 (AF Set Bonus +15)
        neck="Incanter's Torque",					--Ninjutsu +10
        ear1="Hnoss Earring", 						--Ninjutsu +10
        ear2="Crepuscular Earring", 				--M.Acc +10
        ring1="Metamor. Ring +1",					--INT +16, M.Acc +15
        ring2="Medada's Ring", 						--INT +10, M.Acc +20
        back=gear.NIN_MAB_Cape,						--INT +23, M.Acc +20
        waist="Eschan Stone",						--M.Acc +7
        } --INT +198, M.Acc +649 (Heishi +122, Kunimitsu +40), Ninjutsu +37

    sets.midcast.EnhancingNinjutsu = {
		ammo="Staunch Tathlum +1",
        head="Hachiya Hatsu. +3",
		body="Malignance Tabard",
		hands="Mochizuki Tekko +3",
        feet="Mochi. Kyahan +3",
        neck="Incanter's Torque",
        ear1="Eabani Earring",
		ear2="Loquacious Earring",
        ring1="Stikini Ring +1",
        ring2="Stikini Ring",
        back=gear.NIN_FC_Cape,
        waist="Engraved Belt", 						--"Cimmerian Sash",
        }

    sets.midcast.Stun = sets.midcast.EnfeeblingNinjutsu

    sets.midcast.RA = {
		ammo=gear.RAShuriken,
        head="Malignance Chapeau",					-- AGI +33, R.Acc +50, sTP +8, Haste +6, PDL +3, DT -6
        body="Mochi. Chainmail +3",					-- AGI +35, R.Acc +47, R.Att +79, Haste +4
        hands="Hachiya Tekko +3",					-- AGI +26, R.Acc +48, R.Att +48, Throwing +14, Haste +5
        legs="Nyame Flanchard",						-- AGI +34, R.Acc +40, R.Att +55, Haste +5, DT -8
        feet="Malignance Boots",					-- AGI +49, R.Acc +50, sTP +9, Haste +3, PDL +2, DT -4
        neck="Ninja Nodowa +2",						-- AGI +15, R.Acc +25, sTP +7, PDL +10							--"Iskur Gorget",
        ear1="Telos Earring",						-- R.Acc +10, R.Att +10, sTP +5
		ear2="Hattori Earring +1",					-- Throwing +11, sTP +4, PDL +8	
        ring1="Dingir Ring",						-- AGI +10, R.Att +25
		ring2="Crepuscular Ring",					-- R.Acc +10, sTP +6
        back="Sacro Mantle",						-- AGI +25, R.Acc +20, R.Att +20
        waist="Reiki Yotai",						-- R.Acc +10, sTP +4,											--"Yemaya Belt",
        }	-- AGI +247, R.Acc +350, R.Att +237, sTP +58, Haste +23, Throwing +25, PDL +23, DT -23

    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------

    -- Resting sets
--    sets.resting = {}

    -- Idle sets
    sets.idle = {
        ammo="Staunch Tathlum +1",
        head="Hattori Zukin +2",
        body="Hattori Ningi +2",
        hands="Malignance Gloves",
        legs="Hattori Hakama +2",
        feet="Malignance Boots",
        neck="Warder's Charm +1",
        ear1="Sanare Earring",
        ear2="Eabani Earring",
        ring1="Shadow Ring",
        ring2="Warden's Ring",
        back=gear.NIN_FC_Cape,
        waist="Engraved Belt",
		}
		
    sets.idle.REGAIN = set_combine(sets.idle, {
		ammo="Staunch Tathlum +1",
		body="Mochi. Chainmail +3",
		hands="Hachiya Tekko +3",
		legs="Mochi. Hakama +3",
		feet="Hiza. Sune-Ate +2",
		neck="Loricate Torque +1",
		ear1="Suppanomimi",
		ring2="Defending Ring",
		back=gear.NIN_DW_Cape,
		waist="Reiki Yotai",
        })
		
	sets.idle.Evasion = set_combine(sets.idle, {
		ammo="Yamarang",
		head="Mpaca's Cap",
		body="Mpaca's Doublet",
		hands="Mpaca's Gloves",
		legs="Mpaca's Hose",
		feet="Mpaca's Boots",
		neck="Bathy Choker +1",	
        ear1="Infused Earring",
		ring1="Fortified Ring",
		waist="Plat. Mog. Belt",
        })

    -- Defense sets
    sets.defense.PDT = sets.idle
    sets.defense.MDT = sets.idle

    sets.Kiting = {feet="Danzo sune-ate", ring2="Defending Ring"}

    sets.DayMovement = {feet="Danzo sune-ate", ring2="Defending Ring"}
    sets.NightMovement = {feet="Hachiya Kyahan +3", ring2="Defending Ring"}


    --------------------------------------
    -- Engaged sets
    --------------------------------------

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- * NIN Native DW Trait: 35% DW

    -- No Magic Haste (74% DW to cap, Dual Wield V = 35%)
    sets.engaged = {
        ammo="Seki Shuriken",
        head="Hattori Zukin +2",		--DW +7
        body="Mochi. Chainmail +3",		--DW +9
        hands="Hachiya Tekko +3",
        legs="Mpaca's Hose",
        feet="Malignance Boots",
        neck="Ninja Nodowa +2",
        ear1="Suppanomimi",				--DW +5
        ear2="Hattori Earring +1",
        ring1="Gere Ring",
        ring2="Epona's Ring",
        back=gear.NIN_DW_Cape,			--DW +10
        waist="Reiki Yotai",			--DW +7
		}	-- DW +38 (-1), Daken +45 (+99), DA +3 (Innin +14), TA +8
			-- STR +145, DEX +205, AGI +196, Acc 1362/1343, R.Acc 1245 (Daken 1345), Att 1385/1228, R.Att 1231, Haste +335/1024, sTP +41, DT -18/PDT -9, PDL +240/1024

    sets.engaged.LowAcc = set_combine(sets.engaged, {
		legs="Malignance Tights",
		feet="Hattori Kyahan +3",
		ear2="Eabani Earring",
		ring1="Cacoethic Ring +1",
		waist="Eschan Stone",
        })	-- DW +40 (+1), Daken +45 (+99), DA +3 (Innin +14), TA +3
			-- STR +149, DEX +204, AGI +207, Acc 1395/1376, R.Acc 1322 (Daken 1422), Att 1380/1221, R.Att 1237, Haste +325/1024, sTP +30, DT -14, PDL +100/1024

    sets.engaged.HighAcc = set_combine(sets.engaged.LowAcc, {
		ring2="Regal Ring",
        })
	
	--DW (74 - 35 = 39) to cap
	sets.engaged.TANK = {
		ammo="Date Shuriken",
		head="Hattori Zukin +2",
		body="Mpaca's Doublet",
		hands="Mpaca's Gloves",
		legs="Hachiya Hakama +3",
		feet="Hattori Kyahan +3",
		neck="Bathy Choker +1",
		ear1="Suppanomimi",
		ear2="Eabani Earring",
		ring1="Fortified Ring",
		ring2="Defending Ring",
		back=gear.NIN_DW_Cape,
		waist="Reiki Yotai",
		}	--DW +38 (-1), PDT -50/MDT -37, Evasion: 1190, Defense: 1323, HP 2763
			--Accuracy: 1326/1315, Attack: 1331/1178, R.Accuracy: 1183, R.Attack: 1077
				
	sets.engaged.TANK.LowAcc = set_combine(sets.engaged.TANK, {
		neck="Ninja Nodowa +2",					--DEX +15, Accuracy +25
		ring1="Chirich Ring +1",				--Accuracy +10
		})	-- Accuracy +35
		
	sets.engaged.TANK.HighAcc = set_combine(sets.engaged.TANK.LowAcc, {
		ring2="Chirich Ring +1",				--Accuracy +10
		})	-- Accuracy +45
		
	sets.engaged.REGAIN = {
		ammo="Seki Shuriken",
		head="Hattori Zukin +2",
		body="Mochi. Chainmail +3",
		hands="Hachiya Tekko +3",
		legs="Mochi. Hakama +3",
		feet="Hiza. Sune-Ate +2",
		neck="Ninja Nodowa +2",
		ear1="Suppanomimi",
		ear2="Eabani Earring",
		ring1="Gere Ring",
		ring2="Epona's Ring",
		back=gear.NIN_DW_Cape,
		waist="Reiki Yotai",
		}
		
    sets.engaged.REGAIN.LowAcc = set_combine(sets.engaged, {
		legs="Hachiya Hakama +3",
		feet="Hattori Kyahan +3",
		ear2="Eabani Earring",
		ring1="Cacoethic Ring +1",
		waist="Eschan Stone",
        })	-- DW +40 (+1), Daken +45 (+99), DA +3 (Innin +14), TA +3
			-- STR +149, DEX +204, AGI +207, Acc 1395/1376, R.Acc 1322 (Daken 1422), Att 1380/1221, R.Att 1237, Haste +325/1024, sTP +30, DT -14, PDL +100/1024

    sets.engaged.REGAIN.HighAcc = set_combine(sets.engaged.LowAcc, {
		ring2="Regal Ring",
		})
		
	sets.engaged.MA = {
		ammo="Seki Shuriken",
		head="Hiza. Somen +2",
		body="Mpaca's Doublet",
		hands="Count's Cuffs",
		legs="Mpaca's Hose",
		feet="Shukuyu Sune-Ate",
		neck="Combatant's Torque",
		waist="Shaolin Belt",
		left_ear="Mache Earring +1",
		right_ear="Mache Earring +1",
		left_ring="Gere Ring",
		right_ring="Epona's Ring",
		back=gear.NIN_TP_Cape,
		}
	
	sets.engaged.GKT = {
		ammo="Seki Shuriken",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Ninja Nodowa +2",
		ear1="Telos Earring",
		ear2="Dedition Earring",
		ring1="Chirich Ring +1",
		ring2="Chirich Ring +1",
		back=gear.NIN_STP_Cape,
		waist="Kentarch Belt +1",
		}

    -- 15% Magic Haste (67% DW to cap, Dual Wield V = 35%)
    sets.engaged.LowHaste = set_combine(sets.engaged, {
        ear1="Telos Earring",
		})	-- DW +33 (+1), Daken +45 (+99), DA +3 (Innin +14), TA +8
			-- STR +145, DEX +205, AGI +194, Acc 1372/1353, R.Acc 1253 (Daken 1353), Att 1395/1238, R.Att 1241, Haste +335/1024, sTP +46, DT -18/PDT -9, PDL +240/1024

    sets.engaged.LowAcc.LowHaste = set_combine(sets.engaged.LowHaste, {
		legs="Malignance Tights",
		feet="Hattori Kyahan +3",
		ring1="Cacoethic Ring +1",
		waist="Eschan Stone",
        })	-- DW +31 (-1), Daken +45 (+99), DA +3 (Innin +14), TA +3
			-- STR +149, DEX +204, AGI +205, Acc 1427/1408, R.Acc 1341 (Daken 1441), Att 1401/1242, R.Att 1258, Haste +325/1024, sTP +39, DT -14, PDL +180/1024

    sets.engaged.HighAcc.LowHaste = set_combine(sets.engaged.LowAcc.LowHaste, {
		ring2="Regal Ring",
        })
	
	--DW (67 - 35 = 32) to cap
	sets.engaged.TANK.LowHaste = set_combine(sets.engaged.TANK, {
		legs="Hattori Hakama +2",
		})	--DW +33 (+1), PDT -50/MDT -48, Evasion: 1188, Defense: 1319, HP 2753
			--Accuracy: 1349/1337, Attack: 1409/1257, R.Accuracy: 1200, R.Attack: 1074
			
	sets.engaged.TANK.LowAcc.LowHaste = set_combine(sets.engaged.TANK.LowHaste, {
		neck="Ninja Nodowa +2",					--DEX +15, Accuracy +25
		ring1="Chirich Ring +1",				--Accuracy +10
		})	-- Accuracy +35
		
	sets.engaged.TANK.HighAcc.LowHaste = set_combine(sets.engaged.TANK.LowAcc.LowHaste, {
		ring2="Chirich Ring +1",				--Accuracy +10
		})	-- Accuracy +45
			
	sets.engaged.REGAIN.LowHaste = sets.engaged.LowHaste
		
    sets.engaged.REGAIN.LowAcc.LowHaste = set_combine(sets.engaged.REGAIN.LowHaste, {
		legs="Hachiya Hakama +3",
		feet="Hattori Kyahan +3",
		ear2="Eabani Earring",
		ring1="Cacoethic Ring +1",
		waist="Eschan Stone",
        })	-- DW +40 (+1), Daken +45 (+99), DA +3 (Innin +14), TA +3
			-- STR +149, DEX +204, AGI +207, Acc 1395/1376, R.Acc 1322 (Daken 1422), Att 1380/1221, R.Att 1237, Haste +325/1024, sTP +30, DT -14, PDL +100/1024

    sets.engaged.REGAIN.HighAcc.LowHaste = set_combine(sets.engaged.REGAIN.LowAcc.LowHaste, {
		ring2="Regal Ring",
		})
		
	sets.engaged.MA.LowHaste = sets.engaged.MA
	sets.engaged.GKT.LowHaste = sets.engaged.GKT

    -- 30% Magic Haste (56% DW to cap, Dual Wield V = 35%)
    sets.engaged.MidHaste = set_combine(sets.engaged, {
		ear1="Telos Earring",
		back=gear.NIN_TP_Cape,
		})	-- DW +23 (+2), Daken +45 (+99), DA +14 (Innin +25), TA +8
			-- STR +145, DEX +205, AGI +194, Acc 1372/1353, R.Acc 1253 (Daken 1353), Att 1395/1238, R.Att 1241, Haste +335/1024, sTP +46, DT -18/PDT -9, PDL +240/1024
			
    sets.engaged.LowAcc.MidHaste = set_combine(sets.engaged.MidHaste, {
		legs="Malignance Tights",
		feet="Hattori Kyahan +3",
		ring1="Cacoethic Ring +1",
		waist="Eschan Stone",
        })	-- DW +21 (0), Daken +45 (+99), DA +14 (Innin +25), TA +3
			-- STR +149, DEX +204, AGI +205, Acc 1427/1408, R.Acc 1341 (Daken 1441), Att 1401/1242, R.Att 1258, Haste +325/1024, sTP +39, DT -14, PDL +180/1024

    sets.engaged.HighAcc.MidHaste = set_combine(sets.engaged.MidHaste.LowAcc, {
		ring2="Regal Ring",
        })
	
	--DW (56 - 35 = 21) to cap
	sets.engaged.TANK.MidHaste = set_combine(sets.engaged.TANK, {
		legs="Hattori Hakama +2",
		ear1="Infused Earring",
		waist="Svelt. Gouriz +1",
		})	-- DW +21 (0), PDT -50/MDT -48, Evasion: 1214, Defense: 1320, HP 2753
			--Accuracy: 1339/1327, Attack: 1404/1252, R.Accuracy: 1199, R.Attack: 1074
		
	sets.engaged.TANK.LowAcc.MidHaste = set_combine(sets.engaged.TANK.MidHaste, {
		ear1="Telos Earring",				--Accuracy +10
		ring1="Chirich Ring +1",			--Accuracy +10
		ring2="Chirich Ring +1",			--Accuracy +10
		})	-- Accuracy +30
		
	sets.engaged.TANK.HighAcc.MidHaste = set_combine(sets.engaged.TANK.LowAcc.MidHaste, {
		neck="Ninja Nodowa +2",				--DEX +15, Accuracy +25
		waist="Kentarch Belt +1",			--Accuracy +14
		})	-- Accuracy +69
			
	sets.engaged.REGAIN.MidHaste = sets.engaged.MidHaste
		
    sets.engaged.REGAIN.LowAcc.MidHaste = set_combine(sets.engaged.REGAIN.MidHaste, {
		legs="Hachiya Hakama +3",
		feet="Hattori Kyahan +3",
		ear2="Eabani Earring",
		ring1="Cacoethic Ring +1",
		waist="Eschan Stone",
        })	-- DW +40 (+1), Daken +45 (+99), DA +3 (Innin +14), TA +3
			-- STR +149, DEX +204, AGI +207, Acc 1395/1376, R.Acc 1322 (Daken 1422), Att 1380/1221, R.Att 1237, Haste +325/1024, sTP +30, DT -14, PDL +100/1024

    sets.engaged.REGAIN.HighAcc.MidHaste = set_combine(sets.engaged.REGAIN.LowAcc.MidHaste, {
		ring2="Regal Ring",
		})
		
	sets.engaged.MA.MidHaste = sets.engaged.MA
	sets.engaged.GKT.MidHaste = sets.engaged.GKT

    -- 35% Magic Haste (51% DW to cap, Dual Wield V = 35%)
    sets.engaged.HighHaste = set_combine(sets.engaged, {
		head="Malignance Chapeau",
		ear1="Telos Earring",
		back=gear.NIN_TP_Cape,
		}) 	-- DW +17 (+1), Daken +45 (+99), DA +14 (Innin +25), TA +10, QA +2
			-- STR +130, DEX +209, AGI +198, Acc 1374/1355, R.Acc 1255 (Daken 1355), Att 1329/1179, R.Att 1226, Haste +294/1024, sTP +54, DT -15/PDT -9, PDL +270/1024

    sets.engaged.LowAcc.HighHaste = set_combine(sets.engaged.HighHaste, {
		head="Malignance Chapeau",
		legs="Malignance Tights",
		feet="Hattori Kyahan +3",
		ring1="Cacoethic Ring +1",
		waist="Eschan Stone",
        })	-- DW +14 (-2), Daken +45 (+99), DA +14 (Innin +25), TA +3
			-- STR +134, DEX +208, AGI +209, Acc 1429/1410, R.Acc 1343 (Daken 1443), Att 1335/1184, R.Att 1243, Haste +284/1024, sTP +47, DT -11, PDL +210/1024

    sets.engaged.HighAcc.HighHaste = set_combine(sets.engaged.LowAcc.HighHaste, {
		ring2="Regal Ring",
        })
	
	--DW (51 - 35 = 16) to cap
	sets.engaged.TANK.HighHaste = set_combine(sets.engaged.TANK, {
		legs="Hattori Hakama +2",
		back=gear.NIN_STP_Cape,
		waist="Svelt. Gouriz +1",
		})	-- DW +16 (0), PDT -50/MDT -48, Evasion: 1214, Defense: 1320, HP 2753
			--Accuracy: 1339/1327, Attack: 1404/1252, R.Accuracy: 1199, R.Attack: 1074
	
	sets.engaged.TANK.LowAcc.HighHaste = set_combine(sets.engaged.TANK.HighHaste, {
		ring1="Chirich Ring +1",			--Accuracy +10
		ring2="Chirich Ring +1",			--Accuracy +10
		})	-- Accuracy +20
		
	sets.engaged.TANK.HighAcc.HighHaste = set_combine(sets.engaged.TANK.LowAcc.HighHaste, {
		neck="Ninja Nodowa +2",				--DEX +15, Accuracy +25
		waist="Kentarch Belt +1",			--Accuracy +14
		})	-- Accuracy +59
			
	sets.engaged.REGAIN.HighHaste = sets.engaged.HighHaste
		
    sets.engaged.REGAIN.LowAcc.HighHaste = set_combine(sets.engaged.REGAIN.HighHaste, {
		legs="Hachiya Hakama +3",
		feet="Hattori Kyahan +3",
		ear2="Eabani Earring",
		ring1="Cacoethic Ring +1",
		waist="Eschan Stone",
        })	-- DW +40 (+1), Daken +45 (+99), DA +3 (Innin +14), TA +3
			-- STR +149, DEX +204, AGI +207, Acc 1395/1376, R.Acc 1322 (Daken 1422), Att 1380/1221, R.Att 1237, Haste +325/1024, sTP +30, DT -14, PDL +100/1024

    sets.engaged.REGAIN.HighAcc.HighHaste = set_combine(sets.engaged.REGAIN.LowAcc.HighHaste, {
		ring2="Regal Ring",
		})
		
	sets.engaged.MA.HighHaste = sets.engaged.MA
	sets.engaged.GKT.HighHaste = sets.engaged.GKT

    -- 45% Magic Haste (36% DW to cap, Dual Wield V = 35%)
    sets.engaged.MaxHaste = set_combine(sets.engaged, {
		head="Malignance Chapeau",
		ear1="Telos Earring",
		back=gear.NIN_TP_Cape,
		waist="Windbuffet Belt +1",
		})	-- DW +9 (+8), Daken +45 (+99), DA +3, TA +10, QA +2
			-- STR +130, DEX +209, AGI +198, Acc 1366/1347, R.Acc 1245 (Daken 1345), Att 1329/1179, R.Att 1226, Haste +294/1024, sTP +50, DT -15/PDT -9, PDL +270/1024

    sets.engaged.LowAcc.MaxHaste = set_combine(sets.engaged.MaxHaste, {
		legs="Malignance Tights",
		feet="Hattori Kyahan +3",
		ring1="Cacoethic Ring +1",
		waist="Eschan Stone",
		back=gear.NIN_STP_Cape,
        })	-- DW +14 (+13), Daken +45 (+99), DA +4 (Innin +15), TA +3
			-- STR +134, DEX +208, AGI +209, Acc 1439/1420, R.Acc 1343 (Daken 1443), Att 1335/1184, R.Att 1233, Haste +284/1024, sTP +57, DT -11, PDL +210/1024

    sets.engaged.HighAcc.MaxHaste = set_combine(sets.engaged.LowAcc.MaxHaste, {
		ring2="Regal Ring",
        })
	
	--DW (36 - 35 = 1) to cap
	sets.engaged.TANK.MaxHaste = set_combine(sets.engaged.TANK, {
		head="Mpaca's Cap",
		legs="Hattori Hakama +2",
		ear1="Infused Earring",
		back=gear.NIN_STP_Cape,
		waist="Svelt. Gouriz +1",
		})	-- DW +4 (+3), PDT -50/MDT -48, Evasion: 1224, Defense: 1347, HP 2753
			--Accuracy: 1339/1327, Attack: 1420/1265, R.Accuracy: 1145, R.Attack: 1071
		
	sets.engaged.TANK.LowAcc.MaxHaste = set_combine(sets.engaged.TANK.MaxHaste, {
		neck="Ninja Nodowa +2",				--DEX +15, Accuracy +25
		ear1="Telos Earring",				--Accuracy +10
		ring1="Chirich Ring +1",			--Accuracy +10
		ring2="Chirich Ring +1",			--Accuracy +10
		})	-- Accuracy +55
		
	sets.engaged.TANK.HighAcc.MaxHaste = set_combine(sets.engaged.TANK.LowAcc.MaxHaste, {
		head="Malignance Chapeau",			--DEF: 121, VIT +19, AGI +33, Evasion +91, M.Evasion +123, MDB +5, Haste +6, DT -6 (HP +45, DEX +40, Accuracy +50)
		waist="Kentarch Belt +1",			--Accuracy +14
		})	-- Accuracy +74
			
	sets.engaged.REGAIN.MaxHaste = sets.engaged.MaxHaste
		
    sets.engaged.REGAIN.LowAcc.MaxHaste = set_combine(sets.engaged.REGAIN.MaxHaste, {
		legs="Hachiya Hakama +3",
		feet="Hattori Kyahan +3",
		ear2="Eabani Earring",
		ring1="Cacoethic Ring +1",
		waist="Eschan Stone",
        })	-- DW +40 (+1), Daken +45 (+99), DA +3 (Innin +14), TA +3
			-- STR +149, DEX +204, AGI +207, Acc 1395/1376, R.Acc 1322 (Daken 1422), Att 1380/1221, R.Att 1237, Haste +325/1024, sTP +30, DT -14, PDL +100/1024

    sets.engaged.REGAIN.HighAcc.MaxHaste = set_combine(sets.engaged.REGAIN.LowAcc.MaxHaste, {
		ring2="Regal Ring",
		})
		
	sets.engaged.MA.MaxHaste = sets.engaged.MA
	sets.engaged.GKT.MaxHaste = sets.engaged.GKT

    sets.engaged.Hybrid = {
        legs="Malignance Tights", 					--7
		ring2="Defending Ring",						--10
        }

    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.LowAcc.DT = set_combine(sets.engaged.LowAcc, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT = set_combine(sets.engaged.HighAcc, sets.engaged.Hybrid)
    sets.engaged.TANK.DT = set_combine(sets.engaged.TANK, sets.engaged.Hybrid)
    sets.engaged.TANK.LowAcc.DT = set_combine(sets.engaged.TANK.LowAcc, sets.engaged.Hybrid)
    sets.engaged.TANK.HighAcc.DT = set_combine(sets.engaged.TANK.HighAcc, sets.engaged.Hybrid)
    sets.engaged.REGAIN.DT = set_combine(sets.engaged.REGAIN, sets.engaged.Hybrid)
    sets.engaged.REGAIN.LowAcc.DT = set_combine(sets.engaged.REGAIN.LowAcc, sets.engaged.Hybrid)
    sets.engaged.REGAIN.HighAcc.DT = set_combine(sets.engaged.REGAIN.HighAcc, sets.engaged.Hybrid)
	sets.engaged.MA.DT = set_combine(sets.engaged.MA, sets.engaged.Hybrid)
	sets.engaged.GKT.DT = set_combine(sets.engaged.GKT, sets.engaged.Hybrid)

    sets.engaged.DT.LowHaste = set_combine(sets.engaged.LowHaste, sets.engaged.Hybrid)
    sets.engaged.LowAcc.DT.LowHaste = set_combine(sets.engaged.LowAcc.LowHaste, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT.LowHaste = set_combine(sets.engaged.HighAcc.LowHaste, sets.engaged.Hybrid)
    sets.engaged.TANK.DT.LowHaste = set_combine(sets.engaged.TANK.LowHaste, sets.engaged.Hybrid)
    sets.engaged.TANK.LowAcc.DT.LowHaste = set_combine(sets.engaged.TANK.LowAcc.LowHaste, sets.engaged.Hybrid)
    sets.engaged.TANK.HighAcc.DT.LowHaste = set_combine(sets.engaged.TANK.HighAcc.LowHaste, sets.engaged.Hybrid)
    sets.engaged.REGAIN.DT.LowHaste = set_combine(sets.engaged.REGAIN.LowHaste, sets.engaged.Hybrid)
    sets.engaged.REGAIN.LowAcc.DT.LowHaste = set_combine(sets.engaged.REGAIN.LowAcc.LowHaste, sets.engaged.Hybrid)
    sets.engaged.REGAIN.HighAcc.DT.LowHaste = set_combine(sets.engaged.REGAIN.HighAcc.LowHaste, sets.engaged.Hybrid)
	sets.engaged.MA.DT.LowHaste = set_combine(sets.engaged.MA.LowHaste, sets.engaged.Hybrid)
	sets.engaged.GKT.DT.LowHaste = set_combine(sets.engaged.GKT.LowHaste, sets.engaged.Hybrid)

    sets.engaged.DT.MidHaste = set_combine(sets.engaged.MidHaste, sets.engaged.Hybrid)
    sets.engaged.LowAcc.DT.MidHaste = set_combine(sets.engaged.LowAcc.MidHaste, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT.MidHaste = set_combine(sets.engaged.HighAcc.MidHaste, sets.engaged.Hybrid)
    sets.engaged.TANK.DT.MidHaste = set_combine(sets.engaged.TANK.MidHaste, sets.engaged.Hybrid)
    sets.engaged.TANK.LowAcc.DT.MidHaste = set_combine(sets.engaged.TANK.LowAcc.MidHaste, sets.engaged.Hybrid)
    sets.engaged.TANK.HighAcc.DT.MidHaste = set_combine(sets.engaged.TANK.HighAcc.MidHaste, sets.engaged.Hybrid)
    sets.engaged.REGAIN.DT.MidHaste = set_combine(sets.engaged.REGAIN.MidHaste, sets.engaged.Hybrid)
    sets.engaged.REGAIN.LowAcc.DT.MidHaste = set_combine(sets.engaged.REGAIN.LowAcc.MidHaste, sets.engaged.Hybrid)
    sets.engaged.REGAIN.HighAcc.DT.MidHaste = set_combine(sets.engaged.REGAIN.HighAcc.MidHaste, sets.engaged.Hybrid)
	sets.engaged.MA.DT.MidHaste = set_combine(sets.engaged.MA.MidHaste, sets.engaged.Hybrid)
	sets.engaged.GKT.DT.MidHaste = set_combine(sets.engaged.GKT.MidHaste, sets.engaged.Hybrid)

    sets.engaged.DT.HighHaste = set_combine(sets.engaged.HighHaste, sets.engaged.Hybrid)
    sets.engaged.LowAcc.DT.HighHaste = set_combine(sets.engaged.LowAcc.HighHaste, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT.HighHaste = set_combine(sets.engaged.HighAcc.HighHaste, sets.engaged.Hybrid)
    sets.engaged.TANK.DT.HighHaste = set_combine(sets.engaged.TANK.HighHaste, sets.engaged.Hybrid)
    sets.engaged.TANK.LowAcc.DT.HighHaste = set_combine(sets.engaged.TANK.LowAcc.HighHaste, sets.engaged.Hybrid)
    sets.engaged.TANK.HighAcc.DT.HighHaste = set_combine(sets.engaged.TANK.HighAcc.HighHaste, sets.engaged.Hybrid)
    sets.engaged.REGAIN.DT.HighHaste = set_combine(sets.engaged.REGAIN.HighHaste, sets.engaged.Hybrid)
    sets.engaged.REGAIN.LowAcc.DT.HighHaste = set_combine(sets.engaged.REGAIN.LowAcc.HighHaste, sets.engaged.Hybrid)
    sets.engaged.REGAIN.HighAcc.DT.HighHaste = set_combine(sets.engaged.REGAIN.HighAcc.HighHaste, sets.engaged.Hybrid)
	sets.engaged.MA.DT.HighHaste = set_combine(sets.engaged.MA.HighHaste, sets.engaged.Hybrid)
	sets.engaged.GKT.DT.HighHaste = set_combine(sets.engaged.GKT.HighHaste, sets.engaged.Hybrid)

    sets.engaged.DT.MaxHaste = set_combine(sets.engaged.MaxHaste, sets.engaged.Hybrid)	-- Acc 1403/1384, R.Acc 1400, Att 1343/1199, R.Att 1214, DT -36
    sets.engaged.LowAcc.DT.MaxHaste = set_combine(sets.engaged.LowAcc.MaxHaste, sets.engaged.Hybrid)	-- Acc 1446/1427, R.Acc 1445, Att 1413/1263, R.Att 1230, DT -32
    sets.engaged.HighAcc.DT.MaxHaste = set_combine(sets.engaged.HighAcc.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.TANK.DT.MaxHaste = set_combine(sets.engaged.TANK.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.TANK.LowAcc.DT.MaxHaste = set_combine(sets.engaged.TANK.LowAcc.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.TANK.HighAcc.DT.MaxHaste = set_combine(sets.engaged.TANK.HighAcc.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.REGAIN.DT.MaxHaste = set_combine(sets.engaged.REGAIN.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.REGAIN.LowAcc.DT.MaxHaste = set_combine(sets.engaged.REGAIN.LowAcc.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.REGAIN.HighAcc.DT.MaxHaste = set_combine(sets.engaged.REGAIN.HighAcc.MaxHaste, sets.engaged.Hybrid)
	sets.engaged.MA.DT.MaxHaste = set_combine(sets.engaged.MA.MaxHaste, sets.engaged.Hybrid)
	sets.engaged.GKT.DT.MaxHaste = set_combine(sets.engaged.GKT.MaxHaste, sets.engaged.Hybrid)
	
    --------------------------------------
    -- Custom buff sets
    --------------------------------------

    sets.buff.Migawari = {body="Hattori Ningi +2"}
    sets.buff.Yonin = {legs="Hattori Hakama +2"}
    -- sets.buff.Innin = {head="Hattori Zukin +2"}

    sets.magic_burst = set_combine(sets.midcast.ElementalNinjutsu, {
        hands="Hattori Tekko +3",
        ring1="Mujin Band",
        ring2="Medada's Ring",
	})	--(Gokotai/Kunimitsu):	INT +214, M.Dmg +475, M.Acc +625, MAB +253, MB1 +38, MB2 +5, N.Dmg +39
		--(Gokotai/Ochu): 		INT +223, M.Dmg +372, M.Acc +585, MAB +233, MB1 +38, MB2 +18, N.Dmg +39, N.Skill +6 (Set requires: W.Charm+1 R15, Crematio Ear., A.Cape)
		
    sets.buff.Doom = {
		neck="Nicander's Necklace", 					--20
		ring1="Purity Ring", 							--7
		ring2="Saida Ring", 							--15
		waist="Gishdubar Sash", 						--10
	}

    sets.TreasureHunter = {
		ammo="Perfect Lucky Egg", 				--1
        body="Volte Jupon",						--2
		legs="Volte Hose",						--1
    }	--TH Base = 0, TH Gear = 4, Max TH = TH Gear, Total TH = 4


	--Heishi Shorinken
	sets.HeishiSC = {main="Heishi Shorinken", sub="Kunimitsu"}
	sets.HeishiTP = {main="Heishi Shorinken", sub="Hitaki"}
	sets.HeishiTA = {main="Heishi Shorinken", sub="Gleti's Knife"}
	sets.HeishiYag = {main="Heishi Shorinken", sub="Yagyu Darkblade"}
	--Kikoku
	sets.KikokuSC = {main="Kikoku", sub="Kunimitsu"}
	sets.KikokuTP = {main="Kikoku", sub="Hitaki"}
	sets.KikokuTA = {main="Kikoku", sub="Gleti's Knife"}
	sets.KikokuYag = {main="Kikoku", sub="Yagyu Darkblade"}
	--Tanking
	sets.FudoSC = {main="Fudo Masamune", sub="Kunimitsu"}
	sets.FudoTP = {main="Fudo Masamune", sub="Hitaki"}
	sets.FudoTA = {main="Fudo Masamune", sub="Gleti's Knife"}
	sets.FudoTank = {main="Fudo Masamune", sub="Tsuru"}
	sets.FuckPLD = {main="Fudo Masamune", sub="Yagyu Darkblade"}
	--Naegling
    sets.NaeglingSC = {main="Naegling", sub="Kunimitsu"}
    sets.NaeglingTP = {main="Naegling", sub="Hitaki"}
	sets.NaeglingTA = {main="Naegling", sub="Gleti's Knife"}
	sets.NaeglingYag = {main="Naegling", sub="Yagyu Darkblade"}
	--Gokotai
    sets.GokotaiSC = {main="Gokotai", sub="Kunimitsu"}
	sets.GokotaiTP = {main="Gokotai", sub="Hitaki"}
	sets.GokotaiTA = {main="Gokotai", sub="Gleti's Knife"}
	sets.GokotaiMB2 = {main="Gokotai", sub="Ochu"}
	--Tauret
    sets.TauretAE = {main="Tauret", sub="Kunimitsu"}
    sets.TauretCrit = {main="Tauret", sub="Gleti's Knife"}
    sets.TauretYag = {main="Tauret", sub="Yagyu Darkblade"}
	--Lv1 Melee--
	sets.Lv1 = {main="Yagyu Shortblade +1",sub="Yagyu Shortblade"}
	--Karambit
	sets.Karambit = {main="Karambit", sub=empty}
	--Hachimonji
	sets.Hachimonji = {main="Hachimonji", sub="Rigorous Grip +1"}
	--Proc Weapons
	sets.GreatSwordProc = {main="Lament", sub="Alber Strap"}
	sets.DaggerProc = {main="Infiltrator", sub="Esikuva"}
	sets.SwordProc = {main="Kam'lanaut's Sword", sub="Esikuva"}
	sets.ScytheProc = {main="Lost Sickle +1", sub="Alber Strap"}
	sets.KatanaProc = {main="Yagyu Shortblade +1", sub="Esikuva"}
	sets.GKProc = {main="Mutsunokami +1", sub="Alber Strap"}
	sets.ClubProc = {main="Chac-chacs", sub="Esikuva"}
	sets.PoleProc = {main="Aern Spear II", sub="Alber Strap"}
	sets.StaffProc = {main="Trick Staff", sub="Alber Strap"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
    if spell.skill == "Ninjutsu" then
        do_ninja_tool_checks(spell, spellMap, eventArgs)
    end
    if spellMap == 'Utsusemi' and player.equipment.sub ~= 'Yagyu Darkblade' then
        if buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)'] then
            cancel_spell()
            add_to_chat(123, '**!! '..spell.english..' Canceled: [3+ IMAGES] !!**')
            eventArgs.handled = true
            return
        elseif buffactive['Copy Image'] or buffactive['Copy Image (2)'] then
            send_command('cancel 66; cancel 444; cancel Copy Image; cancel Copy Image (2)')
        end
    end
	if spellMap == 'Utsusemi' and player.equipment.sub == 'Yagyu Darkblade' then
        if buffactive['Copy Image'] then
            send_command('cancel Copy Image')
		elseif buffactive['Copy Image (2)'] then
			send_command('cancel Copy Image (2)')
		elseif buffactive['Copy Image (3)'] then
			send_command('cancel Copy Image (3)')
		elseif buffactive['Copy Image (4+)'] then
			send_command('cancel Copy Image (4+)')
        end
    end
    if spell.action_type == 'Ranged Attack' then
        do_bullet_checks(spell, spellMap, eventArgs)
    end

end

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' then
        if lugra_ws:contains(spell.english) and (world.time >= (17*60) or world.time <= (7*60)) then
            equip(sets.Lugra)
        end
        if spell.english == 'Blade: Yu' and (world.weather_element == 'Water' or world.day_element == 'Water') then
            equip(sets.Obi)
        end
    end
	if spell.action_type == 'Ranged Attack' then
        special_ammo_check()
        if flurry == 2 then
            equip(sets.precast.RA.Flurry2)
        elseif flurry == 1 then
            equip(sets.precast.RA.Flurry1)
        end
    end
end

-- Run after the general midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spellMap == 'ElementalNinjutsu' then
        if state.MagicBurst.value then
            equip(sets.magic_burst)
        end
        if (spell.element == world.day_element or spell.element == world.weather_element) then
            equip(sets.Obi)
        end
        if state.Buff.Futae then
            equip(sets.precast.JA['Futae'])
        end
    end
	if spellMap == 'Utsusemi' and buffactive.Yonin then
		equip(sets.midcast.Utsusemi.enmity)
		else
		equip(sets.midcast.Utsusemi)
	end
    if state.Buff.Doom then
        equip(sets.buff.Doom)
    end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted and spell.english == "Migawari: Ichi" then
        state.Buff.Migawari = true
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
   -- if buffactive['Reive Mark'] then
       -- if gain then
           -- equip(sets.Reive)
           -- disable('neck')
       -- else
           -- enable('neck')
       -- end
   -- end
   
   if S{'flurry'}:contains(buff:lower()) then
        if not gain then
            flurry = nil
            --add_to_chat(122, "Flurry status cleared.")
        end
        if not midaction() then
            handle_equipping_gear(player.status)
        end
   end

    if buff == "Migawari" and not gain then
        add_to_chat(61, "*** MIGAWARI DOWN ***")
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
	if player.equipment.sub == 'Tsuru' then
		TANK = true
	else
		TANK = false
	end
	
	if player.equipment.main == 'Gokotai' then
		REGAIN = true
	else
		REGAIN = false
	end

	if player.equipment.main == 'Karambit' then
		MA = true
	else
		MA = false
	end
	
	if player.equipment.main == 'Hachimonji' then
		GKT = true
	else
		GKT = false
	end

	if DW == true and TANK == true then
		state.CombatForm:set('TANK')
	elseif DW == true and REGAIN == true then
		state.CombatForm:set('REGAIN')
	elseif MA == true then
		state.CombatForm:set('MA')
	elseif GKT == true then
		state.CombatForm:set('GKT')
    elseif DW == true then
        state.CombatForm:set('DW')
    elseif DW == false then
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
	if REGAIN == true then
		idleSet = sets.idle.REGAIN
	end
	
    if state.Buff.Migawari then
		idleSet = set_combine(idleSet, sets.buff.Migawari)
    end
    -- if state.CP.current == 'on' then
    --     equip(sets.CP)
    --     disable('back')
    -- else
    --     enable('back')
    -- end
    if state.Auto_Kite.value == true then
        if world.time >= (17*60) or world.time <= (7*60) then
            idleSet = set_combine(idleSet, sets.NightMovement)
        else
            idleSet = set_combine(idleSet, sets.DayMovement)
        end
    end

    return idleSet
end


-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.Buff.Migawari then
        meleeSet = set_combine(meleeSet, sets.buff.Migawari)
    end
	-- if state.Buff.Innin then
		-- meleeSet = set_combine(meleeSet, sets.buff.Innin)
	-- end
	-- if state.Buff.Yonin then
		-- meleeSet = set_combine(meleeSet, sets.buff.Yonin)
	-- end
    if state.TreasureMode.value == 'Fulltime' then
        meleeSet = set_combine(meleeSet, sets.TreasureHunter)
    end
    -- if state.Buff.Sange then
        -- meleeSet = set_combine(meleeSet, sets.buff.Sange)
    -- end

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
        elseif spellMap == 'ElementalNinjutsu' then
            ninja_tool_name = "Inoshishinofuda"
        elseif spellMap == 'EnfeeblingNinjutsu' then
            ninja_tool_name = "Chonofuda"
        elseif spellMap == 'EnhancingNinjutsu' then
            ninja_tool_name = "Shikanofuda"
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

function do_bullet_checks(spell, spellMap, eventArgs)
    local bullet_name
    local bullet_min_count = 1

	if spell.action_type == 'Ranged Attack' then
        bullet_name = gear.RAShuriken
    end

    local available_bullets = player.inventory[bullet_name] or player.wardrobe[bullet_name]

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

function special_ammo_check()
    -- Stop if anything but Date Shurikens are equipped
    if no_shoot_ammo:contains(player.equipment.ammo) then
        cancel_spell()
        add_to_chat(123, '** Action Canceled: [ '.. player.equipment.ammo .. ' equipped!! ] **')
        return
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
    if player.sub_job ~= 'NIN' or player.sub_job ~= 'DNC' then
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
    if player.sub_job == 'WAR' then
        set_macro_page(1, 4)
    elseif player.sub_job == 'BLM' then
        set_macro_page(2, 4)
    elseif player.sub_job == 'RDM' then
        set_macro_page(3, 4)
	elseif player.sub_job == 'DNC' then
		set_macro_page(4, 4)
	elseif player.sub_job == 'THF' then
		set_macro_page(5, 4)
	elseif player.sub_job == 'MNK' then
		set_macro_page(6, 4)
	elseif player.sub_job == 'RUN' then
		set_macro_page(7, 4)
	elseif player.sub_job == 'DRK' then
		set_macro_page(8, 4)
	elseif player.sub_job == 'DRG' then
		set_macro_page(9, 4)
	else
		set_macro_page(10, 4)
    end
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset ' .. lockstyleset)
end