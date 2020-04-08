
require "../Core/Grille.rb"

require "../UI/CaseUI.rb"
require "../UI/IleUI.rb"
require "../UI/PontUI.rb"
require "gtk3"


class GrilleUI < Gtk::DrawingArea

  attr_reader :grille

  def initialize(grille, taille = 40, cameraX = 0)

    super()

    @grille = grille
    @mat = Array.new(@grille.tailleX()) { Array.new(@grille.tailleY()) }
    @taille = taille
    @cameraX = cameraX

    self.set_size_request(@grille.tailleY() * @taille, @grille.tailleX() * @taille)

    for i in 0..(@grille.tailleX()-1)
      for j in 0..(@grille.tailleY()-1)
        c = @grille.getCase(i, j)
        if(c.estIle?())
          @mat[i][j] = IleUI.new(c, @taille, @cameraX)
        elsif(c.estPont?())
          @mat[i][j] = PontUI.new(c, @taille, @cameraX)
        else
          @mat[i][j] = CaseUI.new(c, @taille, @cameraX)
        end

      end
    end

    self.signal_connect "draw" do
      self.on_draw()
    end

    self.signal_connect "button-press-event" do |widget, event|
      self.clickOn(widget, event)
    end

    self.add_events([:button_press_mask])


  end

  def getCase(i, j)

    return @mat[i][j]

  end

  def sortLimite?(i, j)

    return @grille.sortLimite?(i, j)

  end

  def clickOn(widget, event)

    y = (event.x/@taille).to_i
    x = (event.y/@taille).to_i

    if(!sortLimite?(x, y))
      getCase(x, y).clickOn()
    end

    self.queue_draw()

  end


  def on_draw()

    draw(self.window)

    @mat.each do |l|
      l.each do |c|
        c.draw(self.window)
      end
    end

  end


  def draw(window)

    cr = window.create_cairo_context

    cr.set_source_rgb(255, 255, 255)
    cr.rectangle(0, 0, @taille * @grille.tailleY(), @taille * @grille.tailleX() + @cameraX)
    cr.fill()


  end



end
