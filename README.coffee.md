#flatten-json-pipe

Pipe JSON in, get it flattened on the way out.

![Build Status](http://img.shields.io/codeship/???.svg?style=flat)
[![Dependencies](http://img.shields.io/david/radekstepan/flatten-json-pipe.svg?style=flat)](https://david-dm.org/radekstepan/flatten-json-pipe)
[![License](http://img.shields.io/badge/license-AGPL--3.0-red.svg?style=flat)](LICENSE)

##Run

Install with [npm](https://www.npmjs.org/).

```bash
$ npm install flatten-json-pipe -g
```

Pipe through passing an optional `delimiter`.

```bash
$ echo '{"A":{"name":"Peter"},"B":{"val":[\"a\",\"b\"]}}' | flatten-json-pipe '.'
```

You get the following back:

```json
{
  "A.name": "Peter",
  "B.val.0": "a",
  "B.val.1": "b"
}
```

##Source

    _      = require 'highland'
    ndjson = require 'ndjson'
    flat   = require 'flat'

    module.exports = (delimiter='.') ->
      through = (obj) -> flat obj, { delimiter }

      _.pipeline.apply _, [
        do _
        do ndjson.parse
        _.map through
        do ndjson.stringify
      ]