# norad-match

A simple web applet for checking NORAD catalog numbers against a local copy of the space-track catalogue.

<p align="center">
  <img src="/docs/Screenshot.png" width="60%" />
</p>

## Downloading the map file

Copy `credentials.template` to `credentials`, and edit the file to enter your space-track.org credentials.

Run `update_map.sh` to download and format the catalog. This will output a `map.json` file to the `htdocs` directory.

### Updating the map

NB: Please be aware of the space-track API usage guidelines when scheduling updates: https://www.space-track.org/documentation

## Local Web Server for testing

```sh
cd htdocs/ && python3 -m http.server 8080
```

## License

Unless otherwise specified, all materials of this project are licensed under the MIT licence.

## Authors

* Phil Crump <phil@philcrump.co.uk>
