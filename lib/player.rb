# contains the color for each player
class Player
  attr_reader :color

  def initialize(color = "\u26aa")
    @color = color
  end
end
