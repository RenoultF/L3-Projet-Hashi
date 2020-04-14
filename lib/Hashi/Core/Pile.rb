
##
# Auteur:: Brabant Mano
# Version:: 0.1
# Date:: 09/04/2020
#
#Cette classe représente une pile
class Pile

  #@indice => La position dans la pile
  attr_reader :indice

  include Enumerable

  private_class_method :new

  ##
  #Ce constructeur permet de créer une nouvelle pile
  #param::
  # * max Le nombre maximum d'élément dans la pile ("infini" par defaut)
  def Pile.creer(max = 0)
    new(max)
  end

  #:nodoc:
  def initialize(max)

    @actions = Array.new()
    @max = max

  end
  #:doc:

  ##
  #Cette méthode permet de d'empiler un élément
  #param::
  # * element L'élément à empiler
  def empiler(element)

    if(@max > 0)
      if(@actions.length < @max)
        @actions.push(element)
      end
    else
      @actions.push(element)
    end
    return self

  end

  ##
  #Cette méthode permet de dépiler le dernier élément
  #return::
  # * L'élément dépilé
  # * raiseException Si la pile est vide
  def depiler

    if(self.empty?())
      raise("La pile est vide")
    else
      return @actions.pop()
    end

  end

  ##
  #Cette méthode permet de savoir si la pile est vide ou non
  #return::
  # * true Si la pile est vide
  # * false Sinon
  def empty?()
    return @actions.empty?()
  end

  ##
  #Cette méthode permet d'itérer sur tous les éléments de la pile
  def each

    @actions.each do |hyp|
       yield hyp
     end

  end

end
