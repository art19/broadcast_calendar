# BroadcastCalendar Gem

_Note: This is a permanent fork of the original broadcast_calendar because we made a few changes and brought it up to 
date with ruby 2.7.1, and the original is no longer actively maintained._

This library returns the beginning and ending Gregorian (civil) dates for months in the 
[broadcast calendar](http://en.wikipedia.org/wiki/Broadcast_calendar).

# Installation

    gem install broadcast_calendar

# Usage

Dates are returned as a Range object.

    > BroadcastCalendar.dates_for(5,2011)
    => Mon, 25 Apr 2011..Sun, 29 May 2011 

## Building and Publishing

This gem is deployed to GitHub packages. Follow the [GitHub Packages Guide](https://help.github.com/en/github/managing-packages-with-github-packages/configuring-rubygems-for-use-with-github-packages) to set up your system for this. You will end up creating a key in `~/.gem/credentials`, probably named `github`. Once you've done that, you can `GEM_PUSH_KEY=whatever bundle exec rake publish` to publish the gem. Please note that once you "use" a version number on GitHub, it's used forever, so be sure to edit the version number in the app to add `.pre.GIT_SHORT_HASH` to the end if this is a test build (you can use `git rev-parse --short --verify HEAD` to get the Git short hash).

# Problems? Questions?

Email <mike@subelsky.com> or file an issue on GitHub. Thanks!
