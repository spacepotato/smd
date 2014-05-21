class SearchController < ApplicationController

	def search_clubs(search_params)

		@clubs= Array.new

		Club.search_name(search_params).each do |club_name|
			@clubs.push(club_name)
		end

		Club.search_weblink(search_params).each do |club_weblink|
			@clubs.push(club_weblink)
		end


		Club.search_description(search_params).each do |club_description|
			@clubs.push(club_description)
		end

		return @events

	end

	def search_events(search_params)
		@events= Array.new

		Event.search_name(search_params).each do |event_name|
			@events.push(event_name)
		end

		Event.search_location(search_params).each do |event_location|
			@events.push(event_location)
		end


		Event.search_description(search_params).each do |event_description|
			@events.push(event_description)
		end

		return @events

	end

	def search
		@clubs = search_clubs(params[:search])
		search_events(params[:search])

	end


end
