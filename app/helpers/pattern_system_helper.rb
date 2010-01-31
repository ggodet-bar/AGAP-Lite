module PatternSystemHelper
  def link_to_add_fields(name, f, association, field_d_id)
    new_object = f.object.class.reflect_on_association(association).klass.new(:field_descriptor_id => field_d_id)
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render 'classification_fields', :f => builder
    end
    link_to_function name, h("add_fields(this, \"#{association}\",\"#{escape_javascript(fields)}\")")
  end
end
