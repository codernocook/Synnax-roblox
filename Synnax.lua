local Players = game:GetService("Players")
local plr = Players.LocalPlayer
repeat task.wait() until plr.Character and getRoot(plr.Character)
local char = plr.Character or plr.CharacterAdded
local ResetTeleportEnabled = false
local FakeLagEnabled = false
local HeartBeatWalkEnabled = false
local AlwaysJumpEnabled = false
local FloatEnabled = false
local SlowFloatEnabled = false
local AutoReportEnabled = false
local BetterGodModeEnabled = false
local BetterGodModeRespawnCheck = false
local BetterGodModeConnection = nil
local ReportConnection = nil
local HackerDetectorEnabled = false
local HackerDetectorConnection = nil
local Humanoid = char:FindFirstChildWhichIsA("Humanoid")
local Mouse = plr:GetMouse()
local alreadyreported = {}
local hackerreported = {}
local flyloop = nil;
local userinputget1 = nil;
local userinputget2 = nil;
local uis = game:GetService("UserInputService")
local anchor_connection = nil;
local anchor_died_connection = nil;
local resettp_delay = 0;
local infAuraEnabled = false;
local boxReachEnabled = false;

local badwordsreport = {
    ["gay"] = "Bullying",
    ["gays"] = "Bullying",
    ["gae"] = "Bullying",
    ["gey"] = "Bullying",
    ["furry"] = "Bullying",
    ["furries"] = "Bullying",
    ["furr"] = "Bullying",
    ["nig"] = "Bullying",
    ["hack"] = "Scamming",
    ["hax"] = "Scamming",
    ["hex"] = "Scamming",
    ["exploit"] = "Scamming",
    ["cheat"] = "Scamming",
    ["dllcheat"] = "Scamming",
    ["dllexploit"] = "Scamming",
    ["hecker"] = "Scamming",
    ["hacer"] = "Scamming",
    ["haxer"] = "Scamming",
    ["hexer"] = "Scamming",
    ["fuck"] = "Bullying",
    ["bitch"] = "Bullying",
    ["beach"] = "Bullying",
    ["ass"] = "Bullying",
    ["fat"] = "Bullying",
    ["deck"] = "Bullying",
    ["black"] = "Bullying",
    ["getalife"] = "Bullying",
    ["report"] = "Bullying",
    ["fatherless"] = "Bullying",
    ["disco"] = "Offsite Links",
    ["yt"] = "Offsite Links",
    ["youtube"] = "Offsite Links",
    ["dizcourde"] = "Offsite Links",
    ["http:/"] = "Offsite Links",
    ["https:/"] = "Offsite Links",
    ["retard"] = "Swearing",
    ["bad"] = "Bullying",
    ["trash"] = "Bullying",
    ["rubbish"] = "Bullying",
    ["nolife"] = "Bullying",
    ["nolive"] = "Bullying",
    ["loser"] = "Bullying",
    ["urmom"] = "Bullying",
    ["urmum"] = "Bullying",
    ["killyour"] = "Bullying",
    ["kys"] = "Bullying",
    ["hacktowin"] = "Bullying",
    ["bozo"] = "Bullying",
    ["kid"] = "Bullying",
    ["adopted"] = "Bullying",
    ["linlife"] = "Bullying",
    ["commitnotalive"] = "Bullying",
    ["vape"] = "Offsite Links",
    ["futureclient"] = "Offsite Links",
    ["infyield"] = "Offsite Links",
    ["krnl"] = "Offsite Links",
    ["syn"] = "Offsite Links",
    ["fluxus"] = "Offsite Links",
    ["scriptware"] = "Offsite Links",
    ["script-ware"] = "Offsite Links",
    ["download"] = "Offsite Links",
    ["yalltube"] = "Offsite Links",
    ["github"] = "Offsite Links",
    ["gitlab"] = "Offsite Links",
    ["spotify"] = "Offsite Links",
    ["die"] = "Bullying",
    ["lobby"] = "Bullying",
    ["ban"] = "Bullying",
    ["wizard"] = "Bullying",
    ["wisard"] = "Bullying",
    ["witch"] = "Bullying",
    ["magic"] = "Bullying",
    ["shut"] = "Bullying",
    ["bot"] = "Scamming",
    ["sex"] = "Scamming",
    ["L"] = "Bullying",
}

function getRoot(charget)
    local rootPart = charget:FindFirstChild('HumanoidRootPart') or charget:FindFirstChild('Torso') or charget:FindFirstChild('UpperTorso')
    return rootPart
end

function getTorso(charget)
    local rootPart = charget:FindFirstChild('Torso') or charget:FindFirstChild('UpperTorso')
    return rootPart
end

function getLowest(table_)
	local low = math.huge
	local index

	for i, v in pairs(table_) do
		if (v["mag"] < 0) then v["mag"] = 0 - v["mag"] end;
		if v["mag"] < low then
			low = v["mag"]
			index = i
		end
	end

	return index;
end

local function nearestPlayer(dist_)
	local obj_insert = {};

	for _, v in pairs(game:GetService("Players"):GetPlayers()) do
		if (v and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and getRoot(char)) then
			local decide = getRoot(char).Position.Magnitude - v.Character:FindFirstChild("HumanoidRootPart").Position.Magnitude
			if ((getRoot(char).Position.Magnitude - v.Character:FindFirstChild("HumanoidRootPart").Position.Magnitude) > tonumber(dist_)) then
				decide = math.huge;
			end

            if (v ~= game:GetService("Players").LocalPlayer) then
                table.insert(obj_insert, {
                    ["player"] = v,
                    ["mag"] = decide,
                    ["part"] = v.Character:FindFirstChild("HumanoidRootPart")
                })
            end
		end
	end

	local lowest = getLowest(obj_insert);

	if (lowest and obj_insert and obj_insert[lowest] and obj_insert[lowest]["part"] and obj_insert[lowest]["part"].Position) then
		-- return the value
		return {
            ["player"] = obj_insert[lowest]["player"],
            ["part"] = obj_insert[lowest]["part"]
        };
	elseif (not lowest) then
		-- yep no player found :( let's return nil
		return { ["error"] = "error" };
	end
end

local Clip = false;
local Noclipping = nil;
function noclip(state, character_)
    if (state) then
        Clip = false
        task.wait(0.1)
        local function NoclipLoop()
            local character_get
            if (character_) then
                character_get = character_
            else
                character_get = plr.Chracter
            end
            if Clip == false and character_get ~= nil then
                for _, child in pairs(character_get:GetDescendants()) do
                    if child:IsA("BasePart") and child.CanCollide == true then
                        child.CanCollide = false
                    end
                end
            end
        end
        Noclipping = game:GetService("RunService").Stepped:Connect(NoclipLoop)
    else
        if Noclipping then
            Noclipping:Disconnect()
        end
        Clip = true
    end
end

local function removerepeat(str)
    local newstr = ""
    local lastlet = ""
    for i,v in pairs(str:split("")) do
        if v ~= lastlet then
            newstr = newstr..v
            lastlet = v
        end
    end
    return newstr
end

function findreport(msg)
    local checkstr = removerepeat(msg:gsub("%W+", ""):lower())
    for i,v in pairs(badwordsreport) do
        if checkstr:find(i) then
            return v, i
        end
    end
    for i,v in pairs(badwordsreport) do
        if checkstr == i then
            return v, i
        end
    end
    return nil
end



local oldposclick = Mouse.Hit
plr:GetMouse().Button1Down:Connect(function()
    if ResetTeleportEnabled == true then
        oldposclick = Mouse.Hit
        respawn(plr)
    end
end)

game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function(character)
    -- Set new character variable
    char = character;

    -- ResetTeleportExploit
    if ResetTeleportEnabled == true then
        repeat task.wait() until character:FindFirstChild("HumanoidRootPart");
        task.wait(resettp_delay or 0);
	    character:FindFirstChild("HumanoidRootPart").CFrame = oldposclick;
    end
end)

local Synnax = {
    ["PluginName"] = "Synnax",
    ["PluginDescription"] = "Admin Fe script!",
    ["Commands"] = {
        ["ResetBack"] = {
            ["ListName"] = "ResetBack / reback",
            ["Description"] = "Reset you and spawn at same position",
            ["Aliases"] = {"resetback", "reback"},
            ["Function"] = function(args, speaker)
                task.spawn(function()
                    notify("Notification", "Reset your character")
                    local rootget = getRoot(speaker.Character)
                    local resetoldpos = rootget.CFrame
                    execCmd('reset')
                    task.wait(Players.RespawnTime + 0.1)
                    rootget.CFrame = resetoldpos
                end)
            end
        },
        ["ResetTeleport"] = {
            ["ListName"] = "resettp [on/off] [delay]",
            ["Description"] = "Reset you and teleport to the last click position, may bypass some anti cheat",
            ["Aliases"] = {"resettp"},
            ["Function"] = function(args, speaker)
                task.spawn(function()
                    if args[1] then
                        if args[1] == "on" then
                            if ResetTeleportEnabled == true then
                                if (args[2] and tonumber(args[2])) then
                                    resettp_delay = tonumber(args[2]);
                                end
                                notify("Notification", "ResetTeleport already turned on!")
                            else
                                ResetTeleportEnabled = true
                            end
                        elseif args[1] == "off" then
                            if ResetTeleportEnabled == false then
                                if (args[2] and tonumber(args[2])) then
                                    resettp_delay = tonumber(args[2]);
                                end
                                notify("Notification", "ResetTeleport already turned off!")
                            else
                                ResetTeleportEnabled = false
                            end
                        end
                    else
                        notify("Notification", "You must set the status for ResetTeleport [on/off]")
                    end
                end)
            end
        },
        ["FakeLag"] = {
            ["ListName"] = "flag / Fakelag [delay] [delay1 (this option will random from delay to delay1)]",
            ["Description"] = "Make your movement laggier",
            ["Aliases"] = {"flag", "fakelag"},
            ["Function"] = function(args, speaker)
               task.spawn(function()
                    notify("Notification", "Start fake lagging")
                    FakeLagEnabled = true
                    --speaker.Character:FindFirstChild("Animate").Disabled = true;

                    speaker.CharacterAdded:Connect(function()
                        --repeat task.wait() until speaker.Character:FindFirstChild("Animate")
                        --speaker.Character:FindFirstChild("Animate").Disabled = true;
                    end)

                    if args[1] and tonumber(args[1]) then
                        local repE1 = false;

                        -- Character exploit (this's just a way to make character move glitchy (NOT SURE this will save you from anti cheat))
                        if (char) then
                            -- old Archivable value
                            local old_archivable = char.Archivable
                            local old_index = nil;
                            
                            -- Allow to clone character
                            char.Archivable = true;

                            -- Cloning
                            local second_char = char:Clone();
                            char.Archivable = true;
                            second_char.Archivable = false;
                            second_char.Name = char.Name .. "_c";
                            second_char.Parent = game:GetService("Workspace");

                            -- Prevent cloned character keep stuck because main character (using cancollide)
                            for _, v in pairs(char:GetDescendants()) do
                                if (v and (v.ClassName == "Part" or v.ClassName == "MeshPart") or v.ClassName == "Decal") then
                                    game:GetService("RunService").Stepped:Connect(function()
                                        if Clip == false and v ~= nil then
                                            for _, child in pairs(v:GetDescendants()) do
                                                if child:IsA("BasePart") and child.CanCollide == true then
                                                    child.CanCollide = false
                                                end
                                            end
                                        end
                                    end)
                                end
                            end

                            -- Make the main character disappear (transparency)
                            if (char) then
                                for _, v in pairs(char:GetDescendants()) do
                                    if (v and (v.ClassName == "Part" or v.ClassName == "MeshPart") or v.ClassName == "Decal") then
                                        v.Transparency = 1;
                                    end
                                end
                            end

                            -- Set back old setting (like: walkspeed, jumppower, health, ...)
                            if (plr and plr.Character and plr.Character:FindFirstChildWhichIsA("Humanoid") and second_char:FindFirstChildWhichIsA("Humanoid")) then
                                second_char:FindFirstChildWhichIsA("Humanoid").WalkSpeed = plr.Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed;
                                second_char:FindFirstChildWhichIsA("Humanoid").JumpPower = plr.Character:FindFirstChildWhichIsA("Humanoid").JumpPower;
                                second_char:FindFirstChildWhichIsA("Humanoid").JumpHeight = plr.Character:FindFirstChildWhichIsA("Humanoid").JumpHeight;
                                second_char:FindFirstChildWhichIsA("Humanoid").Health = plr.Character:FindFirstChildWhichIsA("Humanoid").Health;
                                second_char:FindFirstChildWhichIsA("Humanoid").MaxHealth = plr.Character:FindFirstChildWhichIsA("Humanoid").MaxHealth;
                            end

                            -- Set client cloned character moving
                            plr.Character = second_char;

                            -- Set camera's subject to second character
                            if (workspace and workspace.CurrentCamera) then
                                workspace.CurrentCamera.CameraSubject = second_char:FindFirstChildWhichIsA("Humanoid");
                            end

                            -- Get main character
                            local main_character = nil;
                            for _, v in pairs(game:GetService("Workspace"):GetDescendants()) do
                                if (v and v.ClassName == "Model" and v:FindFirstChildWhichIsA("Humanoid") and v.Name == plr.Name) then
                                    main_character = v;
                                end
                            end

                            -- Make Character freeze (anchor) to make the lag realistic
                            local anchor_loop = false;
                            anchor_connection = game:GetService("RunService").Heartbeat:Connect(function()
                                if (anchor_loop == true) then return end;
                                anchor_loop = true;
                                task.wait(.25);
                                if (main_character and getRoot(main_character)) then
                                    if (getRoot(main_character).Anchored == false) then
                                        getRoot(main_character).Anchored = true;
                                    else
                                        getRoot(main_character).Anchored = false;
                                    end
                                end
                                anchor_loop = false;
                            end)
                        end
                        --------------------------------------------------------------------------------------------------------------------------

                        local _time = tonumber(args[1]);

                        if (args and args[1] and tonumber(args[1]) and args[2] and tonumber(args[2])) then
                            if (tonumber(args[2]) <= tonumber(args[1])) then
                                notify("Notification", "[delay1] must be > [delay]. Randomed:\n[delay]: 1 | delay[1]: 1.5")
                                _time = math.random(1, 1.5)
                            else
                                _time = math.random(tonumber(args[1]), tonumber(args[2]))
                            end
                        elseif (args and args[1] and tonumber(args[1]) and not args[2]) then
                            _time = tonumber(args[1]);
                        end

                        repeat task.wait(tonumber(_time))
                            -- Renew time
                            if (args and args[1] and tonumber(args[1]) and args[2] and tonumber(args[2])) then
                                if (tonumber(args[2]) <= tonumber(args[1])) then
                                    _time = math.random(2, 3.5)
                                else
                                    _time = math.random(tonumber(args[1]), tonumber(args[2]))
                                end
                            elseif (args and args[1] and tonumber(args[1]) and not args[2]) then
                                _time = tonumber(args[1]);
                            end

                            if (repE1 == false) then
                                if (tonumber(args[1])) then
                                    -- Client legit lag (some server or client anti cheat will think you're actually lagging)
                                    game:GetService("NetworkClient"):SetOutgoingKBPSLimit(-999999)

                                    task.spawn(function()
                                        pcall(function()
                                            settings():GetService("NetworkSettings").IncomingReplicationLag = 999999
                                            task.wait(.08);
                                            settings():GetService("NetworkSettings").IncomingReplicationLag = 0
                                        end)
                                    end)
                                else
                                    notify("Notification", "The value must be a Number.")
                                    repE1 = false;
                                    return;
                                end
                                repE1 = true;
                            else
                                settings():GetService("NetworkSettings").IncomingReplicationLag = 0
                                game:GetService("NetworkClient"):SetOutgoingKBPSLimit(math.huge)
                                if FakeLagEnabled == false then
                                    break
                                end

                                -- Make character vaild
                                if (plr and plr.Character) then
                                    for _, v in pairs(game:GetService("Workspace"):GetDescendants()) do
                                        if (v and v.ClassName == "Model" and v:FindFirstChildWhichIsA("Humanoid") and v.Name == plr.Name) then
                                            -- Make main character CanCollide so cloned character won't touch it
                                            for _, v in pairs(game:GetService("Workspace"):GetDescendants()) do
                                                if (v and v.ClassName == "Model" and v:FindFirstChildWhichIsA("Humanoid") and v.Name == plr.Name) then
                                                    noclip(true, v);
                                                end
                                            end

                                            -- Teleport faked/cloned character to main character
                                            v:PivotTo(plr.Character:GetPivot())

                                            if (v:FindFirstChildWhichIsA("Humanoid") and getRoot(v)) then
                                                local _root = getRoot(v);
                                                v:FindFirstChildWhichIsA("Humanoid"):MoveTo(_root.Position + Vector3.new(2.5, 0, 2.5))
                                            end
                                        end
                                    end
                                end

                                -- Make player move out (thinking lagging)
                                if (plr and plr.Character) then
                                    for _, v in pairs(game:GetService("Workspace"):GetDescendants()) do
                                        if (v and v.ClassName == "Model" and v:FindFirstChildWhichIsA("Humanoid") and v.Name == plr.Name) then
                                            if (v:FindFirstChildWhichIsA("Humanoid")) then
                                                local _root = getRoot(v);

                                                if (plr.Character:FindFirstChildWhichIsA("Humanoid")) then
                                                    if (plr.Character:FindFirstChildWhichIsA("Humanoid").MoveDirection.Magnitude > 0) then
                                                        v:FindFirstChildWhichIsA("Humanoid"):MoveTo(_root.Position + Vector3.new(math.random(0, .5), 0, math.random(0, 0.5)))
                                                    end
                                                    if (plr.Character:FindFirstChildWhichIsA("Humanoid").Jump == true) then
                                                        v:FindFirstChildWhichIsA("Humanoid").Jump = true;
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end

                                -- Died (prevent cloned character and main character loop when died)
                                for _, v in pairs(game:GetService("Workspace"):GetDescendants()) do
                                    if (v and v.ClassName == "Model" and v:FindFirstChildWhichIsA("Humanoid") and v.Name == plr.Name) then
                                        if (v:FindFirstChildWhichIsA("Humanoid")) then
                                            if (plr.Character:FindFirstChildWhichIsA("Humanoid")) then
                                                plr.Character:FindFirstChildWhichIsA("Humanoid").Died:Connect(function()
                                                    notify("Notification", "Stop fake lagging, because you died");
                                                    -- wait until respawned
                                                    task.wait(game:GetService("Players").RespawnTime + 0.5);
                                                    
                                                    FakeLagEnabled = false
                                                    settings():GetService("NetworkSettings").IncomingReplicationLag = 0
                                                    game:GetService("NetworkClient"):SetOutgoingKBPSLimit(math.huge)

                                                    -- Remove anchor loop
                                                    if (anchor_connection) then
                                                        anchor_connection:Disconnect();
                                                        anchor_connection = nil;
                                                    end

                                                    -- Remove character removal checker
                                                    if (anchor_died_connection) then
                                                        anchor_died_connection:Disconnect();
                                                        anchor_died_connection = nil;
                                                    end

                                                    -- Set camera to main character
                                                    for _, v in pairs(game:GetService("Workspace"):GetDescendants()) do
                                                        if (v and v.ClassName == "Model" and v:FindFirstChildWhichIsA("Humanoid") and v.Name == plr.Name) then
                                                            game:GetService("Workspace").CurrentCamera.CameraSubject = v:FindFirstChildWhichIsA("Humanoid");

                                                            -- Make Humanoid setting 
                                                            v:FindFirstChildWhichIsA("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.Died, true);

                                                            -- Change root anchor state
                                                            if (getRoot(v)) then
                                                                getRoot(v).Anchored = false;
                                                            end
                                                        end
                                                    end

                                                    -- Fix character
                                                    if (char) then
                                                        for _, v in pairs(char:GetDescendants()) do
                                                            if (v and (v.ClassName == "Part" or v.ClassName == "MeshPart" or v.ClassName == "Decal") and v.Name ~= "HumanoidRootPart") then
                                                                -- Make the player visible
                                                                v.Transparency = 0;

                                                                -- Make character touchable
                                                                noclip(false, char);
                                                            end
                                                        end
                                                    end

                                                    -- Destroy fake cloned character
                                                    if (plr.Character) then
                                                        for _, v in pairs(game:GetService("Workspace"):GetDescendants()) do
                                                            if (v and v.ClassName == "Model" and v:FindFirstChildWhichIsA("Humanoid") and v.Name == plr.Name) then
                                                                plr.Character = v;

                                                                if (getRoot(v)) then
                                                                    getRoot(v).Anchored = false;
                                                                end
                                                            end
                                                        end
                                                        for _1, v1 in pairs(game:GetService("Workspace"):GetDescendants()) do
                                                            if (v1 and v1.ClassName == "Model" and v1:FindFirstChildWhichIsA("Humanoid") and v1.Name == plr.Name .. "_c") then
                                                                v1:Destroy();
                                                            end
                                                        end
                                                    end
                                                end)
                                            end
                                        end
                                    end
                                end

                                local died_checked = false;

                                anchor_died_connection = game:GetService("RunService").Heartbeat:Connect(function()
                                    if (died_checked == true) then return end;
                                    died_checked = true;

                                    if (not char or not char:FindFirstChildWhichIsA("Humanoid")) then
                                        notify("Notification", "Stop fake lagging, because you died");
                                        -- wait until respawned
                                        task.wait(game:GetService("Players").RespawnTime + 0.5);
                                        
                                        FakeLagEnabled = false
                                        settings():GetService("NetworkSettings").IncomingReplicationLag = 0
                                        game:GetService("NetworkClient"):SetOutgoingKBPSLimit(math.huge)

                                        -- Remove anchor loop
                                        if (anchor_connection) then
                                            anchor_connection:Disconnect();
                                            anchor_connection = nil;
                                        end

                                        -- Remove character removal checker
                                        if (anchor_died_connection) then
                                            anchor_died_connection:Disconnect();
                                            anchor_died_connection = nil;
                                        end

                                        -- Set camera to main character
                                        for _, v in pairs(game:GetService("Workspace"):GetDescendants()) do
                                            if (v and v.ClassName == "Model" and v:FindFirstChildWhichIsA("Humanoid") and v.Name == plr.Name) then
                                                game:GetService("Workspace").CurrentCamera.CameraSubject = v:FindFirstChildWhichIsA("Humanoid");

                                                -- Make Humanoid setting 
                                                v:FindFirstChildWhichIsA("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.Died, true);

                                                -- Change root anchor state
                                                if (getRoot(v)) then
                                                    getRoot(v).Anchored = false;
                                                end
                                            end
                                        end

                                        -- Fix character
                                        if (char) then
                                            for _, v in pairs(char:GetDescendants()) do
                                                if (v and (v.ClassName == "Part" or v.ClassName == "MeshPart" or v.ClassName == "Decal") and v.Name ~= "HumanoidRootPart") then
                                                    -- Make the player visible
                                                    v.Transparency = 0;

                                                    -- Make character touchable
                                                    noclip(false, char);
                                                end
                                            end
                                        end

                                        -- Destroy fake cloned character
                                        if (plr.Character) then
                                            for _, v in pairs(game:GetService("Workspace"):GetDescendants()) do
                                                if (v and v.ClassName == "Model" and v:FindFirstChildWhichIsA("Humanoid") and v.Name == plr.Name) then
                                                    plr.Character = v;

                                                    if (getRoot(v)) then
                                                        getRoot(v).Anchored = false;
                                                    end
                                                end
                                            end
                                            for _1, v1 in pairs(game:GetService("Workspace"):GetDescendants()) do
                                                if (v1 and v1.ClassName == "Model" and v1:FindFirstChildWhichIsA("Humanoid") and v1.Name == plr.Name .. "_c") then
                                                    v1:Destroy();
                                                end
                                            end
                                        end
                                    end
                                end)

                                repE1 = false;
                            end
                            if FakeLagEnabled == false then
                                break
                            end
                        until FakeLagEnabled == false
                    else
                        execCmd("fakelag 1 1.5");
                    end
               end)
            end
        },
        ["UnFakeLag"] = {
            ["ListName"] = "unflag / UnFakelag",
            ["Description"] = "Turn off fake lag movement",
            ["Aliases"] = {"unflag", "Unfakelag"},
            ["Function"] = function(args, speaker)
                notify("Notification", "Stop fake lagging")
                FakeLagEnabled = false
                settings():GetService("NetworkSettings").IncomingReplicationLag = 0
                game:GetService("NetworkClient"):SetOutgoingKBPSLimit(math.huge)

                -- Remove anchor loop
                if (anchor_connection) then
                    anchor_connection:Disconnect();
                    anchor_connection = nil;
                end

                -- Remove character removal checker
                if (anchor_died_connection) then
                    anchor_died_connection:Disconnect();
                    anchor_died_connection = nil;
                end

                -- Set camera to main character
                for _, v in pairs(game:GetService("Workspace"):GetDescendants()) do
                    if (v and v.ClassName == "Model" and v:FindFirstChildWhichIsA("Humanoid") and v.Name == plr.Name) then
                        game:GetService("Workspace").CurrentCamera.CameraSubject = v:FindFirstChildWhichIsA("Humanoid");

                        -- Make Humanoid setting 
                        v:FindFirstChildWhichIsA("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.Died, true);

                        -- Change root anchor state
                        if (getRoot(v)) then
                            getRoot(v).Anchored = false;
                        end
                    end
                end

                -- Fix character
                if (char) then
                    for _, v in pairs(char:GetDescendants()) do
                        if (v and (v.ClassName == "Part" or v.ClassName == "MeshPart" or v.ClassName == "Decal") and v.Name ~= "HumanoidRootPart") then
                            -- Make the player visible
                            v.Transparency = 0;

                            -- Make character touchable
                            noclip(false, char);
                        end
                    end
                end

                -- Destroy fake cloned character
                if (plr.Character) then
                    for _, v in pairs(game:GetService("Workspace"):GetDescendants()) do
                        if (v and v.ClassName == "Model" and v:FindFirstChildWhichIsA("Humanoid") and v.Name == plr.Name) then
                            plr.Character = v;

                            if (getRoot(v)) then
                                getRoot(v).Anchored = false;
                            end
                        end
                    end
                    for _1, v1 in pairs(game:GetService("Workspace"):GetDescendants()) do
                        if (v1 and v1.ClassName == "Model" and v1:FindFirstChildWhichIsA("Humanoid") and v1.Name == plr.Name .. "_c") then
                            v1:Destroy();
                        end
                    end
                end
            end
        },
        ["ConsoleSpam"] = {
            ["ListName"] = "consolespam / spamconsole / spamserverconsole",
            ["Description"] = "Spam server side console with error",
            ["Aliases"] = {"consolespam", "spamconsole", "spamserverconsole"},
            ["Function"] = function(args, speaker)
                if args[1] then
                    notify("Notification", "This feature will add later!")
                else
                    notify("Notification", "You must write the remote function location")
                end
            end
        },
        ["HeartbeatWalk"] = {
            ["ListName"] = "HeartbeatWalk / hbwalk",
            ["Description"] = "This type of speed bypass some anticheat",
            ["Aliases"] = {"heartbeatWalk", "hbwalk"},
            ["Function"] = function(args, speaker)
                HeartbeatWalk = true
                if args[1] then
                    local tpwalking = true
                    local Speed = tonumber(args[1])
                    local HeartBeatDelay = 0.5
                    local chr = plr.Character
                    local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")

                    repeat task.wait(HeartBeatDelay)
                        if hum.MoveDirection.X ~= 0 and hum.MoveDirection.Z ~= 0 then
                            hum.WalkSpeed = Speed
                            task.wait(HeartBeatDelay)
                            repeat
                                task.wait()
                                hum.WalkSpeed -= 1
                                if hum.WalkSpeed == 10 then
                                    break
                                end
                            until hum.WalkSpeed == 10
                        end
                        if HeartbeatWalk == false then
                            break
                        end
                    until HeartbeatWalk == false
                else
                    local tpwalking = true
                    local Speed = 50
                    local HeartBeatDelay = 0.5
                    local chr = plr.Character
                    local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")

                    repeat task.wait(HeartBeatDelay)
                        if hum.MoveDirection.X ~= 0 and hum.MoveDirection.Z ~= 0 then
                            hum.WalkSpeed = Speed
                            task.wait(HeartBeatDelay)
                            repeat
                                task.wait()
                                hum.WalkSpeed -= 1
                                if hum.WalkSpeed == 10 then
                                    break
                                end
                            until hum.WalkSpeed == 10
                        end
                        if HeartbeatWalk == false then
                            break
                        end
                    until HeartbeatWalk == false
                end
            end
        },
        ["UnHeartbeatWalk"] = {
            ["ListName"] = "UnheartbeatWalk / unhbwalk",
            ["Description"] = "Turn off Heartbeat movement",
            ["Aliases"] = {"unheartbeatwalk", "unhbwalk"},
            ["Function"] = function(args, speaker)
                local chr = plr.Character
                local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
                HeartbeatWalk = false
                task.wait(.5)
                hum.WalkSpeed = 16
            end
        },
        ["Teleportclip"] = {
            ["ListName"] = "Teleportclip / tpclip",
            ["Description"] = "Change your y level its like minecraft vclip command",
            ["Aliases"] = {"teleportclip", "tpclip"},
            ["Function"] = function(args, speaker)
                task.spawn(function()
                    if args[1] and speaker and speaker.Character then
                        local root = getRoot(speaker.Character)
                        root.CFrame = CFrame.new(root.CFrame.X, root.CFrame.Y + tonumber(args[1]), root.CFrame.Z)
                    else
                        notify("Notification", "You must type the y level")
                    end
                end)
            end
        },
        ["AlwaysJump"] = {
            ["ListName"] = "Alwaysjump / repeatjump / rpjump",
            ["Description"] = "Make you jump when walk",
            ["Aliases"] = {"alwaysjump", "repeatjump", "rpjump"},
            ["Function"] = function(args, speaker)
                AlwaysJumpEnabled = true
                local chr = plr.Character
                local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
                repeat task.wait()
                    if hum.FloorMaterial ~= Enum.Material.Air and hum.MoveDirection.X ~= 0 and hum.MoveDirection.Z ~= 0 then
                        hum:ChangeState(Enum.HumanoidStateType.Jumping)
                    end
                    if AlwaysJumpEnabled == false then
                        break
                    end
                until AlwaysJumpEnabled == false
            end
        },
        ["UnAlwaysJump"] = {
            ["ListName"] = "UnAlwaysjump / unrepeatjump / unrpjump",
            ["Description"] = "Turn off AlwaysJump",
            ["Aliases"] = {"unalwaysJump", "unrepeatjump", "unrpjump"},
            ["Function"] = function(args, speaker)
                AlwaysJumpEnabled = false
            end
        },
        ["Timer"] = {
            ["ListName"] = "Timer [TimerSpeed] ",
            ["Description"] = "It like minecraft timer, really fast!",
            ["Aliases"] = {"timer", "timeSpeed"},
            ["Function"] = function(args, speaker)
                local chr = plr.Character
                local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
                if args[1] and not tonumber(args[1]) == 0 then
                    game:GetService("Workspace").Gravity = tonumber(args[1]) * 100
                    hum.WalkSpeed = tonumber(args[1]) * 10
                else
                    if tonumber(args[1]) == 0 then
                        game:GetService("Workspace").Gravity = 196.2
                        hum.WalkSpeed = 16
                    else
                        game:GetService("Workspace").Gravity = 500
                        hum.WalkSpeed = 50
                    end
                end
            end
        },
        ["Betterfling"] = {
            ["ListName"] = "BetterFling / bfling / ffling [plr]",
            ["Description"] = "Fling player you want to!",
            ["Aliases"] = {"BetterFling", "FastFling", "betterfling", "bfling", "fastfling", "ffling"},
            ["Function"] = function(args, speaker)
                local flinging = false
                function Fling(playerfling)
                    for flingcheck, playerflingcheck in pairs(playerfling) do
                        local flingplrcheck = nil
                        if Players:FindFirstChild(playerflingcheck) then
                            flingplrcheck = Players:FindFirstChild(playerflingcheck)
                        else
                            flingplrcheck = nil
                        end
                        if flingplrcheck.Character and speaker.Character then
                            task.spawn(function()
                                if flingplrcheck.Character:FindFirstChildWhichIsA("Humanoid").Sit == true then
                                    notify("Notification", "Can't fling Player in sitting state!")
                                    return
                                elseif getRoot(flingplrcheck.Character).Anchored == true then
                                    notify("Notification", "Can't fling Player is anchored!")
                                    return
                                elseif getTorso(flingplrcheck.Character).CanCollide == false and flingplrcheck.Character:FindFirstChild("Head").CanCollide == false then
                                    notify("Notification", "Can't fling Player has CanCollide off!")
                                    return
                                elseif not getRoot(speaker.Character) then
                                    notify("Notification", "Can't get your Character RootPart!")
                                    return
                                end
                                for _, child in pairs(speaker.Character:GetDescendants()) do
                                    if child:IsA("BasePart") then
                                        child.CustomPhysicalProperties = PhysicalProperties.new(math.huge, math.huge, math.huge)
                                    end
                                end
                                noclip(true)
                                local OldCFrameBeforeRun = getRoot(speaker.Character).CFrame
                                task.wait(.1)
                                local bambam = Instance.new("BodyAngularVelocity")
                                local bambam1 = Instance.new("BodyThrust")
                                local RunLoopTeleport = false
                                bambam.Name = randomString()
                                bambam.Parent = getRoot(speaker.Character)
                                bambam.AngularVelocity = Vector3.new(999999999,999999999,999999999)
                                bambam.MaxTorque = Vector3.new(math.huge,math.huge,math.huge)
                                bambam.P = math.huge
                                bambam1.Parent = getRoot(speaker.Character)
                                bambam1.Force = Vector3.new(999999999, 999999999, 999999999)
                                bambam1.Location = getRoot(speaker.Character).Position
                                bambam1.Name = randomString()
                                local Char = speaker.Character:GetChildren()
                                for i, v in next, Char do
                                    if v:IsA("BasePart") then
                                        v.CanCollide = false
                                        v.Massless = true
                                        v.Velocity = Vector3.new(0, 0, 0)
                                    end
                                end
                                local flingDied = nil
                                flinging = true
                                local function flingDiedF()
                                    execCmd('unfling')
                                end
                                flingDied = Humanoid.Died:Connect(flingDiedF)
    
                                local flingloopteleport = game:GetService("RunService").Heartbeat:Connect(function()
                                    pcall(function()
                                        if RunLoopTeleport == true and flingplrcheck and flingplrcheck.Character then
                                            if bambam1 then
                                                bambam1.Location = getRoot(speaker.Character).Position
                                            end
                                            local flingplrcframe = getRoot(flingplrcheck.Character).CFrame
                                            getRoot(speaker.Character).CFrame = CFrame.new(flingplrcframe.X, flingplrcframe.Y + 1, flingplrcframe.Z)
                                            getRoot(speaker.Character).CFrame = CFrame.new(flingplrcframe.X, flingplrcframe.Y + 1, flingplrcframe.Z)
                                            task.wait(.035)
                                            noclip(true)
                                            getRoot(speaker.Character).CFrame = CFrame.new(flingplrcframe.X + 0.5, flingplrcframe.Y + 1.5, flingplrcframe.Z + 0.5)
                                            noclip(false)
                                            task.wait(.035)
                                            noclip(true)
                                            getRoot(speaker.Character).CFrame = CFrame.new(flingplrcframe.X - 0.5, flingplrcframe.Y - 1.5, flingplrcframe.Z - 0.5)
                                            noclip(false)
                                            task.wait(.035)
                                            getRoot(speaker.Character).CFrame = CFrame.new(flingplrcframe.X + 0.5, flingplrcframe.Y + 1.5, flingplrcframe.Z + 0.5)
                                            task.wait(.035)
                                            getRoot(speaker.Character).CFrame = CFrame.new(flingplrcframe.X - 0.5, flingplrcframe.Y - 1.5, flingplrcframe.Z - 0.5)
                                            task.wait(.035)
                                            getRoot(speaker.Character).CFrame = CFrame.new(flingplrcframe.X + 0.5, flingplrcframe.Y + 1.5, flingplrcframe.Z + 0.5)
                                            task.wait(.035)
                                            getRoot(speaker.Character).CFrame = CFrame.new(flingplrcframe.X - 0.5, flingplrcframe.Y - 1.5, flingplrcframe.Z - 0.5)
                                            task.wait(.035)
                                            getRoot(speaker.Character).CFrame = CFrame.new(flingplrcframe.X + 0.5, flingplrcframe.Y + 1.5, flingplrcframe.Z + 0.5)
                                            task.wait(.035)
                                            getRoot(speaker.Character).CFrame = CFrame.new(flingplrcframe.X + 0.5, flingplrcframe.Y - 1.5, flingplrcframe.Z + 0.5)
                                            task.wait(.035)
                                            getRoot(speaker.Character).CFrame = CFrame.new(flingplrcframe.X, flingplrcframe.Y - 1, flingplrcframe.Z)
                                            getRoot(speaker.Character).CFrame = CFrame.new(flingplrcframe.X, flingplrcframe.Y - 1, flingplrcframe.Z)
                                            getRoot(speaker.Character).CFrame = flingplrcframe.CFrame * flingplrcframe.Velocity/4.
                                            task.wait(.015)
                                            getRoot(speaker.Character).CFrame = flingplrcframe.CFrame * flingplrcframe.Velocity/5.3
                                            task.wait(.015)
                                            getRoot(speaker.Character).CFrame = flingplrcframe.CFrame * flingplrcframe.Velocity/2.3
                                            task.wait(.015)
                                            getRoot(speaker.Character).CFrame = flingplrcframe.CFrame * flingplrcframe.Velocity/4.3
                                        end
                                    end)
                                end)

                                for flinglooprun = 1, 6 do
                                    if not speaker.Character or not getRoot(speaker.Character) then return end
                                    RunLoopTeleport = true
                                    bambam.AngularVelocity = Vector3.new(999999999,999999999,999999999)
                                    bambam1.Force = Vector3.new(999999999, 999999999, 999999999)
                                    if not speaker.Character or not getRoot(speaker.Character) then return end
                                    bambam1.Location = getRoot(speaker.Character).Position
                                    task.wait(.3)
                                    bambam.AngularVelocity = Vector3.new(0,0,0)
                                    bambam1.Force = Vector3.new(0,0,0)
                                    if not speaker.Character or not getRoot(speaker.Character) then return end
                                    bambam1.Location = getRoot(speaker.Character).Position
                                    task.wait(.1)
                                end
    
                                if bambam then
                                    bambam:Destroy()
                                end
                                if bambam1 then
                                    bambam1:Destroy()
                                end
                                if flingDied then
                                    flingDied:Disconnect()
                                end
                                flinging = false
                                RunLoopTeleport = false
                                flingloopteleport:Disconnect()
                                task.wait(.1)
                                local speakerChar = speaker.Character
                                if not speakerChar or not getRoot(speakerChar) then return end
                                for i,v in pairs(getRoot(speakerChar):GetChildren()) do
                                    if v.ClassName == 'BodyAngularVelocity' or v.ClassName == 'BodyThrust' then
                                        v:Destroy()
                                    end
                                end
                                for _, child in pairs(speakerChar:GetDescendants()) do
                                    if child.ClassName == "Part" or child.ClassName == "MeshPart" then
                                        child.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0.3, 0.5)
                                    end
                                end
                                task.wait(.1)
                                if getRoot(speaker.Character) then
                                    RunLoopTeleport = false
                                    flingloopteleport:Disconnect()
                                    if bambam then
                                        bambam:Destroy()
                                    end
                                    if bambam1 then
                                        bambam1:Destroy()
                                    end
                                    local antiflingout_method1 = Instance.new("BodyGyro", getRoot(speaker.Character));
                                    antiflingout_method1.P = 9e4;
                                    antiflingout_method1.maxTorque = Vector3.new(9e9, 9e9, 9e9);
                                    local antiflingout = Instance.new("BodyVelocity")
                                    antiflingout.Parent = getRoot(speaker.Character)
                                    antiflingout.Name = randomString()
                                    antiflingout.MaxForce = Vector3.new(9e9, 9e9, 9e9)
                                    antiflingout.Velocity = Vector3.new(0, -100, 0)
                                    getRoot(speaker.Character).Anchored = true
                                    getRoot(speaker.Character).CFrame = OldCFrameBeforeRun
                                    task.wait(.5)
                                    noclip(false)
                                    getRoot(speaker.Character).Anchored = false
                                    getRoot(speaker.Character).CFrame = OldCFrameBeforeRun
                                    task.wait(.6)
                                    antiflingout.MaxForce = Vector3.new(9e9, 9e9, 9e9)
                                    if antiflingout then
                                        antiflingout:Destroy()
                                    end
                                    getRoot(speaker.Character).CFrame = OldCFrameBeforeRun
                                    task.wait(1)
                                    if (antiflingout_method1) then
                                        antiflingout_method1:Destroy()
                                    end
                                    getRoot(speaker.Character).CFrame = OldCFrameBeforeRun
                                end
                            end)
                        else
                            if flingplrcheck.Character:FindFirstChildWhichIsA("Humanoid").Sit == true then
                                notify("Notification", "Can't fling Player in sitting state!")
                            elseif getRoot(flingplrcheck.Character).Anchored == true then
                                notify("Notification", "Can't fling Player is anchored!")
                            elseif getTorso(flingplrcheck.Character).CanCollide == false and flingplrcheck.Character:FindFirstChild("Head").CanCollide == false then
                                notify("Notification", "Can't fling Player has CanCollide off!")
                            elseif not getRoot(speaker.Character) then
                                notify("Notification", "Can't get your Character RootPart!")
                            end
                        end
                    end
                end
                if args[1] then
                    if tostring(args[1]):lower() == "all" then
                        for allplrscount, allsplrget in pairs(Players:GetChildren()) do
                            Fling(allsplrget.Name)
                        end
                    else
                        if BetterFlingEnabled == true then
                            notify("Notification", "Is Flinging another player")
                        else
                            if getPlayer(args[1], speaker) and getPlayer(args[1], speaker) ~= "" then
                                for something, plrintestget in pairs(getPlayer(args[1], speaker)) do
                                    if plrintestget == speaker.Name then
                                        local bambam = Instance.new("BodyAngularVelocity")
                                        bambam.AngularVelocity = Vector3.new(9999999,9999999,9999999)
                                        bambam.MaxTorque = Vector3.new(math.huge,math.huge,math.huge)
                                        bambam.P = math.huge
                                        bambam1.Parent = getRoot(speaker.Character)
                                    else
                                        Fling(getPlayer(args[1], speaker))
                                    end
                                end
                            end
                        end
                    end
                else
                    notify("Notification", "Invalid player")
                end
            end
        },
        ["BetterInvisiblefling"] = {
            ["ListName"] = "BetterInvisibleFling / BetterInvisFling [plr]",
            ["Description"] = "Fling player you want, but it will be invisible!",
            ["Aliases"] = {"BetterInvisibleFling", "FastInvisibleFling", "betterinvisfling", "betterinvisiblefling", "fastinvisiblefling", "fastinvisfling", "fvfling"},
            ["Function"] = function(args, speaker)
                if args[1] then
                    local ch = speaker.Character
                    local prt=Instance.new("Model")
                    prt.Parent = speaker.Character
                    local z1 = Instance.new("Part")
                    z1.Name="Torso"
                    z1.CanCollide = false
                    z1.Anchored = true
                    local z2 = Instance.new("Part")
                    z2.Name="Head"
                    z2.Parent = prt
                    z2.Anchored = true
                    z2.CanCollide = false
                    local z3 =Instance.new("Humanoid")
                    z3.Name="Humanoid"
                    z3.Parent = prt
                    z1.Position = Vector3.new(0,9999,0)
                    speaker.Character=prt
                    task.wait(.1)
                    speaker.Character=ch
                    task.wait(.1)
                    local Hum = Instance.new("Humanoid")
                    z2:Clone()
                    Hum.Parent = speaker.Character
                    local root =  getRoot(speaker.Character)
                    for i,v in pairs(speaker.Character:GetChildren()) do
                        if v ~= root and  v.Name ~= "Humanoid" then
                            v:Destroy()
                        end
                    end
                    root.Transparency = 0
                    root.Color = Color3.new(1, 1, 1)
                    local invisflingStepped
                    invisflingStepped = RunService.Stepped:Connect(function()
                        if speaker.Character and getRoot(speaker.Character) then
                            getRoot(speaker.Character).CanCollide = false
                            execCmd('loopgoto ' .. tostring(args[1]) .. " 0 0.5")
                            task.wait(.01)
                            execCmd('unloopgoto')
                        else
                            invisflingStepped:Disconnect()
                        end
                    end)
                    execCmd('fly')
                    noclip(true)
                    workspace.CurrentCamera.CameraSubject = root
                    local bambam = Instance.new("BodyThrust")
                    bambam.Parent = getRoot(speaker.Character)
                    bambam.Force = Vector3.new(99999,99999*10,99999)
                    bambam.Location = getRoot(speaker.Character).Position
                    task.wait(.1)
                    task.wait(2)
                    respawn(speaker)
                end
            end
        },
        ["ForceGiveTool"] = {
            ["ListName"] = "ForceGiveTool / fgivetool / bettergive / bgive",
            ["Description"] = "Remove your humanoid to forcegivetool player",
            ["Aliases"] = {"forcegiveTool", "fgivetool"},
            ["Function"] = function(args, speaker)
                if speaker and speaker.Character and speaker.Character:FindFirstChildWhichIsA("Humanoid") and args[1] and args[2] then
                    local GetGiveToolPlayer = getPlayer(tostring(args[1]))
                    local ToolGive = tostring(args[2])

                    if (GetGiveToolPlayer == nil) then return notify("Notification", "Please type a valid player.") end;
                    if (ToolGive == nil) then return notify("Notification", "Please type a valid tool and make sure the tool have handle.") end;

                    if (char:FindFirstChildWhichIsA("Humanoid")) then
                        if (not char) then return notify("Notification", "Character not found") end;
                        if (char:FindFirstChild(ToolGive) and plr.Backpack:FindFirstChild(ToolGive)) then return notify("Notification", "Tool given not found / not exist") end;

                        if (plr.Backpack:FindFirstChild(ToolGive)) then
                            if (not char) then return notify("Notification", "Character not found") end;
                            plr.Backpack:FindFirstChild(ToolGive).Parent = char;
                        end

                        char:FindFirstChildWhichIsA("Humanoid"):Destroy();

                            if (GetGiveToolPlayer == nil) then return notify("Notification", "Please type a valid player.") end;

                            if (GetGiveToolPlayer.Character) then
                                local givenChar = GetGiveToolPlayer.Character;

                                if (givenChar:FindFirstChild("HumanoidRootPart")) then
                                    if (char:FindFirstChild("HumanoidRootPart")) then
                                        local oldCframe = char:FindFirstChild("HumanoidRootPart").CFrame;

                                        local loopHeartbeat = game:GetService("RunService").Heartbeat:Connect(function()
                                            char:FindFirstChild("HumanoidRootPart").CFrame = givenChar:FindFirstChild("HumanoidRootPart").CFrame * CFrame.new(0, 0, -.5);
                                        end)

                                        task.wait(2)
                                        
                                        loopHeartbeat:Disconnect();
                                        loopHeartbeat = nil;

                                        repeat task.wait() until not char;
                                        char = plr.Character or plr.CharacterAdded;

                                        if (char:FindFirstChild("HumanoidRootPart")) then
                                            char:FindFirstChild("HumanoidRootPart").CFrame = oldCframe;
                                        end
                                    else
                                        notify("Notification", "You must have a HumanoidRootPart to give player tool")
                                    end
                                else
                                    notify("Notification", "HumanoidRootPart of the given player is not exist");
                                end
                            else
                                return notify("Notification", "The player given doesn't have a valid character");
                            end
                    else
                        return notify("Notification", "No humanoid found in your character")
                    end
                end
            end
        },
        ["BetterFloat"] = {
            ["ListName"] = "BetterFloat / BFloat [speed]",
            ["Description"] = "Fix Infinite yield Float",
            ["Aliases"] = {"betterfloat", "bfloat"},
            ["Function"] = function(args, speaker)
                FloatEnabled = true
                if args[1] then
                    execCmd('tpwalk ' .. tostring((tonumber(args[1]) / 100)))
                end
                local floatName = "Fly"
                local Tpwalkspeed = 50
                local Float = Instance.new("Part", plr.Character)
                Float.Name = floatName
                Float.Transparency = 1
                Float.Size = Vector3.new(2,0.2,1.5)
                Float.Anchored = true
                local FloatValue = -3.1
                local BodyVelocityValue = 0
                Float.CFrame = getRoot(plr.Character).CFrame * CFrame.new(0, FloatValue, 0)
                local BodyVelocity = Instance.new("BodyVelocity")
                BodyVelocity.Parent = getRoot(plr.Character)
                BodyVelocity.MaxForce = Vector3.new(500, 500, 500)
                BodyVelocity.Name = "Body"
                flyloop = game:GetService("RunService").Heartbeat:Connect(function()
                    if Float then
                        Float.CFrame = getRoot(plr.Character).CFrame * CFrame.new(0, FloatValue, 0)
                        BodyVelocity.Velocity = Vector3.new(plr.Character:FindFirstChild("Humanoid").MoveDirection.X * 1000, 0, plr.Character:FindFirstChild("Humanoid").MoveDirection.Z * 1000)
                    else
                        if plr.Character and getRoot(plr.Character) then
                            local Float1 = Instance.new("Part", plr.Character)
                            Float1.Name = floatName
                            Float1.Transparency = 1
                            Float1.Size = Vector3.new(2,0.2,1.5)
                            Float1.Anchored = true
                            local FloatValue = -3.1
                            Float1.CFrame = getRoot(plr.Character).CFrame * CFrame.new(0, FloatValue, 0)
                        end
                    end
                end)
                task.spawn(function()
                    userinputget1 = uis.InputBegan:Connect(function(key)
                        if FloatEnabled == true then
                            if key.KeyCode == Enum.KeyCode.LeftShift then
                                FloatValue -= 0.5
                                BodyVelocityValue -= 1
                            end
                        end
                    end)

                    userinputget2 = uis.InputEnded:Connect(function(key)
                        if FloatEnabled == true then
                            if key.KeyCode == Enum.KeyCode.LeftShift then
                                FloatValue += 0.5
                                BodyVelocityValue += 1
                            end
                        end
                    end)
                end)
            end
        },
        ["UnBetterFloat"] = {
            ["ListName"] = "UnbetterFloat / UnBFloat",
            ["Description"] = "Fix Infinite yield Float",
            ["Aliases"] = {"unbetterfloat", "unbfloat"},
            ["Function"] = function(args, speaker)
                FloatEnabled = false
                execCmd('tpwalk 0')
                execCmd('untpwalk')
                if plr.Character:FindFirstChild("Fly") then
                    plr.Character:FindFirstChild("Fly"):Destroy()
                end
        
                if flyloop then
                    flyloop:Disconnect()
                end

                if userinputget1 then
                    userinputget1:Disconnect()
                end
        
                if userinputget2 then
                    userinputget2:Disconnect()
                end
            end
        },
        ["SlowFloat"] = {
            ["ListName"] = "SlowFloat / FreezeFloat / SFloat",
            ["Description"] = "Make you walk in air but slow so it will bypass anticheat",
            ["Aliases"] = {"slowfloat", "freezefloat", "sfloat"},
            ["Function"] = function(args, speaker)
                if args[1] and tonumber(args[1]) ~= nil then
                    SlowFloatEnabled = true
                    local floatName = "Float"
                    local Tpwalkspeed = 50
                    local Float = Instance.new("Part", speaker.Character)
                        Float.Name = floatName
                        Float.Transparency = 1
                        Float.Size = Vector3.new(2,0.2,1.5)
                        Float.Anchored = true
                        local FloatValue = -3.1
                        Float.CFrame = getRoot(speaker.Character).CFrame * CFrame.new(0, FloatValue, 0)
                        execCmd('HeartbeatWalk ' .. tonumber(args[1]))
                        game:GetService("RunService").Heartbeat:Connect(function()
                            Float.CFrame = getRoot(speaker.Character).CFrame * CFrame.new(0, FloatValue, 0)
                            if SlowFloatEnabled == false then
                                Float:Destroy()
                            end
                        end)
                    task.spawn(function()
                        uis.InputBegan:Connect(function(key)
                            if key.KeyCode == Enum.KeyCode.LeftShift then
                                FloatValue -= 0.5
                            end
                        end)

                        uis.InputEnded:Connect(function(key)
                            if key.KeyCode == Enum.KeyCode.LeftShift then
                                FloatValue += 0.5
                            end
                        end)
                    end)
                else
                    SlowFloatEnabled = true
                    local uis = game:GetService("UserInputService")
                    local floatName = "Float"
                    local Tpwalkspeed = 50
                    local Float = Instance.new("Part", speaker.Character)
                        Float.Name = floatName
                        Float.Transparency = 1
                        Float.Size = Vector3.new(2,0.2,1.5)
                        Float.Anchored = true
                        local FloatValue = -3.1
                        Float.CFrame = getRoot(speaker.Character).CFrame * CFrame.new(0, FloatValue, 0)
                        execCmd('HeartbeatWalk 50')
                        game:GetService("RunService").Heartbeat:Connect(function()
                            Float.CFrame = getRoot(speaker.Character).CFrame * CFrame.new(0, FloatValue, 0)
                            if SlowFloatEnabled == false then
                                Float:Destroy()
                            end
                        end)
                    task.spawn(function()
                        uis.InputBegan:Connect(function(key)
                            if key.KeyCode == Enum.KeyCode.LeftShift then
                                FloatValue -= 0.5
                            end
                        end)

                        uis.InputEnded:Connect(function(key)
                            if key.KeyCode == Enum.KeyCode.LeftShift then
                                FloatValue += 0.5
                            end
                        end)
                    end)
                end
            end
        },
        ["UnSlowFloat"] = {
            ["ListName"] = "UnSlowFloat / UnFreezeFloat / UnSFloat",
            ["Description"] = "Make you float slowly bypass some anti cheat",
            ["Aliases"] = {"unslowFloat", "unfreezeFloat", "unsfloat"},
            ["Function"] = function(args, speaker)
                SlowFloatEnabled = false
                execCmd('unheartbeatwalk')
            end
        },
        ["AutoReport"] = {
            ["ListName"] = "AutoReport / Autorep",
            ["Description"] = "Report someone say bad words",
            ["Aliases"] = {"AutoReport", "Autorep", "autoreport", "autorep"},
            ["Function"] = function(args, speaker)
                
                if AutoReportEnabled == false then
                    AutoReportEnabled = true
                    notify("Notification", "Autoreport turned on!")
                    ReportConnection = game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents"):FindFirstChild("OnMessageDoneFiltering").OnClientEvent:Connect(function(tab, channel)
                        local plrreportget = Players:FindFirstChild(tab["FromSpeaker"])
                        local args = tab.Message:split(" ")
                        if AutoReportEnabled == true and plrreportget and plrreportget ~= plr then
                            local reportreason, reportedmatch = findreport(tab.Message)
                            if reportreason then 
                                if alreadyreported[plr] == nil then
                                    task.spawn(function()
                                        if syn == nil then
                                            Players:ReportAbuse(plrreportget, reportreason, "he said a bad word")
                                        end
                                    end)
                                    notify("AutoReport", "Reported "..plrreportget.Name.." for "..reportreason..' ('..reportedmatch..')')
                                    table.insert(alreadyreported, alreadyreported[plr])
                                    alreadyreported[plrreportget] = true
                                end
                            end
                        end
                    end)
                else
                    notify("Notification", "Autoreport already turned on!")
                end
            end
        },
        ["UnAutoReport"] = {
            ["ListName"] = "UnAutoReport / UnAutorep",
            ["Description"] = "Turn off AutoReport, it will not report and send notify",
            ["Aliases"] = {"UnAutoReport", "UnAutorep", "unautoreport", "unautorep"},
            ["Function"] = function(args, speaker)
                if AutoReportEnabled == true then
                    AutoReportEnabled = false
                    notify("Notification", "Autoreport turned off!")
                    if ReportConnection then
                        ReportConnection:Disconnect()
                    end
                else
                    notify("Notification", "Autoreport already turned off!")
                end
            end
        },
        ["HackerDetector"] = {
            ["ListName"] = "HackerDetector",
            ["Description"] = "Detect Cheater or Hacker Classic Type!",
            ["Aliases"] = {"HackerDetector", "hackerdetector"},
            ["Function"] = function(args, speaker)
                if args[1] then
                    if args[1]:lower() == "true" or tostring(args[1]):lower() == "on" then
                        if HackerDetectorEnabled == false then
                            HackerDetectorEnabled = true
                            notify("Notification", "HackerDetector is On")
                            HackerDetectorConnection = game:GetService("RunService").Stepped:Connect(function(time, deltaTime)
                                task.spawn(function()
                                    if HackerDetectorEnabled == true then
                                        for plrcount, allplrs in pairs(game:GetService("Players"):GetPlayers()) do
                                            local allchars = allplrs.Character or allplrs.CharacterAdded
                                            if allplrs ~= game:GetService("Players").LocalPlayer then
                                                if allchars and getRoot(allchars) and allchars:FindFirstChildWhichIsA("Humanoid") then
                                                    task.spawn(function()
                                                        local AnotherHumanoidRootPart = getRoot(allchars)
                                                        local OldPos = AnotherHumanoidRootPart.Position
                                                        task.wait(.5)
                                                        local NewPos = AnotherHumanoidRootPart.Position
                                                        if (NewPos - OldPos).Magnitude > (Humanoid.WalkSpeed + 15) and allchars:FindFirstChildWhichIsA("Humanoid").Sit == false and not allchars:FindFirstChildWhichIsA("ForceField") then
                                                            notify("HackerDetector", "User: " .. tostring(allplrs.Name) .. ", Display: " .. tostring(allplrs.DisplayName) .. "\n Speed, Teleport Cheating, Type: MagnitudeDetect")
                                                            
                                                            if (args[2]) then
                                                                if (args[2] == "true" or args[2] == "on") then
                                                                    Players:ReportAbuse(plrreportget, reportreason, "he keep using SPEED and TELEPORT everywhere to KILL everyone in the game")
                                                                end
                                                            end
                                                        end
                                                    end)
                                                end
                            
                                                if allchars:FindFirstChildWhichIsA("Humanoid") then
                                                    if allchars:WaitForChild("Humanoid").PlatformStand == true then
                                                        notify("HackerDetector", "User: " .. tostring(allplrs.Name) .. ", Display: " .. tostring(allplrs.DisplayName) .. "\n Fly Cheating, Type: FlatformStanding")
                                                        Players:ReportAbuse(plrreportget, reportreason, "he's FLYING arround the game, and something FLING me")

                                                        if (args[2]) then
                                                            if (args[2] == "true" or args[2] == "on") then
                                                                Players:ReportAbuse(plrreportget, reportreason, "he's FLYING arround the game, and something FLING me")
                                                            end
                                                        end
                                                    end
                                                end

                                               --[[
                                                 if allchars:FindFirstChild("Torso") or allchars:FindFirstChild("UpperTorso") then
                                                    if allchars:FindFirstChild("Torso") and allchars:FindFirstChild("Torso").CanCollide == false and allchars:FindFirstChild("Torso").CollisionGroupId == 0 and not allchars:FindFirstChild("UpperTorso") then
                                                        notify("HackerDetector", "User: " .. tostring(allplrs.Name) .. ", Display: " .. tostring(allplrs.DisplayName) .. "\n Noclip, Type: CanCollide")
                                                        Players:ReportAbuse(plrreportget, reportreason, "he's HACKING and KILL everyone in the game")
                                                        if (args[2]) then
                                                            if (args[2] == "true" or args[2] == "on") then
                                                                Players:ReportAbuse(plrreportget, reportreason, "he's HACKING and KILL everyone in the game")
                                                            end
                                                        end
                                                    elseif not allchars:FindFirstChild("Torso") and allchars:FindFirstChild("UpperTorso") and allchars:FindFirstChild("UpperTorso").CanCollide == false and allchars:FindFirstChild("UpperTorso").CollisionGroupId == 0 then
                                                        notify("HackerDetector", "User: " .. tostring(allplrs.Name) .. ", Display: " .. tostring(allplrs.DisplayName) .. "\n Noclip, Type: CanCollide")
                                                        if (args[2]) then
                                                            if (args[2] == "true" or args[2] == "on") then
                                                                Players:ReportAbuse(plrreportget, reportreason, "he's HACKING and KILL everyone in the game")
                                                            end
                                                        end
                                                    end
                                                end
                                                --]]
                                            end
                                        end
                                        task.wait(.1)
                                    end
                               end)
                            end)
                        else
                            notify("Notification", "It already turned on")
                        end
                    elseif args[1]:lower() == "false" or tostring(args[1]):lower() == "off" then
                        if HackerDetectorEnabled == true then
                            notify("Notification", "HackerDetector is Off")
                            HackerDetectorEnabled = false
                            if HackerDetectorConnection then
                                HackerDetectorConnection:Disconnect()
                            end
                        else
                            notify("Notification", "It already turned off")
                        end
                    end
                else
                    notify("Notification", "You must set status like HackerDetector mode: ['on/off' or 'true/false']; Report player: ['on/off' or 'true/false']")
                end
            end
        },
        ["BetterGodMode"] = {
            ["ListName"] = "BetterGodMode / BGodmode [on/off]",
            ["Description"] = "Make you turn into god!",
            ["Aliases"] = {"BetterGodMode", "BGodmode", "bettergodMode", "bgodmode", "bgod"},
            ["Function"] = function(args, speaker)
                if args[1] then
                    if tostring(args[1]):lower() == "on" then
                        if BetterGodModeEnabled == false then
                            BetterGodModeEnabled = true
                            local sureRagdoll = false;
                            notify("Notification", "You are god now!")
                            if speaker.Character and speaker.Character:FindFirstChildWhichIsA("Humanoid") then
                                BetterGodModeConnection = game:GetService("RunService").RenderStepped:Connect(function()
                                    if speaker.Character:FindFirstChildWhichIsA("Humanoid") then
                                        speaker.Character:FindFirstChildWhichIsA("Humanoid").BreakJointsOnDeath = false
                                        speaker.Character:FindFirstChildWhichIsA("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.Dead, false)
                                        if speaker.Character:FindFirstChildWhichIsA("Humanoid").Health <= 0 then
                                            speaker.Character:FindFirstChildWhichIsA("Humanoid").BreakJointsOnDeath = false
                                            speaker.Character:FindFirstChildWhichIsA("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.Dead, false)
                                            speaker.Character:FindFirstChildWhichIsA("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.PlatformStanding, true)
                                            speaker.Character:FindFirstChildWhichIsA("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
                                            if BetterGodModeRespawnCheck == false then
                                                BetterGodModeRespawnCheck = true
                                                local oldrespawnpos = speaker.Character:GetPivot()
                                                local oldcameracframe = game:GetService("Workspace").CurrentCamera.CFrame
                                                task.wait(game:GetService("Players").RespawnTime - 0.05)
                                                oldrespawnpos = speaker.Character:GetPivot()
                                                oldcameracframe = game:GetService("Workspace").CurrentCamera.CFrame
                                                task.wait(0.1)
                                                speaker.Character:FindFirstChildWhichIsA("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
                                                task.wait(0.1)
                                                repeat task.wait() until speaker.Character and game:GetService("Workspace").CurrentCamera
                                                speaker.Character:PivotTo(oldrespawnpos)
                                                speaker.Character:FindFirstChildWhichIsA("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
                                                speaker.Character:FindFirstChildWhichIsA("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
                                                speaker.Character:PivotTo(oldrespawnpos)
                                                local anti_ragdoll = Instance.new("BodyGyro");
                                                if (speaker.Character and speaker.Character:FindFirstChild("HumanoidRootPart")) then
                                                    anti_ragdoll.P = 9e4;
                                                    anti_ragdoll.maxTorque = Vector3.new(9e9, 9e9, 9e9);
                                                    anti_ragdoll.Parent = speaker.Character:FindFirstChild("HumanoidRootPart")
                                                end
                                                if (speaker.Character and speaker.Character:FindFirstChild("HumanoidRootPart")) then
                                                    speaker.Character:FindFirstChild("HumanoidRootPart").Position = speaker.Character:FindFirstChild("HumanoidRootPart").Position
                                                end
                                                game:GetService("Workspace").CurrentCamera.CFrame = oldcameracframe
                                                speaker.Character:PivotTo(oldrespawnpos)
                                                if (speaker.Character and speaker.Character:FindFirstChild("HumanoidRootPart")) then
                                                    speaker.Character:FindFirstChild("HumanoidRootPart").Position = speaker.Character:FindFirstChild("HumanoidRootPart").Position
                                                end
                                                game:GetService("Workspace").CurrentCamera.CFrame = oldcameracframe
                                                if (anti_ragdoll) then
                                                    anti_ragdoll:Destroy();
                                                end
                                                speaker.Character:FindFirstChildWhichIsA("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
                                                speaker.Character:FindFirstChildWhichIsA("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.PlatformStanding, false)
                                                speaker.Character:FindFirstChildWhichIsA("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
                                                speaker.Character:FindFirstChildWhichIsA("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.Ragdoll, true)
                                                task.wait(.8)
                                                if (speaker and speaker.Character and speaker.Character:FindFirstChildWhichIsA("Humanoid")) then
                                                    speaker.Character:FindFirstChildWhichIsA("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
                                                    speaker.Character:FindFirstChildWhichIsA("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
                                                    speaker.Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping);
                                                end
                                                speaker.Character:PivotTo(oldrespawnpos)
                                                local anti_ragdoll = Instance.new("BodyGyro");
                                                if (speaker.Character and speaker.Character:FindFirstChild("HumanoidRootPart")) then
                                                    anti_ragdoll.P = 9e4;
                                                    anti_ragdoll.maxTorque = Vector3.new(9e9, 9e9, 9e9);
                                                    anti_ragdoll.Parent = speaker.Character:FindFirstChild("HumanoidRootPart")
                                                end
                                                if (speaker.Character and speaker.Character:FindFirstChild("HumanoidRootPart")) then
                                                    speaker.Character:FindFirstChild("HumanoidRootPart").Position = speaker.Character:FindFirstChild("HumanoidRootPart").Position
                                                end
                                                game:GetService("Workspace").CurrentCamera.CFrame = oldcameracframe
                                                speaker.Character:PivotTo(oldrespawnpos)
                                                if (speaker.Character and speaker.Character:FindFirstChild("HumanoidRootPart")) then
                                                    speaker.Character:FindFirstChild("HumanoidRootPart").Position = speaker.Character:FindFirstChild("HumanoidRootPart").Position
                                                end
                                                game:GetService("Workspace").CurrentCamera.CFrame = oldcameracframe
                                                if (anti_ragdoll) then
                                                    anti_ragdoll:Destroy();
                                                end
                                                speaker.Character:FindFirstChildWhichIsA("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
                                                speaker.Character:FindFirstChildWhichIsA("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.PlatformStanding, false)
                                                speaker.Character:FindFirstChildWhichIsA("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
                                                speaker.Character:FindFirstChildWhichIsA("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.Ragdoll, true)
                                                BetterGodModeRespawnCheck = false
                                            end
                                        end
                                    end
                                end)
                            end
                        else
                            notify("Notification", "BetterGodMode already turned on!")
                        end
                    elseif tostring(args[1]):lower() == "off" then
                        if BetterGodModeEnabled == true then
                            if BetterGodModeConnection then
                                notify("Notification", "You turned off god mode")
                                BetterGodModeConnection:Disconnect()
                            end
                        else
                            notify("Notification", "BetterGodMode already turned off!")
                        end
                    end
                else
                    notify("Notification", "You must set status for BetterGodMode [on/off]")
                end
            end
        },
        ["FlyTeleport"] = {
            ["ListName"] = "FlyTeleport / Flytp [speed]",
            ["Description"] = "Make you freeze and will teleport you after fly",
            ["Aliases"] = {"FlyTeleport", "Flytp", "flyteleport", "flytp"},
            ["Function"] = function(args, speaker)
                if speaker.Character and speaker.Character:FindFirstChild("Head") then
                    local Head = speaker.Character:FindFirstChild("Head")
                    Head.Anchored = true
                    if args[1] then
                        execCmd("cfly " .. tostring(args[1]))
                    else
                        execCmd("cfly 20")
                    end
                end
            end
        },
        ["UnFlyTeleport"] = {
            ["ListName"] = "UnFlyTeleport / UnFlytp [speed]",
            ["Description"] = "Make you freeze and will teleport you after fly",
            ["Aliases"] = {"UnFlyTeleport", "UnFlytp", "unflyteleport", "unflytp"},
            ["Function"] = function(args, speaker)
                if speaker.Character and speaker.Character:FindFirstChild("Head") then
                    local Head = speaker.Character:FindFirstChild("Head")
                    Head.Anchored = false
                    execCmd("uncfly")
                    execCmd("tpwalk 0")
                    execCmd("untpwalk")
                end
            end
        },
        ["boxReach"] = {
            ["ListName"] = "boxReach [status:on/off]",
            ["Description"] = "Make sure you have roblox tool on, and have handle (like sword), Make tool hit everyone in the workspace",
            ["Aliases"] = {"boxReach"},
            ["Function"] = function(args, speaker) -- I get the idea from CMDx | their github: https://github.com/CMD-X/CMD-X
                if (args and args[1] and tostring(args[1])) then
                    if (tostring(args[1]):lower() == "on") then
                        if (infAuraEnabled == true) then notify("Notification", "infAura already enabled/turned on. You must turn off to use") ; return ; end;
                        if (boxReachEnabled == true) then notify("Notification", "boxReach already enabled/turned on.") ; return ; end;
                        boxReachEnabled = true;

                        if (speaker and speaker:FindFirstChildWhichIsA("Backpack") and speaker.Character) then
                            if (not speaker.Character:FindFirstChildWhichIsA("Tool")) then
                                notify("Notification", "You must have a roblox tool in your character.")
                                return; -- stop here because player don't have any tool in character
                            else
                                for _, v in pairs(speaker.Character:GetDescendants()) do
                                    if (v:IsA("Tool") and v:FindFirstChild("Handle")) then
                                        -- If the tool configuration exist, then do nothing
                                        if (v:FindFirstChild("_toolSize_save_") and v:FindFirstChild("_toolGrip_save")) then
                                            pcall(function()
                                                v:FindFirstChild("_toolSize_save_box"):Destroy();
                                            end)
                                            pcall(function()
                                                v:FindFirstChild("_toolGrip_saveBox"):Destroy();
                                            end)
                                        end

                                        -- Save the tool size
                                        local saveValue = Instance.new("Vector3Value");
                                        local grip_saveValue = Instance.new("Vector3Value");

                                        saveValue.Name = "_toolSize_save_box";
                                        saveValue.Value = v:FindFirstChild("Handle").Size;

                                        grip_saveValue.Name = "_toolGrip_saveBox";
                                        grip_saveValue.Value = v.GripPos;

                                        -- Set the tool save position
                                        saveValue.Parent = v;
                                        grip_saveValue.Parent = v;

                                        -- Start cheating
                                        v.Handle.Massless = true;
                                        v.Handle.Size = Vector3.new(2^63-1, 2^63-1, 2^63-1);
                                        v.GripPos = Vector3.new(0, 0, 0);

                                        if (not speaker or not speaker:FindFirstChildWhichIsA("Backpack") or not speaker.Character) then return end; -- prevent another script affect the main script
                                        v.Parent = speaker:FindFirstChildWhichIsA("Backpack");
                                        v.Parent = speaker.Character;
                                    end
                                end

                                -- Success, now ready
                                notify("Notification", "boxReach enabled.")
                            end
                        end
                    elseif (tostring(args[1]):lower() == "off") then
                        if (infAuraEnabled == true) then notify("Notification", "infAura already enabled/turned on. You must turn off to use") ; return ; end;
                        if (boxReachEnabled == false) then notify("Notification", "boxReach already enabled/turned on.") ; return ; end;
                        boxReachEnabled = false;

                        if (speaker and speaker:FindFirstChildWhichIsA("Backpack") and speaker.Character) then
                            if (speaker:FindFirstChildWhichIsA("Backpack"):FindFirstChildWhichIsA("Tool")) then
                                for _, v in pairs(speaker:FindFirstChildWhichIsA("Backpack"):GetDescendants()) do
                                    pcall(function()
                                        if (v:IsA("Tool")) then
                                            if (v:FindFirstChild("_toolSize_save_box") and v:FindFirstChild("_toolSize_save_").ClassName == "Vector3Value" and v:FindFirstChild("_toolGrip_save") and v:FindFirstChild("_toolGrip_save").ClassName == "Vector3Value") then
                                                -- Set to the original value
                                                v.Handle.Size = v:FindFirstChild("_toolSize_save_box").Value;
                                                v.GripPos = v:FindFirstChild("_toolGrip_saveBox").Value;

                                                -- Delete the saved value
                                                pcall(function()
                                                    if (v:FindFirstChild("_toolSize_save_box")) then
                                                        v:FindFirstChild("_toolSize_save_box"):Destroy();
                                                    end
                                                end)

                                                pcall(function()
                                                    if (v:FindFirstChild("_toolGrip_saveBox")) then
                                                        v:FindFirstChild("_toolGrip_saveBox"):Destroy();
                                                    end
                                                end)
                                            end
                                        end
                                    end)
                                end
                            end
                            if (speaker.Character:FindFirstChildWhichIsA("Tool")) then
                                for _, v in pairs(speaker.Character:GetDescendants()) do
                                    pcall(function()
                                        if (v:IsA("Tool")) then
                                            if (v:FindFirstChild("_toolSize_save_") and v:FindFirstChild("_toolSize_save_").ClassName == "Vector3Value" and v:FindFirstChild("_toolGrip_save") and v:FindFirstChild("_toolGrip_save").ClassName == "Vector3Value") then
                                                -- Set to the original value
                                                v.Handle.Size = v:FindFirstChild("_toolSize_save_").Value;
                                                v.GripPos = v:FindFirstChild("_toolGrip_save").Value;

                                                -- Delete the saved value
                                                pcall(function()
                                                    if (v:FindFirstChild("_toolSize_save_box")) then
                                                        v:FindFirstChild("_toolSize_save_box"):Destroy();
                                                    end
                                                end)

                                                pcall(function()
                                                    if (v:FindFirstChild("_toolGrip_saveBox")) then
                                                        v:FindFirstChild("_toolGrip_saveBox"):Destroy();
                                                    end
                                                end)
                                            end
                                        end
                                    end)
                                end
                            end

                            -- Success
                            notify("Notification", "boxreach disabled.")
                        end
                    elseif (tostring(args[1]):lower() ~= "off" and tostring(args[1]):lower() ~= "on") then
                        notify("Notification", "the status must be `on` or `off`")
                    end
                else
                    notify("Notification", "Missing arguments.")
                end
            end
        },
        ["infAura"] = {
            ["ListName"] = "infAura [status:on/off] [distance:number] [team:boolean true/false]",
            ["Description"] = "Make sure you have roblox tool on, and have handle (like sword), teleport + boxreach",
            ["Aliases"] = {"infAura"},
            ["Function"] = function(args, speaker) -- I get the idea from CMDx | their github: https://github.com/CMD-X/CMD-X
                if (args and args[1] and tostring(args[1])) then
                    if (tostring(args[1]):lower() == "on") then
                        if (not args[2] or not tonumber(args[2]) or not args[3] or not tostring(args[3])) then return end;
                        if (boxReachEnabled == true) then notify("Notification", "infAura already enabled/turned on off. You must turn off to use") ; return ; end;
                        if (infAuraEnabled == true) then notify("Notification", "infAura already enabled/turned on") ; return ; end;
                        infAuraEnabled = true;

                        if (speaker and speaker:FindFirstChildWhichIsA("Backpack") and speaker.Character) then
                            if (not speaker.Character:FindFirstChildWhichIsA("Tool")) then
                                notify("Notification", "You must have a roblox tool in your character.")
                                return; -- stop here because player don't have any tool in character
                            else
                                for _, v in pairs(speaker.Character:GetDescendants()) do
                                    if (v:IsA("Tool") and v:FindFirstChild("Handle")) then
                                        -- If the tool configuration exist, then do nothing
                                        if (v:FindFirstChild("_toolSize_save_") and v:FindFirstChild("_toolGrip_save")) then
                                            pcall(function()
                                                v:FindFirstChild("_toolSize_save_"):Destroy();
                                            end)
                                            pcall(function()
                                                v:FindFirstChild("_toolGrip_save"):Destroy();
                                            end)
                                        end

                                        -- Save the tool size
                                        local saveValue = Instance.new("Vector3Value");
                                        local grip_saveValue = Instance.new("Vector3Value");

                                        saveValue.Name = "_toolSize_save_";
                                        saveValue.Value = v:FindFirstChild("Handle").Size;

                                        grip_saveValue.Name = "_toolGrip_save";
                                        grip_saveValue.Value = v.GripPos;

                                        -- Set the tool save position
                                        saveValue.Parent = v;
                                        grip_saveValue.Parent = v;

                                        -- Start cheating
                                        v.Handle.Massless = true;
                                        v.Handle.Size = Vector3.new(10, 10, 10);
                                        v.GripPos = Vector3.new(0, 0, 0);

                                        -- Hit detecting
                                        local remove_hitDetecting = nil;
                                        remove_hitDetecting = v.Activated:Connect(function()
                                            if (v and v:FindFirstChild("_toolSize_save_") and v:FindFirstChild("_toolGrip_save")) then
                                                -- Make sure the owner is the main player
                                                if (v and v.Parent and game:GetService("Players"):GetPlayerFromCharacter(v.Parent) and game:GetService("Players"):GetPlayerFromCharacter(v.Parent) == game:GetService("Players").LocalPlayer) then
                                                    local neartestPlayer_ = nearestPlayer(tonumber(args[2]));
                                                    repeat task.wait() until neartestPlayer_;
                                                    
                                                    if (neartestPlayer_["error"]) then return end;

                                                    task.spawn(function()
                                                        local old_hitCFrame = CFrame.new(0, 0, 0);

                                                        if (char and getRoot(char)) then
                                                            old_hitCFrame = getRoot(char).CFrame;
                                                        end

                                                        if (tostring(args[3]) == "on" or tostring(args[3]) == "true") then
                                                            if (char and getRoot(char) and neartestPlayer_["player"] and neartestPlayer_["part"]) then
                                                                getRoot(char).CFrame = neartestPlayer_["part"].CFrame * CFrame.new(math.random(1.45, 1.7), 0, math.random(1.45, 1.7));
                                                            end
                                                        elseif (tostring(args[3]) == "off" or tostring(args[3]) == "false") then
                                                            if (char and getRoot(char) and neartestPlayer_["player"] and neartestPlayer_["player"].Team and neartestPlayer_["player"].Team ~= plr.Team and neartestPlayer_["part"]) then
                                                                getRoot(char).CFrame = neartestPlayer_["part"].CFrame * CFrame.new(math.random(1.45, 1.7), 0, math.random(1.45, 1.7));
                                                            end
                                                        end

                                                        task.wait(1);

                                                        if (char and getRoot(char)) then
                                                            getRoot(char).CFrame = old_hitCFrame;
                                                        end
                                                    end)
                                                end
                                            else
                                                if (remove_hitDetecting) then
                                                    remove_hitDetecting:Disconnect();
                                                    remove_hitDetecting = nil;
                                                end
                                            end
                                        end)

                                        if (not speaker or not speaker:FindFirstChildWhichIsA("Backpack") or not speaker.Character) then return end; -- prevent another script affect the main script
                                        v.Parent = speaker:FindFirstChildWhichIsA("Backpack");
                                        v.Parent = speaker.Character;
                                    end
                                end

                                -- Success, now ready
                                notify("Notification", "infAura enabled.")
                            end
                        end
                    elseif (tostring(args[1]):lower() == "off") then
                        if (boxReachEnabled == true) then notify("Notification", "infAura already enabled/turned on off. You must turn off to use") ; return ; end;
                        if (infAuraEnabled == false) then notify("Notification", "infAura already disabled/turned off") ; return ; end;
                        infAuraEnabled = false;

                        if (speaker and speaker:FindFirstChildWhichIsA("Backpack") and speaker.Character) then
                            if (speaker:FindFirstChildWhichIsA("Backpack"):FindFirstChildWhichIsA("Tool")) then
                                for _, v in pairs(speaker:FindFirstChildWhichIsA("Backpack"):GetDescendants()) do
                                    pcall(function()
                                        if (v:IsA("Tool")) then
                                            if (v:FindFirstChild("_toolSize_save_") and v:FindFirstChild("_toolSize_save_").ClassName == "Vector3Value" and v:FindFirstChild("_toolGrip_save") and v:FindFirstChild("_toolGrip_save").ClassName == "Vector3Value") then
                                                -- Set to the original value
                                                v.Handle.Size = v:FindFirstChild("_toolSize_save_").Value;
                                                v.GripPos = v:FindFirstChild("_toolGrip_save").Value;

                                                -- Delete the saved value
                                                pcall(function()
                                                    if (v:FindFirstChild("_toolSize_save_")) then
                                                        v:FindFirstChild("_toolSize_save_"):Destroy();
                                                    end
                                                end)

                                                pcall(function()
                                                    if (v:FindFirstChild("_toolGrip_save")) then
                                                        v:FindFirstChild("_toolGrip_save"):Destroy();
                                                    end
                                                end)
                                            end
                                        end
                                    end)
                                end
                            end
                            if (speaker.Character:FindFirstChildWhichIsA("Tool")) then
                                for _, v in pairs(speaker.Character:GetDescendants()) do
                                    pcall(function()
                                        if (v:IsA("Tool")) then
                                            if (v:FindFirstChild("_toolSize_save_") and v:FindFirstChild("_toolSize_save_").ClassName == "Vector3Value" and v:FindFirstChild("_toolGrip_save") and v:FindFirstChild("_toolGrip_save").ClassName == "Vector3Value") then
                                                -- Set to the original value
                                                v.Handle.Size = v:FindFirstChild("_toolSize_save_").Value;
                                                v.GripPos = v:FindFirstChild("_toolGrip_save").Value;

                                                -- Delete the saved value
                                                pcall(function()
                                                    if (v:FindFirstChild("_toolSize_save_")) then
                                                        v:FindFirstChild("_toolSize_save_"):Destroy();
                                                    end
                                                end)

                                                pcall(function()
                                                    if (v:FindFirstChild("_toolGrip_save")) then
                                                        v:FindFirstChild("_toolGrip_save"):Destroy();
                                                    end
                                                end)
                                            end
                                        end
                                    end)
                                end
                            end

                            -- Success
                            notify("Notification", "infAura disabled.")
                        end
                    elseif (tostring(args[1]):lower() ~= "off" and tostring(args[1]):lower() ~= "on") then
                        notify("Notification", "the status must be `on` or `off`")
                    end
                else
                    notify("Notification", "Missing arguments.")
                end
            end
        }
    }
}

return Synnax
