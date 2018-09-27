# .cshrc

if (! $?LOGINLOADED) then
  source $HOME/.login
endif

# interactive shell?
if ( $?prompt ) then
  # turn on filename completion in csh - default on in tcsh
  set filec
  # expand-history invoked before completion attempt
  set autoexpand
  # possibilities are listed after ambiguous completion
  set autolist
  # places to cd to by default
  set cdpath = ( ~ )
  # pushd w/o args does 'pushd ~'
  set pushdtohome
  # shell announces job completions asyncly
  set notify
  # it takes two ^D's to terminate shell
  set ignoreeof = 2
  # mail spool
  set mail = /var/spool/mail/$user
  # don't idle-logout
  unset autologout
  # for color ls-F
  set color

  if ( -x "`which git`" ) then
    alias __git_curr_branch 'git rev-parse --abbrev-ref HEAD >& /dev/null && echo " {`git symbolic-ref -q --short HEAD || git describe --tags --exact-match`}"'
  endif

  # xterm-title: user @ host : dir
  # prompt: user@host:dir> 
  if ( ( $?TERM ) && ( ( $?COLORTERM ) || ( "x$TERM" == xrxvt ) || ( "x$TERM" == xxterm ) || ( "x$TERM" == xxterm-color ) ) ) then
    set prompt = "%{\033]2;%n @ %m : %~\007%}%n@%m%u:%B%~%b%# "
    if ( -x "`which git`" ) then
      alias precmd 'set prompt="%{\033]2;%n @ %m : %~\007%}%n@%m%u:%B%~%b`__git_curr_branch`%# "'
    endif
  else
    set prompt = "%n@%m%u:%B%~%b%# "
    if ( -x "`which git`" ) then
      alias precmd 'set prompt="%n@%m%u:%B%~%b`__git_curr_branch`%# "'
    endif
  endif

  umask 022

  if ($?tcsh ) then
    # key bindings
    bindkey "\e[1~" beginning-of-line  # Home
    bindkey "\e[7~" beginning-of-line  # Home rxvt
    bindkey "\e[2~" overwrite-mode     # Ins
    bindkey "\e[3~" delete-char        # Delete
    bindkey "\e[4~" end-of-line        # End
    bindkey "\e[8~" end-of-line        # End rxvt
    bindkey "^W"  backward-delete-word

    # simple completions
    complete cd 'C/*/d/'
    complete chdir 'C/*/d/'
    complete pushd 'C/*/d/'
    complete rmdir 'C/*/d/'

    complete which 'p/1/c/'
    complete where 'p/1/c/'
    complete exec 'p/1/c/'
    complete strace 'p/1/c/'
    complete man 'p/1/c/'

    complete alias 'p/1/a/'
    complete unalias 'p/1/a/'

    complete set 'p/1/s/'
    complete unset 'p/1/s/'

    complete setenv 'p/1/e/' 'c/*:/f/' # for PATH, etc
    complete unsetenv 'p/1/e/'
    complete printenv 'p/1/e/'

    complete limit      c/-/"(h)"/ 'n/*/l/'
    complete unlimit      c/-/"(h)"/ 'n/*/l/'

    complete bindkey 'p/1/b/'

    complete chgrp 'p/1/g/'
    complete chown 'p/1/g/'

    complete complete   'p/1/X/'
    complete uncomplete 'p/*/X/'

    # complex completions
    complete kill 'c/-/S/' 'p/*/`ps x | awk \{print\ \$1\}`/'

    complete {fg,bg,stop}       c/%/j/ p/1/"(%)"//
    
  endif

  # notify on mail
  if ( -x "`which biff`" ) then
    biff y
  endif

  # Load local cshrc options
  if ( -e $HOME/.cshrc.local ) then
    source $HOME/.cshrc.local
  endif

  # Load aliases from ~/.alias
  if ( -e $HOME/.alias ) then
    source $HOME/.alias
  endif

endif

# vim:sw=2 sts=2
