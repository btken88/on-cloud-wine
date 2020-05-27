class Wine < ActiveRecord::Base
  has_many :user_wines
  has_many :users, through: :user_wines

  def self.browse_wines
    red_or_white = {
      "Red" => 1,
      "White" => 2
    }
    color_choice =  $prompt.select('What color of wine would you like to peruse?:', red_or_white)

    case color_choice
    when 1
      self.reds
    when 2
      self.whites
    end
  end

  def self.reds
    type_of_red = {
      "All Varietals" => 1,
      "Cabernet Franc" => 2,
      "Syrah" => 3,
      "Petit Verdot" => 4,
      "Rhône-Style Blend" => 5,
      "Teroldego" => 6,
      "Merlot" => 7,
      "Bordeaux-Style Blend" => 8,
      "Graciano" => 9,
      "Blend" => 10,
      "Previous Page" => 11
    }

    choice_of_red = $prompt.select("Your choice of varietal?:", type_of_red)

    case choice_of_red
    when 1
      self.all_reds
    when 2
      self.cabernet_franc
    when 3
      self.syrah
    when 4 
      self.petit_verdot
    when 5
      self.rhone_style_blend
    when 6
      self.teroldego
    when 7
      self.merlot
    when 8
      self.bordeaux_style_blend
    when 9
      self.graciano
    when 10
      self.red_blend
    when 11
      browse_wines
    end
  end

  def self.whites
    type_of_white = {
    "All Varietals" => 1,
    "Gewürztraminer" => 2,
    "Cabernet Sauvignon" => 3,
    "Riesling" => 4,
    "Voigner" => 5,
    "Moscato" => 6,
    "Chardonnay" => 7,
    "Blend" =>8,
    "Previous Page" => 9
    }

    choice_of_white = $prompt.select("Your choice of varietal?:", type_of_white)

    case choice_of_white
    when 1
      self.all_whites
    when 2
      self.gewurztraminer
    when 3
      self.cabernet_sauvignon
    when 4
      self.riesling
    when 5
      self.voigner
    when 6
      self.moscato
    when 7
      self.chardonnay
    when 8
      self.white_blend
    when 9
      browse_wines
    end
  end

  def self.all_reds
  end

  def self.all_whites
  end

  def self.cabernet_franc
    puts "TEST"
  end

  def self.syrah
  end

  def self.petit_verdot
  end

  def self.rhone_style_blend
  end

  def self.teroldego
  end

  def self.merlot
  end

  def self.bordeaux_style_blend
  end

  def self.graciano
  end

  def self.red_blend
  end

  def self.gewurztraminer
  end

  def self.cabernet_sauvignon
  end
  
  def self.riesling
  end

  def self.voigner
  end

  def self.moscato
  end

  def self.chardonnay
  end

  def self.white_blend
  end
end