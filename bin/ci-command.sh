#!/bin/bash
# ART19 Script Support for Travis CI
#
# This program is used by Travis CI to perform different actions during the various stages
# of a build. We currently use a "Test" and a "Report" stage on Travis.

##
# Show usage and quite program
usage() {
  echo -e "Usage: $0 sub-command\n"
  echo -e "Subcommands:"
  echo -e "  before_install     - Install dependencies for the build"
  echo -e "  before_script      - Do things before the actual build script is executed"
  echo -e "  after_success      - What to do once a job/build was successful"
  echo -e "  collect_and_report - The Report stage's build process"
}

##
# Install the latest CodeClimate test reporter and place it into ~/bin
install_cc_test_reporter() {
  if [ ! -d ~/bin ]; then
    mkdir -p ~/bin && chmod +x ~/bin
  fi

  curl -L https://codeclimate.com/downloads/test-reporter/test-reporter-latest-linux-amd64 > ~/bin/cc-test-reporter && chmod +x ~/bin/cc-test-reporter
  test -x ~/bin/cc-test-reporter && echo "CodeClimate test reporter installed"
}

##
# Only report code coverage when running in MRI/YARV.
# This exports COVERAGE with a value of 'true' into the environment
configure_coverage_flag() {
  if [ "x`ruby --version | cut -d ' ' -f 1`" = "xruby" ]; then
    export COVERAGE=true
    echo "** Turning coverage on: ${COVERAGE}"
  else
    echo "** No Coverage reporting for this Ruby version"
  fi
}

##
# Execute the before_install step for the Test stage.
# This installs bundler and the test-reporter
before_install() {
  echo "** Before install for Test"

  gem install bundler
  bundle --version

  echo "** Installing CodeClimate test reporter"
  install_cc_test_reporter
}

##
# Setup, install and configure all stuff required for the Test stage.
#
# Make sure to "source" this command in Travis, otherwise the coverage config is lost
before_script() {
  echo "** Before script for Test"

  configure_coverage_flag

  # Use the documentation format for rubinius since it gets killed by Travis-CI before finishing for some reason
  if [ "x`ruby --version | cut -d ' ' -f 1`" = "xrubinius" ]; then echo '--format documentation' >> .rspec; fi
}

##
# Execute the script for the Test stage
script() {
  sync

  export RACK_ENV=test
  bundle exec rubocop
  bundle exec rspec
}

##
# A job has finished successfully in the Test stage.  If COVERAGE is turned on,
# format the coverage data and upload it to S3.
after_success() {
  echo "** after_success"

  if [ "x$COVERAGE" = "xtrue" ]; then
    ~/bin/cc-test-reporter format-coverage --debug -t simplecov
  else
    echo "** COVERAGE reporting is turned OFF"
  fi
}

##
# Main
##
if [ $# -ne 1 ]; then
  usage
  exit 1
fi

echo "cmd: ${1}"
${1}
