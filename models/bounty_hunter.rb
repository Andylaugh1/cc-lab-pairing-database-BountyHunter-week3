require("pg")

class BountyHunter

  attr_accessor :name, :species, :homeworld, :bounty_value

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @name = options["name"]
    @species = options["species"]
    @homeworld = options["homeworld"]
    @bounty_value = options["bounty_value"].to_i
  end

  def save()
    db = PG.connect({
      dbname: "bounty_hunters",
      host: "localhost"
      })
    sql = "INSERT INTO bounty_hunters
    (name, species, homeworld, bounty_value)
    VALUES ($1, $2, $3, $4) RETURNING id"
    values = [@name, @species, @homeworld, @bounty_value]
    db.prepare("save", sql)
    @id = db.exec_prepared("save", values)[0]["id"].to_i
    db.close()
  end

  def update()
    db = PG.connect({
      dbname: "bounty_hunters",
      host: "localhost"
      })
    sql = "UPDATE bounty_hunters
    SET (name, species, homeworld, bounty_value) = ($1, $2, $3, $4) WHERE id = $5"
    values = [@name, @species, @homeworld, @bounty_value, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close()

  end

  def BountyHunter.delete_all()
    db = PG.connect({
      dbname: "bounty_hunters",
      host: "localhost"
      })
    sql = "DELETE FROM bounty_hunters"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close()
  end

  def BountyHunter.find_by_name(input_name)
    db = PG.connect({
      dbname: "bounty_hunters",
      host: "localhost"
      })
    sql = "SELECT * FROM bounty_hunters WHERE name = $1"
    db.prepare("find_by_name", sql)
    values = [input_name]
    result_hash = db.exec_prepared("find_by_name", values)[0]
    db.close
    return BountyHunter.new(result_hash)

  end




end
