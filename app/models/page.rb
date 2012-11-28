class Page
  include Mongoid::Document

  field :slug, type: String
  field :template, type: String
  field :content, type: Hash, localize: true, default: {}

  def get_content(key)
    content[key] if content
  end

  def update_content(data)
    new_content = data.map do |key, value|
      [key, value['value']]
    end
    self.content = Hash[*new_content.flatten]
  end
end
