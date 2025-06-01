-- Original: Motenten / Modified: Arislan
-- Haste/DW Detection Requires Gearinfo Addon

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
--              [ ALT+` ]           Toggle Magic Burst Mode
--              [ WIN+C ]           Toggle Capacity Points Mode
--
--  Abilities:  [ CTRL+` ]          Composure										*Change to CTRL+-
--              [ CTRL+- ]          Light Arts/Addendum: White						*Change to CTRL+=
--              [ CTRL+= ]          Dark Arts/Addendum: Black						*Change to ALT+=
--              [ CTRL+; ]          Celerity/Alacrity								*Change to CTRL+,
--              [ ALT+[ ]           Accesion/Manifestation							*Change to CTRL+.
--              [ ALT+; ]           Penury/Parsimony								*Change to CTRL+/
--
--  Spells:     [ CTRL+` ]          Stun
--              [ ALT+Q ]           Temper
--              [ ALT+W ]           Flurry II
--              [ ALT+E ]           Haste II
--              [ ALT+R ]           Refresh II
--              [ ALT+Y ]           Phalanx
--              [ ALT+O ]           Regen II
--              [ ALT+P ]           Shock Spikes
--              [ WIN+, ]           Utsusemi: Ichi
--              [ WIN+. ]           Utsusemi: Ni
--
--  Weapons:    [ WIN+W ]          Toggles Weapon Lock
--
--  WS:         [ CTRL+Numpad0 ]    Savage Blade
--              [ CTRL+Numpad1 ]    Chant Du Cygne
--              [ CTRL+Numpad2 ]    Sanguine Blade
--				[ CTRL+Numpad3 ]	Seraph Blade
--				[ CTRL+Numpad4 ]	Aeolian Edge
--				[ CTRL+Numpad5 ]	Black Halo
--				[ CTRL+Numpad6 ]	Empyreal Arrow
--				[ CTRL+Numpad7 ]    Requiescat
--				[ CTRL+Numpad8 ]	Knights of the Round
--				[ CTRL+Numpad9 ]	Death Blossom
--
--              (Global-Binds.lua contains additional non-job-related keybinds)


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--              Addendum Commands:
--              Shorthand versions for each strategem type that uses the version appropriate for
--              the current Arts.
--                                          Light Arts                  Dark Arts
--                                          ----------                  ---------
--              gs c scholar light          Light Arts/Addendum
--              gs c scholar dark                                       Dark Arts/Addendum
--              gs c scholar cost           Penury                      Parsimony
--              gs c scholar speed          Celerity                    Alacrity
--              gs c scholar aoe            Accession                   Manifestation
--              gs c scholar addendum       Addendum: White             Addendum: Black


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

    -- state.CP = M(false, "Capacity Points Mode")
    state.Buff.Composure = buffactive.Composure or false
    state.Buff.Saboteur = buffactive.Saboteur or false
    state.Buff.Stymie = buffactive.Stymie or false
	state.Buff.Accession = buffactive.Accession or false
	state.Buff['Haste Samba'] = buffactive.HasteSamba or false

    no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
              "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring", "Reraise Earring", 
			  "Cassie's Cap", "Korrigan Masque", "Korrigan Suit", "Nexus Cape", "Worm Masque +1"}

	--	Immunobreak spells: Bind, Blind, Blind II, Break, Gravity, Gravity II, Paralyze, Paralyze II, Poison, Poison II, 
	--	Sleep, Sleep II, Sleepga, Sleepga II, Slow, Slow II

    -- enfeebling_int_acc = S{'Bind','Break','Dispel'} --*Immunobreak
	-- enfeebling_mnd_acc = S{'Distract','Distract II','Frazzle','Frazzle II'}
	-- enfeebling_silence = S{'Silence'}
    -- enfeebling_skill = S{'Poison II'} --*Immunobreak
    -- enfeebling_int_effect = S{'Blind','Blind II','Gravity','Gravity II'} --*Immunobreak
    -- enfeebling_mnd_effect = S{'Paralyze','Paralyze II','Slow','Slow II'} --*Immunobreak
    -- enfeebling_magic_sleep = S{'Sleep','Sleep II','Sleepga','Sleepga II'} --*Immunobreak
	-- enfeebling_fraz3_dist3 = S{'Frazzle III','Distract III'}
	-- enfeebling_dia = S{'Dia','Dia II','Dia III','Diaga'}

    skill_spells = S{
        'Temper', 'Temper II', 'Enfire', 'Enfire II', 'Enblizzard', 'Enblizzard II', 'Enaero', 'Enaero II',
        'Enstone', 'Enstone II', 'Enthunder', 'Enthunder II', 'Enwater', 'Enwater II'}
		
	bar_element = S{'Barfire','Barfira','Barblizzard','Barblizzara','Baraero','Baraera','Barstone','Barstonra','Barthunder','Barthundra',
					'Barwater','Barwatera'}
					
	bar_status = S{'Baramnesia','Barvirus','Barvira','Barparalyze','Barparalyzra','Barsilence','Barsilencra','Barpetrify','Barpetra',
					'Barpoison','Barpoisonra','Barblind','Barblindra','Barsleep','Barsleepra'}

    include('Mote-TreasureHunter')

    -- For th_action_check():
    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{35, 204}
    -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
    info.default_u_ja_ids = S{201, 202, 203, 205, 207}
	
	lockstyleset = 22
end


-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Odin', 'MidAcc', 'HighAcc')
    state.HybridMode:options('Normal','DT')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Seidr', 'Resistant')
    state.IdleMode:options('Normal','MDT','PDT')

    state.EnSpell = M{['description']='EnSpell', 'Enfire', 'Enblizzard', 'Enaero', 'Enstone', 'Enthunder', 'Enwater'}
    state.BarElement = M{['description']='BarElement', 'Barfire', 'Barblizzard', 'Baraero', 'Barstone', 'Barthunder', 'Barwater'}
    state.BarStatus = M{['description']='BarStatus', 'Baramnesia', 'Barvirus', 'Barparalyze', 'Barsilence', 'Barpetrify', 'Barpoison', 'Barblind', 'Barsleep'}
    state.GainSpell = M{['description']='GainSpell', 'Gain-STR', 'Gain-INT', 'Gain-AGI', 'Gain-VIT', 'Gain-DEX', 'Gain-MND', 'Gain-CHR'}

	state.WeaponSet = M{['description']='Weapon Set','DeathBlossom','Excalibur','Naegling','MagicWS',
						'Maxentius','Caliburnus','Aeolian','Enspell','Odin'}
	
    state.WeaponLock = M(false, 'Weapon Lock')
    state.MagicBurst = M(false, 'Magic Burst')
    state.EnspellMode = M(false, 'Enspell Melee Mode')
    state.NM = M(false, 'NM Enfeeble Mode')
    -- state.CP = M(false, "Capacity Points Mode")
	
    -- Additional local binds
    include('Chizel_Global_Binds.lua')
    -- include('Global-GEO-Binds.lua') -- OK to remove this line

    send_command('bind ^- input /ja "Composure" <me>')
    send_command('bind @t gs c cycle treasuremode')
    send_command('bind !` gs c toggle MagicBurst')

    if player.sub_job == 'SCH' then
        send_command('bind ^= gs c scholar light')
        send_command('bind != gs c scholar dark')
        send_command('bind ^, gs c scholar speed')
        send_command('bind ^. gs c scholar aoe')
        send_command('bind ^/ gs c scholar cost')
	elseif player.sub_job == 'DNC' then
		send_command('bind @, input /ja "Stutter Step" <t>')
		send_command('bind @. input /ja "Box Step" <t>')
		send_command('bind @/ input /ja "Quickstep" <t>')
		send_command('bind !] input /ja "Violent Flourish" <t>')
	elseif player.sub_job == 'NIN' then    
		send_command('bind @, input /ma "Utsusemi: Ichi" <me>')
		send_command('bind @. input /ma "Utsusemi: Ni" <me>')
        send_command('bind ![ input /ma "Monomi: Ichi" <me>')
        send_command('bind !] input /ma "Tonko: Ni" <me>')
	elseif player.sub_job == 'RUN' then
		send_command('bind ^numpad/ input /ja "Swordplay" <me>')
		send_command('bind ^numpad* input /ja "Pflug" <me>')
		send_command('bind ^numpad- input /ja "Valiance" <me>')
		send_command('bind !numpad- input /ja "Vallation" <me>')
		send_command('bind ^numpad+ input /ma "Flash" <stnpc>')
		send_command('bind ^[ input /ja "Lux" <me>')
		send_command('bind ^] input /ja "Tenebrae" <me>')
		send_command('bind @insert input /ja "Flabra" <me>')
		send_command('bind @home input /ja "Gelus" <me>')
		send_command('bind @pageup input /ja "Ignis" <me>')
		send_command('bind @pagedown input /ja "Unda" <me>')
		send_command('bind @end input /ja "Sulpor" <me>')
		send_command('bind @delete input /ja "Tellus" <me>')
	end
	
    send_command('bind !insert gs c cycleback EnSpell')
    send_command('bind !delete gs c cycle EnSpell')
    send_command('bind ^insert gs c cycleback GainSpell')
    send_command('bind ^delete gs c cycle GainSpell')
    send_command('bind ^home gs c cycleback BarElement')
    send_command('bind ^end gs c cycle BarElement')
    send_command('bind ^pageup gs c cycleback BarStatus')
    send_command('bind ^pagedown gs c cycle BarStatus')
	
	send_command('bind ^z gs c EnSpell')
	send_command('bind ^g gs c GainSpell')
	send_command('bind ^b gs c BarElement')
	send_command('bind ^n gs c BarStatus')
	send_command('bind ^s input /ja "Saboteur" <me>')
	send_command('bind !s input /ja "Stymie" <me>')

    send_command('bind @q gs c cycle EnspellMode')
    send_command('bind @` gs c toggle NM')
    send_command('bind @w gs c toggle WeaponLock')
    -- send_command('bind @c gs c toggle CP')
    send_command('bind @e gs c cycleback WeaponSet')
    send_command('bind @r gs c cycle WeaponSet')

    send_command('bind ^numpad0 input /ws "Savage Blade" <t>')
    send_command('bind ^numpad1 input /ws "Chant du Cygne" <t>')
    send_command('bind ^numpad2 input /ws "Sanguine Blade" <t>')
    send_command('bind ^numpad3 input /ws "Seraph Blade" <t>')
    send_command('bind ^numpad4 input /ws "Aeolian Edge" <t>')
	send_command('bind ^numpad5 input /ws "Black Halo" <t>')
	send_command('bind ^numpad6 input /ws "Red Lotus Blade" <t>')
	send_command('bind ^numpad7 input /ws "Requiescat" <t>')
	send_command('bind ^numpad8 gs c use Alternate')
	send_command('bind ^numpad9 input /ws "Death Blossom" <t>')
	
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

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind ^-')
    send_command('unbind ^=')
    send_command('unbind !-')
    send_command('unbind !=')
    send_command('unbind ^;')
    send_command('unbind !;')
    send_command('unbind !q')
    send_command('unbind !w')
    send_command('unbind !o')
    send_command('unbind !p')
    send_command('unbind @s')
    send_command('unbind @d')
    send_command('unbind @t')
	send_command('unbind !pageup')
	send_command('unbind !pagedown')
	send_command('unbind ^,')
	send_command('unbind ^.')
	send_command('unbind ^/')
	send_command('unbind !,')
	send_command('unbind !.')
	send_command('unbind ^numpad/')
	send_command('unbind ^numpad*')
	send_command('unbind ^numpad-')
	send_command('unbind !numpad-')
	send_command('unbind ^numpad+')
	send_command('unbind ^[')
	send_command('unbind ^]')
	send_command('unbind ^insert')
	send_command('unbind ^home')
	send_command('unbind ^pageup')
	send_command('unbind ^pagedown')
	send_command('unbind ^end')
	send_command('unbind ^delete')
	
	send_command('unbind ^z')
	send_command('unbind ^g')
	send_command('unbind ^b')
	send_command('unbind ^n')
	send_command('unbind ^s')
	send_command('unbind !s')

    send_command('unbind !numpad7')
    send_command('unbind !numpad8')
    send_command('unbind !numpad9')
    send_command('unbind !numpad4')
    send_command('unbind !numpad5')
    send_command('unbind !numpad6')
    send_command('unbind !numpad1')
    send_command('unbind !numpad2')
    send_command('unbind !numpad3')
    send_command('unbind !numpad0')
	send_command('unbind !numlock')
	send_command('unbind !numpad/')
	send_command('unbind !numpad*')
	send_command('unbind !numpad-')
	
	send_command('unbind @numpad7')
    send_command('unbind @numpad8')
    send_command('unbind @numpad9')
    send_command('unbind @numpad4')
    send_command('unbind @numpad5')
    send_command('unbind @numpad6')
    send_command('unbind @numpad1')
    send_command('unbind @numpad2')
    send_command('unbind @numpad3')
    send_command('unbind @numpad0')
	send_command('unbind @numlock')
	send_command('unbind @numpad/')
	send_command('unbind @numpad*')
	send_command('unbind @numpad-')

    send_command('unbind @w')
    -- send_command('unbind @c')
    send_command('unbind @e')
    send_command('unbind @q')
    send_command('unbind !insert')
    send_command('unbind !delete')
    send_command('unbind ^insert')
    send_command('unbind ^delete')
    send_command('unbind ^home')
    send_command('unbind ^end')
    send_command('unbind ^pageup')
    send_command('unbind ^pagedown')
    send_command('unbind ^numpad7')
    send_command('unbind ^numpad8')
    send_command('unbind ^numpad9')
    send_command('unbind ^numpad4')
    send_command('unbind ^numpad5')
    send_command('unbind ^numpad6')
    send_command('unbind ^numpad1')
    send_command('unbind ^numpad2')
    send_command('unbind ^numpad3')
    send_command('unbind ^numpad0')
	
	send_command('unbind @m')
end

-- Define sets and vars used by this job file.
function init_gear_sets()

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA['Chainspell'] = {body="Viti. Tabard +3"}
	
	sets.Enmity = {
		ammo="Sapience Orb",									--Enmity +2
		head="Halitus Helm",									--Enmity +8
		neck="Unmoving Collar +1",								--Enmity +10
		ear1="Friomisi Earring",								--Enmity +2
		ear2="Cryptic Earring",									--Enmity +4
		body="Emet Harness +1",									--Enmity +10
		hands="Malignance Gloves",								
		ring1="Supershear Ring",								--Enmity +5
		ring2="Eihwaz Ring",									--Enmity +5
		back="Reiki Cloak",										--Enmity +6
		waist="Kasiri Belt",									--Enmity +3
		legs="Zoar Subligar +1",								--Enmity +6
		feet="Malignance Boots",								
		} -- Enmity +61
		
	sets.precast.JA['Pflug'] = sets.Enmity																				-- Base: CE: 450/VE: 900 * 1.61 (CE: 724/VE: 1449)
	sets.precast.JA['Valiance'] = sets.Enmity																			-- Base: CE: 450/VE: 900 * 1.61 (CE: 724/VE: 1449)
	sets.precast.JA['Vallation'] = sets.Enmity																			-- Base: CE: 450/VE: 900 * 1.61 (CE: 724/VE: 1449)
	sets.precast.JA['Swordplay'] = sets.Enmity																			-- Base: CE: 160/VE: 320 * 1.61 (CE: 257/VE: 515)

	sets.precast.JA['Convert'] = {main="Murgleis"}
	
    -- Fast cast sets for spells
    sets.precast.FC = {
		ammo="Staunch Tathlum +1",
        head="Bunzi's Hat", 
		neck="Loricate Torque +1",	
		ear1="Eabani Earring",
		ear2="Leth. Earring +1",
        body="Bunzi's Robe",
		hands="Bunzi's Gloves",
		ring1="Medada's Ring",
		ring2="Weather. Ring",
		back="Perimede Cape",
		waist="Witful Belt",
		legs="Malignance tights",
        feet="Bunzi's Sabots",
        } --Haste 270/1024, FC +56 (Native 38, Cap = 80), DT -47 (-57 with Sacro Bulwark), QM +10, M.Eva +682

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
		ear1="Mendi. Earring",									--Cure Cast -4
		waist="Cornelia's Belt",								--Haste +10
		legs="Kaykaus Tights +1",								--FC +7, Haste +5
		feet="Kaykaus Boots +1",								--Cure Cast -7, Haste +3
        }) --Haste 320/1024, FC 51, Cure Cast -11 (FC Combined = 62, will compensate for Dark Arts cure casting -20), DT -38

    sets.precast.FC.Curaga = sets.precast.FC.Cure
    sets.precast.FC['Healing Magic'] = sets.precast.FC.Cure

    sets.precast.FC.Impact = set_combine(sets.precast.FC, {
		ammo="Sapience Orb", 									--FC 2
		head=empty,
		body="Crepuscular Cloak",								--Haste 9
		neck="Baetyl Pendant", 									--FC 4
        }) --Haste 250/1024, FC 43 (Native 38, Cap = 80)

    sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak", sub="Ammurapi Shield", waist="Shinjutsu-no-Obi +1"})
    sets.precast.Storm = set_combine(sets.precast.FC, {})
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Bead Necklace",})


    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.WS = {
        ammo="Oshasha's Treatise",
        head="Nyame Helm",
        body="Nyame Mail",
        hands="Nyame Gauntlets",
        legs="Nyame Flanchard",
        feet="Leth. Houseaux +3",
        neck="Fotia Gorget",
        ear1="Ishvara Earring",
        ear2="Moonshade Earring",
        ring1="Epaminondas's Ring",
        ring2="Ilabrat Ring",
        back={name="Sucellos's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
        waist="Fotia Belt",
        }

    sets.precast.WS.Acc = set_combine(sets.precast.WS, {
		ammo="Voluspa Tathlum",
        neck="Combatant's Torque",
        ear2="Telos Earring",
        waist="Grunfeld Rope",
        })

    sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {
        ammo="Yetshila +1",
        head="Blistering Sallet +1",
		body="Lethargy Sayon +3",
        hands="Malignance Gloves",
        legs="Zoar Subligar +1",
        feet="Thereoid Greaves",
        ear1="Sherida Earring",
		ear2="Mache Earring +1",
        ring1="Begrudging Ring",
        back={name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},
        })

    sets.precast.WS['Chant du Cygne'].Acc = set_combine(sets.precast.WS['Chant du Cygne'], {
		ammo="Voluspa Tathlum",
        })
		
	sets.precast.WS['Imperator'] = {
		ammo="Coiste Bodhar",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Leth. Houseaux +3",
		neck="Rep. Plat. Medal",
		waist="Sailfi Belt +1",
		ear1="Sherida Earring",
		ear2="Moonshade Earring",
		ring1="Epaminondas's Ring",
		ring2="Ilabrat Ring",
		back={name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Damage taken-5%',}},
	}
	
	-- Acc 1246/1241 (Composure: 1316/1311, Food: 1401/1396), Att 1576/1406, DEX 355, MND 323, WSD +70, DA/TA/QA +31/46/0

    sets.precast.WS['Vorpal Blade'] = sets.precast.WS['Chant du Cygne']
    sets.precast.WS['Vorpal Blade'].Acc = sets.precast.WS['Chant du Cygne'].Acc
	sets.precast.WS['Evisceration'] = sets.precast.WS['Chant du Cygne']
    sets.precast.WS['Evisceration'].Acc = sets.precast.WS['Chant du Cygne'].Acc

    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
		ammo="Coiste Bodhar",
        neck="Rep. Plat. Medal",
		ear1="Regal Earring",
		ring2="Shukuyu Ring",
        waist="Sailfi Belt +1",
        })

    sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS['Savage Blade'], {
		ammo="Voluspa Tathlum",
		neck="Combatant's Torque",
		waist="Grunfeld Rope",
        })

	sets.precast.WS['Knights of Round'] = sets.precast.WS['Savage Blade']
	sets.precast.WS['Knights of Round'].Acc = sets.precast.WS['Savage Blade'].Acc	
	sets.precast.WS['Death Blossom'] = sets.precast.WS['Savage Blade']
    sets.precast.WS['Death Blossom'].Acc = sets.precast.WS['Savage Blade'].Acc

    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {
        ear2="Sherida Earring",
        ring2="Shukuyu Ring",
        })

    sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS['Requiescat'], {
		ammo="Voluspa Tathlum",
		neck="Combatant's Torque",
        ear1="Telos Earring",
        })

    sets.precast.WS['Sanguine Blade'] = {
        ammo="Sroda Tathlum",
        head="Pixie Hairpin +1",
        body="Nyame Mail",
        hands="Nyame Gauntlets",
        legs="Nyame Flanchard",
        feet="Leth. Houseaux +3",
        neck="Sibyl Scarf",
        ear1="Regal Earring",
        ear2="Malignance Earring",
        ring1="Medada's Ring",
        ring2="Archon Ring",
        back={name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Weapon skill damage +10%','Damage taken-5%',}},
		waist="Orpheus's Sash",
        }

    sets.precast.WS['Seraph Blade'] = set_combine(sets.precast.WS['Sanguine Blade'], {
		head="Nyame Helm",
        ear2="Moonshade Earring",
        ring2="Weather. Ring",
        })

    sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS['Sanguine Blade'], {
        ear2="Moonshade Earring",
        })

    sets.precast.WS['Black Halo'] = set_combine(sets.precast.WS['Savage Blade'], {
        ear2="Sherida Earring",
        ring2="Shukuyu Ring",
        })

    sets.precast.WS['Black Halo'].Acc = set_combine(sets.precast.WS['Black Halo'], {
		ammo="Voluspa Tathlum",
		neck="Combatant's Torque",
		ear2="Telos Earring",
        waist="Grunfeld Rope",
        })


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.SpellInterrupt = set_combine(sets.precast.FC, {
        ammo="Staunch Tathlum +1", 								-- SIRD 10
        body="Ros. Jaseran +1", 								-- SIRD 20
        hands={name="Chironic Gloves", augments={'"Mag.Atk.Bns."+5','INT+4','"Refresh"+2','Accuracy+15 Attack+15','Mag. Acc.+14 "Mag.Atk.Bns."+14',}},
        legs="Carmine Cuisses +1", 								-- SIRD 20
        neck="Loricate Torque +1", 								-- SIRD 5, DT -6
        ear1="Magnetic Earring", 								-- SIRD 8
		ear2="Odnowa Earring +1", 								-- DT -3
        ring1="Defending Ring", 								-- DT -10
		ring2="Freke Ring",										-- SIRD 10
        })	-- SIRD (Merits) 100/1024, (Gear) 980/1024 = 105%

    sets.midcast.Utsusemi = set_combine(sets.precast.FC.Utsusemi, sets.midcast.SpellInterrupt)
	sets.midcast['Flash'] = sets.Enmity

    sets.midcast.Cure = {
        main="Daybreak", 										--CP1+30, MND+30
        sub="Sacro Bulwark",									--CP1+5, DT-10, SIRD-7
		ammo="Staunch Tathlum +1",								--DT-3, SIRD-11
		head="Bunzi's Hat", 									--MND+33, Enmity-7, FC+10, DT-7
		body="Bunzi's Robe",									--MND+43, Enmity-10, CP1+15, DT-10
        hands="Bunzi's Gloves", 								--MND+47, Enmity-8, DT-8
		legs="Bunzi's Pants",									--MND+38, Enmity-9, DT-9, SIRD-20
		feet="Bunzi's Sabots",									--MND+33, Enmity-6, DT-6
        neck="Incanter's Torque",								--Healing Skill +10
		ear1="Magnetic Earring",								--SIRD-8
        ear2="Regal Earring",									--MND+10
        ring1="Stikini Ring +1",								--MND+5, Healing Skill+8
        ring2="Stikini Ring",									--MND+8, Healing Skill+11
        back={name="Sucellos's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','Enmity-10','Damage taken-5%',}},
        waist="Luminary Sash",									--MND+10, CMP+4
        }	--MND+287 (MND 130+287+(Gain-MND [+55]) = 472), CP1 +50%, Enmity -50, FC +43, DT -50, Healing Skill +29 (420, Light Arts: 464)

    sets.midcast.CureWeather = set_combine(sets.midcast.Cure, {
        main="Chatoyant Staff",									--MND+5, CP1 +10, "Irridescense"
        sub="Enki Strap",										--MND+10
		legs="Kaykaus Tights +1",
		neck="Loricate Torque +1",
		ear1="Mendi. Earring",
		ear2="Odnowa Earring +1",
		ring1="Defending Ring",
		waist="Hachirin-no-Obi",
        })

    sets.midcast.CureSelf = set_combine(sets.midcast.Cure, {
																-- neck="Phalaina Locket", -- 4(4)
		ring2="Asklepian Ring", 								-- (3)
        waist="Gishdubar Sash", 								-- (10)
        })

    sets.midcast.Curaga = set_combine(sets.midcast.Cure, {
		waist="Luminary Sash",
        })

    sets.midcast.StatusRemoval = {
        head="Vanya Hood",
        body="Vanya Robe",
        legs="Atrophy Tights +3",
        feet="Vanya Clogs",
        neck="Incanter's Torque",
        ear2="Meili Earring",
        ring1="Menelaus's Ring",
        ring2="Haoma's Ring",
		back="Vates Cape +1",
        waist="Bishop's Sash",
        }

    sets.midcast.Cursna = set_combine(sets.midcast.StatusRemoval, {
																-- hands="Hieros Mittens",
        body="Viti. Tabard +3",
        neck="Debilis Medallion",
																-- ear1="Beatific Earring",
																-- back="Oretan. Cape +1",
        })

    sets.midcast['Enhancing Magic'] = {
		main={name="Colada", augments={'Enh. Mag. eff. dur. +4','INT+3','"Mag.Atk.Bns."+4',}},
		sub="Ammurapi Shield",						-- INT +13, MND +13, M.Acc +38, Enh. Duration +10%
		ammo="Regal Gem",
		head={name="Telchine Cap", augments={'Mag. Evasion+17','"Regen"+2','Enh. Mag. eff. dur. +10',}},
        body="Viti. Tabard +3",
        hands="Atrophy Gloves +3",
        legs="Atrophy Tights +3",
        feet="Leth. Houseaux +3",
        neck="Dls. Torque +2",
        ear1="Mimir Earring",
		ear2="Leth. Earring +1",
        ring1="Stikini Ring +1",
        ring2="Stikini Ring",
        back="Ghostfyre Cape",
        waist="Embla Sash",
        } -- INT +186, MND +214, M.Acc +334, Enhancing Skill +103 (564), Enhancing Duration +145%

    sets.midcast.EnhancingDuration = set_combine(sets.midcast['Enhancing Magic'], {
        legs={name="Telchine Braconi", augments={'Mag. Evasion+20','"Regen"+2','Enh. Mag. eff. dur. +9',}},
        }) -- INT +174, MND +201, M.Acc +316, Enhancing Skill +82 (543), Enhancing Duration +151%
		
    sets.buff.ComposureOther = set_combine(sets.midcast.EnhancingDuration, {
        head="Leth. Chappel +3",
		body="Lethargy Sayon +3",
        legs="Leth. Fuseau +3",
        feet="Leth. Houseaux +3",
        })	--Enh. Mag. Skill 546, Duration +175%

    sets.midcast.EnhancingSkill = set_combine(sets.midcast['Enhancing Magic'], {
        main="Pukulatmuj +1",						-- Enh. Skill +11, M.Acc.Skill +188 (M.Acc +94)
		sub={name="Forfend +1", priority=20},							-- Enh. Skill +10, M.Acc +15
		head="Befouled Crown",						-- INT +33, MND +33, M.Acc +20, Enh. Skill +16
		neck="Incanter's Torque",					-- Enh. Skill +10
		ear2="Andoaa Earring",						-- Enh. Skill +5
        hands="Viti. Gloves +3",					-- INT +32, MND +46, M.Acc +38, Enh. Skill +24
		waist="Olympus Sash",						-- Enh. Skill +5
        }) -- INT +198, MND +222, M.Acc +362, Enhancing Skill +184 (670), Enhancing Duration +72%

    sets.midcast.Regen = set_combine(sets.midcast.EnhancingDuration, {
		main="Bolelabunga",
		sub="Ammurapi Shield",
        body={name="Telchine Chas.", augments={'Mag. Evasion+19','"Regen"+2','Enh. Mag. eff. dur. +10',}},
		feet="Bunzi's Sabots",
        })

    sets.midcast.RefreshOther = set_combine(sets.midcast.EnhancingDuration, {
		head="Leth. Chappel +3",								-- head="Amalric Coif +1", -- +1
        body="Atrophy Tabard +3", 								-- +2
        legs="Leth. Fuseau +3", 								-- +4
        })

    sets.midcast.RefreshSelf = set_combine(sets.midcast.EnhancingDuration, {
		body="Atrophy Tabard +3",
		legs="Leth. Fuseau +3",
        waist="Gishdubar Sash",
        back="Grapevine Cape",
        })

    sets.midcast.Stoneskin = {
		ammo="Staunch Tathlum +1",
		head="Bunzi's Hat",
		body="Viti. Tabard +3",
		hands="Stone Mufflers",
		legs="Shedir Seraweels",
		feet="Bunzi's Sabots",
		neck="Nodens Gorget",
		ear1="Earthcry Earring",
		ear2="Leth. Earring +1",
		ring1="Defending Ring",
		ring2="Warden's Ring",
		waist="Siegel Sash",
		back={name="Sucellos's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Haste+10','Mag. Evasion+15',}},
        } --Stoneskin +125

    sets.midcast['Phalanx'] = set_combine(sets.midcast.EnhancingDuration, {
		main="Sakpata's Sword",
        body={name="Taeon Tabard", augments={'Mag. Evasion+15','Spell interruption rate down -6%','Phalanx +3',}}, 							--3(10)
        hands={name="Taeon Gloves", augments={'Mag. Evasion+15','Spell interruption rate down -2%','Phalanx +2',}}, 						--3(10)
        legs={name="Taeon Tights", augments={'Mag. Evasion+16','Spell interruption rate down -2%','Phalanx +3',}}, 							--3(10)
        feet={name="Taeon Boots", augments={'Mag. Evasion+16','Spell interruption rate down -3%','Phalanx +2',}}, 							--3(10)
        })

    sets.midcast.Aquaveil = set_combine(sets.midcast.EnhancingDuration, {
        ammo="Staunch Tathlum +1",
		head={name="Chironic Hat", augments={'Mag. Acc.+16','"Resist Silence"+8','MND+10',}},							--"Amalric Coif +1",
		hands="Regal Cuffs",
		legs="Shedir Seraweels",
        ear1="Halasz Earring",
		ring1="Evanescence Ring",
        ring2="Freke Ring",
        waist="Emphatikos Rope",
        })
		
	sets.midcast.BarElement = set_combine(sets.midcast['Enhancing Magic'], {
		main="Pukulatmuj +1",								--Enh. Skill +11
		sub="Forfend +1",									--Enh. Skill +10
		hands="Viti. Gloves +3",							--Enh. Skill +24
		legs="Shedir Seraweels",							--Barelement +15
		})
	
	sets.midcast.BarStatus = set_combine(sets.midcast.EnhancingDuration, {
		neck="Sroda Necklace",
		})

    sets.midcast.Storm = sets.midcast.EnhancingDuration
    sets.midcast.GainSpell = set_combine(sets.midcast['Enhancing Magic'], {hands="Viti. Gloves +3"}) --STAT +55 (Hard Cap)
    sets.midcast.SpikesSpell = set_combine(sets.midcast['Enhancing Magic'], {legs="Viti. Tights +3"})

    sets.midcast.Protect = set_combine(sets.midcast.EnhancingDuration, {ring2="Sheltered Ring"})
    sets.midcast.Protectra = sets.midcast.Protect
    sets.midcast.Shell = sets.midcast.Protect
    sets.midcast.Shellra = sets.midcast.Protect
	
	--Transportation--
	sets.midcast['Warp'] = sets.precast.FC
	sets.midcast['Warp II'] = sets.precast.FC
	sets.midcast['Retrace'] = sets.precast.FC
	sets.midcast['Tractor'] = sets.precast.FC
	sets.midcast['Teleport-Dem'] = sets.precast.FC
	sets.midcast['Teleport-Mea'] = sets.precast.FC
	sets.midcast['Teleport-Holla'] = sets.precast.FC
	sets.midcast['Teleport-Altep'] = sets.precast.FC
	sets.midcast['Teleport-Vahzl'] = sets.precast.FC
	sets.midcast['Recall-Jugner'] = sets.precast.FC
	sets.midcast['Recall-Meriph'] = sets.precast.FC
	sets.midcast['Recall-Pashh'] = sets.precast.FC

	-- Enfeebling Magic (MND)
	-- Immunobreak (MND 434, M.Acc +441, M.Acc.Skill +228, Enfeeble Skill 601, Enfeeble Potency +58
	-- Enfeeble Duration +45, Aug.Enf.Duration +25, Immunobreak +1
	
    sets.midcast['Paralyze'] = {
        main="Contemplator +1",								--MND +22, M.Acc +70, M.Acc.Skill +242, Enfeeble Skill +20
		sub="Mephitis Grip",								--M.Acc +5, Enfeeble Skill +5
		ammo={name="Regal Gem", priority=15},				--MND +7, M.Acc +15, Enfeeble Effect +10
        head="Viti. Chapeau +3",							--MND +42, M.Acc +77, Enfeeble Skill +26
        body={name="Lethargy Sayon +3", priority=14},		--MND +45, M.Acc +64, Enfeeble Effect +18, Enfeeble Duration +10% (Set Bonus)
		hands="Regal Cuffs",								--MND +40, M.Acc +45, Enfeeble Duration +20%
        legs="Chironic Hose",								--MND +36, M.Acc +57, Enfeeble Skill +13, Immunobreak +1 
        feet={name="Vitiation Boots +3", priority=13},		--MND +32, M.Acc +43, Enfeeble Skill +16, Enfeeble Effect +10, Immunobreak +20
        neck={name="Dls. Torque +2", priority=12},			--MND +12, M.Acc +25, Enfeeble Effect +10, Enfeeble Duration +20%
        ear1="Snotra Earring",								--MND +8, M.Acc +10, Enfeeble Duration +10%
        ear2="Malignance Earring",							--MND +8, M.Acc +10
        ring1="Kishar Ring",								--M.Acc +5, Enfeeble Duration +10%
        ring2="Metamor. Ring +1",							--MND +16, M.Acc +15
		back={name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Weapon skill damage +10%','Damage taken-5%',}, priority=11},
		waist="Obstinate Sash",								--MND +5, M.Acc +15, Enfeeble Skill +10, Enfeeble Duration +5%
        }
		
	sets.midcast['Paralyze II'] = sets.midcast['Paralyze']
	sets.midcast['Slow'] = sets.midcast['Paralyze']
	sets.midcast['Slow II'] = sets.midcast['Paralyze']

	-- Non-Immunobreak (MND 433, M.Acc +422, M.Acc.Skill +255, Enfeeble Skill 621, Enfeeble Potency +20
	-- Enfeeble Duration +25, Aug.Enf.Duration +25
	
    sets.midcast['Distract'] = set_combine(sets.midcast['Paralyze'], {
        main="Murgleis",		
		sub="Ammurapi Shield",			
        range="Ullr",				
        ammo=empty,
		hands="Leth. Ganth. +3",			
        body="Atrophy Tabard +3",			
		legs="Leth. Fuseau +3",
		ear2="Regal Earring",	
        ring2="Stikini Ring +1",
		back="Aurist's Cape +1",
        })
	
	sets.midcast['Distract II'] = sets.midcast['Distract']
	sets.midcast['Frazzle'] = sets.midcast['Distract']
	sets.midcast['Frazzle II'] = sets.midcast['Distract']
	sets.midcast['Silence'] = set_combine(sets.midcast['Distract'], {legs={name="Chironic Hose", priority=15}}) -- M.Acc +426
	sets.midcast['Addle'] = sets.midcast['Distract']
	sets.midcast['Addle II'] = sets.midcast['Distract']
		
	sets.midcast['Dia'] = set_combine(sets.midcast['Paralyze'], {
		head="Leth. Chappel +3",
		legs="Leth. Fuseau +3",
		feet="Leth. Houseaux +3",
		}) 
		
	sets.midcast['Dia II'] = sets.midcast['Dia']
	sets.midcast['Dia III'] = sets.midcast['Dia']
	sets.midcast['Diaga'] = sets.midcast['Dia']

	-- Enfeebling Magic (INT)
	-- Immunobreak (INT 417, M.Acc +431, M.Acc.Skill +228, Enfeeble Skill 601, Enfeeble Potency +58
	-- Enfeeble Duration +45, Aug.Enf.Duration +25, Immunobreak +1
	
    sets.midcast['Blind'] = {
        main="Contemplator +1",					
		sub="Mephitis Grip",							
		ammo={name="Regal Gem",	priority=15},					
		head="Viti. Chapeau +3",
		body={name="Lethargy Sayon +3", priority=14},
		hands="Regal Cuffs",
		legs="Chironic Hose",
		feet={name="Vitiation Boots +3", priority=13},
		neck={name="Dls. Torque +2", priority=12},
		ear1="Snotra Earring",
		ear2="Regal Earring",
		ring1="Kishar Ring",
		ring2="Metamor. Ring +1",
		back={name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Damage taken-5%',}, priority=11},					
        waist="Obstinate Sash",
        }
		
	sets.midcast['Blind II'] = sets.midcast['Blind']
	sets.midcast['Gravity'] = sets.midcast['Blind']
	sets.midcast['Gravity II'] = sets.midcast['Blind']

	-- Immunobreak/MAcc+ (INT 404, M.Acc +531, M.Acc.Skill +255, Enfeeble Skill 634, Enfeeble Potency +30
	-- Enfeeble Duration +15, Aug.Enf.Duration +25

    sets.midcast['Bind'] = set_combine(sets.midcast['Blind'], {
        main="Murgleis",			
		sub="Ammurapi Shield",							
        range="Ullr",					
        ammo=empty,
		hands="Leth. Ganth. +3",			
		body="Atrophy Tabard +3",			
		ear2="Regal Earring",			
        ring1="Medada's Ring",	
        ring2="Stikini Ring +1",	
		back="Aurist's Cape +1",	
        })
		
	sets.midcast['Break'] = sets.midcast['Bind']
	
    sets.midcast['Sleep'] = set_combine(sets.midcast['Bind'], {
		head="Leth. Chappel +3",
		body="Lethargy Sayon +3",
		hands="Regal Cuffs",
		legs="Chironic Hose",
		feet="Leth. Houseaux +3"
		})
		
    sets.midcast['Sleep II'] = sets.midcast['Sleep']
    sets.midcast['Sleepga'] = sets.midcast['Sleep']
    sets.midcast['Sleepga II'] = sets.midcast['Sleep']
	
	sets.midcast['Dispel'] = set_combine(sets.midcast['Bind'], {neck="Dls. Torque +2",})	
    sets.midcast['Dispelga'] = set_combine(sets.midcast['Dispel'], {main="Daybreak", sub="Ammurapi Shield", waist="Shinjutsu-no-Obi +1"})

	-- Enfeebling Magic (Skill)
	-- Immunobreak (MND 412/INT 383, M.Acc +404, M.Acc.Skill +228, Enfeeble Skill 655, Enfeeble Potency +20
	-- Enfeeble Duration +25, Immunobreak +1

    sets.midcast['Poison'] = set_combine(sets.midcast['Paralyze'], {
        main="Contemplator +1",								--INT +12, MND +22, M.Acc +70, M.Acc.Skill +228, Enfeeble Skill +11
        sub="Mephitis Grip",								--M.Acc +5, Enfeebling Skill +5
        body="Atrophy Tabard +3",							--INT +43, MND +43, M.Acc +55, Enfeeble Skill +21
        neck="Incanter's Torque",							--Enfeeble Skill +10
        ring1="Stikini Ring", 								--MND +5, M.Acc +8, Enfeeble Skill +5												--{name="Stikini Ring +1", bag="wardrobe4"},
        ring2="Stikini Ring +1",							--MND +8, M.Acc +11, Enfeeble Skill +8
        ear1="Vor Earring",									--Enfeebling Skill +10
		back="Aurist's Cape +1",
		waist="Obstinate Sash",								--MND +5, M.Acc +15, Enfeebling Skill +10, Enfeeble Duration +5%
        })	
		
	sets.midcast['Poison II'] = sets.midcast['Poison']
	sets.midcast['Poisonga'] = sets.midcast['Poison']
	
	sets.midcast['Frazzle III'] = set_combine(sets.midcast['Poison'], {
		legs={name="Leth. Fuseau +3", priority=15},
		neck={name="Dls. Torque +2", priority=14},
		ear2={name="Snotra Earring", priority=13},
		ring1={name="Kishar Ring", priority=12},
		back={name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Weapon skill damage +10%','Damage taken-5%',}, priority=11},
		})
		
	sets.midcast['Distract III'] = sets.midcast['Frazzle III']

    sets.midcast['Dark Magic'] = {
		main="Rubicundity",									-- INT +21, M.Acc +30, M.Acc.Skill +215, Dark Magic Skill +25, Drain/Aspir Potency +20
		sub="Ammurapi Shield",								-- INT +13, M.Acc +38
		range="Ullr",										-- M.Acc +40
		ammo=empty,
        head="Pixie Hairpin +1",							-- INT +27, Dark Affinity +28
		body="Carm. Scale Mail",							-- INT +36, M.Acc +28, Dark Magic Skill +15
        hands="Leth. Ganth. +3",							-- INT +33, M.Acc +62
		legs="Amalric Slops +1",							-- INT +52, Dark Magic Skill +20													-- legs="Ea Slops +1",
        feet="Merlinic Crackows",							-- INT +24, M.Acc +12, Drain/Aspir Potency +18
        neck="Null Loop",									-- M.Acc +50
        ear1="Mani Earring",								-- Dark Magic Skill +10
        ear2="Malignance Earring",							-- INT +8, M.Acc +10 
        ring1="Evanescence Ring",							-- Dark Magic Skill +10, Drain/Aspir Potency +10
        ring2="Archon Ring",								-- Dark M.Acc +5, Dark Affinity +5
		back="Aurist's Cape +1",							-- INT +23, M.Acc +28
        waist="Null Belt",									-- M.Acc +30
        }
		-- INT +237 (378, Gain-INT = 433), M.Acc +491, Dark Magic Skill +90 (412, RDM/SCH with Dark Arts = 516)
		-- Drain/Aspir Potency +61, Dark Affinity +33, Potency Range: 176~352
		-- Base (Skill) Dark Magic Accuracy = 903, RDM/SCH with Dark arts = 1,007 (dINT>70: 963, RDM/SCH with Dark Arts = 1,067)

    sets.midcast['Drain'] = set_combine(sets.midcast['Dark Magic'], {
		head="Pixie Hairpin +1",
        feet="Merlinic Crackows",
		neck="Erra Pendant",
															-- ear1="Hirudinea Earring",
        ring1="Evanescence Ring",
        ring2="Archon Ring",
		back="Perimede Cape",
        waist="Fucho-no-obi",
        })

    sets.midcast['Aspir'] = sets.midcast['Drain']
    sets.midcast['Stun'] = set_combine(sets.midcast['Dark Magic'], {waist="Luminary Sash"})
    sets.midcast['Bio III'] = set_combine(sets.midcast['Dark Magic'], {legs="Viti. Tights +3"})

    sets.midcast['Elemental Magic'] = {
        main="Marin Staff +1",
        sub="Enki Strap",
        ammo="Ghastly Tathlum +1",
        head="Atrophy Chapeau +3",
        body="Lethargy Sayon +3",
        hands="Leth. Ganth. +3",
        legs="Leth. Fuseau +3",
        feet="Leth. Houseaux +3",
        neck="Incanter's Torque",
        ear1="Regal Earring",
        ear2="Malignance Earring",
        ring1="Medada's Ring",
        ring2="Metamor. Ring +1",
        back={name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Damage taken-5%',}},
        waist="Acuity Belt +1",
        }
		
	sets.midcast['Absorb-TP'] = {
		ammo="Pemphredo Tathlum",
		head="Atrophy Chapeau +3",
		body="Viti. Tabard +3",
		hands="Bunzi's Gloves",
		legs="Bunzi's Pants",
		feet="Bunzi's Sabots",
		neck="Null Loop",
		ear1="Odnowa Earring +1",
		ear2="Leth. Earring +1",
		ring1="Medada's Ring",
		ring2="Defending Ring",
		back={name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+7','Haste+10','Spell interruption rate down-10%',}},
		waist="Null Belt",
		}

    sets.midcast['Elemental Magic'].Seidr = set_combine(sets.midcast['Elemental Magic'], {
		ammo="Pemphredo Tathlum",
															-- body="Seidr Cotehardie",
															-- legs="Merlinic Shalwar",
															-- feet="Merlinic Crackows",
		neck="Erra Pendant",
		waist="Acuity Belt +1",
        })

    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {
        range="Ullr",
        ammo=empty,
        legs="Viti. Tights +3",
        feet="Merlinic Crackows",
        neck="Erra Pendant",
        })

    sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {
		head=empty,
		body="Crepuscular Cloak",
        ring1="Medada's Ring",
        waist="Shinjutsu-no-Obi +1",
        })

    -- Initializes trusts at iLvl 119
    sets.midcast.Trust = sets.precast.FC

    -- Job-specific buff sets

    sets.buff.Saboteur = {hands={name="Leth. Ganth. +3", priority=20}}


    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.idle = {
        ammo="Homiliary",									--Refresh +1
        head="Viti. Chapeau +3",							--M.Eva +95, MDB +7, Refresh +3
        body="Lethargy Sayon +3",							--DT-14, M.Eva +136, MDB +11, Refresh +4
        hands={name="Chironic Gloves", augments={'"Mag.Atk.Bns."+5','INT+4','"Refresh"+2','Accuracy+15 Attack+15','Mag. Acc.+14 "Mag.Atk.Bns."+14',}},
        legs="Volte Brais",									--M.Eva +142, MDB +7, Refresh +1	
        feet="Bunzi's Sabots", 								--DT -6, M.Eva +150, MDB +8	
        neck="Sibyl Scarf",									--Refresh +1
        ear1="Eabani Earring",								--M.Eva +8
        ear2="Odnowa Earring +1", 							--DT-3, MDT-2	
        ring1="Stikini Ring +1",							--Refresh +1
        ring2="Shadow Ring",
        back={name="Sucellos's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Haste+10','Mag. Evasion+15',}},
        waist="Carrier's Sash",								--Elemental Resistance +15
        } --DT -42, MDT -2, M.Eva +580, MDB +36, Refresh +13 (Daybreak), Annuls Magic +13%, Resist Death +25%
		
	sets.idle.MDT = set_combine(sets.idle, {
		ammo="Staunch Tathlum +1",
		head="Bunzi's Hat",
		body="Bunzi's Robe",
		hands="Bunzi's Gloves",					
		legs="Leth. Fuseau +3",							
		feet="Bunzi's Sabots",
		neck="Warder's Charm +1",	
		ring1="Defending Ring",
        })

	sets.idle.PDT = set_combine(sets.idle, {
		main="Excalibur",
		sub="Sacro Bulwark",
		ammo="Staunch Tathlum +1",
		head="Nyame Helm",
		body="Adamantite Armor",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Atro. Boots +3",
		neck="Warder's Charm +1",
		ear1="Foresti Earring",
		ear2="Odnowa Earring +1",
		ring1="Warden's Ring",
		ring2="Fortified Ring",
		waist="Flume Belt +1",
		})

    sets.resting = set_combine(sets.idle, {
        main="Chatoyant Staff",
		sub="Ariesian Grip",
        waist="Shinjutsu-no-Obi +1",
        })

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.defense.PDT = sets.idle.PDT
    sets.defense.MDT = sets.idle.MDT

    sets.magic_burst = {
		main="Mpaca's Staff", 								--INT +15, MAcc +43, MDmg +263, MAB +53, MB2 +2
		sub="Enki Strap",									--INT +10, MAcc +10
		ammo="Ghastly Tathlum +1",							--INT +11, MDmg +21
        head="Ea Hat +1", 									--INT +43, MAcc +50, MAB +38, MB1 +7, MB2 +7
        body="Lethargy Sayon +3",							--INT +47, MAcc +64, MDmg +34, MAB +54
        hands="Bunzi's Gloves",								--INT +34, MAcc +40, MDmg +53, MAB +30, MB1 +8, MB2 +3
        legs="Leth. Fuseau +3",								--INT +48, MAcc +63, MDmg +33, MAB +58, MB1 +15
        feet="Leth. Houseaux +3",							--INT +30, MAcc +60, MDmg +30, MAB +50
        neck="Mizu. Kubikazari", 							--INT +4, MAB +8, MB1 +10
		waist="Acuity Belt +1",								--INT +23, MAcc +10
		ear1="Regal Earring",								--INT +10, MAB +7
		ear2="Malignance Earring",							--INT +8, MAcc +10, MAB +8
		ring1="Medada's Ring",								--INT +10, MAcc +20, MAB +10
        ring2="Freke Ring", 								--INT +10, MAB +8
		back={name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Damage taken-5%',}},								--INT +20, MAcc +27, MDmg +20, MAB +10
        }	--INT 533, MAcc +404, MAccSkill +255, MDmg +455, MAB +334, MB1 +40, MB2 +14
			--With BLM Burn: Triboulex dINT +93 (Tier II)
			--With GEO Indi-INT: Triboulex dINT +138 (Tier III)
			--With Impact: Triboulex dINT +240 (Tier IV)

    sets.Kiting = {ammo="Staunch Tathlum +1", legs="Carmine Cuisses +1", ring1="Defending Ring", back="Shadow Mantle"}
    sets.latent_refresh = {waist="Fucho-no-obi"}


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    sets.engaged = {
        ammo="Coiste Bodhar",								--STR +10, DEX +10, Att +15, sTP +3, DA +3
        head="Bunzi's Hat",									--STR +11, DEX +40, Acc +50, Haste +6%, sTP +8, PDL +3, DT -6%
        body="Malignance Tabard",							--STR +19, DEX +49, Acc +50, Haste +4%, sTP +11, PDL +6, DT -9%
        hands="Malignance Gloves",							--STR +25, DEX +56, Acc +50, Haste +4%, sTP +12, PDL +4, DT -5%
        legs="Malignance Tights",							--STR +28, Acc +50, Haste +9%, sTP +10, PDL +5, DT -7%
        feet="Malignance Boots",							--STR +6, DEX +40, Acc +50, Haste +3%, sTP +9, PDL +2, DT -4
        neck="Anu Torque",									--Att +20, sTP +7
        ear1="Sherida Earring",								--STR +5, DEX +5, DA +5, sTP +5
        ear2="Telos Earring",								--Acc +10, Att +10, DA +1, sTP +5
        ring1="Hetairoi Ring",								--Crit +1%, TA +2, TA.Dmg +5
        ring2="Chirich Ring +1",							--Acc +10, sTP +6
        back={name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},
        waist="Windbuffet Belt +1",							--Acc +2, TA +2, QA +2
        } --STR +104, DEX +220, Acc +290, Att +65, sTP +86, PDL +20, DT -31, Haste +27%, DA +9, TA +4, QA +2, Crit +1%

    sets.engaged.MidAcc = set_combine(sets.engaged, {
		hands="Gazu Bracelets +1",							--STR +10, DEX +32, Acc +82, Att -17, Haste +10
		neck="Combatant's Torque",							--Sword Skill +10, sTP +4
		ear1="Crepuscular Earring", 						--Acc +10, sTP +5
        waist="Kentarch Belt +1",							--Acc +14, DA +3, sTP +5
        }) --STR +79, DEX +176, Acc +344, Att +20, sTP +77, PDL +16, DT -26, Haste +33%, DA +4, TA +2, Crit +1%, Sword Skill +10

    sets.engaged.HighAcc = set_combine(sets.engaged, {
		ammo="Voluspa Tathlum",								--STR +5, DEX +5, Acc +10, Att +10
        head="Carmine Mask +1",								--STR +25, DEX +25, Acc +58, Haste +8%
		body="Lethargy Sayon +3",							--STR +34, DEX +34, Acc +64, Att +64, Haste +3%, DT -14
        legs="Carmine Cuisses +1",							--STR +30, Acc +55 (Set Bonus +20), Att +47, Haste +6%
        }) --STR +110, DEX +146, Acc +399, Att +134, sTP +44, PDL +2, DT -18, Haste +31%, DA +4, TA +2, Crit +1%, Sword Skill +10

    -- No Magic Haste (74% DW to cap)
    sets.engaged.DW = {
        ammo="Coiste Bodhar",
        head={name="Taeon Chapeau", augments={'Accuracy+20','"Dual Wield"+5','DEX+8',}},							--5
        body="Malignance Tabard",
        hands="Malignance Gloves",
        legs="Carmine Cuisses +1", 							--6
        feet={name="Taeon Boots", augments={'Accuracy+17 Attack+17','"Dual Wield"+4','DEX+8',}}, 							--8
        neck="Anu Torque",
        ear1="Eabani Earring", 								--4
        ear2="Suppanomimi", 								--5
        ring1="Hetairoi Ring",
        ring2="Chirich Ring +1",
        back={name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}}, 								--10
        waist="Reiki Yotai", 								--7
        } --74% to cap: /NIN 25% + Gear 45% (70%, -4%)

    sets.engaged.DW.MidAcc = set_combine(sets.engaged.DW, {
		hands="Gazu Bracelets +1",							--STR +10, DEX +32, Acc +82, Att -17, Haste +10%
		neck="Combatant's Torque",							--Sword Skill +10, sTP +4
		ear1="Crepuscular Earring", 						--Acc +10, sTP +5
        waist="Kentarch Belt +1",							--Acc +14, DA +3, sTP +5
        })

    sets.engaged.DW.HighAcc = set_combine(sets.engaged.DW.MidAcc, {
		ammo="Voluspa Tathlum",								--STR +5, DEX +5, Acc +10, Att +10
        head="Carmine Mask +1",								--STR +25, DEX +25, Acc +58, Haste +8%
		body="Lethargy Sayon +3",							--STR +34, DEX +34, Acc +64, Att +64, Haste +3%, DT -14
        legs="Carmine Cuisses +1",							--STR +30, Acc +55 (Set Bonus +20), Att +47, Haste +6%
        })

    -- 15% Magic Haste (67% DW to cap)
    sets.engaged.DW.LowHaste = set_combine(sets.engaged.DW, {
        ear1="Digni. Earring",
        }) --67% to cap: /NIN 25% + Gear 41% (66%, -1%)

    sets.engaged.DW.MidAcc.LowHaste = set_combine(sets.engaged.DW.LowHaste, {
		hands="Gazu Bracelets +1",							--STR +10, DEX +32, Acc +82, Att -17, Haste +10%
		neck="Combatant's Torque",							--Sword Skill +10, sTP +4
		ear1="Crepuscular Earring", 						--Acc +10, sTP +5
        waist="Kentarch Belt +1",							--Acc +14, DA +3, sTP +5
        })

    sets.engaged.DW.HighAcc.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, {
		ammo="Voluspa Tathlum",								--STR +5, DEX +5, Acc +10, Att +10
        head="Carmine Mask +1",								--STR +25, DEX +25, Acc +58, Haste +8%
		body="Lethargy Sayon +3",							--STR +34, DEX +34, Acc +64, Att +64, Haste +3%, DT -14
        legs="Carmine Cuisses +1",							--STR +30, Acc +55 (Set Bonus +20), Att +47, Haste +6%
        })

    -- 30% Magic Haste (56% DW to cap)
    sets.engaged.DW.MidHaste = set_combine(sets.engaged.DW, {
        head="Bunzi's Hat",
        feet="Malignance Boots",
        }) --56% to cap: /NIN 25% + Gear 32% (57%, +1%)

    sets.engaged.DW.MidAcc.MidHaste = set_combine(sets.engaged.DW.MidHaste, {
		hands="Gazu Bracelets +1",							--STR +10, DEX +32, Acc +82, Att -17, Haste +10%
		neck="Combatant's Torque",							--Sword Skill +10, sTP +4
		ear1="Crepuscular Earring", 						--Acc +10, sTP +5
        waist="Kentarch Belt +1",							--Acc +14, DA +3, sTP +5
        })

    sets.engaged.DW.HighAcc.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, {
		ammo="Voluspa Tathlum",								--STR +5, DEX +5, Acc +10, Att +10
        head="Carmine Mask +1",								--STR +25, DEX +25, Acc +58, Haste +8%
		body="Lethargy Sayon +3",							--STR +34, DEX +34, Acc +64, Att +64, Haste +3%, DT -14
        legs="Carmine Cuisses +1",							--STR +30, Acc +55 (Set Bonus +20), Att +47, Haste +6%
        })

    -- 35% Magic Haste (51% DW to cap)
    sets.engaged.DW.HighHaste = set_combine(sets.engaged.DW, {
        head="Bunzi's Hat",
        legs="Malignance Tights",
        back={name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},
      }) --51% to cap: /NIN 25% + Gear 24% (49%, -2%)

    sets.engaged.DW.MidAcc.HighHaste = set_combine(sets.engaged.DW.HighHaste, {
		hands="Gazu Bracelets +1",							--STR +10, DEX +32, Acc +82, Att -17, Haste +10%
		neck="Combatant's Torque",							--Sword Skill +10, sTP +4
		ear1="Crepuscular Earring", 						--Acc +10, sTP +5
        waist="Kentarch Belt +1",							--Acc +14, DA +3, sTP +5
        })

    sets.engaged.DW.HighAcc.HighHaste = set_combine(sets.engaged.DW.MidAcc.HighHaste, {
		ammo="Voluspa Tathlum",								--STR +5, DEX +5, Acc +10, Att +10
        head="Carmine Mask +1",								--STR +25, DEX +25, Acc +58, Haste +8%
		body="Lethargy Sayon +3",							--STR +34, DEX +34, Acc +64, Att +64, Haste +3%, DT -14
        legs="Carmine Cuisses +1",							--STR +30, Acc +55 (Set Bonus +20), Att +47, Haste +6%
        })

    -- 45% Magic Haste (36% DW to cap)
    sets.engaged.DW.MaxHaste = set_combine(sets.engaged.DW, {
        head="Bunzi's Hat",
        legs="Malignance Tights",
        feet="Malignance Boots",
        ear2="Telos Earring",
        back={name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},
        }) --36% to cap: /NIN 25% + Gear 11% (36%)

    sets.engaged.DW.MidAcc.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, {
		hands="Gazu Bracelets +1",							--STR +10, DEX +32, Acc +82, Att -17, Haste +10%
		neck="Combatant's Torque",							--Sword Skill +10, sTP +4
		ear1="Crepuscular Earring", 						--Acc +10, sTP +5
        waist="Kentarch Belt +1",							--Acc +14, DA +3, sTP +5
        })

    sets.engaged.DW.HighAcc.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, {
		ammo="Voluspa Tathlum",								--STR +5, DEX +5, Acc +10, Att +10
        head="Carmine Mask +1",								--STR +25, DEX +25, Acc +58, Haste +8%
		body="Lethargy Sayon +3",							--STR +34, DEX +34, Acc +64, Att +64, Haste +3%, DT -14
        legs="Carmine Cuisses +1",							--STR +30, Acc +55 (Set Bonus +20), Att +47, Haste +6%
        })

    -- 45% Magic Haste (25% DW to cap)
    sets.engaged.DW.MaxHasteSamba = set_combine(sets.engaged.DW, {
        head="Bunzi's Hat",
        legs="Malignance Tights",
        feet="Malignance Boots",
        ear1="Digni. Earring",
        ear2="Telos Earring",
        back={name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},
		waist="Windbuffet Belt +1",
        }) --0% to cap: /NIN 25% + Gear 0% (25%)

    sets.engaged.DW.MidAcc.MaxHasteSamba = set_combine(sets.engaged.DW.MaxHasteSamba, {
		hands="Gazu Bracelets +1",							--STR +10, DEX +32, Acc +82, Att -17, Haste +10%
		neck="Combatant's Torque",							--Sword Skill +10, sTP +4
		ear1="Crepuscular Earring", 						--Acc +10, sTP +5
        waist="Kentarch Belt +1",							--Acc +14, DA +3, sTP +5
        })

    sets.engaged.DW.HighAcc.MaxHasteSamba = set_combine(sets.engaged.DW.MidAcc.MaxHasteSamba, {
		ammo="Voluspa Tathlum",								--STR +5, DEX +5, Acc +10, Att +10
        head="Carmine Mask +1",								--STR +25, DEX +25, Acc +58, Haste +8%
		body="Lethargy Sayon +3",							--STR +34, DEX +34, Acc +64, Att +64, Haste +3%, DT -14
        legs="Carmine Cuisses +1",							--STR +30, Acc +55 (Set Bonus +20), Att +47, Haste +6%
        })


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.engaged.Hybrid = {
		head="Bunzi's Hat", 								--DT -6
		hands="Malignance Gloves",							--DT -5
		legs="Malignance Tights",							--DT -7
		feet="Malignance Boots",							--DT -4
		ring1="Defending Ring",								--DT -10
       }

    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.MidAcc.DT = set_combine(sets.engaged.MidAcc, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT = set_combine(sets.engaged.HighAcc, sets.engaged.Hybrid)

    sets.engaged.DW.DT = set_combine(sets.engaged.DW, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT = set_combine(sets.engaged.DW.MidAcc, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT = set_combine(sets.engaged.DW.HighAcc, sets.engaged.Hybrid)

    sets.engaged.DW.DT.LowHaste = set_combine(sets.engaged.DW.LowHaste, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.LowHaste = set_combine(sets.engaged.DW.HighAcc.LowHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.MidHaste = set_combine(sets.engaged.DW.MidHaste, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.MidHaste = set_combine(sets.engaged.DW.HighAcc.MidHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.HighHaste = set_combine(sets.engaged.DW.HighHaste, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT.HighHaste = set_combine(sets.engaged.DW.MidAcc.HighHaste, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.HighHaste = set_combine(sets.engaged.DW.HighAcc.HighHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.MaxHaste = set_combine(sets.engaged.DW.HighAcc.MaxHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.MaxHasteSamba = set_combine(sets.engaged.DW.MaxHasteSamba, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT.MaxHasteSamba = set_combine(sets.engaged.DW.MidAcc.MaxHasteSamba, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.MaxHasteSamba = set_combine(sets.engaged.DW.HighAcc.MaxHasteSamba, sets.engaged.Hybrid)
	
    sets.engaged.Enspell = {
        hands="Aya. Manopolas +2",
		ammo="Sroda Tathlum",
		ear1="Crep. Earring",
		back={name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}},
		waist="Orpheus's Sash",
        }

    sets.engaged.Enspell.Fencer = {} --{ring1="Fencer's Ring"}
	
	sets.DefaultShield = {sub="Sacro Bulwark"}


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.buff.Doom = {
	neck="Nicander's Necklace", 					--20
	ring1="Saida Ring", 							--15
	ring2="Purity Ring", 							--7
    waist="Gishdubar Sash", 						--10
		}

    sets.Obi = {waist="Hachirin-no-Obi"}
    -- sets.CP = {back="Mecisto. Mantle"}

    sets.TreasureHunter = {
		ammo="Perfect Lucky Egg", 	-- +1
		body="Volte Jupon",			-- +2
		legs="Volte Hose",			-- +1
		} --TH +4

	--Idle Weapon Sets
	
	--DW/Enspell--
	sets.DeathBlossom = {main="Murgleis", sub="Gleti's Knife"}
	sets.Excalibur = {main="Excalibur", sub="Gleti's Knife"}
	sets.Naegling = {main="Naegling", sub="Thibron"}
    sets.MagicWS = {main="Crocea Mors", sub="Daybreak"}
	sets.Maxentius = {main="Maxentius", sub="Thibron"}
	sets.Caliburnus = {main="Caliburnus", sub="Thibron"}
	sets.Aeolian = {main="Tauret", sub="Malevolence"}
	sets.Enspell = {main="Crocea Mors", sub="Pukulatmuj +1"}
	sets.Odin = {main="Infiltrator", sub="Esikuva"}
	
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
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
    if spell.name == 'Impact' then
        equip(sets.precast.FC.Impact)
    end
    if spell.english == "Phalanx II" and (spell.target.type == 'SELF' and buffactive.Accession) then
        cancel_spell()
        send_command('@input /ma "Phalanx" <me>')
    end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Enhancing Magic' then
        if classes.NoSkillSpells:contains(spell.english) then
            equip(sets.midcast.EnhancingDuration)
			if spellMap == 'Refresh' and spell.target.type == 'SELF' then
				equip(sets.midcast.RefreshSelf)
			end
			return
		end
        if skill_spells:contains(spell.english) then
            equip(sets.midcast.EnhancingSkill)
		elseif bar_element:contains(spell.english) then
			equip(sets.midcast.BarElement)
		elseif bar_status:contains(spell.english) then
			equip(sets.midcast.BarStatus)
        elseif spell.english:startswith('Gain') then
            equip(sets.midcast.GainSpell)
        elseif spell.english:contains('Spikes') then
            equip(sets.midcast.SpikesSpell)
        end
        if (spell.target.type == 'PLAYER' or spell.target.type == 'NPC') and (spellMap == 'Refresh' or spellMap == 'Aquaveil') 
			and buffactive.Composure or (buffactive.Composure and buffactive.Acession) then
				equip(sets.midcast.RefreshOther)
			elseif (spell.target.type == 'PLAYER' or spell.target.type == 'NPC') and buffactive.Composure or (buffactive.Composure and buffactive.Acession) then
				equip(sets.buff.ComposureOther)
        end
    end
    if spellMap == 'Cure' and spell.target.type == 'SELF' then
        equip(sets.midcast.CureSelf)
    end
    if spell.skill == 'Elemental Magic' then
        if state.MagicBurst.value then
            equip(sets.magic_burst)
            if spell.english == "Impact" then
                equip(sets.midcast.Impact)
            end
        end
        if spell.skill == 'Elemental Magic' then
            if spell.element == world.weather_element and (get_weather_intensity() == 2 and spell.element ~= elements.weak_to[world.day_element]) then
                equip(sets.Obi)
            -- Target distance under 1.7 yalms.
            elseif spell.target.distance < (1.7 + spell.target.model_size) then
                equip({waist="Orpheus's Sash"})
            -- Matching day and weather.
            elseif spell.element == world.day_element and spell.element == world.weather_element then
                equip(sets.Obi)
            -- Target distance under 8 yalms.
            elseif spell.target.distance < (8 + spell.target.model_size) then
                equip({waist="Orpheus's Sash"})
            -- Match day or weather.
            elseif spell.element == world.day_element or spell.element == world.weather_element then
                equip(sets.Obi)
            end
        end
    end
	if spell.skill == 'Enfeebling Magic' and buffactive.Saboteur then
			equip(sets.buff.Saboteur)
	end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.english:contains('Sleep') and not spell.interrupted then
        set_sleep_timer(spell)
    end
    if player.status ~= 'Engaged' and state.WeaponLock.value == false then
        check_weaponset()
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

function job_buff_change(buff,gain)
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
        disable('main','sub','range')
    else
        enable('main','sub','range')
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
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if default_spell_map == 'Cure' or default_spell_map == 'Curaga' then
            if (world.weather_element == 'Light' or world.day_element == 'Light') then
                return 'CureWeather'
            end
        end
    end
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
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    -- if state.CP.current == 'on' then
    --     equip(sets.CP)
    --     disable('back')
    -- else
    --     enable('back')
    -- end

    if state.Auto_Kite.value == true then
       idleSet = set_combine(idleSet, sets.Kiting)
    end

    return idleSet
end

function customize_melee_set(meleeSet)
    if state.EnspellMode.value == true then
        meleeSet = set_combine(meleeSet, sets.engaged.Enspell)
    end
    if state.EnspellMode.value == true and player.hpp <= 75 and player.tp < 1000 then
        meleeSet = set_combine(meleeSet, sets.engaged.Enspell.Fencer)
    end
    if state.TreasureMode.value == 'Fulltime' then
        meleeSet = set_combine(meleeSet, sets.TreasureHunter)
    end

    check_weaponset()

    return meleeSet
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
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
        if DW_needed < 11 then
			classes.CustomMeleeGroups:append('MaxHasteSamba')
		elseif DW_needed >= 11 and not buffactive.HasteSamba then
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif DW_needed > 15 and DW_needed <= 26 then
            classes.CustomMeleeGroups:append('HighHaste')
        elseif DW_needed > 26 and DW_needed <= 32 then
            classes.CustomMeleeGroups:append('MidHaste')
        elseif DW_needed > 32 and DW_needed <= 43 then
            classes.CustomMeleeGroups:append('LowHaste')
        elseif DW_needed > 43 then
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

function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'scholar' then
        handle_strategems(cmdParams)
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'nuke' then
        handle_nuking(cmdParams)
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'enspell' then
        send_command('@input /ma '..state.EnSpell.value..' <me>')
    elseif cmdParams[1]:lower() == 'barelement' then
        send_command('@input /ma '..state.BarElement.value..' <me>')
    elseif cmdParams[1]:lower() == 'barstatus' then
        send_command('@input /ma '..state.BarStatus.value..' <me>')
    elseif cmdParams[1]:lower() == 'gainspell' then
        send_command('@input /ma '..state.GainSpell.value..' <me>')
    end
	if cmdParams[1]=="use" then
        --[[
        dagger          = 2
        sword           = 3
        ]]
        if cmdParams[2] == 'Alternate' then
            if player.equipment.main ~= 'empty' and player.equipment.main == 'Excalibur' then
                send_command('input /ws "Knights of Round" <t>')
            elseif player.equipment.main ~= 'empty' and player.equipment.main == 'Caliburnus' then
                send_command('input /ws "Imperator" <t>')
            end
        end
    end

    gearinfo(cmdParams, eventArgs)
end

-- General handling of strategems in an Arts-agnostic way.
-- Format: gs c scholar <strategem>

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

function set_sleep_timer(spell)
    local self = windower.ffxi.get_player()

    if spell.en == "Sleep II" then
        base = 90
    elseif spell.en == "Sleep" or spell.en == "Sleepga" then
        base = 60
    end

    if state.Buff.Saboteur then
        if state.NM.value then
            base = base * 1.25
        else
            base = base * 2
        end
    end

    -- Merit Points Duration Bonus
    base = base + self.merits.enfeebling_magic_duration*6

    -- Relic Head Duration Bonus
    if not (buffactive.Stymie and buffactive.Composure) then
        base = base + self.merits.enfeebling_magic_duration*3
    end

    -- Job Points Duration Bonus
    base = base + self.job_points.rdm.enfeebling_magic_duration

    --Enfeebling duration non-augmented gear total
    gear_mult = 1.40
    --Enfeebling duration augmented gear total
    aug_mult = 1.25
    --Estoquer/Lethargy Composure set bonus
    --2pc = 1.1 / 3pc = 1.2 / 4pc = 1.35 / 5pc = 1.5
    empy_mult = 1 --from sets.midcast.Sleep

    if (buffactive.Stymie and buffactive.Composure) then
        if buffactive.Stymie then
            base = base + self.job_points.rdm.stymie_effect
        end
        empy_mult = 1.5 --from sets.midcast.SleepMaxDuration
    end

    totalDuration = math.floor(base * gear_mult * aug_mult * empy_mult)

    -- Create the custom timer
    if spell.english == "Sleep II" then
        send_command('@timers c "Sleep II ['..spell.target.name..']" ' ..totalDuration.. ' down spells/00259.png')
    elseif spell.english == "Sleep" or spell.english == "Sleepga" then
        send_command('@timers c "Sleep ['..spell.target.name..']" ' ..totalDuration.. ' down spells/00253.png')
    end
    add_to_chat(1, 'Base: ' ..base.. ' Merits: ' ..self.merits.enfeebling_magic_duration.. ' Job Points: ' ..self.job_points.rdm.stymie_effect.. ' Set Bonus: ' ..empy_mult)

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
    if player.sub_job ~= 'NIN' and player.sub_job ~= 'DNC' then
		-- equip(sets[state.DW_WeaponSet.current])
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
    set_macro_page(1, 1)
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset ' .. lockstyleset)
end