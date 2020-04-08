##
# Auteur JOLLIET Corentin
# Version 0.1 : Date : Fri Mar 06 09:24:44 CET 2020
#

class Chrono

	@minutes
	@secondes
	@active
	@grille

	def initialize(grille)
		@minutes = 0
		@secondes = 0
		@grille = grille
	end

	def afficherTps()
		if(@minutes < 10)
			if(@secondes < 10)
				return ("0#{@minutes}:0#{@secondes}")
			else
				return("0#{@minutes}:#{@secondes}")
			end
		else if(@secondes < 10)
				return("#{@minutes}:0#{@secondes}")
			else
				return("#{@minutes}:#{@secondes}")
			end
		end
	end

	def activeChrono()
		if (@active)
			@active = false
		else
			@active = true
		end
	end

	def razChrono()
		@minutes = 0;
		@secondes = 0;
	end

	def razChrLbl(chr)
		self.razChrono();
		chr.set_label("00:00")
	end

	def lancerChrono()
	#Chrono sans arguments
		self.activeChrono()
		while( (@minutes < 59) && @active )
			print("Chrono : " + self.afficherTps()+"\n")
			sleep(1)
			@secondes += 1
			if(@secondes%10 == 0)
				@grille.modifScore(-10)
			end
			if(@secondes >= 60)
				@minutes += 1
				@secondes = 0
			end
		end
		@grille.setTempsFin(@minutes, @secondes)
	end

	def lancerChrono2(tps, chrono)
	#Chrono avec arguments : Durée du Chrono, Label du Chrono
		self.activeChrono()
		while( (@minutes < tps) & @active )
			chrono.set_label(self.afficherTps())
			sleep(1)
			@secondes += 1
			if(@secondes >= 60)
				@minutes += 1
				@secondes = 0
			end
		end
	end

end # Marqueur de fin de classe

# Test Chrono
# c = Chrono.new()
# c.lancerChrono()
