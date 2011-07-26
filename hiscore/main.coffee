#
# Hiscore main file
#
# Copyright (C) 2011 Nikolay Nemshilov
#

# hook up dependencies
core     = require('core')
$        = require('dom')
Cookie   = require('cookie')

# local variables assignments
Hash     = core.Hash
Class    = core.Class
Element  = $.Element
document = global.document

# glue in your files
include 'src/hiscore'

# export your objects in the module
exports = Hiscore
exports.version = '%{version}'
