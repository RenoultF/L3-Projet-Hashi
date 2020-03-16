

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
    @indice = 0
    @nbElement = 0
  end
  #:doc:

  ##
  #Cette méthode permet de d'empiler un element
  #
  #@param element L'element à empiler
  def empiler(element)
    @actions.insert(@indice, element)
    @indice += 1
    @nbElement = @indice
    return self
  end

  ##
  #Cette méthode permet de dépiler le dernier element
  #@return L'action dépilée
  def undo
    if(@indice <= 0)
      raise("La pile est vide")
    else
      @indice -= 1
      return @actions.at(@indice)
    end
  end

  ##
  #Cette méthode permet de dépiler le dernier element
  #@return L'action dépilée
  def redo
    if(@indice >= @nbElement)
      raise("Vous etes au bout de la pile")
    else
      @indice += 1
      return @actions.at(@indice - 1)
    end
  end

  def empty?()
    return @actions.empty?()
  end

end
