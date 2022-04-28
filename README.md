# media_market_challenge

Media Market Challenge

## Getting Started

To run the app get a Github access token and enter it in the file `lib/tokens.dart`.

[How to generate access token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token)


### Architecture of the app
Following clean architecture app separated into 3 layer,
 - UI -> Just classes related to only representation of the app, could be replaced by any other interface, like command line interface.
 - Domain -> Only should consists of the repository interfaces, use cases and entities, completely isolated from the the details, like ui or data sources, etc which are prone to change.
 - Data -> Where the data comes from, Implementation of domain layer repositores, could switch between different data source with ease by implementing domain layer repositories or mock them in order to write unit tests.

### Dependency management
Used [get_it](https://pub.dev/packages/get_it) package as the service locator to manage the implementation instances of the domain repositories.
However there is also one consideration which is because resolving dependency any where for example in the target classes body is [considered as a bad practice](https://stackoverflow.com/a/22795888/6552303)
dependencies get resolved and the passed in the constructor of the dependent classes.
