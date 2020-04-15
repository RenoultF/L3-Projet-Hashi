
##
# Auteur Brabant Mano
# Version 0.1 : Date : 07/02/2020


require "../Core/Jeu.rb"
require "../Core/ConnectSqlite3.rb"

res = ""

res += "4=5---2"
res += "\"2\"1-2|"
res += "\"\"\"  |1"
res += "\"\"6==5 "
res += "2\"\"  \" "
res += " \"4=2\" "
res += " 4===4 "



begin

  print "Veuillez entrer le nom du compte : "
  nomCompte = gets.chomp
  jeu = Jeu.creer(0, 7, Compte.recuperer(nomCompte))

rescue => e

    puts e.message()
    puts "Voulez vous le creer ? (O/n)"
    rep = gets.chomp

    if(rep == "o" || rep == "O" || rep == "Oui" || rep == "OUI" || rep == "oui")

      compte = Compte.creer(nomCompte)
      jeu = Jeu.creer(0, 7, compte)

    elsif(rep == "n" || rep == "N" || rep == "Non" || rep == "NON" || rep == "non")

      retry

    end

end

jeu.lanceToi()
