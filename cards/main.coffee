#
# Cards main file
#
# Copyright (C) 2011 Nikolay Nemshilov
#

# hook up dependencies
core    = require('core')
$       = require('dom')

# local variables assignments
ext     = core.ext
Class   = core.Class
List    = core.List
Element = $.Element

# glue in your files
include 'src/card'
include 'src/deck'

# export your objects in the module
ext exports,
  version: '%{version}'
  Card:    Card
  Deck:    Deck
