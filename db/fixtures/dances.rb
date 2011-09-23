# This is a bit fragile; requires it to be in sync with `sections.rb`
standard       = 1
latin          = 2
smooth         = 3
rhythm         = 4

# Standard
Dance.seed do |d|
  d.id         = 1
  d.name       = "International Waltz"
  d.section_id = standard
end

Dance.seed do |d|
  d.id         = 2
  d.name       = "International Tango"
  d.section_id = standard
end

Dance.seed do |d|
  d.id         = 3
  d.name       = "International Foxtrot"
  d.section_id = standard
end

Dance.seed do |d|
  d.id         = 4
  d.name       = "International Viennese Waltz"
  d.section_id = standard
end

Dance.seed do |d|
  d.id         = 5
  d.name       = "International Quickstep"
  d.section_id = standard
end

# Latin
Dance.seed do |d|
  d.id         = 6
  d.name       = "International Cha Cha"
  d.section_id = latin
end

Dance.seed do |d|
  d.id         = 7
  d.name       = "International Rumba"
  d.section_id = latin
end

Dance.seed do |d|
  d.id         = 8
  d.name       = "International Samba"
  d.section_id = latin
end

Dance.seed do |d|
  d.id         = 9
  d.name       = "International Jive"
  d.section_id = latin
end

Dance.seed do |d|
  d.id         = 10
  d.name       = "International Paso Doble"
  d.section_id = latin
end

# Smooth
Dance.seed do |d|
  d.id         = 11
  d.name       = "American Waltz"
  d.section_id = smooth
end

Dance.seed do |d|
  d.id         = 12
  d.name       = "American Tango"
  d.section_id = smooth
end

Dance.seed do |d|
  d.id         = 13
  d.name       = "American Foxtrot"
  d.section_id = smooth
end

Dance.seed do |d|
  d.id         = 14
  d.name       = "American Viennese Waltz"
  d.section_id = smooth
end

# Rhythm
Dance.seed do |d|
  d.id         = 15
  d.name       = "American Cha Cha"
  d.section_id = rhythm
end

Dance.seed do |d|
  d.id         = 16
  d.name       = "American Rumba"
  d.section_id = rhythm
end

Dance.seed do |d|
  d.id         = 17
  d.name       = "American Swing"
  d.section_id = rhythm
end

Dance.seed do |d|
  d.id         = 18
  d.name       = "American Bolero"
  d.section_id = rhythm
end

Dance.seed do |d|
  d.id         = 19
  d.name       = "American Mambo"
  d.section_id = rhythm
end
