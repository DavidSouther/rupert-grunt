Path = require 'path'
findup = require 'findup-sync'

noop = ->

module.exports = (grunt, config)->
  # quick and dirty check if a dependency is requireable
  canRequire = (key)->
    key.indexOf('rupert-config-') is 0 or key.indexOf('/') > -1

  cfg = config.find 'plugins', findup('package.json')
  if typeof cfg is 'string'
      cfg = require Path.resolve cfg
  deps = cfg.dependencies
  for key of deps when canRequire key
    dependency =
      try
        require(key).Gruntfile or noop
      catch e
        noop
    dependency(grunt, config)
