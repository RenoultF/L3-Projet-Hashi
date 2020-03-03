
##
# Auteur Brabant Mano
# Version 0.1 : Date : 07/02/2020


require "./Compte.rb"
require "./Grille.rb"
require "./Sauvegarde.rb"
require "active_record"
require "rubygems"
require "./ConnectSqlite3.rb"

Compte.has_many :sauvegardes
Sauvegarde.belongs_to :compte

#Commande pour créer une nouvelle sauvegarde
print "Donnez le nom de compte à récuperer : "
compte = Compte.recuperer(gets.chomp)
sauvegarde = Sauvegarde.creer(compte, nil)
p sauvegarde
print sauvegarde, "\n"

if(!sauvegarde.save)

  print sauvegarde.errors.messages, "\n"

end

p sauvegarde
print sauvegarde, "\n"


recupSauvegarde = Sauvegarde.liste(Compte.recuperer(gets.chomp))

recupSauvegarde.each do |s|

  p s

end
