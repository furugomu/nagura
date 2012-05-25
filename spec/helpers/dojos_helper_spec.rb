require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the DojosHelper. For example:
#
# describe DojosHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe DojosHelper do
  describe "imcg user url" do
    it do
      helper.imcg_user_url(56497169).should ==
        'http://sp.pf.mbga.jp/12008305/?url=http%3A%2F%2F' +
        '125.6.169.35%2Fidolmaster%2Fprofile%2Fshow%2F56497169'
    end
  end
end
