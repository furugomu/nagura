# -*- encoding: UTF-8 -*-
class Dojo < ActiveRecord::Base
  belongs_to :rank
  attr_accessible :rank_id, :description, :force, :leader, :level, :mbgaid, :personality

  PERSONALITIES = %w(cute cool passion)

  validates :rank, :level, :leader, :mbgaid, :force, presence: true
  validates :level, numericality: {only_integer: true, greater_than: 0}
  validates :personality, inclusion: {in: PERSONALITIES}
  validates :leader, :force, length: {maximum: 255}
  validates :description, length: {maximum: 1000}

  # 保存前に force から数字を抜き出して force_value へ
  before_save do |record|
    record.force_value = $1.to_i(10) if record.force =~ /(\d+)/
  end

  scope :tsuyoi, order('rank_id desc, level desc')
end
