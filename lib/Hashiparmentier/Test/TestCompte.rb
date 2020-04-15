

##
# Auteur Brabant Mano
# Version 0.1 : Date : 07/02/2020


require "../Core/Compte.rb"
require "../Core/Sauvegarde.rb"
require "active_record"
require "rubygems"
require "../Core/ConnectSqlite3.rb"

Compte.has_many :sauvegardes
Sauvegarde.belongs_to :compte

retry_count = 0

print "Donnez le nom de compte à créer : "
compte = Compte.creer(gets.chomp)
p compte
print compte, "\n"

if(!compte.sauvegarder())

  print compte.errors.messages, "\n"

end

p compte
print compte.pseudo, "\n"

retry_count = 0
begin

  print "Donnez le nom de compte à recupérer : "
  recupCompte = Compte.recuperer(gets.chomp)

rescue

  print "Ce compte n'existe pas \n"
  if(retry_count < 3)
    retry_count+=1
    retry
  else
    print "Nombre maximum de retry atteint \n"
  end

end

p recupCompte
