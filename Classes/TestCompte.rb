

##
# Auteur Brabant Mano
# Version 0.1 : Date : 07/02/2020


require "./Compte.rb"
require "./Sauvegarde.rb"
require "active_record"
require "rubygems"
require "./ConnectSqlite3.rb"

Compte.has_many :sauvegardes
Sauvegarde.belongs_to :compte

print "Donnez le nom de compte à créer : "
compte = Compte.creer(gets.chomp)
p compte
print compte, "\n"

if(!compte.sauvegarder())

  print compte.errors.messages, "\n"

end

p compte
print compte.pseudo, "\n"

recupCompte = Compte.recuperer("toto")

p recupCompte
