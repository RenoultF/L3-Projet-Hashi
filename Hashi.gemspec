Gem::Specification.new do |s|
  s.name        = 'Hashiparmentier'
  s.version     = '0.4.0'
  s.executables << 'Hashiparmentier'
  s.date        = '2020-04-14'
  s.summary     = 'test'
  s.description = 'Un jeu de Hashiwokakero'
  s.authors     = ["Brabant Mano", "Jolliet Corentin", "Oranskii Andrew", "Pitaut Adrien", "Renoult Florent", "Serelle Erwan"]
  s.email       = "florent.renoult.etu@univ-lemans.fr"
  s.files       = ["lib/Hashiparmentier.rb", "launcher.command"] + Dir.glob("lib/Hashiparmentier/**/**/**/**") + Dir.glob("bin/**/**/**/**")
  s.homepage    = "https://rubygems.org/gems/Hashi"
  s.license     = 'MIT'
  s.add_dependency 'gtk3', '~> 3.4.1'
  s.add_dependency 'activerecord', '~> 6.0.2.1'
  s.add_dependency 'sqlite3', '~> 1.4.1'
end
