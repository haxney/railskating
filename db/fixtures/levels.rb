Level.seed do |l|
  l.id     = Constants::Levels::NEWCOMER_ID
  l.name   = "Newcomer"
  l.weight = 100
end

Level.seed do |l|
  l.id     = Constants::Levels::BRONZE_ID
  l.name   = "Bronze"
  l.weight = 200
end

Level.seed do |l|
  l.id     = Constants::Levels::SILVER_ID
  l.name   = "Silver"
  l.weight = 300
end

Level.seed do |l|
  l.id     = Constants::Levels::GOLD_ID
  l.name   = "Gold"
  l.weight = 300
end

Level.seed do |l|
  l.id     = Constants::Levels::OPEN_ID
  l.name   = "Open"
  l.weight = 400
end

Level.seed do |l|
  l.id     = Constants::Levels::PRE_CHAMPIONSHIP_ID
  l.name   = "Pre-Championship"
  l.weight = 450
end

Level.seed do |l|
  l.id     = Constants::Levels::CHAMPIONSHIP_ID
  l.name   = "Championship"
  l.weight = 470
end
