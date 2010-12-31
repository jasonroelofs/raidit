# Embedded in Characters, keep track of the
# history of a given character's loot and/or raid attendance
class LootHistoryEntry
  include MongoMapper::EmbeddedDocument

  key :timestamp, Time
  key :amount, Integer
  key :item, String
  key :reason, String
end
