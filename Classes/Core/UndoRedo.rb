
##
# Auteur Brabant Mano
# Version 0.1 : Date : 07/02/2020


#Cette classe représente une structure de donnée permettant de faire des udo et des redo
class UndoRedo

  #@indice => La position dans la undoRedo

  private_class_method :new

  #Ce constructeur permet de créer une nouvelle undoRedo
  def UndoRedo.creer()
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
  #Cette méthode permet de recupérer l'élément d'avant
  #
  #@return L'élément dépilée
  def undo()
    if(@indice <= 0)
      raise("La undoRedo est vide")
    else
      @indice -= 1
      return @actions.at(@indice)
    end
  end

  ##
  #Cette méthode permet de recupérer l'élément du dernier undo
  #
  #@return L'élément correspondant
  def redo()
    if(@indice >= @nbElement)
      raise("Vous etes au bout de la undoRedo")
    else
      @indice += 1
      return @actions.at(@indice - 1)
    end
  end

  def empty?()
    return @actions.empty?()
  end

  def clear()
    @actions.clear()
    return self
  end

end
