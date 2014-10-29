class WelcomeController < ApplicationController

  def index
    @projects = get_project_type
    @palettes = get_palette_type
  end

  def display
    @font_pair = generate_font_combo(@project)
    @project = params[:project_type]
    @palette = params[:palette_type]
    @projects = get_project_type
    @palettes = get_palette_type
  end


  private

  def get_project_type
    projects = [
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

  def get_palette_type
    palettes = [
      ["Monochromatic", "Monochromatic" ],
      ["Analogous", "Analogous" ],
      ["Complimentary", "Complimentary" ],
    ]
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
end
