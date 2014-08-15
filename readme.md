#canvas-lms.js [![Build Status](https://travis-ci.org/rockymadden/canvas-lms.js.png?branch=master)](http://travis-ci.org/rockymadden/canvas-lms.js)
Functional Node wrapper for the open source Canvas LMS REST API. All REST calls are supported via the lower-level
[http closure](https://github.com/rockymadden/canvas-lms.js/blob/master/src/main/coffeescript/lib/http.coffee).
Many are also supported via the higher-level
[client closure](https://github.com/rockymadden/canvas-lms.js/tree/master/src/main/coffeescript/lib/client.coffee),
which makes interaction with Canvas as easy as possible.

> <sub>__Example:__ `client.getAccount(1)` vs `http.get(((i) -> "/api/v1/accounts/#{ i }"), 1)`</sub>

## Grokking
Experience with basic category theory (e.g. monads and applicative functors), functional programming concepts, and
future/promise constructs is highly recommended. Additionally, two third-party libraries are leveraged heavily, which
you should familiarize yourself with:

* [bilby.js](https://github.com/puffnfresh/bilby.js): Serious functional programming library for JavaScript
* [q](https://github.com/kriskowal/q): A tool for making and composing asynchronous promises in JavaScript

## Depending
The project is available on the [Node Packaged Modules registry](https://npmjs.org/package/canvas-lms.js). Add the
dependency in your package.json file:

```javascript
"dependencies": {
  "canvas-lms.js": "0.7.x"
}
```

## Using
Create user, update user, delete user, and then end session:
```coffeescript
client = require('canvas-lms.js').client('https://canvas.example.com', 'token')

client.withSession((canvas) ->
  create =
    user: name: 'create user'
    pseudonym: unique_id: 'user@example.com'
  update =
    user: name: 'update user'

  canvas.postUser(1, create)
    .then((response) -> response.fold((-> -1), ((r) -> r.id)))
    .then((id) -> canvas.putUser(id, update); id)
    .then((id) -> canvas.deleteUser({account_id: 1, user_id: id}))
    .done()
)
```

> <sub>__Note:__ Client uses a pre-generated token. Thus, there is no session clean up needed (e.g. logout).</sub>

## License
```
The MIT License (MIT)

Copyright (c) 2014 Rocky Madden (https://rockymadden.com/)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
```
