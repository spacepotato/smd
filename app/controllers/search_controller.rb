class SearchController < ApplicationController

	def search_clubs(search_params)
		#Searching by name
		Club.search(search_params)

	end

	def search_events(search_params)
		Event.search(search_params)

	end

	def search_acts

	end

	def search
		@clubs = search_clubs(params[:search])
		@events = search_clubs(params[:search])

	end


end
