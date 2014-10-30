class Scheme < ActiveRecord::Base
  attr_accessor :project_type, :palette_type, :base_color
  before_create :generate

  validates_presence_of :project_type, :palette_type, :base_color
  has_many :users

  def generate
    generate_base_hue(base_color)
    populate_fonts(project_type)
    populate_colors(palette_type)
  end


  def populate_colors(palette_type)
    case palette_type
    when "Monochromatic"
      self.color1, self.color2, self.color3, self.color4, self.color5 = generate_monochromatic_scheme(generate_base_hue(base_color))
    when "Complimentary"
      self.color1, self.color2, self.color3, self.color4, self.color5 = generate_complimentary_scheme(generate_base_hue(base_color))
    when "Analogous"
      self.color1, self.color2, self.color3, self.color4, self.color5 = generate_analogous_scheme(generate_base_hue(base_color))
    end
  end

  def populate_fonts(project_type)
    self.font1, self.font2 = generate_font_combo(project_type)
  end

  def generate_font_combo(project_type)
    case project_type
    when "Journalism" || "Historical"
      return [humanist_serif, humanist_sans ] # index 0 will be header, 1 will be body
    when "Historical"
      return [humanist_serif, humanist_sans ]
    when "Academia" || "Legal"
      return [transitional_serif, transitional_sans ]
    when "Legal"
      return [transitional_serif, transitional_sans ]
    when "Arts + Culture"
      return [ modern_serif, humanist_sans ]
    when "Marketing"
      return [ modern_serif, humanist_sans ]
    when "Promotional"
      return [ modern_serif, humanist_sans ]
    when "Government"
      return [humanist_sans, humanist_serif ]
    when "Education"
      return [humanist_sans, humanist_serif ]
    when "Finance"
      return [humanist_sans, humanist_serif ]
    when "Technology"
      return [transitional_sans, transitional_serif]
    when "Transportation"
      return [transitional_sans, transitional_serif]
    when "Science"
      return [geometric_sans, transitional_serif]
    when "Architecture"
      return [geometric_sans, transitional_serif]
    end
  end


  def generate_monochromatic_scheme(base_hue)
    [ "#{base_hue}, #{(0..100).to_a.sample}%, #{(0..100).to_a.sample}%", "#{base_hue}, #{(0..100).to_a.sample}%, #{(0..100).to_a.sample}%","#{base_hue}, #{(0..100).to_a.sample}%, #{(0..100).to_a.sample}%","#{base_hue}, #{(0..100).to_a.sample}%, #{(0..100).to_a.sample}%","#{base_hue}, #{(0..100).to_a.sample}%, #{(0..100).to_a.sample}%"]
  end

  def generate_complimentary_scheme(base_hue)
    if base_hue + 180 <= 360
      ["#{base_hue + [0,180].sample}, #{(0..100).to_a.sample}%, #{(0..100).to_a.sample}%" , "#{base_hue + [0,180].sample}, #{(0..100).to_a.sample}%, #{(0..100).to_a.sample}%" , "#{base_hue + [0,180].sample}, #{(0..100).to_a.sample}%, #{(0..100).to_a.sample}%" , "#{base_hue + [0,180].sample}, #{(0..100).to_a.sample}%, #{(0..100).to_a.sample}%" , "#{base_hue + [0,180].sample}, #{(0..100).to_a.sample}%, #{(0..100).to_a.sample}%"]
    else
      [ "#{base_hue - [0,180].sample}, #{(0..100).to_a.sample}%, #{(0..100).to_a.sample}%" , "#{base_hue - [0,180].sample}, #{(0..100).to_a.sample}%, #{(0..100).to_a.sample}%" , "#{base_hue - [0,180].sample}, #{(0..100).to_a.sample}%, #{(0..100).to_a.sample}%" , "#{base_hue - [0,180].sample}, #{(0..100).to_a.sample}%, #{(0..100).to_a.sample}%" , "#{base_hue - [0,180].sample}, #{(0..100).to_a.sample}%, #{(0..100).to_a.sample}%"]
    end
  end

  def generate_analogous_scheme(base_hue)
    if base_hue + 40 <= 360 && base_hue - 40 >= 0
      [ "#{base_hue + (-40..40).to_a.sample}, #{(0..100).to_a.sample}%, #{(0..100).to_a.sample}%", "#{base_hue + (-40..40).to_a.sample}, #{(0..100).to_a.sample}%, #{(0..100).to_a.sample}%", "#{base_hue + (-40..40).to_a.sample}, #{(0..100).to_a.sample}%, #{(0..100).to_a.sample}%", "#{base_hue + (-40..40).to_a.sample}, #{(0..100).to_a.sample}%, #{(0..100).to_a.sample}%", "#{base_hue + (-40..40).to_a.sample}, #{(0..100).to_a.sample}%, #{(0..100).to_a.sample}%"]
    elsif base_hue - 40 < 0
      [ "#{(0..40).to_a.sample}, #{(0..100).to_a.sample}%, #{(0..100).to_a.sample}%" , "#{(0..40).to_a.sample}, #{(0..100).to_a.sample}%, #{(0..100).to_a.sample}%" , "#{(0..40).to_a.sample}, #{(0..100).to_a.sample}%, #{(0..100).to_a.sample}%" , "#{(0..40).to_a.sample}, #{(0..100).to_a.sample}%, #{(0..100).to_a.sample}%" , "#{(0..40).to_a.sample}, #{(0..100).to_a.sample}%, #{(0..100).to_a.sample}%" ]
    elsif base_hue + 40 > 360
      [ "#{(320..360).to_a.sample}, #{(0..100).to_a.sample}%, #{(0..100).to_a.sample}%" , "#{(320..360).to_a.sample}, #{(0..100).to_a.sample}%, #{(0..100).to_a.sample}%" , "#{(320..360).to_a.sample}, #{(0..100).to_a.sample}%, #{(0..100).to_a.sample}%" , "#{(320..360).to_a.sample}, #{(0..100).to_a.sample}%, #{(0..100).to_a.sample}%" , "#{(320..360).to_a.sample}, #{(0..100).to_a.sample}%, #{(0..100).to_a.sample}%" ]
    end
  end


  def egyptian_serif
    ["Arvo", "Bitter", "Coustard", "Patua One", "Rockwell"].sample
  end

  def geometric_sans
    ["Century Gothic", "Exo", "Futura", "Raleway", "Roboto"].sample
  end

  def humanist_sans
    ["Cabin", "Droid Sans", "Gill Sans", "Open Sans", "Verdana", "Fjalla One", "Ubuntu", "Oswald", "Alegreya Sans"].sample
  end

  def humanist_serif
    ["Palatino", "Crimson Text", "Garamond", "Cardo", "Merriweather"].sample
  end

  def modern_serif
    ["Playfair Display", "Bodoni", "Didot", "Old Standard TT", "Oranienbaum"].sample
  end

  def transitional_serif
    ["Baskerville", "Droid Serif", "Lora", "Poly", "Times New Roman"].sample
  end

  def transitional_sans
    ["Helvetica", "PT Sans", "Source Sans Pro" , "Trebuchet MS"].sample
  end


  # def random_color
  #   c = "%06x" % (rand * 0xffffff)
  #   " ##{c}"
  # end
  def generate_base_hue(base_color)
    case base_color
    when "Red"
      return (1..10).to_a.sample
    when "Orange"
      return (20..30).to_a.sample
    when "Yellow"
      return (46..60).to_a.sample
    when "green"
      return (80..140).to_a.sample
    when "Blue"
      return (175..250).to_a.sample
    when "Purple"
      return (262..277).to_a.sample
    when "Pink"
      return (290..335).to_a.sample
    end
  end

  def self.palettes
    [
      ["Monochromatic", "Monochromatic" ],
      ["Analogous", "Analogous" ],
      ["Complimentary", "Complimentary" ],
    ]
  end


  def self.projects
    [
      ["Academia", "Academia" ],
      ["Architecture", "Architecture" ],
      ["Arts + Culture", "Arts + Culture" ],
      ["Education", "Education" ],
      ["Government", "Government" ],
      ["History", "History" ],
      ["Legal", "Legal" ],
      ["Marketing", "Marketing" ],
      ["Promotional", "Promotional" ],
      ["Science", "Science" ],
      ["Technology", "Technology"],
      ["Transportation", "Transportation"]
    ]
  end

  def self.colors
    [
      ["Red", "Red" ],
      ["Orange", "Orange" ],
      ["Yellow", "Yellow" ],
      ["Green", "Green" ],
      ["Orange", "Orange" ],
      ["Yellow", "Yellow" ],
      ["Blue", "Blue" ],
      ["Purple", "Purple" ],
      ["Pink", "Pink" ]
    ]
  end

end
