# WebUI

To get started, run WebUI with:

```
pilosa-webui [-bind ADDR]
```

Optionally pass a bind address.

Pilosa must be configured with CORS support for the WebUI to work:

```
pilosa server --handler.allowed-origins="http://localhost:8000"
```

## Development

Start a basic development server with:

```
make server
```

## License

Pilosa WebUI is license under the GNU Affero General Public License. A copy of the license is included in `COPYING`.
