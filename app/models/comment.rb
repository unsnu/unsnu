class Comment < ActiveRecord::Base
  belongs_to :parent
end
