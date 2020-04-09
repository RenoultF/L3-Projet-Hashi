
##
# Auteur Brabant Mano
# Version 0.1 : Date : 09/04/2020



require 'gtk3'


class ChoixNomUI < Gtk::Entry

  attr_reader :menu

  def initialize(menu)

    super()

    @menu = menu

  end

end
