-------------------------------------------------------------------------------------------------------------------
-- Modify the sets table.  Any gear sets that are added to the sets table need to
-- be defined within this function, because sets isn't available until after the
-- include is complete.  It is called at the end of basic initialization in Mote-Include.
-------------------------------------------------------------------------------------------------------------------

function define_global_sets()
	-- Skirmish Gear --
	gear.Gende_SongCast_hands = {name="Gende. Gages +1", augments={'Phys. dmg. taken -4%','Song spellcasting time -4%',}}

	-- Acro --
	gear.Acro_TP_hands = {name="Acro Gauntlets", augments={'Accuracy+17 Attack+17','"Store TP"+6','STR+7 DEX+7',}}
	gear.Acro_Breath_body = {name="Acro Surcoat", augments={'Pet: Mag. Acc.+25','Pet: Breath+8','Pet: Damage taken -4%',}}
	
	-- Taeon --
	gear.Taeon_Phalanx_body = {name="Taeon Tabard", augments={'Mag. Evasion+12','Spell interruption rate down -10%','Phalanx +3',}}
	gear.Taeon_Regen_body = {name="Taeon Tabard", augments={'Mag. Evasion+12','Spell interruption rate down -7%','"Regen" potency+3',}}
	gear.Taeon_Phalanx_hands = {name="Taeon Gloves", augments={'Mag. Evasion+16','Spell interruption rate down -4%','Phalanx +2',}}
	gear.Taeon_Phalanx_legs = {name="Taeon Tights", augments={'Mag. Evasion+16','Spell interruption rate down -5%','Phalanx +3',}}
	gear.Taeon_Phalanx_feet = {name="Taeon Boots", augments={'Mag. Evasion+15','Spell interruption rate down -5%','Phalanx +3',}}
	gear.Taeon_Regen_feet = {name="Taeon Boots", augments={'Mag. Evasion+13','Spell interruption rate down -7%','"Regen" potency+3',}}
	
	-- Telchine --
	gear.Telchine_SongCast_feet = {name="Telchine Pigaches", augments={'Mag. Evasion+25','Song spellcasting time -5%','VIT+10',}}
	
	-- Ambuscade Capes --
	gear.BRD_TP_Cape = {name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}}
	gear.BRD_Song_Cape = {name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Damage taken-3%',}}
	gear.BRD_Savage_Cape = {name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}}
	gear.BRD_Rudras_Cape = {name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+5','Weapon skill damage +10%','Damage taken-5%',}}
	
	gear.DRG_TP_Cape = {name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}}
	gear.DRG_WSD_Cape = {name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}}
	gear.DRG_Stardiver_Cape = {name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Damage taken-5%',}}
	gear.DRG_Idle_Cape = {name="Brigantia's Mantle", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','Pet: Damage taken -5%',}}
	gear.DRG_Crit_Cape = {name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Crit.hit rate+10','Damage taken-1%',}} --*Dye+10(STR), Resin+4(DT)
	gear.DRG_Breath_Cape = {name="Updraft Mantle", augments={'STR+5','Pet: Breath+10','Pet: Damage taken -3%',}}
	
	-- Linos --
	gear.Linos_FC_MAcc = {name="Linos", augments={'Mag. Acc.+14','"Fast Cast"+4','INT+6 MND+6',}}
	gear.Linos_TP = {name="Linos", augments={'Accuracy+19','"Store TP"+3','Quadruple Attack +3',}}
	gear.Linos_ConserveMP = {name="Linos", augments={'Mag. Acc.+16','"Conserve MP"+3','MND+8',}}
	
	-- Kali --
	gear.Kali_Song = {name="Kali", augments={'DMG:+15','CHR+15','Mag. Acc.+15',}}
	gear.Kali_Skill = {name="Kali", augments={'Mag. Acc.+15','String instrument skill +10','Wind instrument skill +10',}}
	gear.Kali_MAcc = {name="Kali", augments={'MP+60','Mag. Acc.+20','"Refresh"+1',}}
	
	-- Vanya --
	gear.Vanya_HatB = {name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}
	gear.Vanya_HatC = {name="Vanya Hood", augments={'MND+10','Spell interruption rate down +15%','"Conserve MP"+6',}}
	gear.Vanya_BodyB = {name="Vanya Robe", augments={'MND+10','Spell interruption rate down +15%','"Conserve MP"+6',}}
	gear.Vanya_LegsC = {name="Vanya Slops", augments={'MND+10','Spell interruption rate down +15%','"Conserve MP"+6',}}
	gear.Vanya_FeetB = {name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}
	gear.Vanya_FeetD = {name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}}
	
	--Chironic--
	gear.Chironic_Enfeeble_legs = {name="Chironic Hose", augments={'Mag. Acc.+29','MND+10','"Mag.Atk.Bns."+8',}}
	
	--Herculean--
	gear.Herculean_FC_head = {name="Herculean Helm", augments={'"Fast Cast"+6','Mag. Acc.+9',}}
	gear.Herculean_DPS_body = {name="Herculean Vest", augments={'Accuracy+16 Attack+16','Crit. hit damage +2%','Accuracy+14','Attack+7',}}
	gear.Herculean_Dimidiation_hands = {name="Herculean Gloves", augments={'Attack+10','Weapon skill damage +4%','DEX+8','Accuracy+7',}}
	
	--Valorous--
	gear.Valorous_TP_feet = {name="Valorous Greaves", augments={'Accuracy+30','"Store TP"+4',}}

end



laggy_zones = S{'Al Zahbi', 'Aht Urhgan Whitegate', 'Eastern Adoulin', 'Mhaura', 'Nashmau', 'Selbina', 'Western Adoulin', 'Kamihr Drifts', 'Norg', 'Leafallia'}

windower.register_event('zone change',
    function()
      -- Caps FPS to 30 via Config addon in certain problem zones
        if laggy_zones:contains(world.zone) then
            send_command('config FrameRateDivisor 2')
        else
            send_command('config FrameRateDivisor 1')
        end

        -- Auto load Omen add-on
        -- if world.zone == 'Reisenjima Henge' then
            -- send_command('lua l omen')
        -- end
    end
)