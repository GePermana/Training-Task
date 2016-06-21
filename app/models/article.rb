class Article < ActiveRecord::Base

has_many :comments




default_scope {where(status: 'active')}

validates :title, presence: true,

                            length: { minimum: 5 }

        validates :content, presence: true,

                            length: { minimum: 10 }

        validates :status, presence: true

end
