-------------------------------------------------------------------------------------------------------------------
--  Chizel's Global Keybinds
-------------------------------------------------------------------------------------------------------------------

    -- ^ stands for the Ctrl key.
	-- ! stands for the Alt key. 
    -- @ stands for the Windows key.
	-- ~ stands for the Shift Key
	-- # stands for the App Key

	if player.main_job == 'DNC' or player.sub_job == 'DNC' then
        send_command('bind ![ input /ja "Spectral Jig" <me>')
    elseif player.sub_job == 'NIN' then    
		send_command('bind @, input /ma "Utsusemi: Ichi" <me>')
		send_command('bind @. input /ma "Utsusemi: Ni" <me>')
        send_command('bind ![ input /ma "Monomi: Ichi" <me>')
        send_command('bind !] input /ma "Tonko: Ni" <me>')
	elseif player.main_job == 'RDM' or player.sub_job == 'RDM'
        or player.main_job == 'SCH' or player.sub_job == 'SCH'
        or player.main_job == 'WHM' or player.sub_job == 'WHM' then
        send_command('bind ![ input /ma "Sneak" <stpt>')
        send_command('bind !] input /ma "Invisible" <stpt>')
	elseif player.main_job == 'NIN' then    
		send_command('bind @, input /ma "Utsusemi: Ichi" <me>')
		send_command('bind @. input /ma "Utsusemi: Ni" <me>')
		send_command('bind @/ input /ma "Utsusemi: San" <me>')
        send_command('bind ![ input /ma "Monomi: Ichi" <me>')
        send_command('bind !] input /ma "Tonko: Ni" <me>')	
	else
        send_command('bind ![ input /item "Silent Oil" <me>')
        send_command('bind !] input /item "Prism Powder" <me>')
    end
	if player.main_job == 'COR' then
		send_command('bind ^/ input /item "Chr. Bul. Pouch" <me>')
		send_command('bind !/ input /item "Trump Card Case" <me>')
	end
	
	--Sawdust BRD--
	-- send_command('bind @numpad/ //send Sawdust /ja \"Nightingale\" <me>')
	-- send_command('bind @numpad* //send Sawdust /ja \"Troubadour\" <me>')
	-- send_command('bind @numpad- //send Sawdust /ja \"Marcato\" <me>')
	-- send_command('bind @numpad+ input //send Sawdust /ma \"Horde Lullaby\" <bt>')
	-- send_command('bind @numpad9 input //send Sawdust /ma \"Pining Nocturn\" <bt>')
	-- send_command('bind @numpad8 input //send Sawdust /ma \"Foe Requiem VII\" <bt>')
	-- send_command('bind @numpad7 input //send Sawdust /ma \"Carnage Elegy\" <bt>')
	-- send_command('bind @numpad6 input //send Sawdust /ma \"Victory March\" <me>')
	-- send_command('bind @numpad5 input //send Sawdust /ma \"Advancing March\" <me>')
	-- send_command('bind @numpad4 input //send Sawdust /ma \"Blade Madrigal\" <me>')
	-- send_command('bind @numpad3 input //send Sawdust /ma \"Valor Minuet V\" <me>')
	-- send_command('bind @numpad2 input //send Sawdust /ma \"Valor Minuet IV\" <me>')
	-- send_command('bind @numpad1 input //send Sawdust /ma \"Valor Minuet III\" <me>')
	-- send_command('bind @numpad0 input //send Sawdust /ma \"Savage Blade\" <t>')
	
	--Warp Rings--
	send_command('bind @numpad. input //send @all /equip ring2 \"Warp Ring\"')
	send_command('bind ^numpad. input //send @all /item \"Warp Ring\" <me>')
	--Misc Commands--
	send_command('bind !l input //gs disable')
	send_command('bind ^l input //gs enable')