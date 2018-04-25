# Charts Testing

## Pull Request Testing

Static analysis is run automatically.

### Static Analysis

Static analysis is performed on every pull request and is run by CircleCI. The
configuration is stored in the [`.travis.yml`](../.travis.yml)
file.

The static analysis currently:

* Performs `helm lint` on any changed charts to provide quick feedback
