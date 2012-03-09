# Morphine

**NOTE: I am in the process of extracting dependency injection features from [Gaug.es](http://get.gaug.es). Currently, the only feature of this library is memoization. I am not dumb or inexperienced. I'm just not done yet.**

Morphine is a lightweight dependency injection framework for Ruby. It uses a simple Ruby DSL to ease the pain of wiring your dependencies together.

## Usage

Create a container for your dependencies and include the `Morphine` module.

```ruby
class Application
  include Morphine

  register :track_service do
    KestrelTrackService.new(kestrel_client, config.tracking_queue)
  end

  register :track_processor do
    KestrelTrackProcessor.new(blocking_kestrel_client, config.tracking_queue)
  end

private

  register :kestrel_client do
    c = config['kestrel'].dup
    Kestrel::Client.new(c.delete('servers'), c.symbolize_keys)
  end

  register :blocking_kestrel_client do
    Kestrel::Client::Blocking.new(kestrel_client)
  end
end
```

Create an instance of your container, and use that to load your dependencies

```ruby
$app = Application.new

get '/track.gif' do
  $app.track_processor.record(params['h'])
end
```

# But I don't need dependency injection in Ruby!

Many [argue](http://weblog.jamisbuck.org/2008/11/9/legos-play-doh-and-programming) that you [don't](http://davybrion.com/blog/2010/10/why-you-dont-need-dependency-injection-in-ruby/) [need](http://fabiokung.com/2010/05/06/ruby-and-dependency-injection-in-a-dynamic-world/) dependency injection in dynamic languages like Ruby. What they are really saying is you don't need a complicated dependency injection framework, and *they're right*.

That's why Morphine is an extremely simple library.

## Contributing

If you find what looks like a bug:

1. Check the [GitHub issue tracker](http://github.com/bkeepers/morphine/issues/) to see if anyone else has reported issue.
2. If you don't see anything, create an issue with information on how to reproduce it.

If you want to contribute an enhancement or a fix:

1. Fork the project on GitHub.
2. Make your changes with tests.
3. Commit the changes without making changes to the Rakefile, Gemfile, gemspec, or any other files that aren't related to your enhancement or fix
4. Send a pull request.
