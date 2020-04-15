

##
# Auteur:: Brabant Mano
# Version:: 0.1
# Date:: 09/04/2020
#
#Cette classe représente une structure de donnée permettant de faire des undo et des redo
class UndoRedo

  #@indice => La position dans la undoRedo

  private_class_method :new

  ##
  #Ce constructeur permet de créer une nouvelle undoRedo
  def UndoRedo.creer()
    new()
  end

  #:nodoc:
  def initialize()

    @actions = Array.new()
    clear()

  end
  #:doc:

  ##
  #Cette méthode permet de d'empiler un élément (va supprimer tous les éléments qui aurait pu être récupérer avec UndoRedo#redo)
  #param::
  # * element L'élément à empiler
  def empiler(element)

    @actions.insert(@indice, element)
    @indice += 1
    @nbElement = @indice
    return self

  end

  ##
  #Cette méthode permet de recupérer l'élément d'avant (de descendre dans la undoRedo)
  #return::
  # * L'élément d'avant
  def undo()

    if(@indice <= 0)
      raise("La undoRedo est vide")
    else
      @indice -= 1
      return @actions.at(@indice)
    end

  end

  ##
  #Cette méthode permet de recupérer l'élément du dernier undo (de remonter dans la undoRedo)
  #return::
  # * L'élément du dernier undo
  def redo()

    if(@indice >= @nbElement)
      raise("Vous etes au bout de la undoRedo")
    else
      @indice += 1
      return @actions.at(@indice - 1)
    end

  end

  ##
  #Cette méthode permet de savoir si la undoRedo est vide
  #return::
  # * true Si la undoRedo est vide
  # * false Sinon
  def empty?()
    return @actions.empty?()
  end

  ##
  #Cette méthode permet de vider la undoRedo
  def clear()

    @actions.clear()
    @indice = 0
    @nbElement = 0
    return self

  end

end
