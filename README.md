WebUI
=====

To get started, run WebUI with:

```
make server
```

Pilosa must be configured with CORS support:

```
pilosa server --handler.allowed-origins="http://localhost:8000"
```
