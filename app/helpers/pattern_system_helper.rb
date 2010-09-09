module PatternSystemHelper

  def classification_name(field_desc)
    if field_desc.pattern_formalism.present? \
      && field_desc.pattern_formalism.system_formalism.pattern_formalisms.count > 1
      
      field_desc.pattern_formalism.name.capitalize + ':'
    else
      ''
    end + field_desc.section.capitalize + ':' + field_desc.name.capitalize
  end
end
