require "app_store_lookup/version"

module AppStoreLookup
	class App
	  	attr_reader :id, :name, :censored_name, :kind, :release_date, :primary_genre, :genres, :price, :currency, :version, :current_version_release_date, :artist, :bundle_id, :minimum_os_version, :description,
	  				:is_game_center_enabled, :is_vpp_device_based_licensing_enabled, :rating, :current_version_rating, :seller, :file_size, :languages, :content_advisory_rating, :url, :supported_devices, :artwork, :screenshots

	  	def initialize(attributes = {})
	  		require 'date'
	  		@id = attributes['trackId'].to_i
	  		@name = attributes['trackName']	  		
	  		@censored_name = attributes['trackCensoredName']
	  		@kind = attributes['kind']
	  		@release_date = DateTime.parse(attributes['releaseDate'])
	  		@primary_genre = AppStoreLookup::AppGenre.new(:name => attributes['primaryGenreName'], :id => attributes['primaryGenreId'])
	  		@genres = attributes['genres'].each_with_index.map {|genre,i| AppStoreLookup::AppGenre.new(:name => genre, :id => attributes['genreIds'][i])}
	  		@price = attributes['price'].to_f
	  		@currency = attributes['currency']
	  		@version = attributes['version']
	  		@current_version_release_date = DateTime.parse(attributes['currentVersionReleaseDate'])
	  		@artist = AppStoreLookup::AppArtist.new(:name => attributes['artistName'], :id => attributes['artistId'], :url => attributes['artistViewUrl'])
	  		@bundle_id = attributes['bundleId']
	  		@minimum_os_version = attributes['minimum_os_version']
	  		@description = attributes['description']
	  		@is_vpp_device_based_licensing_enabled = attributes['isVppDeviceBasedLicensingEnabled']
	  		@is_game_center_enabled = attributes['is_game_center_enabled']
	  		@rating = AppStoreLookup::AppRating.new(:count => attributes['userRatingCount'], :rating => attributes['averageUserRating'])
	  		@current_version_rating = AppStoreLookup::AppRating.new(:count => attributes['userRatingCountForCurrentVersion'], :rating => attributes['averageUserRatingForCurrentVersion'])
	  		@seller = AppStoreLookup::AppSeller.new(:name => attributes['sellerName'], :url => attributes['sellerUrl'])
	  		@file_size = attributes['fileSizeBytes'].to_i
	  		@languages = attributes['languageCodesISO2A'].map {|l| AppStoreLookup::AppLanguage.new(:code => l)}
	  		@content_advisory_rating = attributes['contentAdvisoryRating']
	  		@url = attributes['trackViewUrl']
	  		@supported_devices = attributes['supportedDevices'].map {|sd| AppStoreLookup::AppSupportedDevices.new(:name => sd)}
	  		@artwork = { :a60 => AppStoreLookup::AppImage.new(:url => attributes['artworkUrl60']), :a100 => AppStoreLookup::AppImage.new(:url => attributes['artworkUrl100']), :a512 => AppStoreLookup::AppImage.new(:url => attributes['artworkUrl512'])}
	  		@screenshots = {:iphone => attributes['screenshotUrls'].map {|s| AppStoreLookup::AppImage.new(:url => s)}, :ipad => attributes['ipadScreenshotUrls'].map {|s| AppStoreLookup::AppImage.new(:url => s)}, :apple_tv => attributes['appletvScreenshotUrls'].map {|s| AppStoreLookup::AppImage.new(:url => s)}}
	  	end

	  	def self.find_by_bundle_id(bundle_id)
	  		require 'net/http'
			require 'uri'
			require 'json'
			listing = JSON.parse(Net::HTTP.get(URI.parse("https://itunes.apple.com/lookup?bundleId="+bundle_id)))['results']
			unless listing.empty?
	  			AppStoreLookup::App.new(listing[0])
	  		else

	  		end 
	  	end
  	end

	class AppImage
		attr_reader :url

		def initialize(attributes = {})
			@url = attributes[:url]
		end
	end

	class AppSupportedDevices
		attr_reader :name

		def initialize(attributes = {})
			@name = attributes[:name]
		end
	end

	class AppGenre
		attr_reader :id, :name

		def initialize(attributes = {})
			@name = attributes[:name]
			@id = attributes[:id].to_i
		end
	end

	class AppArtist
		attr_reader :id, :name, :url

		def initialize(attributes = {})
			@name = attributes[:name]
			@id = attributes[:id]
			@url = attributes[:url]
		end
	end

	class AppSeller
		attr_reader :name, :url

		def initialize(attributes = {})
			@name = attributes[:name]
			@url = attributes[:url]
		end
	end

	class AppRating
		attr_reader :count, :rating

		def initialize(attributes = {})
			@count = attributes[:count]
			@rating = attributes[:rating]
		end
	end

	class AppLanguage
		attr_reader :code

		def initialize(attributes = {})
			@code = attributes[:code]
		end
	end
end