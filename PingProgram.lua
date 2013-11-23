--Functions--
function note()
	if note == nil then
		print("Note: Ignore the above information, the status of your connection will be shown below. Please press 'enter' to proceed.")
		end	
	end
function status()
	os.execute( "cls" )
	print("The status of the connection to the main router is " ..sr..".")
	print("The status of the connection to the internet is " ..si..".")
	if ds == 0 then
		print("The internet is fully operational!")
		end
	if ds == 1 then
		print("The DNS servers are not working at the moment, please try later or try using 8.8.8.8 and 8.8.4.4 as your DNS servers.")
		end
	if ds == 2 then
		print("The internet is down.")
		end
	if ds == 3 then
		print("You are connected to the internet but not to the main router.")
		end
	if ds == 4 then
		print("The router you are connected to (not the main one) is not connected to the internet.")
		end
	print("Press 'enter' when you are finished reading the above information.")
	io.stdin:read'*l'
	end
function debugging()
	debugit = "off" --On or off for debug mode.
	debugfun = "NOTA" --On or off for have fun with debugging mode.
	if debugit == "on" then
		if mr ~= nil then
			print(mr)
			end
		if sr ~= nil then
			print(sr)
			end
		if si ~= nil then
			print(si)
			end
		if sd ~= nil then
			print(sd)
			end
		if ds ~= nil then
			print(ds)
			end
		if dr ~= nil then
			print(dr)
			end
		if ir ~= nil then
			print(ir)
			end
		print("Thank you for using my Network Status tool written in Lua!")	
		end	
	if debugit == "off" then 
		if debugfun == "on" then
			error("Debug off, fool! :)")
			end
		if debugfun == "off" then
			print("Debug off.")
			end
		print("Thank you for using my Network Status tool written in Lua!")	
		end	
	if debugit == "NOTA" then
		print("Thank you for using my Network Status tool written in Lua!")
		end
	end		
--Start of code--	
os.execute( "cls" )
mr = os.execute("ping 192.168.1.1 -n 1") --Router Connection Testing
note()
if mr == nil then
	error("WTF!")
	end
if mr == 0 then
	sr = "[OK]"
	si = "[READY]"
	end
if mr == 1 then
	os.execute( "cls" )
	sr = "[BAD]"
	end
print("The status of the connection to the router is " ..sr..".")
if si == "[READY]" then
	dr = os.execute("ping 74.125.224.161 -n 1") --DNS Testing
	if dr == 0 then
		sd = "[OK]"
		end
	if dr == 1 then
		sd = "[BAD]"
		end	
	ir = os.execute("ping google.com -n 1") --Internet Testing
	note()
	if ir == 0 then
		si = "[OK]"
		end
	if ir == 1 then
		si = "[BAD]"
		end
	if si == "[OK]" and sd == "[OK]" then
		ds = 0
		status()
		end
	if si == "[BAD]" then
		ds = 2
		end
	if sd == "[BAD]" then
		ds = 1
		status()
		end
	end	
if si == "[BAD]" then
	air = os.execute("ping google.com -n 1") --Alternate Internet Testing
	if air == 0 then
		asi = "[OK]"
		end
	if air == 1 then
		asi = "[BAD]"
		end
	if asi == "[OK]" then
		ds = 3
		status()
		end
	if asi == "[BAD]" then
		ds = 4
		status()
		end	
	end	
debugging()	
