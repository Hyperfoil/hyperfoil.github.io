---
---
# Hyperfoil.io Website Based on Jekyll

>[!NOTE]
> The content of this `master` branch is old, :point_right: checkout [Hyperfoil](https://github.com/Hyperfoil/Hyperfoil/tree/master/docs) repository for the website source code or the [gh-pages](https://github.com/Hyperfoil/hyperfoil.github.io/tree/gh-pages) branch of this repository for the live content published at [hyperfoil.io](https://hyperfoil.io).

## New website

Starting from July 15th, we published a renewed version of the Hyperfoil website.

With this renewal we changed some things that are summarized below:
- The source code of the website has been move in the [Hyperfoil](https://github.com/Hyperfoil/Hyperfoil/tree/master/docs) repository, this way docs changes can be done in the same pull request of the feature change.
- The website is entirely based on [docsy](https://www.docsy.dev/) Hugo template, therefore we switched to [Hugo](https://gohugo.io/) as static site generator.
- The live content is hosted in the [gh-pages](https://github.com/Hyperfoil/hyperfoil.github.io/tree/gh-pages) branch of this repository, we will empty the `master` one in the coming future.
- The website deployment is automated using a GitHub worklofow, see [deploy-gh-pages.yaml](./.github/workflows/deploy-gh-pages.yaml) for more details.
- The live content points to the latest *stable* branch in the Hyperfoil repository, e.g., `0.26.x`. You can find the used branch in the [deploy-gh-pages.yaml](https://github.com/lampajr/hyperfoil.github.io/blob/355ed02d88f3247e946b975b8235ad7be2fdd6fb/.github/workflows/deploy-gh-pages.yaml#L30) configuration.


For more information on how to build (locally) and update the website content, please checkout [github.com/Hyperfoil/Hyperfoil/docs](https://github.com/Hyperfoil/Hyperfoil/tree/master/docs).

## Old website

>[!NOTE]
> This content will be removed in the coming future!

The `master` branch contains the content for the old Jekyll-based static website that is no longer published anywhere.

### Getting Started

These instructions will get you a copy of the Hyperfoil.io website up and running on your local machine for development and testing purposes.

#### Installation
[Jekyll static site generator docs](https://jekyllrb.com/docs/).

1. Install a full [Ruby development environment](https://jekyllrb.com/docs/installation/)
2. Install [bundler](https://jekyllrb.com/docs/ruby-101/#bundler)  [gems](https://jekyllrb.com/docs/ruby-101/#gems) 
  
        gem install bundler

3. Fork the [project repository](https://github.com/Hyperfoil/hyperfoil.github.io), then clone your fork.
  
        git clone git@github.com:YOUR_USER_NAME/hyperfoil.github.io.git

4. Change into the project directory:
  
        cd hyperfoil.github.io

5. Use bundler to fetch all required gems in their respective versions

        bundle install

6. Build the site and make it available on a local server
  
        bundle exec jekyll serve
        
7. Now browse to http://localhost:4000

> If you encounter any unexpected errors during the above, please refer to the [troubleshooting](https://jekyllrb.com/docs/troubleshooting/#configuration-problems) page or the [requirements](https://jekyllrb.com/docs/installation/#requirements) page, as you might be missing development headers or other prerequisites.

**For more regarding the use of Jekyll, please refer to the [Jekyll Step by Step Tutorial](https://jekyllrb.com/docs/step-by-step/01-setup/).**


## License

This website is licensed under the [Creative Commons Attribution 3.0](https://creativecommons.org/licenses/by/3.0/).