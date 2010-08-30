require "authlogic_drc/session"
 
Authlogic::Session::Base.send(:include, AuthlogicDRC::Session)
