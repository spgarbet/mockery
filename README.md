The purpose of Mockery is to quickly mock any endpoint called by a server with a canned response. This has value for full regression testing, when the response is known.

make
./_rel/mockery_release/bin/mockery_release console


The Massive To Do List


# /mockery Tabs
1. Instructions and Log, updated via async javascript
   a. Log include URI requested, and Hash Delivered
   b. Log includes, mock responses created
   c. It's a rolling log of 20 events
2. Current Routes, updated when tab is selected
   a. Scans local file system, and shows all Verb, URI -> Hashed Response
   b. If the Verb is POST or PUT it is clickable to display the body of request
   c. The Hash value is clickable to display the actual response
3. Create Route,
   Verb         : GET, POST, DELETE, PUT, HEAD
   URI          : a fully qualified URI
   Status       : HTTP status of response
   Content-Type : Content type of response (Can be omitted, freeform text, but has defaults)
   Request      : Body of Request (only available to PUT and POST)
   Response     : Mocked Response 
   
   a. GET, can be partial based on header 'Content-Range: bytes 1000-3979/3980'
   b. HEAD is a GET request, with no body
   c. POST and PUT have data in request body
   
   When create is clicked. Hashed and written to file system.
   If it alrady exists, a warning appears, allowing "Abort" or "Overwrite"
 

A SHA1 Hash of Verb + URI + {Request} is used for locally storing response.

First two characters will be directory under <project>/mocks. Remaining will be file containing JSON.

Actual reserved routes

/mockery => The main tabs, an internal asset that is mocked. Yes, the application is post-modern.
/mockery/log => Log callback => JSON
/mockery/routes => all the routes in  JSON
/mockery/routes/[Hash] => returns JSON {verb, uri, request, status, request, response}

Any other URI is hashed to get status/response from filesystem.

Open question : How to store binary objects for response?

List of status:

200 OK
201 Created
202 Accepted
203 Non-Authoritative Information
204 No Content
205 Reset Content
206 Partial Content
207 Multi-Status
208 Already Reported
226 IM Used
300 Multiple Choices
301 Move Permanently
302 Found
303 See Other
304 Not Modified
305 Use Proxy
306 Switch Proxy
307 Temporary Redirect
308 Permanent Redirect
400 Bad Request
401 Unauthorized
402 Payment Required
403 Forbidden
404 Not Found
405 Method Not Allowed
406 Not Acceptable
407 Proxy Authentication Required
408 Request Timeout
409 Conflict
410 Gone
411 Length Required
412 Precondition Failed
413 Request Entity Too Large
414 Request-URI Too Long
415 Unsupported Media Type
416 Requested Range Not Satisfiable
417 Expectation Failed
418 I'm a teapot
419 Authentication Timeout
420 Enhance Your Calm
422 Unprocessable Entity
423 Locked
424 Failed Dependency
426 Upgrade Required
428 Precondition Required
429 Too Many Requests
431 Request Header Fields Too Large
440 Login Timeout
444 No Response
449 Retry With
450 Blocked by Windows Parental Controls
451 Unavailable For Legal Reasons
494 Request Header Too Large
495 Cert Error
496 No Cert
497 HTTP to HTTPS
498 Token expired/invalid
499 Client Closed Request
500 Internal Server Error
501 Not Implemented
502 Bad Gateway
503 Service Unavailable
504 Gateway Timeout
505 HTTP Version Not Supported
506 Variant Also Negotiates
507 Insufficient Storage
508 Loop Detected
509 Bandwidth Limit Exceeded
510 Not Extended
511 Network Authentication Required
520 Origin Error
521 Web server is down
522 Connection timed out
523 Proxy Declined Request
524 A timeout occurred
598 Network read timeout error
599 Network connect timeout error


* Content-Type
application/ecmascript
application/javascript
application/json
application/xhtml+xml
application/xml
application/xml-dtd
application/zip
application/gzip
image/gif
image/jpeg
image/png
image/svg+xml
image/tiff
text/css
text/csv
text/html
text/plain
text/xml