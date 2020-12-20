Flutter NFC release `vX.Y.Z`

 * Set the milestone on this issue
 * Review the list of changes since the last release and fill below:
    * **In the changelog**
    * **Not in the changelog**
 * Decide on the version number by reference to
    the [Versioning](https://semver.org/spec/v2.0.0.html)
    * Typically if you want to release code from current `main` branch you will update `MINOR` version, e.g. `1.2.0` -> `1.3.0`. In that case you **don't** need to create stable branch
    * If you want to backport some bug fix or security fix you will need to update stable branch `X-Y-stable`
 * Create an MR for [flutter_nfc project](https://github.com/skwcrd/flutter_nfc/pulls).
    * Update `CHANGELOG.md`.
    * Assign to reviewer
 * Once `flutter_nfc` is merged create a signed+annotated tag pointing to the **merge commit** on the **stable branch**

   In case of `main` branch:

   ``` shell
   git fetch upstream main
   git tag -a -s -m "Release v1.0.0" v1.0.0 upstream/main
   ```

   In case of `stable` branch:

   ``` shell
   git fetch upstream 1-0-stable
   git tag -a -s -m "Release v1.0.0" v1.0.0 upstream/1-0-stable
   ```

 * Verify that you created tag properly:

   ``` shell
   git show v1.0.0
   ```

   it should include something like:
    * `(tag: v1.0.0, upstream/main, main)` for `main`
    * `(tag: v1.0.1, upstream/1-0-stable, 1-0-stable)` for `stable` branch

 * Push this tag to origin(**Skip this for security release!**)
   ``` shell
   git push upstream v1.0.0
   ```