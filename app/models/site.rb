class Site
  include Mongoid::Document
  field :domains, type: Array, default: []
  field :title, type: String
  field :layout, type: String
  field :html_head, type: String
  field :small_logo_url, type: String
  
  embeds_many :pages
  embeds_many :snippets, as: :snippet_container
  embeds_many :images
  has_and_belongs_to_many :users

  attr_accessor :domains_string
  attr_accessible :domains, :title, :layout, :html_head, :domains_string
  
  def self.find_for_request(request)
    site = where(domains: request.host).first
    if !site && request.host == Figaro.env.admin_domain
      site = Site.find_or_create_by(domains: ['admin'])
    end
    raise Mongoid::Errors::DocumentNotFound.new(self, "domains" => request.host) unless site
    site
  end

  def domains_string
    read_attribute(:domains).join(", ")
  end

  def domains_string=(value)
    arr = value.split(',').map(&:strip)
    write_attribute(:domains, arr)
  end
  
  def update_snippets(data)
    snippet_contents = data.inject({}) do |memo, (key, value)|
      if value['data'] && value['data']['content-store'] == 'snippet'
        memo[key] = {value['data']['snippet-key'] => {'value' => value['value']}}
      end
      memo
    end

    snippet_contents.each do |key, content|
      snippet = self.snippets.find_or_initialize_by(name: key)
      snippet.update_content(content)
    end
  end
end
