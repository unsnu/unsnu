class Comment < ActiveRecord::Base
  belongs_to :parent
  belongs_to :article
  belongs_to :user
end
