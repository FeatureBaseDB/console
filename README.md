# Console

To get started, run Console with:

```
pilosa-console [-bind ADDR]
```

Optionally pass a bind address.

Pilosa must be configured with CORS support for the Console to work:

```
pilosa server --handler.allowed-origins="http://localhost:8000"
```

## Development

Start a basic development server with:

```
make server
```

## License

Pilosa Console is license under the GNU Affero General Public License. A copy of the license is included in `COPYING`.
