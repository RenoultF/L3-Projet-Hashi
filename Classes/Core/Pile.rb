
##
# Auteur Brabant Mano
# Version 0.1 : Date : 07/02/2020


#Cette classe représente une pile
class Pile

  #@indice => La position dans la pile

  private_class_method :new

  #Ce constructeur permet de créer une nouvelle pile
  def Pile.creer()
    new()
  end

  #:nodoc:
  def initialize()
    @actions = Array.new()
  end
  #:doc:

  ##
  #Cette méthode permet de d'empiler un element
  #
  #@param element L'element à empiler
  def empiler(element)
    @actions.push(element)
    puts element
    return self
  end

  ##
  #Cette méthode permet de dépiler le dernier element
  #@return L'action dépilée
  def depiler
    if(self.empty?())
      raise("La pile est vide")
    else
      ret = @actions.pop()
      puts ret
      return ret
    end
  end

  def empty?()
    return @actions.empty?()
  end

end
