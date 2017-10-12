# csh .login
#
setenv EDITOR		"vim"
setenv VISUAL		"vim"
setenv PAGER		"less"

if ( -e ~/.login.local ) then
  source ~/.login.local
endif
