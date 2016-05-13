dofile("cfg.lc")
wifi.setmode(wifi.STATION)
print('MAC:    ', wifi.sta.getmac())
print('essid:  ', konfigas.ssid)
print('pass:   ', konfigas.pass)
print('broker: ', konfigas.broker)
-- wifi config start
wifi.sta.config(konfigas.ssid, konfigas.pass)
tmr.alarm(1,1000, 1, function()
	  if not wifi.sta.getip()==nil then
		  print("New IP address is "..wifi.sta.getip())
		  tmr.stop(1)
		  dofile("telnet.lc")
	  end
end)
