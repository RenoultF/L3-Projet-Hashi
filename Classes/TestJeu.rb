

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



jeu = Jeu.creer(0, 7, Compte.recuperer(gets.chomp))

print jeu
