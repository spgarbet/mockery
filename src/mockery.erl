-module(mockery).

-export([start/0]).

start() ->
    ok = application:start(crypto),
    ok = application:start(cowboy),
    ok = application:start(mockery).