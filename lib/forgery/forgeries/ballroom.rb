class Forgery::Ballroom < Forgery
  def self.section
    dictionaries[:sections].random.unextend
  end

  def self.dance
    dictionaries[:dances].random.unextend
  end

  def self.level
    dictionaries[:levels].random.unextend
  end
end
