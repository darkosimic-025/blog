
# Blog

## Running in the development environment

To start the application, run the following command:

```bash
docker-compose up --build
```

**Note**: The application requires all tests to pass for a successful startup.

## Running tests separately

To run the tests separately, use the following command:

```bash
docker-compose run web bin/rails test
```
