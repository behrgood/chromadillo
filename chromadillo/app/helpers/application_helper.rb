module ApplicationHelper

  def egyptian_serif
    ["Arvo", "Bitter", "Coustard", "Patua One", "Rockwell"].sample
  end

  def geometric_sans
    ["Century Gothic", "Exo", "Futura", "Railway", "Roboto"].sample
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

  def generate_monochromatic_color(base_hue)
    "#{base_hue}, #{(0..100).to_a.sample}, #{(0..100).to_a.sample}"
  end

  def generate_analogous_color(base_hue)
    if base_hue + 180 <= 360
      "#{base_hue + [0,180].sample}, #{(0..100).to_a.sample}, #{(0..100).to_a.sample}"
    else
      "#{base_hue - [0,180].sample}, #{(0..100).to_a.sample}, #{(0..100).to_a.sample}"
    end
  end

  def generate_complimentary_color(base_hue)
    if base_hue + 40 <= 360 && base_hue - 40 >= 0
      "#{base_hue + (-40..40).to_a.sample}, #{(0..100).to_a.sample}, #{(0..100).to_a.sample}"
    elsif base_hue - 40 < 0
      "#{(0..40).to_a.sample}, #{(0..100).to_a.sample}, #{(0..100).to_a.sample}"
    elsif base_hue + 40 > 360
      "#{(320..360).to_a.sample}, #{(0..100).to_a.sample}, #{(0..100).to_a.sample}"
    end
  end
end
