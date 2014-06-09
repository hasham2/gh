module ApplicationHelper

  def display_base_errors resource
    return '' if (resource.errors.empty?) or (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end
   def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render('enrollment_steps/workhours', :f => builder)
    end
     link_to(name, '#',:style=>"margin-top:10px;", class: "add_fields btn btn-default", data: {id: id, fields: fields.gsub("\n", "")})
  end
   def link_to_add_Standards_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render('enrollment_steps/standard_workhours', :f => builder)
    end
    link_to(name, '#',:style=>"margin-top:10px;", class: "add_standard_fields btn btn-default", data: {id: id, fields: fields.gsub("\n", "")})
  end

  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to(name,'#', onclick:'remove_fields(this)')
  end

  def sniffed_region_code
    if defined? @georesp
      @georesp.first.region_code rescue nil
    else
      "NY"
    end
  end

  def sniffed_country_code
    if defined? @georesp
      @georesp.first.country_code rescue nil
    else
      "US"
    end
  end
end
