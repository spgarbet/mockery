-module(mock_SUITE).

-compile(export_all).

-include_lib("common_test/include/ct.hrl").

% etest macros
-include_lib ("etest/include/etest.hrl").
% etest_http macros
-include_lib ("etest_http/include/etest_http.hrl").

suite() ->
    [{timetrap,{seconds,30}}].

init_per_suite(Config) ->
    mockery:start(),
    Config.

end_per_suite(_Config) ->
    mockery:stop(),
    ok.

init_per_testcase(_TestCase, Config) ->
    Config.

end_per_testcase(_TestCase, _Config) ->
    ok.

all() -> 
    [joe].

joe(_Config) ->
    Response = ?perform_get("http://localhost:8080/joe"),
    ?assert_status(200, Response),
    ?assert_body("booyah", Response),
    ok.