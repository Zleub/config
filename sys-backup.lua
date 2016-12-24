#!/usr/bin/lua

print('sys-backup start')

local config = dofile('/home/sys-config.lua')

local date = os.date("%w")

local cmd = {
   function (f, p) return 'tar -cf /tmp/'..f..'.tar.'..date..' '..p end,
   function (f, p) return '\
ftp -n -p dedibackup-dc3.online.net<<END_SCRIPT\
quote USER sd-83415\
quote PASS arno1234\
put /tmp/'..f..'.tar.'..date..' '..f..'.tar.'..date..'\
quit\
END_SCRIPT\
exit 0' end
}

for k,v in pairs(config) do
    print(k, v)
   for _,f in ipairs(cmd) do
	  print(f(k, v))
	  os.execute(f(k, v))
   end
end

local s = ""
for l in io.lines('/etc/motd') do
   local m = l:match('Last System Backup:%s*(.+)')
   if (m) then
	    s = s..'\tLast System Backup:\t'..os.date()..'\n'
   else
	    s = s..l..'\n'
   end
end

local f = io.open('/etc/motd', 'w')
f:write(s)
f:flush()
f:close()
