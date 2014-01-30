# Localhook

Localhook let you receive webhooks behind a firewall. It works like [UltraHook](http://www.ultrahook.com/) or [ngrok](https://ngrok.com/), but you host the server yourself.g

## What is Localhook?

A WebHook is an HTTP callback: an HTTP POST that occurs when something happens. Many popular services (GitHub, Stripe, ActiveCampaign, Papertrail, etc) support updates via webhooks. However, since these webhook requests are made over Internet, it's difficult receive them when testing from behind a firewall.

Localhook lets you host a public endpoint for other services and tunnels requests to a private endpoint on your computer.

## Installation

Install localhook client:

``
gem install localhook
``

## Usage

First, you must host your own localhook server on internet. Check [localhook-server](https://github.com/siuying/localhook-server) for details.

Then configure a endpoint in localhook-server:

```
LOCALHOOK_ENDPOINTS=endpoint1:1234
```

To expose a local webhook ``http://localhost:3000/webhook`` to internet, 

```
localhook https://localhook.mydomain.com http://localhost:3000 --token=1234
```

Instead of giving third party url "http://localhost:3000/webhook", you give them
``https://localhook.mydomain.com/endpoint1/webhook``.

Any POST request sent to ``https://localhook.mydomain.com/endpoint1/webhook`` will be
forwarded to ``http://localhost:3000/webhook``.

## Contributing

1. Fork it ( http://github.com/<my-github-username>/localhook/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

MIT License.