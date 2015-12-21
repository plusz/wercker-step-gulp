# step-gulp

A wercker step to execute commands using the [gulp](http://gulpjs.com/) cli.

You should have nodejs and npm installed and you have to add the `gulp`
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
- example: `tasks: serve:dev`

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
