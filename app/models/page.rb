class Page
  include Mongoid::Document

  field :slug, type: String
  field :title, type: String, localize: true
  field :template, type: String
  field :content, type: Hash, localize: true, default: {}
  field :styles, type: Hash, default: {}
  field :order, type: Integer, default: 0

  embedded_in :site

  before_create do
    self.order = self.site.pages.desc(:order).first.order + 1
  end
  
  def get_content(key)
    content[key] if content
  end

  def update_content(data)
    #TODO validate data length.
    new_content = data.map do |key, value|
      [key, value['value']]
    end
    self.content = Hash[*new_content.flatten]
  end

  def move_down!
    prev_page = self.site.pages.where(:order.lt => self.order).desc(:order).first
    if prev_page
      prev_page.order += 1
      self.order -= 1
      prev_page.save
      self.save
      prev_page
    end
  end

  def move_up!
    next_page = self.site.pages.where(:order.gt => self.order).asc(:order).first
    if next_page
      next_page.order -= 1
      self.order += 1
      next_page.save
      self.save
      next_page
    end
  end
end
