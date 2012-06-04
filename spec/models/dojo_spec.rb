# -*- encoding: UTF-8 -*-
require 'spec_helper'

describe Dojo do
  describe '発揮値' do
    it '最初の数字を force_value に' do
      create(:dojo, force: 'たぶん2000。3000かも。').force_value.should == 2000
    end
  end

  describe 'TSV' do
    before :each do
      @rank = create(:rank, name: 'SS')
      @tsv = "10\t153\t..SS\t60251756\tCu\tスマホ\t応援\t"+
        "SR+桃華ちゃん\t5500前後\t24時間営業\t10\t2012/05/10"
    end

    it "タブ区切りテキストをattributesに" do
      attrs = Dojo.split_tsv(@tsv)
      attrs.should == {
        level: '153',
        rank_id: @rank.id,
        mbgaid: '60251756',
        personality: 'cute',
        leader: 'SR+桃華ちゃん',
        force: '5500前後',
        description: '24時間営業',
      }
    end

    it "dojo.tsvにテキストを入れる" do
      dojo = Dojo.new(tsv: @tsv)
      dojo.should be_valid
      dojo.mbgaid.should == 60251756
    end

    it "find_or_create_from_tsv" do
      x = Dojo.create_or_update_from_tsv!(@tsv)
      y = Dojo.create_or_update_from_tsv!(@tsv)
      x.id.should == y.id
    end
  end

  it 'モバゲーIDはユニーク' do
    x = create(:dojo, mbgaid: '123456')
    x.should be_valid
    y = build(:dojo, mbgaid: x.mbgaid)
    y.should_not be_valid
    y.should have(1).errors_on(:mbgaid)
  end

end
