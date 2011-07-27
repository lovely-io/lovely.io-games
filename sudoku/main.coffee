#
# Sudoku main file
#
# Copyright (C) 2011 Nikolay Nemshilov
#

$       = require('dom')
core    = require('core')
Timer   = require('timer')
Hiscore = require('hiscore')
Cookie  = require('cookie')

# local variables assignments
ext     = core.ext
List    = core.List
Hash    = core.Hash
Class   = core.Class
Element = $.Element

# glue in your files
include 'src/sudoku'
include 'src/puzzle'
include 'src/field'
include 'src/block'
include 'src/cell'
include 'src/status'
include 'src/records'

# exporting the main class itself
exports = ext Sudoku,
  version: '%{version}'
  Puzzle:  Puzzle
  Field:   Field
  Block:   Block
  Cell:    Cell