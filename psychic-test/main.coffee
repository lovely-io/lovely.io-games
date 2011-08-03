#
# Psychic-Test main file
#
# Copyright (C) 2011 Nikolay Nemshilov
#

# hook up dependencies
core    = require('core')
$       = require('dom')
Deck    = require('cards').Deck
Hiscore = require('hiscore')

# local variables assignments
ext     = core.ext
bind    = core.bind
Class   = core.Class
Element = $.Element

# glue in your files
include 'src/psychic_test'
include 'src/controls'

# export your objects in the module
exports = ext PsychicTest,
  version: '%{version}'
