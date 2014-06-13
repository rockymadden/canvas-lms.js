#canvas-lms.js [![Build Status](https://travis-ci.org/rockymadden/canvas-lms.js.png?branch=master)](http://travis-ci.org/rockymadden/canvas-lms.js)
Functional Node wrapper for the Canvas LMS REST API. All Canvas LMS REST functions are supported via the lower-level
[http closure](https://github.com/rockymadden/canvas-lms.js/blob/master/src/main/coffeescript/lib/http.coffee). Many
functions are also supported via the higher-level
[client closure](https://github.com/rockymadden/canvas-lms.js/tree/master/src/main/coffeescript/lib/client.coffee),
which makes interaction with Canvas as easy as possible. For example: `session.getUser(1)`

## Depending Upon
The project is available on the [Node Packaged Modules registry](https://npmjs.org/package/canvas-lms.js). Add the
dependency in your package.json file:

```javascript
"dependencies": {
	"canvas-lms.js": "0.1.x"
}
```

## Usage
Create a user, update user, delete user, and then end session:
```coffeescript
client = canvas.client('https://example.com', 'token')
create =
	user: name: 'create user'
	pseudonym: unique_id: 'user@example.com'
update =
	user: name: 'update user'

client.withSession((session) ->
	session.postUser(1, create)
		.then((response) -> response.fold((-> -1), ((r) -> r.id)))
		.then((id) -> session.putUser(id, update); id)
		.then((id) -> session.deleteUser({account_id: 1, user_id: id}))
		.done()
)
```

## License
```
The MIT License (MIT)

Copyright (c) 2014 Rocky Madden (http://rockymadden.com/)

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
