# Workaround Pycharm check is resolved https://youtrack.jetbrains.com/issue/IDEA-176888
[[ "$PATH" =~ /usr/local/bin ]] || export PATH=$PATH:/usr/local/bin

# Custom PATH
export PATH=$PATH:/usr/local/sbin
export PATH=$PATH:/Users/waxo/develop/flutter/bin
export LC_ALL='en_US.UTF-8'
export LANG='en_US.UTF-8'

# Path to your oh-my-zsh installation.
export ZSH="/Users/mattis/.oh-my-zsh"

alias tfwdev="tf workspace select dev"
alias tfwprod="tf workspace select default"
alias tfpdev="tfwdev && tfp -var-file=dev.tfvars"
alias tfadev="tfwdev && tfa -var-file=dev.tfvars"
alias tfpprod="tfwprod && tfp -var-file=prod.tfvars"
alias tfaprod="tfwprod && tfa -var-file=prod.tfvars"

alias gwax="ga . && gcn! && ggpush --force"
alias gupdate="gco main && ggpull && gco develop && ggpull && gfa"
alias gclbranch="git branch -l --no-color | grep -v 'develop\|main' | xargs git branch -D"

alias ghmerge="gh pr merge --auto --delete-branch"

cheh() {
  str='gh pr create'
  for reviewer in $@
  do
    str="$str --reviewer $reviewer"
  done
  eval $str
}

gmain () {
  git checkout main
  git pull origin "$(git_current_branch)"
  git checkout develop
  git pull origin "$(git_current_branch)"
  git fetch --all --prune
  git checkout -b deploy-main/$1
  git rebase main
  git push origin "$(git_current_branch)"
  gh pr create --base main
}


# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="waxo"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  gitfast
  flutter
  node
  gulp
  yarn
  docker
  docker-compose
  pip
  python
  terraform
  virtualenv
  django-plugin
)

RPROMPT='$(tf_prompt_info)'

POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status virtualenv)

source $ZSH/oh-my-zsh.sh

# User configuration

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Aliases
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform

function virtualenv_info { 
    [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

export VIRTUAL_ENV_DISABLE_PROMPT=1
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH="/usr/local/opt/ruby/bin:$PATH"

if [ -d "/usr/local/opt/ruby/bin" ]; then
  export PATH=/usr/local/opt/ruby/bin:$PATH
  export PATH=`gem environment gemdir`/bin:$PATH
fi
