# AppStoreLookup


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'app_store_lookup'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install app_store_lookup

## Usage

You can find any app by its unique bundle ID like this:

```ruby
app = AppStoreLookup::App.find_by_bundle_id("...")
```

### Example
```ruby
twitter_app = AppStoreLookup::App.find_by_bundle_id("com.atebits.Tweetie2")
twitter_app.name #APP NAME
=> "Twitter"
twitter_app.rating.rating #OVERALL RATING
=> 3.5
twitter_app.screenshots[:iphone][0].url #FIRST IPHONE SCREENSHOT URL
=> "http://a4.mzstatic.com/us/r30/Purple18/v4/2e/6c/d6/2e6cd646-df7b-b500-dd75-2bb9cf676cd5/screen1136x1136.jpeg"
twitter_app.artwork[:a60].url #APP ICON (60x60px)
=> "http://is1.mzstatic.com/image/thumb/Purple30/v4/95/77/3c/95773c1b-6799-7edf-20ae-2738f233be33/source/60x60bb.jpg" 
```

You can use any (or all :simple_smile:) of these attributes:

    id [Integer]
    name [String]
    censored_name [String]
    kind [String]
    release_date [DateTime]
    primary_genre [AppGenre object]
    genres [AppGenre object]
    price [Float]
    currency [String]
    version [String]
    current_version_release_date [DateTime]
    artist [AppArtist object]
    bundle_id [String]
    minimum_os_version [String]
    description [String]
    is_game_center_enabled [Boolean]
    is_vpp_device_based_licensing_enabled [Boolean]
    rating [AppRating object]
    current_version_rating [AppRating object]
    seller [AppSeller object]
    file_size [Integer]
    languages [AppLanguage]
    content_advisory_rating [String]
    url [String]
    supported_devices [AppSupportedDevice object]
    artwork [AppImage object]*
    screenshots [AppImage object]**
    
    *artwork has three image sizes [:a60, :a100, :a512]
    **screenshots are divided in categories [:iphone, :ipad, :apple_tv]

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/MichalHlavacek/app_store_lookup.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

