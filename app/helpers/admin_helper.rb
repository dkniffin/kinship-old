module AdminHelper
  def active(page)
    return current_page?(page) ? 'active' : ''
  end

  def active_array(pages)
    pages.each do |page|
      if current_page?(page)
        return 'active'
      end
    end
    return ''
  end
end
