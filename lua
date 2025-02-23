local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

-- 내 캐릭터 가져오기
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- 서버와 연동되는 DamageEvent 찾기
local DamageEvent = ReplicatedStorage:FindFirstChild("DamageEvent")

if not DamageEvent then
    warn("⚠ DamageEvent가 존재하지 않습니다. 서버에서 막혀 있을 가능성이 있음.")
    return
end

-- 설정값
local DAMAGE_RADIUS = 10  -- 피해 줄 범위
local DAMAGE_AMOUNT = 10  -- 예상 피해량

-- 주기적으로 체크하는 함수
while true do
    wait(1)  -- 1초마다 실행

    for _, player in pairs(Players:GetPlayers()) do
        -- 자신 제외, 캐릭터 존재 확인
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local otherRoot = player.Character.HumanoidRootPart
            local distance = (HumanoidRootPart.Position - otherRoot.Position).Magnitude

            if distance <= DAMAGE_RADIUS then
                print("🔴 " .. player.Name .. "에게 피해 줌!")
                DamageEvent:FireServer(player, DAMAGE_AMOUNT)
            end
        end
    end
end
