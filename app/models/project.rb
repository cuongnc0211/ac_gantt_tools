class Project < ApplicationRecord
  has_many :tasks, -> { where type: 'Task' }
end
