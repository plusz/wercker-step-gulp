#!/bin/bash

# return true if local npm package is installed at ./node_modules, else false
# example
# printf "gulp : $(npm_package_is_installed gulp)"
npm_package_is_installed() {
  # set to true initially
  local RETURN_=true
  # set to false if not found
  ls node_modules | grep "$1" >/dev/null 2>&1 || { local RETURN_=false; }
  # return value
  printf "$RETURN_"
}

# First make sure gulp is installed
if ! type gulp &> /dev/null ; then
    # Check if it is in repo
    if ! $(npm_package_is_installed gulp) ; then
        info "gulp is not installed, currently trying to install it via npm"

        if ! type npm &> /dev/null ; then
            fail "npm not found, make sure you have npm and/or gulp installed"
        else
            info "npm is available"
            debug "npm version: $(npm --version)"

            info "installing gulp"
            sudo npm install -g gulp
            GULP_COMMAND="gulp"
        fi
    else
        info "gulp is available locally"
        debug "gulp version: $(./node_modules/gulp/bin/gulp.js --version)"
        GULP_COMMAND="./node_modules/gulp/bin/gulp.js"
    fi
else
    info "gulp is available"
    debug "gulp version: $(gulp --version)"
    GULP_COMMAND="gulp"
fi

# Parse some variable arguments
if [ "$WERCKER_GULP_DEBUG" = "true" ] ; then
    GULP_COMMAND="$GULP_COMMAND --debug"
fi

if [ "$WERCKER_GULP_VERBOSE" = "true" ] ; then
    GULP_COMMAND="$GULP_COMMAND --verbose"
fi

if [ "$WERCKER_GULP_STACK" = "true" ] ; then
    GULP_COMMAND="$GULP_COMMAND --stack"
fi

if [ -n "$WERCKER_GULP_GULPFILE" ] ; then
    GULP_COMMAND="$GULP_COMMAND --gulpfile $WERCKER_GULP_GULPFILE"
fi

if [ -n "$WERCKER_GULP_TASKS" ] ; then
    GULP_COMMAND="$GULP_COMMAND $WERCKER_GULP_TASKS"
fi

debug "$GULP_COMMAND"

set +e
$GULP_COMMAND
RESULT="$?"
set -e

if [[ $RESULT -eq 0 ]]; then
  success "finished $GULP_COMMAND"
elif [[ $RESULT -eq 6 && "$WERCKER_GULP_FAIL_ON_WARNINGS" != 'true' ]]; then
  warn "gulp returned warnings, however fail-on-warnings is not true"
  success "finished $GULP_COMMAND"
else
    warn "gulp exited with exit code: $RESULT"
    fail "gulp failed"
fi