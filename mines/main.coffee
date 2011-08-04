#
# mines-game main file
#
# Copyright (C) 2011 Nikolay Nemshilov
#

# hook up dependencies
core    = require('core')
dom     = require('dom')
lang    = require('lang')
Timer   = require('timer')
Hiscore = require('hiscore')

Class   = core.Class
List    = core.List
Element = dom.Element

# glue in your files
include 'src/cell'
include 'src/field'
include 'src/smile'
include 'src/stats'
include 'src/game'


# export your objects in the module
Game.version = '%{version}'
exports = Game
