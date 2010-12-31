require 'fileutils'

# Helper that calls out to the lua processor to turn
# a bunch of lua to JSON, returns the hash pulled from JSON
module LuaProcessor
  LUA_BASE_PATH = Rails.root.join("lib", "lua")
  LUA_BINARY_PATH = proc { LUA_BASE_PATH.join(`uname -s`.strip.downcase, "lua") }
  LUA_LIB = proc { |filename| Rails.root.join("lib", "lua", filename) }

  def run(lua_file, to_process, *args)
    json = nil

    FileUtils.cd(LUA_BASE_PATH.to_s) do
      json = `#{LUA_BINARY_PATH.call.to_s} #{LUA_LIB.call(lua_file)} #{to_process} #{args.join(" ")}`
    end

    ActiveSupport::JSON.decode(json)
  end
  module_function :run
end
