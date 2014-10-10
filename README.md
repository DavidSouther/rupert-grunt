ng-stassets-grunt
=================

ng-stassets development toolchain and library.

## Starting a new project

1. Create a new project.
  1. On Githug, set the name and description. Generate a Readme and license.
1. Clone the project from GitHub.
1. Run `npm init ; npm i --save ng-stassets ; npm i --save-dev ng-stassets-grunt`.
  1. While npm is smart in initialization, you can set a name, etc in your [npmrc][npmrc]
1. Run `cp node_modules/ng-stassets-grunt/plain/* .` (See [the source directory here][plain_folder]).
  1. Edit the `name` field in `./server.json`.
1. Add npm scripts:
  1. `"start": "node ./app.js"`
  1. `"test": "./node_modules/.bin/grunt"`

[npmrc]: https://www.npmjs.org/doc/misc/npm-config.html#config-settings
[plain_folder]: https://github.com/DavidSouther/ng-stassets-grunt/tree/master/plain

## Project Layout

### Client Code

### Server APIs & Endpoints

## The Pieces

Built from two and a half years experience with Angular, and nearly a decade of experience with full-stack web development, ng-stassets-grunt is a project library and template that will have any team up and running in minutes. Handling the common cases and core infrastructure, you and your team can focus on building your application, while ng-stassets keeps up to date on the latest changes and security updates in the MEAN ecosystem.

### stassets

[`stassets`](https://github.com/DavidSouther/stassets) is a compiling express middleware. When you first start the Node project, stassets scans its `root` directory for your project files (by default, Angular controller, services, directives, templates, styles, etc). Whenever those files change, stassets compiles them, storing the generated `index.html`, `vendors.js`, `application.js`, etc files in memory. When your browser requests those files, it always has the most up to date version of the development library. This approach allows for extremely rapid iteration when developing.

### ng-stassets

[`ng-stassets`](https://github.com/DavidSouther/ng-stassets) is an express server configured to use `stassets`. It can also be configured to attach your custom API endpoints, use TLS authentication (including generating a development certificate on the fly), and configure [socket.io](http://socket.io/) for realtime data.

### MEAN

MEAN is an acronym for the MEAN stack. There are many impementations of the MEAN stack; ng-stassets is YAMS (Yet Another Mean Stack).

#### Express

#### Angular

## Cookbook

### TDD
