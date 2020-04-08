


##
# Auteur Brabant Mano
# Version 0.1 : Date : 07/02/2020


require "active_record"

ActiveRecord::Base.establish_connection(

	:adapter => "sqlite3",
	:database => "../BDD/pif.db",
	:timeout => 5000

)
