#
# Sudoku main file
#
# Copyright (C) 2011 Nikolay Nemshilov
#

$       = require('dom')
core    = require('core')
Timer   = require('timer')
Hiscore = require('hiscore')

# local variables assignments
ext     = core.ext
List    = core.List
Hash    = core.Hash
Class   = core.Class
Element = $.Element

# glue in your files
include 'src/sudoku'
include 'src/puzzle'

exports = ext Sudoku,
  version: '%{version}'
  Puzzle:  Puzzle