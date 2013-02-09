class Site
  include Mongoid::Document
  field :domains, type: Array

  embeds_many :pages
  embeds_many :images
  has_and_belongs_to_many :users
  
  attr_accessible :domains

  def self.find_for_request(request)
    site = where(domains: request.host).first
    raise Mongoid::Errors::DocumentNotFound.new(self, "domains" => request.host) unless site
    site
  end

  def domains=(value)
    case value
    when Array
      write_attribute(:domains, value)
    when String
      arr = value.split(',').map(&:strip)
      write_attribute(:domains, arr)
    end
  end
end
