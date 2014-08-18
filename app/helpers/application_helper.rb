module ApplicationHelper
  def form_field(f, method, *args, &blk)
    label = f.label(method)
    field = if block_given?
        capture { blk.call(method) }
      else
        f.text_field method, *args
      end
    content_tag :div, label + content_tag(:div, field, class: 'control'), class: 'field'
  end
end
