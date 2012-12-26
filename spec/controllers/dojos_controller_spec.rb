# -*- encoding: UTF-8 -*-
require 'spec_helper'

describe DojosController do

  describe 'create' do
    describe 'by tsv' do
      let(:tsv) {
        "16\t199\t..S3\t60251756\tCu\tスマホ\t応援\t" +
        "SR+桃華ちゃん\t5500前後\t24時間営業\t16\t2012/06/06"
      }
      before do
        create(:rank, name: 'S3')
      end
      it 'should be redirect' do
        post 'create', dojo: {tsv: tsv}
        response.should be_redirect
      end
      it 'なんかできる' do
        expect {
          post 'create', dojo: {tsv: tsv}
        }.to change{Dojo.count}.by(1)
      end
    end
  end

end
