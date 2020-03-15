

#Cette classe représente une pile
class Pile

  private_class_method :new

  #Ce constructeur permet de créer une nouvelle pipe
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
    return self
  end

  ##
  #Cette méthode permet de dépiler le dernier element
  #@return L'action dépilée
  def depiler
    return @actions.pop()
  end

  def empty?()
    return @actions.empty?()
  end

end
