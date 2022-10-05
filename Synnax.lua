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

local badwordsreport = {
    ["gay"] = "Bullying",
    ["gays"] = "Bullying",
    ["gae"] = "Bullying",
    ["gey"] = "Bullying",
    ["hack"] = "Scamming",
    ["exploit"] = "Scamming",
    ["cheat"] = "Scamming",
    ["dllcheat"] = "Scamming",
    ["dllexploit"] = "Scamming",
    ["hecker"] = "Scamming",
    ["hacer"] = "Scamming",
    ["fuck"] = "Bullying",
    ["bitch"] = "Bullying",
    ["ass"] = "Bullying",
    ["report"] = "Bullying",
    ["fat"] = "Bullying",
    ["black"] = "Bullying",
    ["getalife"] = "Bullying",
    ["fatherless"] = "Bullying",
    ["report"] = "Bullying",
    ["fatherless"] = "Bullying",
    ["disco"] = "Offsite Links",
    ["yt"] = "Offsite Links",
    ["youtube"] = "Offsite Links",
    ["dizcourde"] = "Offsite Links",
    ["retard"] = "Swearing",
    ["bad"] = "Bullying",
    ["trash"] = "Bullying",
    ["nolife"] = "Bullying",
    ["nolife"] = "Bullying",
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
    ["synnapse"] = "Offsite Links",
    ["syn"] = "Offsite Links",
    ["download"] = "Offsite Links",
    ["youtube"] = "Offsite Links",
    ["die"] = "Bullying",
    ["lobby"] = "Bullying",
    ["ban"] = "Bullying",
    ["wizard"] = "Bullying",
    ["wisard"] = "Bullying",
    ["witch"] = "Bullying",
    ["magic"] = "Bullying",
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

plr:GetMouse().Button1Down:Connect(function()
    if ResetTeleportEnabled == true then
        local oldposclick = Mouse.Hit.Position
        respawn(plr)
        oldposclick = Mouse.Hit.Position
        task.wait(Players.RespawnTime + 0.1)
        local rootget = getRoot(plr.Character)
        rootget.CFrame = CFrame.new(oldposclick.X, oldposclick.Y, oldposclick.Z)
        ResetTeleportEnabled = false
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
            ["ListName"] = "resetp / resettp / reback [on/off]",
            ["Description"] = "Reset you and teleport to the last click position, may bypass some anti cheat",
            ["Aliases"] = {"resettp", "resetp", "reback"},
            ["Function"] = function(args, speaker)
                task.spawn(function()
                    if args[1] then
                        if args[1] == "on" then
                            if ResetTeleportEnabled == true then
                                notify("Notification", "ResetTeleport already turned on!")
                            else
                                ResetTeleportEnabled = true
                            end
                        elseif args[1] == "off" then
                            if ResetTeleportEnabled == false then
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
            ["ListName"] = "flag / Fakelag",
            ["Description"] = "Make your movement more laggy",
            ["Aliases"] = {"flag", "fakelag"},
            ["Function"] = function(args, speaker)
               task.spawn(function()
                    notify("Notification", "Start lag")
                    FakeLagEnabled = true
                    speaker.Character.Animate.Disabled = true
                    if args[1] and tonumber(args[1]) then
                        repeat task.wait(tonumber(args[1]))
                            execCmd('replicationlag ' .. tonumber(args[1]))
                            task.wait(5)
                            execCmd('replicationlag ' .. 0)
                            if FakeLagEnabled == false then
                                break
                            end
                        until FakeLagEnabled == false
                    else
                        repeat task.wait(5)
                            execCmd('replicationlag 5')
                            task.wait(5)
                            execCmd('replicationlag 0')
                            if FakeLagEnabled == false then
                                break
                            end
                        until FakeLagEnabled == false
                    end
               end)
            end
        },
        ["UnFakeLag"] = {
            ["ListName"] = "unflag / UnFakelag",
            ["Description"] = "Turn off fake lag movement",
            ["Aliases"] = {"unflag", "Unfakelag"},
            ["Function"] = function(args, speaker)
                notify("Notification", "Stop lag")
                FakeLagEnabled = false
                execCmd('replicationlag 0')
                speaker.Character.Animate.Disabled = false
                execCmd('replicationlag 0')
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
                    notify("Notification", "You must write the remote event location")
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
            ["ListName"] = "BetterFling / ffling [plr]",
            ["Description"] = "Fling player you want to!",
            ["Aliases"] = {"BetterFling", "FastFling", "betterfling", "fastfling", "ffling"},
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
                                execCmd('noclip')
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
                                            task.wait(.05)
                                            getRoot(speaker.Character).CFrame = CFrame.new(flingplrcframe.X + 0.5, flingplrcframe.Y + 1.5, flingplrcframe.Z + 0.5) 
                                            task.wait(.05)
                                            getRoot(speaker.Character).CFrame = CFrame.new(flingplrcframe.X - 0.5, flingplrcframe.Y - 1.5, flingplrcframe.Z - 0.5)
                                            task.wait(.05)
                                            getRoot(speaker.Character).CFrame = CFrame.new(flingplrcframe.X + 0.5, flingplrcframe.Y + 1.5, flingplrcframe.Z + 0.5)
                                            task.wait(.05)
                                            getRoot(speaker.Character).CFrame = CFrame.new(flingplrcframe.X - 0.5, flingplrcframe.Y - 1.5, flingplrcframe.Z - 0.5)
                                            task.wait(.05)
                                            getRoot(speaker.Character).CFrame = CFrame.new(flingplrcframe.X + 0.5, flingplrcframe.Y + 1.5, flingplrcframe.Z + 0.5)
                                            task.wait(.05)
                                            getRoot(speaker.Character).CFrame = CFrame.new(flingplrcframe.X - 0.5, flingplrcframe.Y - 1.5, flingplrcframe.Z - 0.5)
                                            task.wait(.05)
                                            getRoot(speaker.Character).CFrame = CFrame.new(flingplrcframe.X + 0.5, flingplrcframe.Y + 1.5, flingplrcframe.Z + 0.5)
                                            task.wait(.05)
                                            getRoot(speaker.Character).CFrame = CFrame.new(flingplrcframe.X + 0.5, flingplrcframe.Y - 1.5, flingplrcframe.Z + 0.5)
                                            task.wait(.05)
                                            getRoot(speaker.Character).CFrame = CFrame.new(flingplrcframe.X, flingplrcframe.Y - 1, flingplrcframe.Z)
                                            getRoot(speaker.Character).CFrame = CFrame.new(flingplrcframe.X, flingplrcframe.Y - 1, flingplrcframe.Z)
                                        end
                                    end)
                                end)

                                for flinglooprun = 1, 5 do
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
                                    local antiflingout = Instance.new("BodyVelocity")
                                    antiflingout.Parent = getRoot(speaker.Character)
                                    antiflingout.Name = randomString()
                                    antiflingout.MaxForce = Vector3.new(9e9, 9e9, 9e9)
                                    antiflingout.Velocity = Vector3.new(0, -100, 0)
                                    getRoot(speaker.Character).Anchored = true
                                    getRoot(speaker.Character).CFrame = OldCFrameBeforeRun
                                    task.wait(.5)
                                    execCmd('unnoclip')
                                    getRoot(speaker.Character).Anchored = false
                                    getRoot(speaker.Character).CFrame = OldCFrameBeforeRun
                                    task.wait(.6)
                                    antiflingout.MaxForce = Vector3.new(9e9, 9e9, 9e9)
                                    if antiflingout then
                                        antiflingout:Destroy()
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
                    notify("Notification", "Invaild player")
                end
            end
        },
        ["BetterInvisiblefling"] = {
            ["ListName"] = "BetterInvisibleFling / BetterInvisFling [plr]",
            ["Description"] = "Fling player you want but it will be invisible!",
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
                    execCmd('noclip')
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
            ["ListName"] = "ForceGiveTool / fgivetool",
            ["Description"] = "Remove your humanoid to forcegivetool player",
            ["Aliases"] = {"forcegiveTool", "fgivetool"},
            ["Function"] = function(args, speaker)
                if speaker and speaker.Character and speaker.Character:FindFirstChildWhichIsA("Humanoid") and args[1] and args[2] then
                    local GetGiveToolPlayer = getPlayer(tostring(args[1]))
                    local ToolGive = tostring(args[2])
                    for playercheckcount, playerinpairs in pairs(GetGiveToolPlayer) do
                        local GiveToolPlayer = nil
                        if Players:FindFirstChild(playerinpairs) then
                            GiveToolPlayer = Players:FindFirstChild(playerinpairs)
                        else
                            GiveToolPlayer = nil
                        end
                        speaker.Character:FindFirstChildWhichIsA("Humanoid"):Destroy()
                        Instance.new("Humanoid", speaker.Character)
                        local ToolGiveLocation = nil
                            if speaker and speaker.Backpack and speaker.Backpack:FindFirstChild(ToolGive) then
                                ToolGiveLocation = speaker.Backpack:FindFirstChild(ToolGive)
                            elseif speaker and speaker.Character and speaker.Character:FindFirstChild(ToolGive) then
                                ToolGiveLocation = speaker.Character:FindFirstChild(ToolGive)
                            end
                            if ToolGiveLocation then
                                ToolGiveLocation.Parent = speaker.Character
                                local oldposbeforegoto = getRoot(speaker.Character).CFrame
                                execCmd('noclip')
                                execCmd('loopgoto ' .. GiveToolPlayer.Name .. "0 0")
                                execCmd('unnoclip')
                                task.wait(.5)
                                respawn(speaker)
                                task.wait(tonumber(Players.RespawnTime) + 0.1)
                                getRoot(speaker.Character).CFrame = oldposbeforegoto
                            end
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
                local uis = game:GetService("UserInputService")
                local Tpwalkspeed = 50
                local Float = Instance.new("Part", speaker.Character)
                    Float.Name = randomString()
                    Float.Transparency = 1
                    Float.Size = Vector3.new(2,0.2,1.5)
                    Float.Anchored = true
                    local FloatValue = -3.1
                    Float.CFrame = getRoot(speaker.Character).CFrame * CFrame.new(0, FloatValue, 0)
                    game:GetService("RunService").Heartbeat:Connect(function()
                        Float.CFrame = getRoot(speaker.Character).CFrame * CFrame.new(0, FloatValue, 0)
                        if FloatEnabled == false then
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
        },
        ["UnBetterFloat"] = {
            ["ListName"] = "UnbetterFloat / UnBFloat",
            ["Description"] = "Fix Infinite yield Float",
            ["Aliases"] = {"unbetterfloat", "unbfloat"},
            ["Function"] = function(args, speaker)
                FloatEnabled = false
            end
        },
        ["SlowFloat"] = {
            ["ListName"] = "SlowFloat / FreezeFloat / SFloat",
            ["Description"] = "Make you walk in air but slow so it will bypass anticheat",
            ["Aliases"] = {"slowfloat", "freezefloat", "sfloat"},
            ["Function"] = function(args, speaker)
                if args[1] and tonumber(args[1]) ~= nil then
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
                                                        task.wait(1)
                                                        local NewPos = AnotherHumanoidRootPart.Position
                                                        if (NewPos - OldPos).Magnitude > (Humanoid.WalkSpeed + 25) and allchars:FindFirstChildWhichIsA("Humanoid").Sit == false and not allchars:FindFirstChildWhichIsA("ForceField") then
                                                            notify("HackerDetector", "User: " .. tostring(allplrs.Name) .. ", Display: " .. tostring(allplrs.DisplayName) .. "\n Speed, Teleport Cheating, Type: MagnitudeDetect")
                                                        end
                                                    end)
                                                end
                            
                                                if allchars:FindFirstChildWhichIsA("Humanoid") then
                                                    if allchars:WaitForChild("Humanoid").PlatformStand == true then
                                                        notify("HackerDetector", "User: " .. tostring(allplrs.Name) .. ", Display: " .. tostring(allplrs.DisplayName) .. "\n Fly Cheating, Type: Normal")
                                                    end
                                                end
                                                if char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso") then
                                                    if char:FindFirstChild("Torso") and char:FindFirstChild("Torso").CanCollide == false and char:FindFirstChild("Torso").CollisionGroupId == 0 and not char:FindFirstChild("UpperTorso") then
                                                        notify("HackerDetector", "User: " .. tostring(allplrs.Name) .. ", Display: " .. tostring(allplrs.DisplayName) .. "\n Noclip, Type: Normal")
                                                    elseif not char:FindFirstChild("Torso") and char:FindFirstChild("UpperTorso") and char:FindFirstChild("UpperTorso").CanCollide == false and char:FindFirstChild("UpperTorso").CollisionGroupId == 0 then
                                                        notify("HackerDetector", "User: " .. tostring(allplrs.Name) .. ", Display: " .. tostring(allplrs.DisplayName) .. "\n Noclip, Type: Normal")
                                                    end
                                                end
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
                            HackerDetectorEnabled = false
                            if HackerDetectorConnection then
                                HackerDetectorConnection:Disconnect()
                            end
                        else
                            notify("Notification", "It already turned off")
                        end
                    end
                else
                    notify("Notification", "You must set status like HackerDetector [on/off] [true/false]")
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
                            notify("Notification", "You are god now!")
                            if speaker.Character and speaker.Character:FindFirstChildWhichIsA("Humanoid") then
                                BetterGodModeConnection = game:GetService("RunService").RenderStepped:Connect(function()
                                    if speaker.Character:FindFirstChildWhichIsA("Humanoid") then
                                        speaker.Character:FindFirstChildWhichIsA("Humanoid").BreakJointsOnDeath = false
                                        speaker.Character:FindFirstChildWhichIsA("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.Dead, false)
                                        if speaker.Character:FindFirstChildWhichIsA("Humanoid").Health <= 0 then
                                            speaker.Character:FindFirstChildWhichIsA("Humanoid").BreakJointsOnDeath = false
                                            speaker.Character:FindFirstChildWhichIsA("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.Dead, false)
                                            if BetterGodModeRespawnCheck == false then
                                                BetterGodModeRespawnCheck = true
                                                local oldrespawnpos = speaker.Character:GetPivot()
                                                local oldcameracframe = game:GetService("Workspace").CurrentCamera.CFrame
                                                task.wait(game:GetService("Players").RespawnTime - 0.1)
                                                oldrespawnpos = speaker.Character:GetPivot()
                                                oldcameracframe = game:GetService("Workspace").CurrentCamera.CFrame
                                                task.wait(0.1)
                                                speaker.Character:FindFirstChildWhichIsA("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
                                                task.wait(0.1)
                                                repeat task.wait() until speaker.Character and game:GetService("Workspace").CurrentCamera
                                                speaker.Character:PivotTo(oldrespawnpos)
                                                game:GetService("Workspace").CurrentCamera.CFrame = oldcameracframe
                                                speaker.Character:PivotTo(oldrespawnpos)
                                                game:GetService("Workspace").CurrentCamera.CFrame = oldcameracframe
                                                speaker.Character:FindFirstChildWhichIsA("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
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
                        execCmd("BetterFloat " .. tostring(args[1]))
                    else
                        execCmd("BetterFloat 20")
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
                    execCmd("UnBetterFloat")
                    execCmd("tpwalk 0")
                    execCmd("untpwalk")
                end
            end
        },
    }
}

return Synnax
