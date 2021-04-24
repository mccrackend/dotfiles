# # # # # # # # # # # # # # # # # # # # # # # # #
# Environment variables
# # # # # # # # # # # # # # # # # # # # # # # # #
set PATH $PATH ~/git/homebin ~/git/go/bin
export PROJECTS_ROOT='/Users/dmccracken/git'
set EDITOR nvim
# set JAVA_HOME (/usr/libexec/java_home -v 1.8.0_202)
set GOPATH /Users/dmccracken/git/go

# # # # # # # # # # # # # # # # # # # # # # # # #
# BobTheFish Configs
# # # # # # # # # # # # # # # # # # # # # # # # #
set -g theme_nerd_fonts yes
set -g theme_color_scheme solarized-dark
set -g theme_display_vi yes
set -g theme_display_k8s_context yes
set -g theme_display_docker_machine yes
set -g theme_newline_cursor yes
set -g theme_display_git yes
set -g fish_prompt_pwd_dir_length 20

# # # # # # # # # # # # # # # # # # # # # # # # #
# Standard settings
# # # # # # # # # # # # # # # # # # # # # # # # #
fish_vi_key_bindings

# # # # # # # # # # # # # # # # # # # # # # # # #
# Aliases
# # # # # # # # # # # # # # # # # # # # # # # # #
alias refresh="source ~/dotfiles/fish/config.fish"
alias fishconfig="nvim ~/dotfiles/fish/config.fish"
alias vimconfig="nvim ~/dotfiles/nvim/init.vim"
# alias diff="git difftool"
alias vim="nvim"
alias yv="nvim - -c'set ft=yaml'"
alias yb="bat -lyaml"

alias fzfcmd="fzf --ansi -i -1 --height=50% --reverse -0 --inline-info --border"

# Maven aliases
alias mvnci="mvn clean install"
alias mvncist="mvn clean install -DskipTests"

# Directory aliases
alias dotfiles="cd ~/dotfiles"
alias wg="cd ~/git"
alias jenk="ssh -t dmccracken@rhokvtstdmsk01 'sudo su -'"
alias os="~/git/openstack-ci/bin/startOpenStackTools.sh"
alias lcp="sh ~/git/openstack-ci/bin/localKubeConfig.sh"
alias fix="open smb://ddmi.intra.renhsc.com/DeptData"

# CKA Aliases
alias kc='kubectl'

function fco -d "Fuzzy-find and checkout a branch"
  git branch --all | grep -v HEAD | string trim | fzfcmd | read -l result; and git checkout "$result"
end

function fcoc -d "Fuzzy-find and checkout a commit"
  git log --pretty=oneline --abbrev-commit --reverse | fzfcmd --tac +s -e | awk '{print $1;}' | read -l result; and git checkout "$result"
end

function bcd -d 'cd backwards'
	pwd | awk -v RS=/ '/\n/ {exit} {p=p $0 "/"; print p}' | tail -r | fzfcmd +m --select-1 --exit-0 $FZF_BCD_OPTS | read -l result
	[ "$result" ]; and cd $result
	commandline -f repaint
end

function h -d 'cd to one of the previously visited locations'
	# Clear non-existent folders from cdhist.
	set -l buf
	for i in (seq 1 (count $dirprev))
		set -l dir $dirprev[$i]
		if test -d $dir
			set buf $buf $dir
		end
	end
	set dirprev $buf
	string join \n $dirprev | tail -r | sed 1d | fzfcmd +m --tiebreak=index --toggle-sort=ctrl-r $FZF_CDHIST_OPTS | read -l result
	[ "$result" ]; and cd $result
	commandline -f repaint
end

function fssh -d "Fuzzy-find ssh host via ag and ssh into it"
  ag --ignore-case '^host [^*]' ~/.ssh/config | cut -d ' ' -f 2 | fzfcmd | read -l result; and ssh "$result"
end

function fh -d "Fuzzy-find ssh host via ag and ssh into it"
  history | fzfcmd | read -l result
  commandline -r $result
end
