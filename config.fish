# Environment
set WORK /opt/spectrum_health
set HOME_BIN $WORK/bin
set DOTFILES_HOME $HOME/.dotfiles
set JAVA_HOME (/usr/libexec/java_home -v '1.8*')
set MAVEN_OPTS '-Xmx512m -Djava.awt.headless=true'
set GROOVY_HOME /usr/local/opt/groovy/libexec

set PATH $PATH $HOME_BIN $DOTFILES_HOME/bin $JAVA_HOME/bin 

# BobTheFish Configs
set -g theme_nerd_fonts yes
#set -g theme_display_k8s_context yes
#set -g theme_display_docker_machine yes
set -g theme_color_scheme solarized-dark
set -g theme_display_vi no 
set -g theme_newline_cursor yes
set -g theme_display_git yes
set -g fish_prompt_pwd_dir_length 20

# Standard settings
#fish_vi_key_bindings

# Aliases
alias ong="oc login https://openshift.ong.spectrum-health.org -u=mccrda"
alias onb="oc login https://openshift.onb.spectrum-health.org -u=mccrda"
alias ms="oc login (minishift ip):8443 -u=admin -p=admin"

# Maven aliases
alias mvnci="mvn clean install"
alias mvncist="mvn clean install -DskipTests"
alias wg="cd /opt/spectrum_health"

# CKA aliases
alias kc='kubectl'
alias kgp='kubectl get pods'
alias kgs='kubectl get svc'
alias kgc='kubectl get componentstatuses'
alias kctx='kubectl config current-context'
alias kcon='kubectl config use-context'
alias kgc='kubectl config get-context'

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/mccrda/google-cloud-sdk/path.fish.inc' ]; . '/Users/mccrda/google-cloud-sdk/path.fish.inc'; end
