# -*- encoding: UTF-8 -*-
class Dojo < ActiveRecord::Base
  belongs_to :rank
  attr_accessor :tsv
  attr_accessible :rank_id, :description, :force, :leader, :level, :mbgaid, :personality, :tsv

  PERSONALITIES = %w(cute cool passion)

  validates :rank, :level, :leader, :mbgaid, presence: true
  validates :level, numericality: {only_integer: true, greater_than: 0}
  validates :personality, inclusion: {in: PERSONALITIES}
  validates :leader, :force, length: {maximum: 255}
  validates :description, length: {maximum: 1000}
  validates :mbgaid, uniqueness: true

  # 保存前に force から数字を抜き出して force_value へ
  before_save do |record|
    record.force_value = $1.to_i(10) if record.force.to_s =~ /(\d+)/
  end

  # タブ区切りテキストからアレする
  before_validation :load_from_tsv

  default_scope order("#{quoted_table_name}.rank_id desc, #{quoted_table_name}.level desc")
  paginates_per 50

  def self.new_from_tsv(line)
    new.tap{|x| x.tsv=line; x.send(:load_from_tsv)}
  end

  private

  def load_from_tsv
    self.tsv.blank? and return
    columns = [
      nil, :level, :rank_name, :mbgaid, :type,
      nil, nil, :leader, :force, :description,
    ]
    attrs = columns.zip(self.tsv.split("\t")).each_with_object({}) do |pair, hash|
      key, value = pair
      hash[key] = value if key
    end
    attrs[:personality] =
      {'Cu'=>'cute', 'Co'=>'cool', 'Pa'=>'passion'}[attrs.delete(:type)]
    attrs[:rank_id] = Rank.find_by_name(attrs.delete(:rank_name).sub(/^\.+/, '')).id
    self.attributes = attrs
  end

end
