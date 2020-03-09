##
# Auteur JOLLIET Corentin
# Version 0.1 : Date : Fri Mar 06 09:24:44 CET 2020
#
require 'gtk3'

class Chrono

	@minutes
	@secondes
	@active

	def initialize()
		@minutes = 0
		@secondes = 0
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

	def lancerChrono()
	#Chrono sans arguments
		self.activeChrono()
		while( (@minutes < 59) && @active )
			sleep(1)
			@secondes += 1
			if(@secondes >= 60)
				@minutes += 1
				@secondes = 0
			end
			puts self.afficherTps()
		end
	end

	def lancerChrono(tps, chrono)
	#Chrono avec arguments : Durée du Chrono, Label du Chrono
		self.activeChrono()
		while( @minutes < tps )
			sleep(1)
			@secondes += 1
			if(@secondes >= 60)
				@minutes += 1
				@secondes = 0
			end
			chrono.set_text(self.afficherTps())
		end
	end

end # Marqueur de fin de classe

# Test Chrono
# c = Chrono.new()
# c.lancerChrono()
