require 'gtk3'

##
# Auteur:: Adrien PITAULT
# Version:: 0.1
# 
#On définit ici les styles en CSS qui seront appliqués à certains éléments des fenètre

#
# CSS MENU
#
@@CSS_BG_MENU ||= Gtk::CssProvider.new
@@CSS_BG_MENU.load(data: <<-CSS)
    * {
        background-image: url("lib/Hashiparmentier/glade/images/bg.jpg");
    }
    CSS

#
# CSS JEU
#
@@CSS_BG_JEU ||= Gtk::CssProvider.new
@@CSS_BG_JEU.load(data: <<-CSS)
    * {
        background-image: url("lib/Hashiparmentier/glade/images/wJapStylePlusNet15.jpg");
    }
    CSS

#
# CSS REGLES
#
@@CSS_REGLES ||= Gtk::CssProvider.new
@@CSS_REGLES.load(data: <<-CSS)
    * {
        background-image: linear-gradient(#e7b7b0, white);
    }
    CSS
    
#
# CSS AIDE
#
@@CSS_AIDE ||= Gtk::CssProvider.new
@@CSS_AIDE.load(data: <<-CSS)
    * {
        background-image: linear-gradient(#e7b7b0, white);
    }
    CSS

#
# 
#
@@CSS_ASTUCES ||= Gtk::CssProvider.new
@@CSS_ASTUCES.load(data: <<-CSS)
    * {
        background-image: linear-gradient(#e7b7b0, white);
    }
    CSS
    
#
# CSS FIN
#
@@CSS_FIN ||= Gtk::CssProvider.new
@@CSS_FIN.load(data: <<-CSS)
    * {
        background-image: linear-gradient(#a40d0f, white);
    }
    CSS

#
# CSS des togles du menu
#
@@CSS_BUTTON_ACTIVE ||= Gtk::CssProvider.new
@@CSS_BUTTON_ACTIVE.load(data: <<-CSS)
    button{
        background-image: image(#F9CEC7);
        border: 2px solid #e29085;
        box-shadow: 3px 3px 2px #656565;
        font-weight: bold;
    }
    button:checked {
        background-image: image(#e7b7b0);
        border-style: solid;
        border-width: 2px;
        border-color: #c47d73;
        font-weight: bold;
    }
    CSS

#
# REGLAGES POUR LES LABELS DU MENU
#
@@CSS_LABEL_MENU ||= Gtk::CssProvider.new
@@CSS_LABEL_MENU.load(data: <<-CSS)
    label {
       margin-top: 30px;
       margin-bottom: 5px;
    }
    CSS

#
# CSS DES BOUTONS EN HAUT ET BAS DU MENU
#
@@CSS_BTN_TOPMENU ||= Gtk::CssProvider.new
@@CSS_BTN_TOPMENU.load(data: <<-CSS)
    button{
        background-image: image(#ae9bf4);
        border: 2px solid #6e4af2;
        box-shadow: 3px 3px 2px #656565;
        font-weight: bold;
    }
    button:active {
        background-image: image(#FAECBA);
        border-style: solid;
        border-width: 2px;
        border-color: #c47d73;
        font-weight: bold;
        color:black;
    }
    CSS

#
# CSS DES BOUTONS DANS LA FENETRE DE JEUX
#
@@CSS_BTN_JEU ||= Gtk::CssProvider.new
@@CSS_BTN_JEU.load(data: <<-CSS)
    button{
        background-image: image(#a40d0f);
        border: 2px solid #7a0808;
        box-shadow: 3px 3px 2px #656565;
        font-weight: bold;
        color: white;        
    }
    button:active {
        background-image: image(#FAECBA);
        border-style: solid;
        border-width: 2px;
        border-color: #c47d73;
        font-weight: bold;
        color:black;
    }
    CSS


#
# CSS DES BOUTONS ROSES
#

@@CSS_BUTTON_ROSE ||= Gtk::CssProvider.new
@@CSS_BUTTON_ROSE.load(data: <<-CSS)
    button{
        background-image: image(#F9CEC7);
        border: 2px solid #e29085;
        box-shadow: 3px 3px 2px #656565;
        font-weight: bold;
    }
    CSS

#
# CSS DE LA BOX AVEC SCORE, CHRONO, PSEUDO ET CELLE DES CHECKPOINT
#
@@CSS_BOX_STAT ||= Gtk::CssProvider.new
@@CSS_BOX_STAT.load(data: <<-CSS)
    * {
        border-radius: 15px;
        border: 2px solid #a40d0f;
        font-weight: bold;
        padding: 5px;
        background-image: image(#e6e1b9);
        font-size:12px;
    }
    CSS


#
# AFFICHAGE DANS LE LABEL RESULTAT D'UNE IMAGE AVEC 1 - 2 - 3 ETOILES
#
@@CSS_BG_SCORE1 ||= Gtk::CssProvider.new
@@CSS_BG_SCORE1.load(data: <<-CSS)
    * {
        background-image: url("lib/Hashiparmentier/glade/images/1stars.png");
    }
    CSS

@@CSS_BG_SCORE2 ||= Gtk::CssProvider.new
@@CSS_BG_SCORE2.load(data: <<-CSS)
    * {
        background-image: url("lib/Hashiparmentier/glade/images/2stars.png");
    }
    CSS

@@CSS_BG_SCORE3 ||= Gtk::CssProvider.new
@@CSS_BG_SCORE3.load(data: <<-CSS)
    * {
        background-image: url("lib/Hashiparmentier/glade/images/3stars.png");
    }
    CSS

