#!/usr/bin/env ruby

class Accounts

  include Enumerable

  def initialize
    @users = []
    @passes = []
  end

  def parse(from_file='accounts.txt')
    File.foreach(from_file) do |user_data|
      user, pass= *user_data.chomp.split(/\s+/)
      @users << user
      @passes << pass
    end
  end
  def spit
	  return @users,@passes
  end

end

