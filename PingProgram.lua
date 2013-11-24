--Functions--
function table()
	if firstattheend == "table" then
		os.execute( "cls" )
		end
	YIP = "Your IP Address: "
	INS = "Internet Status: "
	ROS = "Router Status: "
	DNS = "DNS Status: "
	if MTIA == "Yes" then
		MTI = "Towny Islands Status: "
		end
	--AIT = "Alt. Internet Status: "
	r = {yipa ,si, dsr, sd, mti} --Table of network results, without the Alt. Internet (add 'asi')
	print(YIP..r[1])
	print(ROS..r[3])
	print(DNS..r[4])
	print(INS..r[2])
	if MTIA == "Yes" then
		print(MTI..r[5])
		end
	if firstattheend == "status" then
		endMessage()
		end
	file = io.open("Logs.txt", "w")	
	file:write(YIP..r[1]..", "..ROS..r[3]..", "..DNS..r[4]..", "..INS..r[2])
	if routername ~= "verizon.home" then
		file:write(", "..routername)
		end
	file:close()
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
	if ip == "0.0.0.0" then
		ds = nil 
		end
	if ds == nil then
		ds = 5
		end
	if asi ~= nil then
		print("The status of the connection to a router, another than the main one             ("..arip..") is " ..asi..".")	
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
	if ds == 5 then
		print("You are not connected to a router at all and as a result there is not way to    check for an internet connection.")
		end
	if firstattheend == "table" then	
		endMessage()
		end
	end
function getIP() -- Do not change anything here, not needed any more but do not delete
	someRandomIP = "192.168.1.1"
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
routername = "verizon.home"
website = "google.com" --Change this to the site you would like to ping
firstattheend = "table" --Which function goes first? The table or status?
MTIA = "No" --Should there be an attempt to access the Towny Islands website? (Please say 'Yes')
--Start of code--
require("socket")
require("table")
print("Are you using Verizon? Yes or No?")
service = io.read()
if service ~= "Yes" then
	a = 1
	end	
if service == "No" then
	os.execute("tracert -h 1 "..rip)
	print("Please input the name to the left of the [IP address] below.")
	routername = io.read()
	a = a - 1
	end	
if a == "1" then
	error("You can't read!")
	end
ip = "0.0.0.0"
ip = socket.dns.toip(website)
getIP()
yipa = mySocket:getsockname()
arip = socket.dns.toip(routername)
if rip ~= arip then
	diff = 1
	end
if ip == nil then
	ip = "0.0.0.0"
	sd = "[BAD]"
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
	if ip  ~= "0.0.0.0" then
		dsr = "[DIFFERENT IP, BUT OK]" 
		end
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
	--asi = "[NOT_NEEDED]"	
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
		if ip ~= "0.0.0.0" then
			ds = 4
			end
		if ip == "0.0.0.0" then
			ds = nil
			end
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
