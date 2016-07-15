module QuizzesHelper

  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + "<div style=\"float:right;\"><span class=\"glyphicon glyphicon-remove\"></span> ".html_safe + link_to(name, "javascript:void(0);", onclick: "remove_fields(this)") + "</div>".html_safe
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to(name, "javascript:void(0);", onclick: "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end
end
