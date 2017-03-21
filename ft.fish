set -x EDITOR emacs

function slim
	command open -a /Applications/Sublime\ Text.app $argv
end

function atom
	command open -a /Applications/Atom.app $argv
end

function t
	command tree -C -h -L 2 $argv
end

function gitstatusfolder
	if test -d $argv[1]

		cd $argv[1]
		if test -d .git
echo '
_  _  ,__
/"\/"\ :`-`
(.    .`))           ' $argv[1] '
.__>--<___.`
'
			git status
		end
	end
end

function gitstatus
	for var in *                                                                                                                            18:12:22
		fish -c 'gitstatusfolder '$var
	end
end

function backup
	mkdir /Volumes/ADEBRAY/(date "+%Y_%m_%d")
	rsync -ap --exclude-from="$HOME/rsync_exclude" $HOME /Volumes/ADEBRAY/(date "+%Y_%m_%d")
end
