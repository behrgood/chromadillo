module ApplicationHelper
  def generate_font_combo(project_type)
    case project_type
    when "Journalism" || "Historical"
      return [humanist_serif, humanist_sans ]
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
