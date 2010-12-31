-- This script takes a Ni Karma file, parses it and outputs to stdout
-- the data formatted in JSON format that Ruby can then slurp up and
-- use as needed
--
-- Usage:
--   ni_karma_parser.lua [path to karma file] [database name]
--  
dofile("json.lua")

karma_file = arg[1]
database = arg[2]

karma_data_fn = loadfile(karma_file)
karma_data = karma_data_fn()

-- Get the database
to_use = KarmaList[database]

-- Convert to JSON and print
print(Json.Encode(to_use))
