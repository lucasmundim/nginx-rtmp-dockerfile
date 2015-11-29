# NGINX RTMP Dockerfile

This Dockerfile installs [nginx][1] configured with [nginx-rtmp-module][2]
and some default settings for [HLS][3] live streaming.

## How to use

1. Build container
    `docker build -t lucasmundim/nginx-rtmp .`

2. Run it
    `docker run -p 1935:1935 -p 8080:80 --rm lucasmundim/nginx-rtmp`

3. Stream your live content to `rtmp://dockerhost:1935/live/stream_name` where
   `stream_name` is the name of your stream.

4. In Safari, VLC or any HLS compatible browser / player, open
   `http://dockerhost:8080/hls/stream_name.m3u8`. Note that the first time,
   it might take a few (10-15) seconds before the stream works. This is because
   when you start streaming to the server, it needs to generate the first
   segments and the related playlists.

## Contributing

1. Fork it
2. Checkout the develop branch (`git checkout -b develop`)
3. Create your feature branch (`git checkout -b my-new-feature`)
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request


## License

This application is distributed under the [MIT License][4].

[1]: http://nginx.org
[2]: https://github.com/arut/nginx-rtmp-module
[3]: https://tools.ietf.org/html/draft-pantos-http-live-streaming
[4]: https://en.wikipedia.org/wiki/MIT_License
