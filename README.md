# Minitest::Stackprof

A minitest plugin to profile your tests, and optionally the setup/teardown
process. with stackprof

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'minitest-stackprof'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install minitest-stackprof

## Usage

Simply run your tests with the `--stackprof` option

If profiling is enabled, the following line will be displayed

~~~
Stackprof enabled - dumping results to NAME_OF_DUMP_FILE
~~~

The dump is made at the end of the tests, not if you interrupt them with CTRL+C
(sorry, I don't really know how to reliably make that work).

If you are wondering why your setup/teardown is too slow, they can also be
profiled with `--profile-setup`

## Development

After checking out the repo, run `bundle install`

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/doudou/minitest-stackprof.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

