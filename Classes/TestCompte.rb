

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

compte = Compte.creer("totogro")
p compte
print compte, "\n"

if(!compte.sauvegarder())

  print compte.errors.messages, "\n"

end

p compte
print compte.pseudo, "\n"

recupCompte = Compte.recuperer("toto")

p recupCompte
