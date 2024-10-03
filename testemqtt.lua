-- MUDAR meu id!!!!
local meuid = "ADOLF"
local m = mqtt.Client("clientid " .. meuid, 120)

local led1 = 0
local led2 = 6

gpio.mode(led1, gpio.OUTPUT)
gpio.mode(led2, gpio.OUTPUT)


function publica(c)
  c:publish("inf1350-a","alo de " .. meuid,0,0, 
            function(client) print("mandou! HORA DO EXTERMINIO") end)
end

function novaInscricao (c)
  local msgsrec = 0
  function novamsg (c, t, m)
    print ("mensagem SOLUÇÃO FINAL BRASILSIL ".. msgsrec .. ", topico: ".. t .. ", dados: " .. m)
    msgsrec = msgsrec + 1
    if m == "1" then
      gpio.write(led1, bit.band(gpio.read(led1)+1,1))
    end
    -- LED 2
    if m == "2" then
      gpio.write(led2, bit.band(gpio.read(led2)+1,1))
    end
  end
  c:on("message", novamsg)
end

function conectado (client)
  publica(client)
  client:subscribe("paranodeA16", 0, novaInscricao)
end 

m:connect("139.82.100.100", 7981, false, 
             conectado,
             function(client, reason) print("failed reason: "..reason) end)
        