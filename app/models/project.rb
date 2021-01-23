class Project < ApplicationRecord
  has_many :participants

  accepts_nested_attributes_for :participants

  validates_presence_of :name, :start_date, :finish_date, :amount, :risk
  validates_numericality_of :amount, :risk
  validates_inclusion_of :risk, in: [0, 1, 2]

  def roi(investment)
    case risk
    when 0 then investment * 0.05
    when 1 then investment * 0.10
    when 2 then investment * 0.20
    end
  end
end
