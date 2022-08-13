$:.unshift(File.join(__dir__, "../BCDice/lib"))
require "bcdice/repl"
require "json"

def target_files
    env_target = ENV["target"]
    unless env_target
      return Dir.glob("BCDice/test/data/*.toml")
    end

    files = env_target.split(",").map do |target|
      target_with_extension = target.end_with?(".toml") ? target : "#{target}.toml"
      path = "test/data/#{target_with_extension}"

      unless File.exist?(path)
        warn("Unknown target: #{path}")
        next nil
      end

      path
    end

    return files.compact
  end


obj = BCDice::all_game_systems.map do |s|
    begin
        g = s.new("")
        toml = "BCDice/test/data/#{ s::ID.tr(":.", "_")}.toml" 
        rb = toml.gsub("/test/data/","/lib/bcdice/game_system/").gsub(".toml",".rb")
        { "id" => s::ID,
        "name" => s::NAME,
        "sort_key" => s::SORT_KEY,
        "help" => s::HELP_MESSAGE,
        #"test" => (File.exist?(toml) ? File.open(toml).read : nil),
        #"source" => (File.exist?(rb) ? File.open(rb).read : nil),
        "prefixes" => s.prefixes,
        "sort_add_dice" => g.sort_add_dice?,
        "sort_barabara_dice" => g.sort_barabara_dice?,
        "d66_sort_type" => g.d66_sort_type,
        "sides_implicit_d" => g.sides_implicit_d,
        "round_type" => g.round_type,
        }
    rescue Exception => e
        puts(e)
    end
end
# puts(target_files)
puts(JSON.dump( { "hash" => ARGV[0] , "list" => obj }))