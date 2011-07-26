#
# Timer's main file
#

core    = require('core')
$       = require('dom')

bind    = core.bind
Hash    = core.Hash
Class   = core.Class
Element = $.Element

include 'src/timer'

Timer.version = '%{version}'

exports = Timer