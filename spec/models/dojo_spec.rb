# -*- encoding: UTF-8 -*-
require 'spec_helper'

describe Dojo do
  describe '発揮値' do
    it '最初の数字を force_value に' do
      create(:dojo, force: 'たぶん2000。3000かも。').force_value.should == 2000
    end
  end

  describe 'new from tsv' do
    it 'hoge' do
      create(:rank, name: 'SS')
      line = "10\t153\t..SS\t60251756\tCu\tスマホ\t応援\t"+
        "SR+桃華ちゃん\t5500前後\t24時間営業\t10\t2012/05/10"
      dojo = Dojo.new_from_tsv(line)
      dojo.should be_valid
      dojo.personality.should == 'cute'
      dojo.rank.name.should == 'SS'
    end
  end

end
