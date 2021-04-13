# Charts Testing

## Pull Request Testing

Static analysis is run automatically.

### Static Analysis

Static analysis is performed on every pull request and is run by Github Actions.

The static analysis currently:

* Performs `helm lint` on any changed charts to provide quick feedback

## Note
Testing is inspired by https://github.com/kubernetes/charts
