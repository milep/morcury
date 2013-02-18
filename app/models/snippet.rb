class Snippet
  include Mongoid::Document
  field :name, type: String
  field :content, type: Hash, localize: true, default: {}
  field :order, type: Integer, default: 0

  embedded_in :snippet_container, polymorphic: true

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
end
