'use strict';

/**
 * @ngdoc function
 * @name frontendApp.controller:MainCtrl
 * @description
 * # MainCtrl
 * Controller of the frontendApp
 */
angular.module('frontendApp')
  .controller('MainCtrl', function ($scope) {
    $scope.awesomeThings = [
      'HTML5 Boilerplate',
      'AngularJS',
      'Karma'
    ];

    $scope.statArray = [
      {id: '200', statResult: '200 OK'},
      {id: '201', statResult: '201 Created'},
      {id: '202', statResult: '202 Accepted'},
      {id: '203', statResult: '203 Non-Authoritative Information'},
      {id: '204', statResult: '204 No Content'},
      {id: '205', statResult: '205 Reset Content'},
      {id: '206', statResult: '206 Partial Content'},
      {id: '207', statResult: '207 Multi-stat'},
      {id: '208', statResult: '208 Already Reported'},
      {id: '226', statResult: '226 IM Used'},
      {id: '300', statResult: '300 Multiple Choices'},
      {id: '301', statResult: '301 Move Permanently'},
      {id: '302', statResult: '302 Found'},
      {id: '303', statResult: '303 See Other'},
      {id: '304', statResult: '304 Not Modified'},
      {id: '305', statResult: '305 Use Proxy'},
      {id: '306', statResult: '306 Switch Proxy'},
      {id: '307', statResult: '307 Temporary Redirect'},
      {id: '308', statResult: '308 Permanent Redirect'},
      {id: '400', statResult: '400 Bad Request'},
      {id: '401', statResult: '401 Unauthorized'},
      {id: '402', statResult: '402 Payment Required'},
      {id: '403', statResult: '403 Forbidden'},
      {id: '404', statResult: '404 Not Found'},
      {id: '405', statResult: '405 Method Not Allowed'},
      {id: '406', statResult: '406 Not Acceptable'},
      {id: '407', statResult: '407 Proxy Authentication Required'},
      {id: '408', statResult: '408 Request Timeout'},
      {id: '409', statResult: '409 Conflict'},
      {id: '410', statResult: '410 Gone'},
      {id: '411', statResult: '411 Length Required'},
      {id: '412', statResult: '412 Precondition Failed'},
      {id: '413', statResult: '413 Request Entity Too Large'},
      {id: '414', statResult: '414 Request-URI Too Long'},
      {id: '415', statResult: '415 Unsupported Media Type'},
      {id: '416', statResult: '416 Requested Range Not Satisfiable'},
      {id: '417', statResult: '417 Expectation Failed'},
      {id: '418', statResult: '418 I\'m a teapot'},
      {id: '419', statResult: '419 Authentication Timeout'},
      {id: '420', statResult: '420 Enhance Your Calm'},
      {id: '422', statResult: '422 Unprocessable Entity'},
      {id: '423', statResult: '423 Locked'},
      {id: '424', statResult: '424 Failed Dependency'},
      {id: '426', statResult: '426 Upgrade Required'},
      {id: '428', statResult: '428 Precondition Required'},
      {id: '429', statResult: '429 Too Many Requests'},
      {id: '431', statResult: '431 Request Header Fields Too Large'},
      {id: '440', statResult: '440 Login Timeout'},
      {id: '444', statResult: '444 No Response'},
      {id: '449', statResult: '449 Retry With'},
      {id: '450', statResult: '450 Blocked by Windows Parental Controls'},
      {id: '451', statResult: '451 Unavailable For Legal Reasons'},
      {id: '494', statResult: '494 Request Header Too Large'},
      {id: '495', statResult: '495 Cert Error'},
      {id: '496', statResult: '496 No Cert'},
      {id: '497', statResult: '497 HTTP to HTTPS'},
      {id: '498', statResult: '498 Token expired/invalid'},
      {id: '499', statResult: '499 Client Closed Request'},
      {id: '500', statResult: '500 Internal Server Error'},
      {id: '501', statResult: '501 Not Implemented'},
      {id: '502', statResult: '502 Bad Gateway'},
      {id: '503', statResult: '503 Service Unavailable'},
      {id: '504', statResult: '504 Gateway Timeout'},
      {id: '505', statResult: '505 HTTP Version Not Supported'},
      {id: '506', statResult: '506 Variant Also Negotiates'},
      {id: '507', statResult: '507 Insufficient Storage'},
      {id: '508', statResult: '508 Loop Detected'},
      {id: '509', statResult: '509 Bandwidth Limit Exceeded'},
      {id: '510', statResult: '510 Not Extended'},
      {id: '511', statResult: '511 Network Authentication Required'},
      {id: '520', statResult: '520 Origin Error'},
      {id: '521', statResult: '521 Web server is down'},
      {id: '522', statResult: '522 Connection timed out'},
      {id: '523', statResult: '523 Proxy Declined Request'},
      {id: '524', statResult: '524 A timeout occurred'},
      {id: '598', statResult: '598 Network read timeout error'},
      {id: '599', statResult: '599 Network connect timeout error'}
    ];

  });
