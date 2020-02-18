
##
# Auteur Brabant Mano
# Version 0.1 : Date : 07/02/2020


load "Compte.rb"
load "Sauvegarde.rb"
require "active_record"
require "rubygems"
load "ConnectSqlite3.rb"

Compte.has_many :sauvegardes
Sauvegarde.belongs_to :compte

#Commande pour créer une nouvelle sauvegarde
sauvegarde = Sauvegarde.sauvegarder("poto", nil)
p sauvegarde
print sauvegarde, "\n"


if(!sauvegarde.save)

  print sauvegarde.errors.messages, "\n"

end

p sauvegarde
print sauvegarde, "\n"


recupSauvegarde = Sauvegarde.where(compte: Compte.where(pseudo: "toto"))

recupSauvegarde.each do |s|

  p s

end
