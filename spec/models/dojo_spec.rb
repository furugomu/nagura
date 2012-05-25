# -*- encoding: UTF-8 -*-
require 'spec_helper'

describe Dojo do
  describe '発揮値' do
    it '最初の数字を force_value に' do
      create(:dojo, force: 'たぶん2000。3000かも。').force_value.should == 2000
    end
  end
end
