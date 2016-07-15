module QuizzesHelper

  def link_to_remove_field(name, f, style)
    if style == 'simple'
      f.hidden_field(:_destroy) +
        link_to('<span class="glyphicon glyphicon-remove"></span>'.html_safe, "javascript:void(0);", onclick: "remove_field(this, 'simple')", title: "Remove", alt: "Remove")
    else
      f.hidden_field(:_destroy) +
        '<div class="right"><span class="glyphicon glyphicon-remove"></span> '.html_safe +
        link_to(name, "javascript:void(0);", onclick: "remove_field(this)", title: "Remove", alt: "Remove") +
        "</div>".html_safe
    end
  end

  def link_to_add_field(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to(name, "javascript:void(0);", onclick: "add_field(this, \"#{association}\", \"#{escape_javascript(fields)}\")", title: "Add #{association}", alt: "Add #{association}")
  end
end
