# HttpIntercept

## What?

Think Rack middleware for your outgoing HTTP requests. Fiddle with, log,
benchmark -- do whatever your heart contents with HTTP calls made by your
Ruby app.

## Why not use _x_?

Some HTTP clients (e.g. Faraday) support the middleware concept out of the
box, others have first-party supported gems to turn it on (e.g. RestClient).
A suitably large Ruby app in production might not use either of these gems,
might use one, both or more. Even if it's only one, usage might be buried
impossibly deep.

This is where HttpIntercept steps in. Write your middleware in a HTTP
library-agnostic fashion, so you can drop in your middleware at an app-level
and not have to worry about the rest.

## How?

Middlewares are mostly Rack-like. They are objects that respond to
`#call(request, app)`. Usage is a little something like this:

```ruby
middleware = proc do |request, app|
  puts "about to hit #{request.uri}"
  response = app.call(request)
  puts "got a response with length #{response['content-length']}"
end

HttpIntercept.add middleware
HttpIntercept.inject
```

## More "how", please.

The `request` object responds to:
* `#type`: The specific class being wrapped, e.g. `"Net::HTTP"`
* `#method`: The HTTP verb, e.g. `"GET"`
* `#uri`: The URI object corresponding to the requested URL
* `#[](key)`: Request header, string keys, e.g. `"Accept"`
* `#[]=(key, val)`: Setter for request headers

The `response` object responds to:
* `#[](key)`: Response header, string keys, e.g. `"content-length"`
* `#to_hash`: Hash of all response headers

If there's something more you need, let the author know.

## What's supported?

* `Net::HTTP` and derivatives:
  * RestClient
  * HTTParty
  * others?

TODO: (in no particular order)

* Curb
* Excon
* HTTPClient
* Typhoeus


## This seems familiar

You're probably thinking of the hard work done by the New Relic team. This
gem is a poor man's (read: dumb man's) attempt at extracting out solely
the monkey-patching of outgoing HTTP calls and generalising it a bit. Please
help make this less terrible.
