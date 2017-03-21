print('sys-log start')

local t = {}
for l in io.lines('/var/log/nginx/access.log') do
   local ip = l:match('[%d.]*')
   if t[ip] then
	  t[ip] = t[ip] + 1
   else
	  t[ip] = 1
   end
end

print('nginx:')
for k,v in pairs(t) do
   print(k, v)
end

t = {}
local file = io.popen('cat /var/log/auth.log')
for l in file:lines() do
   local ssh = l:match('sshd')
   if (ssh) then
	  local ip = l:match('%d+%.%d+%.%d+%.%d+')
	  if ip then
		if t[ip] then
			t[ip] = t[ip] + 1
		else
			t[ip] = 1
		end
	  end
   end
end

print('')
print('sshd:')
for k,v in pairs(t) do
   print(k, v)
end
