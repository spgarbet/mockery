-module(mockery).

-export([start/0]).

start()->
    application:start(crypto),
    application:start(jiffy),
    application:start(ranch),
    application:start(cowlib),
    application:start(cowboy),
    ok = application:start(mockery).