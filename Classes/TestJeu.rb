

require "./Jeu.rb"
require "./ConnectSqlite3.rb"

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

rescue

    puts "Le compte " + nomCompte + " n'existe pas"
    puts "Voulez vous le creer ? (O/n)"
    rep = gets.chomp

    if(rep == "o" || rep == "O" || rep == "Oui" || rep == "OUI" || rep == "oui")

      compte = Compte.creer(nomCompte).sauvegarder()
      jeu = Jeu.creer(0, 7, Compte.recuperer(compte))

    elsif(rep == "n" || rep == "N" || rep == "Non" || rep == "NON" || rep == "non")

      retry

    end

end

jeu.lanceToi()
