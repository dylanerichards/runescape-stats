require_relative "skill"
require "net/http"
require "csv"

class Player
  attr_reader :stats

  def initialize(attrs = {})
    @username = attrs[:username].downcase
    @stats = skills

    stats.each do |stat|
      skill = stat[0]
      level = stat[2].to_i
      experience = stat[3].to_i
      rank = stat[1].to_i

      self.class.send :define_method, stat[0].downcase.to_sym do
        { skill: skill, level: level, experience: experience, rank: rank }
      end

      self.class.send :define_method, ("#{stat[0]}".downcase + "_experience_to_99").to_sym do
        13034431 - experience
      end
    end
  end


  def skills
    uri = URI("http://services.runescape.com/m=hiscore_oldschool/index_lite.ws?player=#{@username}")
    response = Net::HTTP.get(uri)
    skills = format_stats(CSV.parse(response).take(27))
  end

  def format_stats(array_of_stats)
    Skill::LIST.zip(array_of_stats).flatten.each_slice(4).to_a
  end
end

p survive = Player.new(username: "Survive").agility_experience_to_99
