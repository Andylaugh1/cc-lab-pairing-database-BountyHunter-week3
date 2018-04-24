require("pry")
require_relative("models/bounty_hunter")

BountyHunter.delete_all()

hunter1 = BountyHunter.new({
  "name" => "Carlos",
  "species" => "crocoline",
  "homeworld" => "Avatar",
  "bounty_value" => "300"
  })
hunter1.save()

hunter2 = BountyHunter.new({
  "name" => "Andy",
  "species" => "Demagorgon",
  "homeworld" => "Pandora",
  "bounty_value" => "900"
  })
hunter2.save()



binding.pry
nil
