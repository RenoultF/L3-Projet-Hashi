Gem::Specification.new do |s|
  s.name        = 'Hashiparmentier'
  s.version     = '0.1.0'
  s.executables << 'Hashi'
  s.date        = '2020-04-14'
  s.summary     = 'test'
  s.description = 'Un jeu de Hashiwokakero'
  s.authors     = ["Brabant Mano", "Jolliet Corentin", "Oranskii Andrew", "Pitaut Adrien", "Renoult Florent", "Serelle Erwan"]
  s.email       = "florent.renoult.etu@univ-lemans.fr"
  s.files       = ["lib/Hashi.rb", "launcher.command"] + Dir.glob("lib/Hashi/**/**/**/**") + Dir.glob("bin/**/**/**/**")
  s.homepage    = "https://rubygems.org/gems/Hashi"
  s.license     = 'MIT'
  s.add_dependency 'gtk3', '~> 3.4.1'
  s.add_dependency 'activerecord', '~> 6.0.2.1'
end
