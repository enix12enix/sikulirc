# Sikulinewrc

Ruby wrapped client API of sikuli server

## Installation

To get Sikuli Server, Please go to http://github.com/enix12enix/sikuli-remote-control and follow instruction

Add this line to your application's Gemfile:

    gem 'sikulinewrc', :git => 'git://github.com/powerkx/sikulinewrc.git'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sikulinewrc

## Usage

    require 'sikulinewrc'

    rs = Sikulinewrc::RemoteScreen.new("127.0.0.1")
    rs.click "D:\\1.png"
    rs.app_focus "title"
    rs.type_in_field "D:\\field.png", "content"
    rs.page_down
    rs.wait "D:\\field.png"
    rs.find "D:\\field.png"
    rs.set_min_similarity 0.9

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
