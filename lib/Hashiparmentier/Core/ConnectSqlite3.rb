



require "active_record"

##
# Auteur:: Brabant Mano
# Version:: 0.1
# Date:: 09/04/2020
#
#Fichier à importer si on veux se connecter à la base de donnée
ActiveRecord::Base.establish_connection(

	:adapter => "sqlite3",
	:database => "lib/Hashiparmentier/BDD/BDDDPQADSAHASHIPARMENTIER.db",
	:timeout => 5000

)
