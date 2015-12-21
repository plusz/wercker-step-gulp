# step-gulp

[![wercker status](https://app.wercker.com/status/62f69c1a976679c325cf25fce9282431/m "wercker status")](https://app.wercker.com/project/bykey/62f69c1a976679c325cf25fce9282431)

A wercker step to execute commands using the [gulp](http://gulpjs.com/) cli.

You should have `nodejs` and `npm` installed and you have to add the `gulp`
package to your package.json.

## Example Usage

In your [wercker.yml](http://devcenter.wercker.com/articles/werckeryml/) file under the `build` section:

``` bash
build:
  steps:
    - gulp:
        tasks: test
        debug: true
```

## Properties

### tasks
- type: string
- optional: true
- description: Tasks which should be run. You can use spaces to specify multiple tasks. If no tasks have been specified, then gulp will run the `default` task.
- example: `tasks: dev test`

### gulpfile
- type: string
- optional: true
- description: Specify an alternate Gulpfile. By default, gulp looks in the source directory or its parent directories for the nearest gulpfile.js file.

### stack
- type: boolean
- optional: true (default: false)
- description: Print a stack trace when exiting with a warning or fatal error.

### verbose
- type: boolean
- optional: true (default: false)
- description: Run gulp in verbose mode

### debug
- type: boolean
- optional: true (default: false)
- description: Enable debugging mode for tasks that support it.

### fail-on-warnings
- type: boolean
- optional: true (default: false)
- description: If gulp returns an error code of 6 (warning) then fail the build.

# Changelog

## 0.1.0

- initial release
