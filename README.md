# Hyperfoil.io Website Based on Hugo

If you want to change the website content, please open a PR against https://github.com/Hyperfoil/Hyperfoil to update the website.

Documentation is now automatically built and deployed from the stable branch of Hyperfoil Repo.

## A bit of history

Starting from July 15th, we published a renewed version of the Hyperfoil website.

With this renewal we changed some things that are summarized below:
- The source code of the website has been move in the [Hyperfoil](https://github.com/Hyperfoil/Hyperfoil/tree/master/docs) repository, this way docs changes can be done in the same pull request of the feature change.
- The website is entirely based on [docsy](https://www.docsy.dev/) Hugo template, therefore we switched to [Hugo](https://gohugo.io/) as static site generator.
- The live content is hosted in the [gh-pages](https://github.com/Hyperfoil/hyperfoil.github.io/tree/gh-pages) branch of this repository, we will empty the `master` one in the coming future.
- The website deployment is automated using a GitHub worklofow, see [deploy-gh-pages.yaml](./.github/workflows/deploy-gh-pages.yaml) for more details.
- The live content points to the latest *stable* branch in the Hyperfoil repository, e.g., `0.26.x`. You can find the used branch in the [deploy-gh-pages.yaml](https://github.com/lampajr/hyperfoil.github.io/blob/355ed02d88f3247e946b975b8235ad7be2fdd6fb/.github/workflows/deploy-gh-pages.yaml#L30) configuration.


## Development

For more information on how to build (locally) and update the website content, please checkout [github.com/Hyperfoil/Hyperfoil/docs/site](https://github.com/Hyperfoil/Hyperfoil/tree/master/docs/site).
