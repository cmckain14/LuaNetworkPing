--Functions--
function table()
	if firstattheend == "table" then
		os.execute( "cls" )
		end
	INS = "Internet Status: "
	ROS = "Router Status: "
	DNS = "DNS Status: "
	if MTIA == "Yes" then
		MTI = "Towny Islands Status: "
		end
	--AIT = "Alt. Internet Status: " --Will be removed at a later date
	r = {si, dsr, sd, mti} --Table of network results, without the Alt. Internet (add 'asi')
	print(ROS..r[2])
	print(INS..r[1])
	print(DNS..r[3])
	if MTIA == "Yes" then
		print(MTI..r[4])
		end
	--print(AIT..r[4]) --Will be removed at a later date
	if firstattheend == "status" then
		endMessage()
		end
	end
function note()
	if note == nil then
		print("Note: Ignore the above information, the status of your connection will be shown below. Please press 'enter' to proceed.")
		end	
	end
function status()
	if firstattheend == "status" then
		os.execute( "cls" )
		end
	if sr == nil and si == nil then 
		sr = "[UNKNOWN]"
		si = "[UNKNOWN]"
		vt = vt + 1
		end
	if vt == 0 then
		if sr == nil then
			error("Warning: Variable 'sr' is nil.")
			end
		if si == nil then
			error("Warning: Variable 'si' is nil.")
			end
		end
	if diff == 1 then
		ds = 3
		end
	if diff == nil then
		print("The status of the connection to the main router is " ..sr..".")
		end
	print("The status of the connection to the internet is " ..si..".")
	if asi ~= nil then
		print("The status of the connection to a router, another than the main one ("..arip..") is " ..asi..".")	
		end
	if ds == 0 then
		print("The internet is fully operational!")
		end
	if ds == 1 then
		print("The DNS servers are not working at the moment, please try later or try using 8.8.8.8 and 8.8.4.4 as your DNS servers.")
		end
	if ds == 2 then
		print("The internet is down, please try again later.")
		end
	if ds == 3 then
		print("You are connected to the internet but not to the main router.                   ("..arip.." vs. "..rip..")") --Leave the space there 
		end
	if ds == 4 then
		print("The router you are connected to (not the main one) is not connected to the internet.")
		end
	if firstattheend == "table" then	
		endMessage()
		end
	end
function getIP() -- Do not change anything here
	someRandomIP = "192.168.1.122" 
	someRandomPort = "3102" 
	mySocket = socket.udp() 
	mySocket:setpeername(someRandomIP,someRandomPort) 
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
		end	
	if debugit == "off" then 
		if debugfun == "on" then
			error("Debug off, fool! :)")
			end
		if debugfun == "off" then
			print("Debug off.")
			end	
		end	
	if debugit == "NOTA" then
		end
	end
function endMessage()
	if MTIA == "Yes" then
		if mti == "[OK]" then
			print("and the best news is...you were able to connect to the Towny Islands website!")
			end
		end	
	print("Press 'enter' when you are finished reading the above information.")
	io.stdin:read'*l'
	end
--Variables-- --Set these! :)	
rip = "192.168.1.1" --Change this to your router's IP address	
website = "google.com" --Change this to the site you would like to ping
firstattheend = "table" --Which function goes first? The table or status?
MTIA = "No" --Should there be an attempt to access the Towny Islands website? (Please say 'Yes')
--Start of code--
require("socket")
require("table")
ip = socket.dns.toip(website)
getIP()
arip = mySocket:getsockname() 
if rip ~= arip then
	diff = 1
	end
if ip == nil then
	error("No IP address found")
	end	
os.execute( "cls" )
vt = 0
mr = os.execute("ping "..rip.." -n 1") --Router Connection Testing
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
	si = "[BAD]"
	end
dsr = sr	
if diff == 1 then
	dsr = "[DIFFERENT IP, BUT OK]" 
	end
print("The status of the connection to the router is " ..sr..".")
if si == "[READY]" then
	dr = os.execute("ping "..ip.." -n 1") --DNS Testing
	if dr == 0 then
		sd = "[OK]"
		end
	if dr == 1 then
		sd = "[BAD]"
		end	
	ir = os.execute("ping "..website.." -n 1") --Internet Testing
	note()
	if ir == 0 then
		si = "[OK]"
		end
	if ir == 1 then
		si = "[BAD]"
		end
	if si == "[OK]" and sd == "[OK]" then
		ds = 0
		end
	if si == "[BAD]" then
		ds = 2
		end
	if sd == "[BAD]" then
		ds = 1
		end
	--asi = "[NOT_NEEDED]"	--Will be removed at a later date
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
		si = "[OK]"
		end
	if asi == "[BAD]" then
		ds = 4
		end	
	end
if MTIA == "Yes" then	
	mtiwt = os.execute("ping minecrafttownyislands.com -n 1")
	if mtiwt == 0 then
		mti = "[OK]"
		end
	if mtiwt == 1 then
		mti = "[BAD]"
		end
	end	
debugging()	
table()
status()
