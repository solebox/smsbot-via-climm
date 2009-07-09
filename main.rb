#!/usr/bin/ruby -w
BEGIN {
	if File.exists?("data.ini")
		File.open("data.ini") do |f|
			@day = Marshal.load(f)
		end
	else
		@c1,@c2 = 0,0
	end
	if File.exists?("counters.ini")
		if @day != Time.new.day
			File.delete("counters.ini")
			@c1,@c2 = 0,0
		else
			File.open("counters.ini") do |f|
				@c1,@c2 = *Marshal.load(f)
			end
		end
	end
}
require 'Accounts'
acc = Accounts.new
acc.parse
@uins,@passwords = acc.spit

if @c2 < 6
	if @c1 < @uins.length
		puts "please insert recieving cell number"
		@num = gets.chomp.sub('0','')
		puts "please insert a message"
		@message = gets.chomp ## try to get more than one line without using \n
		system("climm --uin #{@uins[@c1]} -p #{@passwords[@c1]} -s dnd -C 'sms +972#{@num} #{@message}'")
		@c1 += 1
	else
		@c1 = 0
		@c2 += 1
	end
	
		
	
else
	puts "all sms messages are depleted, try again tomorrow ;)"
end

END {
	@day = Time.new.day 
	
	File.open("data.ini", "w+") do |f|
		Marshal.dump(@day, f)	
	end
	File.open("counters.ini", "w+") do |f|
		Marshal.dump([@c1,@c2], f)
	end
		
}
