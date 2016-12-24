#!/usr/bin/lua

local cmd = {
   "apt-get update",
   "apt-get upgrade"
}

for i,v in ipairs(cmd) do
   print(v)
   os.execute(v)
end

local s = ""
for l in io.lines('/etc/motd') do
   local m = l:match('Last System Update:%s*(.+)')
   if (m) then
	  s = s..'\tLast System Update:\t'..os.date()..'\n'
   else
	  s = s..l..'\n'
   end
end

local f = io.open('/etc/motd', 'w')
f:write(s)
f:flush()
f:close()
