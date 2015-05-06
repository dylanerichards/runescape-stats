require_relative "skill"
require "net/http"
require "csv"

class Player
  attr_reader :stats

  def initialize(attrs = {})
    @username = attrs[:username].downcase
    @stats = skills

    stats.each do |stat|
      self.class.send :define_method, stat[0].downcase.to_sym do
        skill = stat[0]
        level = stat[2].to_i
        experience = stat[3].to_i
        rank = stat[1].to_i

        { skill: skill, level: level, experience: experience, rank: rank }
      end
    end
  end


  def skills
    uri = URI("http://services.runescape.com/m=hiscore/index_lite.ws?player=#{@username}")
    response = Net::HTTP.get(uri)
    skills = format_stats(CSV.parse(response).take(27))
  end

  def format_stats(array_of_stats)
    Skill::LIST.zip(array_of_stats).flatten.each_slice(4).to_a
  end
end
