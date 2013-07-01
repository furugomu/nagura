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

  describe 'next' do
    describe 'with dojo ひとつ' do
      let!(:dojo) {create(:dojo)}

      it 'should assign @dojo' do
        get 'next_dojo'
        assigns(:dojo).should == dojo
      end

      it '殴る URL にリダイレクト' do
        url = 'http://sp.pf.mbga.jp/12008305/?url=http%3A%2F%2F125.6.169.35' +
        '%2Fidolmaster%2Fbattle%2Fbattle_check%2F' + dojo.mbgaid.to_s
        get 'next_dojo'
        response.should redirect_to(url)
      end

      it 'ガラケーでも殴る URL にリダイレクト' do
        request.stub!(:mobile? => true)
        url = 'http://pf.mbga.jp/12008305/?url=http%3A%2F%2F125.6.169.35' +
        '%2Fidolmaster%2Fbattle%2Fbattle_check%2F' + dojo.mbgaid.to_s
        get 'next_dojo'
        response.should redirect_to(url)
      end

      describe 'リファラーがある' do
        before do
          request.env['HTTP_REFERER'] = request.protocol+request.host_with_port+'/hoge'
        end
        it 'HTML を吐く' do
          get 'next_dojo'
          response.should render_template(:next_dojo)
        end
      end

      describe 'クッキーの期限は' do
        context '今5時前なら' do
          before { Timecop.freeze(Time.zone.local(2012, 7, 25, 4, 59, 59)) }
          it 'should be 今日の5時' do
            get 'next_dojo'
            response.headers['Set-Cookie'].should =~
              /expires=Tue, 24-Jul-2012 20:00:00 GMT/
          end
        end
        context '今5時以降なら' do
          before { Timecop.freeze(Time.zone.local(2012, 12, 31, 5, 0, 0)) }
          it 'should be 明日の5時' do
            p Time.zone.now
            get 'next_dojo'
            response.headers['Set-Cookie'].should =~
              /expires=Mon, 31-Dec-2012 20:00:00 GMT/
          end
        end
      end
    end

    describe 'with 複数の dojos' do
      before do
        2.times{create(:dojo)}
      end

      it '2回呼ぶと進む' do
        get 'next_dojo'
        first_dojo = assigns(:dojo)
        get 'next_dojo'
        assigns(:dojo).should_not == first_dojo
      end

      it '全ての道場分を実行すると最初に戻る' do
        get 'next_dojo'
        first_dojo = assigns(:dojo)
        Dojo.count.times do
          get 'next_dojo'
        end
        assigns(:dojo).should == first_dojo
      end
    end
  end

end
