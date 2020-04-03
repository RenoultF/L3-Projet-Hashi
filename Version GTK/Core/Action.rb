
##
# Auteur Brabant Mano
# Version 0.1 : Date : 07/02/2020

#Cette classe représente les actions réalisées par le joueur (placer, retirer des ponts)
class Action

  #@ile1 => La première ile
  attr_reader:ile1

  #@ile2 => La deuxième ile
  attr_reader:ile2

  #@ile1 => La méthode utilisé
  attr_reader:methode

  private_class_method :new

  #Ce constructeur permet de creer une nouvelle action
  #
  #@param ile1 La premiere ile
  #
  #@param ile2 La deuxieme ile
  #
  #@param methode La methode utilisé (createPont ou supprimePont)
  def Action.creer(ile1, ile2, methode)
    new(ile1, ile2, methode)
  end

  #:nodoc:
  def initialize(ile1, ile2, methode)
    @ile1 = ile1
    @ile2 = ile2
    @methode = methode
  end
  #:doc:

  #Cette méthode permet d'afficher l'action
  def to_s
    @ile1.to_s() + ":" + @ile2.to_s() + ":" + @methode.to_s()
  end

end
