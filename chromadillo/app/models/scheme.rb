class Scheme < ActiveRecord::Base
  attr_accessor :project_type, :palette_type
  before_create :generate

  validates_presence_of :project_type, :palette_type


  def generate
    populate_fonts(project_type)
    populate_colors(palette_type)

  end

  def populate_colors(palette_type)
  end


  def populate_fonts(project_type)
    self.font1, self.font2 = generate_font_combo(project_type)
  end

  def generate_font_combo(project_type)
    case project_type
    when "Journalism" || "Historical"
      return [humanist_serif, humanist_sans ] # index 0 will be header, 1 will be body
    when "Academia" || "Legal"
      return [transitional_serif, transitional_sans ]
    when "Arts + Culture" || "Marketing" || "Promotional"
      return [ modern_serif, humanist_sans ]
    when "Government" || "Education" || "Finance"
      return [humanist_sans, humanist_serif ]
    when "Technology" || "Transportation"
      return [transitional_sans, transitional_serif]
    when "Science" || "Architechture"
      return [geometric_sans, transitional_serif]
    end
  end

  def generate_monochromatic_scheme(base_hue)
    [ "#{base_hue}, #{(0..100).to_a.sample}, #{(0..100).to_a.sample}", "#{base_hue}, #{(0..100).to_a.sample}, #{(0..100).to_a.sample}","#{base_hue}, #{(0..100).to_a.sample}, #{(0..100).to_a.sample}","#{base_hue}, #{(0..100).to_a.sample}, #{(0..100).to_a.sample}","#{base_hue}, #{(0..100).to_a.sample}, #{(0..100).to_a.sample}"]
  end

  def generate_complimentary_scheme(base_hue)
    if base_hue + 180 <= 360
      ["#{base_hue + [0,180].sample}, #{(0..100).to_a.sample}, #{(0..100).to_a.sample}" , "#{base_hue + [0,180].sample}, #{(0..100).to_a.sample}, #{(0..100).to_a.sample}" , "#{base_hue + [0,180].sample}, #{(0..100).to_a.sample}, #{(0..100).to_a.sample}" , "#{base_hue + [0,180].sample}, #{(0..100).to_a.sample}, #{(0..100).to_a.sample}" , "#{base_hue + [0,180].sample}, #{(0..100).to_a.sample}, #{(0..100).to_a.sample}"]
    else
      [ "#{base_hue - [0,180].sample}, #{(0..100).to_a.sample}, #{(0..100).to_a.sample}" , "#{base_hue - [0,180].sample}, #{(0..100).to_a.sample}, #{(0..100).to_a.sample}" , "#{base_hue - [0,180].sample}, #{(0..100).to_a.sample}, #{(0..100).to_a.sample}" , "#{base_hue - [0,180].sample}, #{(0..100).to_a.sample}, #{(0..100).to_a.sample}" , "#{base_hue - [0,180].sample}, #{(0..100).to_a.sample}, #{(0..100).to_a.sample}"]
    end
  end

  def generate_analogous_scheme(base_hue)
    if base_hue + 40 <= 360 && base_hue - 40 >= 0
      [ "#{base_hue + (-40..40).to_a.sample}, #{(0..100).to_a.sample}, #{(0..100).to_a.sample}", "#{base_hue + (-40..40).to_a.sample}, #{(0..100).to_a.sample}, #{(0..100).to_a.sample}", "#{base_hue + (-40..40).to_a.sample}, #{(0..100).to_a.sample}, #{(0..100).to_a.sample}", "#{base_hue + (-40..40).to_a.sample}, #{(0..100).to_a.sample}, #{(0..100).to_a.sample}", "#{base_hue + (-40..40).to_a.sample}, #{(0..100).to_a.sample}, #{(0..100).to_a.sample}"]
    elsif base_hue - 40 < 0
      [ "#{(0..40).to_a.sample}, #{(0..100).to_a.sample}, #{(0..100).to_a.sample}" , "#{(0..40).to_a.sample}, #{(0..100).to_a.sample}, #{(0..100).to_a.sample}" , "#{(0..40).to_a.sample}, #{(0..100).to_a.sample}, #{(0..100).to_a.sample}" , "#{(0..40).to_a.sample}, #{(0..100).to_a.sample}, #{(0..100).to_a.sample}" , "#{(0..40).to_a.sample}, #{(0..100).to_a.sample}, #{(0..100).to_a.sample}" ]
    elsif base_hue + 40 > 360
      [ "#{(320..360).to_a.sample}, #{(0..100).to_a.sample}, #{(0..100).to_a.sample}" , "#{(320..360).to_a.sample}, #{(0..100).to_a.sample}, #{(0..100).to_a.sample}" , "#{(320..360).to_a.sample}, #{(0..100).to_a.sample}, #{(0..100).to_a.sample}" , "#{(320..360).to_a.sample}, #{(0..100).to_a.sample}, #{(0..100).to_a.sample}" , "#{(320..360).to_a.sample}, #{(0..100).to_a.sample}, #{(0..100).to_a.sample}" ]
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


  def random_color
    c = "%06x" % (rand * 0xffffff)
    " ##{c}"
  end
  def generate_base_hue_red
    (1..10).to_a.sample
  end

  def generate_base_hue_orange
    (20..30).to_a.sample
  end

  def generate_base_hue_yellow
    (46..60).to_a.sample
  end

  def generate_base_hue_green
    (80..140).to_a.sample
  end

  def generate_base_hue_blue
    (175..250).to_a.sample
  end

  def generate_base_hue_purple
    (262..277).to_a.sample
  end

  def generate_base_hue_pink
    (290..335).to_a.sample
  end

  # def generate_base_hue_brown
  #    (1..10).to_a.sample
  # end

  # def generate_base_hue_black
  #    (1..10).to_a.sample
  # end

  # def generate_base_hue_white
  #    (1..10).to_a.sample
  # end


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
      ["Science", "Science" ],
      ["Technology", "Technology"],
      ["Transportation", "Transportation"]
    ]
  end


end
