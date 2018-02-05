class Article
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title, type: String
  field :short_desc, type: String
  field :long_desc, type: String
  field :create_by, type: String
  field :updated_by, type: String

  def self.search(search)
    if search
      any_of({_id: /#{search}/i},{title: /#{search}/i},{short_desc: /#{search}/i},{long_desc: /#{search}/i},{create_by: /#{search}/i},{updated_by: /#{search}/i})
    end
  end
end
