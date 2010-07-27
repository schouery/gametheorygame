#Helper for SymmetricFunctionGame's Views
module SymmetricFunctionGamesHelper
  #Used to add strategy fields on the form, based on
  #http://asciicasts.com/episodes/197-nested-model-form-part-2
  def link_to_add_fields(name, form, association)  
    new_object = form.object.class.reflect_on_association(association).klass.new  
    fields = form.fields_for(association, new_object,
      :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields",
        :f => builder, :last => true)
    end  
    link_to_function(name,
      h("add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")"))
  end
end
