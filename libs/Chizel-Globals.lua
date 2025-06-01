-------------------------------------------------------------------------------------------------------------------
-- Modify the sets table.  Any gear sets that are added to the sets table need to
-- be defined within this function, because sets isn't available until after the
-- include is complete.  It is called at the end of basic initialization in Mote-Include.
-------------------------------------------------------------------------------------------------------------------

function define_global_sets()

    -- Augmented Weapons
    gear.Colada_ENH = {name="Colada", augments={'Enh. Mag. eff. dur. +4','INT+3','"Mag.Atk.Bns."+4',}}

    gear.Kali_Song = {name="Kali", augments={'DMG:+15','CHR+15','Mag. Acc.+15',}}
	gear.Kali_Skill = {name="Kali", augments={'Mag. Acc.+15','String instrument skill +10','Wind instrument skill +10',}}

    gear.Linos_TP = {name="Linos", augments={'Accuracy+13 Attack+13','"Dbl.Atk."+3','Quadruple Attack +3',}}
    gear.Linos_SavageBlade = {name="Linos", augments={'Attack+14','Weapon skill damage +3%','STR+7',}}
    gear.Linos_RudrasStorm = {name="Linos", augments={'Attack+11','Weapon skill damage +3%','DEX+7',}}
    gear.Linos_Evisceration = {name="Linos", augments={'Attack+12','Crit. hit damage +3%','DEX+8',}}
	gear.Linos_FC = {name="Linos", augments={'Mag. Acc.+15','"Fast Cast"+6','MND+8',}}
	gear.Linos_DT = {name="Linos", augments={'DEF+12','Phys. dmg. taken -4%','VIT+8',}}

    gear.Grioavolr_Enfeeble = {name="Grioavolr", augments={'Enfb.mag. skill +11','INT+6','Mag. Acc.+25','"Mag.Atk.Bns."+1','Magic Damage +4',}}

    -- Acro

    -- Adhemar
    gear.Adhemar_B_head = {name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}}
	gear.Adhemar_A_body = {name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}}
	gear.Adhemar_A_hands = {name="Adhemar Wristbands", augments={'DEX+10','AGI+10','Accuracy+15',}}
    gear.Adhemar_B_hands = {name="Adhemar Wristbands", augments={'STR+10','DEX+10','Attack+15',}}
	gear.Adhemar_D_hands = {name="Adhemar Wrist. +1", augments={'Accuracy+20','Attack+20','"Subtle Blow"+8',}}
    gear.Adhemar_D_feet = {name="Adhe. Gamashes +1", augments={'HP+65','"Store TP"+7','"Snapshot"+10',}} --respec? Currently B

    -- Chironic
	gear.Chironic_Idle_hands = {name="Chironic Gloves", augments={'"Mag.Atk.Bns."+5','INT+4','"Refresh"+2','Accuracy+15 Attack+15','Mag. Acc.+14 "Mag.Atk.Bns."+14',}}
	gear.Chironic_FC_feet = {name="Chironic Slippers", augments={'Mag. Acc.+15','"Fast Cast"+5','MND+3','"Mag.Atk.Bns."+14',}}
	gear.Chironic_AV_head = {name="Chironic Hat", augments={'Mag. Acc.+16','"Resist Silence"+8','MND+10',}}

	-- Gendewitha
	gear.Gende_SongCast_hands = {name="Gende. Gages +1", augments={'Phys. dmg. taken -4%','Song spellcasting time -4%',}}
	
    -- Herculean
	gear.Herc_FC_head = {name="Herculean Helm", augments={'"Mag.Atk.Bns."+16','"Fast Cast"+4','MND+5','Mag. Acc.+3',}}
	gear.Herc_Counter_hands = {name="Herculean Gloves", augments={'Accuracy+5','"Counter"+5','STR+5','Attack+10',}}

    -- Merlinic
	gear.Merl_OA_hands = {name="Merlinic Dastanas", augments={'Mag. Acc.+6','"Occult Acumen"+11','MND+1','"Mag.Atk.Bns."+14',}}
	gear.Merl_OA_feet = {name="Merlinic Crackows", augments={'"Occult Acumen"+10','Mag. Acc.+7',}}
	gear.Merl_Dark_body = {name="Merlinic Jubbah", augments={'"Drain" and "Aspir" potency +11','Mag. Acc.+5',}}
	gear.Merl_Dark_hands = {name="Merlinic Dastanas", augments={'"Mag.Atk.Bns."+9','"Drain" and "Aspir" potency +10','INT+5','Mag. Acc.+7',}}
	
	-- Odyssean
	gear.Odyssean_Phalanx_Head = {name="Odyssean Helm", augments={'Crit.hit rate+1','Phys. dmg. taken -4%','Phalanx +5','Accuracy+19 Attack+19',}}
	gear.Odyssean_Phalanx_Body = {name="Odyss. Chestplate", augments={'Rng.Atk.+15','"Rapid Shot"+5','Phalanx +5',}}
	gear.Odyssean_CureFC_Body = {name="Odyss. Chestplate", augments={'"Mag.Atk.Bns."+5','"Fast Cast"+6','Mag. Acc.+8',}}
	gear.Odyssean_CurePot_Feet = {name="Odyssean Greaves", augments={'Accuracy+5','"Cure" potency +3%','MND+9','Mag. Acc.+4',}}

	-- Souveran
	gear.Souveran_Enmity_Hands = {name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}}
	gear.Souveran_ShieldSkill_Hands = {name="Souv. Handsch. +1", augments={'HP+65','Shield skill +15','Phys. dmg. taken -4',}}
	
    -- Taeon
	gear.Taeon_DW_head = {name="Taeon Chapeau", augments={'Accuracy+20','"Dual Wield"+5','DEX+8',}}
    gear.Taeon_DW_feet = {name="Taeon Boots", augments={'Accuracy+17 Attack+17','"Dual Wield"+4','DEX+8',}}
    gear.Taeon_FC_body = {name="Taeon Tabard", augments={'Evasion+20','"Fast Cast"+5','HP+47',}}
    gear.Taeon_Phalanx_body = {name="Taeon Tabard", augments={'Mag. Evasion+15','Spell interruption rate down -6%','Phalanx +3',}}
    gear.Taeon_Phalanx_hands = {name="Taeon Gloves", augments={'Mag. Evasion+15','Spell interruption rate down -2%','Phalanx +2',}}
    gear.Taeon_Phalanx_legs = {name="Taeon Tights", augments={'Mag. Evasion+16','Spell interruption rate down -2%','Phalanx +3',}}
    gear.Taeon_Phalanx_feet = {name="Taeon Boots", augments={'Mag. Evasion+16','Spell interruption rate down -3%','Phalanx +2',}}

	--Telchine
    gear.Telchine_ENH_head = {name="Telchine Cap", augments={'Mag. Evasion+17','"Regen"+2','Enh. Mag. eff. dur. +10',}}
    gear.Telchine_ENH_body = {name="Telchine Chas.", augments={'Mag. Evasion+19','"Regen"+2','Enh. Mag. eff. dur. +10',}}
    gear.Telchine_ENH_hands = {name="Telchine Gloves", augments={'Mag. Evasion+11','"Regen"+2','Enh. Mag. eff. dur. +9',}}
    gear.Telchine_ENH_legs = {name="Telchine Braconi", augments={'Mag. Evasion+20','"Regen"+2','Enh. Mag. eff. dur. +9',}}
    gear.Telchine_ENH_feet = {name="Telchine Pigaches", augments={'Mag. Evasion+19','"Regen"+2','Enh. Mag. eff. dur. +10',}}
	gear.Telchine_SongCast_feet = {name="Telchine Pigaches", augments={'Accuracy+15 Attack+15','Song spellcasting time -7%','CHR+10',}}

    -- Valorous

    -- Ambuscade Capes
	gear.BLM_FC_Cape = {name="Taranus's Cape", augments={'MP+60','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10','Damage taken-5%',}}
	gear.BLM_MAB_Cape = {name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Damage taken-5%',}}
	gear.BLM_TP_Cape = {name="Taranus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}}
	gear.BLM_OA_Cape = {name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Store TP"+10','Damage taken-5%',}}
	gear.BLM_INT_WS_Cape = {name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+5','Weapon skill damage +10%','Damage taken-5%',}}
	gear.BLM_Idle_Cape = {name="Taranus's Cape", augments={'MP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity-10','Damage taken-5%',}}
	
    gear.BLU_MAB_Cape = {name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Damage taken-5%',}} --*
	gear.BLU_FC_Cape = {name="Rosmerta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Damage taken-5%',}} --*
    gear.BLU_TP_Cape = {name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}} --*
	gear.BLU_Idle_Cape = {name="Rosmerta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Haste+10','Damage taken-5%',}} --*
	-- gear.BLU_STP_Cape = {name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}} --**
    gear.BLU_STR_Cape = {name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}} --*
	gear.BLU_CDC_Cape = {name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10','Damage taken-5%',}}
	gear.BLU_DW_Cape = {name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}}
	
	gear.BRD_Song_Cape = {name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10','Damage taken-5%',}} --*
	gear.BRD_TP_Cape = {name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Damage taken-5%',}}
	gear.BRD_Savage_Cape = {name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}}
	gear.BRD_Rudras_Cape = {name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+5','Weapon skill damage +10%','Damage taken-5%',}}
	
	gear.COR_TP_Cape = {name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Damage taken-5%',}}
	gear.COR_STR_Cape = {name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}}
	gear.COR_Snap_Cape = {name="Camulus's Mantle", augments={'"Snapshot"+10',}}
	gear.COR_RA_Cape = {name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10','Damage taken-5%',}}	
	gear.COR_Leaden_Cape = {name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Damage taken-5%',}}
	gear.COR_RAWSD_Cape = {name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%','Damage taken-5%',}}
	
	gear.DRK_TP_Cape = {name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
	gear.DRK_STR_WSD = {name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+5','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
	gear.DRK_FC_Cape = {name="Ankou's Mantle", augments={'MND+20','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10',}}
	gear.DRK_VIT_WSD = {name="Ankou's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%','Phys. dmg. taken-4%',}}
	gear.DRK_STR_DA = gear.DRK_STR_WSD
	gear.DRK_Impact_Cape = {name="Ankou's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Store TP"+10','Phys. dmg. taken-10%',}}
	gear.DRK_INT_WSD = gear.DRK_Impact_Cape
	
	gear.MNK_Chakra_Cape = {}
	gear.MNK_Counter_Cape = {name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Crit.hit rate+10','System: 1 ID: 640 Val: 4',}}
	gear.MNK_TP_Cape = {name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+3','"Dbl.Atk."+10','Damage taken-5%',}}
	gear.MNK_ChiBlast_Cape = gear.MNK_TP_Cape --{}
	gear.MNK_STR_WS_Cape = {name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Damage taken-5%',}}
	
    gear.NIN_FC_Cape = 	{name="Andartia's Mantle", augments={'MND+20','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Mag. Evasion+15',}} --**
    gear.NIN_MAB_Cape = {name="Andartia's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+3','"Mag.Atk.Bns."+10','Spell interruption rate down-10%',}}
    gear.NIN_TP_Cape = 	{name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Rng.Atk.+10','"Dbl.Atk."+10','Damage taken-5%',}} --**
	gear.NIN_WSD_STR_Cape = {name="Andartia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+5','Weapon skill damage +10%','Damage taken-5%',}} --**
	gear.NIN_DW_Cape = {name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Rng.Atk.+10','"Dual Wield"+10','Damage taken-5%',}}
	gear.NIN_STP_Cape = {name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Rng.Atk.+10','"Store TP"+10','Damage taken-5%',}}
	
	gear.PLD_DEF_Cape = {name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Enmity+10','DEF+50',}} --**
	gear.PLD_MEva_Cape = {name="Rudianos's Mantle", augments={'HP+60','Mag. Evasion+5','Eva.+20 /Mag. Eva.+20','Enmity+10','Occ. inc. resist. to stat. ailments +10',}} --**
	gear.PLD_TP_Cape = {name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+3','"Store TP"+10','Chance of successful block +5',}} --**
	gear.PLD_FC_Cape = {name="Rudianos's Mantle", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','"Fast Cast"+10','Spell interruption rate down-10%',}} --**
	gear.PLD_CurePot_Cape = {name="Rudianos's Mantle", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','VIT+10','"Cure" potency +10%','Spell interruption rate down-10%',}} --*
	gear.PLD_STR_Cape = {name="Rudianos's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}} --**
	gear.PLD_DEX_Cape = {name="Rudianos's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Crit.hit rate+10',}}
	gear.PLD_Phalanx_Cape = {name="Weard Mantle", augments={'VIT+2','DEX+2','Enmity+5','Phalanx +4',}}

    -- gear.RDM_DW_Cape = {name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}} --**
    -- gear.RDM_INT_Cape = {name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Damage taken-5%',}} --*
    -- gear.RDM_STP_Cape = {name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}} --*
    -- gear.RDM_STR_WS_Cape = {name="Sucellos's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}} --*
	-- gear.RDM_MND_WS_Cape = {name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+7','Weapon skill damage +10%','Damage taken-5%',}} --*
	-- gear.RDM_MND_EnfPot_Cape = {name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+7','Weapon skill damage +10%','Damage taken-5%',}} --*
	-- gear.RDM_Cure_Cape = {name="Sucellos's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','Enmity-10','Damage taken-5%',}}
    -- gear.RDM_Idle_Cape = {name="Sucellos's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Haste+10','Mag. Evasion+15',}}
	-- gear.RDM_AbsTP_Cape = {name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Haste+10',}}
	
	gear.WAR_TP_Cape = {name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}}
	gear.WAR_Upheaval_Cape = {name="Cichol's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','Weapon skill damage +10%','Damage taken-5%',}}
	gear.WAR_Savage_Cape = {name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}}

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