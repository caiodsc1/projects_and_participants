class Participant < ApplicationRecord
  belongs_to :project

  validates_presence_of :name
end
