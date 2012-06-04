# -*- encoding: utf-8 -*-

ENV["RAILS_ENV"] ||= 'development'
require File.expand_path('../../config/application',  __FILE__)
Rails.application.require_environment!

USAGE = '標準入力にスプレッドシートの中身を貼り付けろ'

def main
  Rank.cache do
    Dojo.transaction do
      $stdin.each_line do |line|
        begin
          Dojo.create_or_update_from_tsv!(line)
        rescue =>e
          $stderr.puts(line)
          raise e
        end
      end
    end
  end
end

if __FILE__ == $0
  main
end
