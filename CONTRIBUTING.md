# Contributing to Flutter NFC plugin

Contributions of all kinds are greatly appreciated. To help smoothen the process we have a few non-exhaustive guidelines to follow which should get you going in no time.

## What you will need

 * A Linux, Mac OS X, or Windows machine (note: to run and compile iOS specific parts you'll need access to a Mac OS X machine)
 * git (used for source version control, installation instruction can be found [here](https://git-scm.com/))
 * The Flutter SDK (installation instructions can be found [here](https://flutter.dev/get-started/install/))
 * A personal GitHub account (you can sign-in [here](https://github.com/))

## Setting up your development environment

 * [Fork](https://github.com/skwcrd/flutter_nfc/forks/new) `https://github.com/skwcrd/flutter_nfc` into your own GitHub account. If you already have a fork and moving to a new computer, make sure you update you fork.
 * If you haven't configured your machine with an SSH key that's known to github, then follow [GitHub's directions](https://github.com/help/ssh/README) to generate an SSH key.
 * Clone your forked repo on your local development machine: `git clone git@github.com:<your_name_here>/flutter_nfc.git`
 * Change into the `flutter_nfc` directory: `cd flutter_nfc`
 * Add an upstream to the original repo, so that fetch from the master repository and not your clone: `git remote add upstream git@github.com:skwcrd/flutter_nfc.git`

## Submitting a Merge Requests

 * Write appropriate title.
 * Wrtie a proper description including the issue name and solution.

## Using GitHub Issues

 * Feel free to use GitHub issues for questions, bug reports, and feature requests.
 * Use the search feature to check for an existing issue.
 * Include as much information as possible and provide any relevant resources (eg. screenshots).
 * For bug reports ensure you have a reproducible test case.
    * A merge request with a breaking test would be super preferable here but isn't required.

## Create a new issue

The easiest way to get involved is to create a [new issue](https://github.com/skwcrd/flutter_nfc/issues/new) when you spot a bug, if the documentation is incomplete or out of date, or if you identify an implementation problem.

## Running the example project

 * Change into the example directory: `cd example`
 * Run the App: `flutter run`

## Contribute

We really appreciate contributions via GitHub pull requests. To contribute take the following steps:

 * Make sure you are up to date with the latest code on the master:
    * `git fetch upstream`
    * `git checkout upstream/dev -b <name_of_your_branch>`
 * Apply your changes.
 * Verify your changes and fix potential warnings/ errors:
    * Check formatting: `flutter format .`
    * Run static analyses: `flutter analyze`
    * Run unit-tests: `flutter test`
 * Commit your changes: `git commit -am "<your informative commit message>"`
 * Push changes to your fork: `git push -u upstream <name_of_your_branch>`

Please make sure you solved all warnings and errors reported by the static code analyses and that you fill in the full pull request template. Failing to do so will result in us asking you to fix it.