# Contributing to the openHAB website

This website is made with [VitePress](https://vitepress.dev/).
It will be installed as part of the dev dependencies.
Node.js 24 LTS or newer is required.
For the Ruby scripts used by the website build, Ruby 3.3.11 is needed.
If you are using a Node.js version manager like [fnm](https://github.com/Schniz/fnm), the provided `.node-version` file should automatically set the correct Node.js version needed.
If you are using a Ruby version manager like [rvm](https://rvm.io/), running `rvm use` should automatically set the correct version according to the `.ruby-version` file.

## Editing

Be careful not to edit anything in the folder `.vitepress/dist` as it is the folder that contains generated content.
The configuration and theme files are located in `.vitepress` (note the dot at the beginning of the folder name).
You can alter layouts and components in `.vitepress/components` or `.vitepress/layouts`, or the navigation in `.vitepress/config.mts`.

Note: if you add a new component and reference it in a (Markdown) page with its custom tag, it might not work until you restart the dev server.

## Environment Setup

This chapter describes how to setup a local environment to be able to build the whole website and review changes locally before creating a pull request.

### Linux / MacOS

The following has been tested on Linux and MacOS (Windows seems to have a few minors that prevent the script to run completely).

#### Ruby 3.3.11

It is highly recommended to use the [Ruby Version Manager (RVM)](https://rvm.io).
Once installed it will help to automatically download and configure `Ruby`:

```bash
$ rvm install "ruby-3.3.11"
$ rvm use
Using /home/foo/.rvm/gems/ruby-3.3.11
```

If there are no binary packages available for your distribution, `rvm` will compile `Ruby` from the source code:

```bash
$ rvm install "ruby-3.3.11"
Searching for binary rubies, this might take some time.
No binary rubies available for: ubuntu/22.04/x86_64/ruby-3.3.11.
Continuing with compilation.
# ...
```

## Running in development mode

To run the website on your local machine on a development server with live reload:

- run the released (stable) version of the documentation execute `npm run build-local-stable -y`
- run the latest (work in progress) version use `npm run build-local-latest -y`

As the compilation can take a few minutes due to the size of the docs, wait for the "VuePress dev server listening at <http://localhost:8080> (or another available port)" message.
When loading the website in the browser it may take a few seconds until it finally appears.

### Build documentation from PR

In special situations; e.g. if you make changes in the documentation repository that might impact the website build, it is possible to build the website from a PR.
This makes it possible to verify that your proposed changes do not have negative side effects:

```bash
ARGUMENTS="--pull-request 2272" npm run build-local
```

Available ARGUMENTS:

- `--verbose`
- `--no-clone`
- `--pull-request #`

## Building the final website

This step is normally done by a CI service (e.g. Netlify).
You can however build it manually with the command: `npm run build`.

This will:

1. Run `ruby scripts/prepare-website.rb` as above.
2. Run `vitepress build` which will output the final static files in `.vitepress/dist`.

The complete build will take between 2 and 5 minutes.
