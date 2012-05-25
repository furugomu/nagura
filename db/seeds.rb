# -*- encoding: UTF-8 -*-

# ランクちゃん
%w(F E D C B A S SS S3).each do |name|
  Rank.find_or_create_by_name(name)
end
