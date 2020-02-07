
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

sauvegarde = Sauvegarde.new(:compte => Compte.new(:pseudo =>  "polo"))
p sauvegarde
print sauvegarde, "\n"

sauvegarde.save

p sauvegarde
print sauvegarde, "\n"

recupCompte = Compte.where(pseudo: "polo")

recupSauvegarde = Sauvegarde.where(compte: recupCompte)

recupSauvegarde.each do |s|

  p s

end
