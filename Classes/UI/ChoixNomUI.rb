
##
# Auteur Brabant Mano
# Version 0.1 : Date : 09/04/2020



require 'gtk3'


class ChoixNomUI < Gtk::Box

  attr_reader :menu
  attr_reader :entry

  def initialize(menu)

    super(:vertical, 0)

    @menu = menu

    @entry = Gtk::Entry.new()
    @label = Gtk::Label.new("Prénom")

    temp = Gtk::Box.new(:horizontal, 0)

    temp.pack_start(@label)
    temp.pack_start(@entry, :expand => true, :fill => true)

    pack_start(temp, :expand => true, :fill => true)

  end

end
