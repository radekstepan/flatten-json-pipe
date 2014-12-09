{ assert } = require 'chai'
_          = require 'highland'
ndjson     = require 'ndjson'
filter     = require 'jsonfilter'

through = require '../README.coffee.md'

module.exports =
  'flatten': (done) ->
    obj =
      "A":
        "name": "Peter"
      "B":
        "val": [ 'a', 'b' ]

    expected =
      "A.name": "Peter"
      "B.val.0": "a"
      "B.val.1": "b"

    _([ obj ])
    .pipe(do ndjson.stringify)
    .pipe(do through)
    .toArray (res) ->
      assert.deepEqual JSON.parse(res), expected
      do done

  'jsonfilter': (done) ->
    obj =
      "values": [
        {
          "A":
            "name": "Peter"
          "B":
            "val": [ 'a', 'b' ]
        }
      ]

    expected =
      "A.name": "Peter"
      "B.val.0": "a"
      "B.val.1": "b"

    _([ obj ])
    .pipe(do ndjson.stringify)
    .pipe(filter 'values.*')
    .pipe(do through)
    .toArray (res) ->
      assert.deepEqual JSON.parse(res), expected
      do done