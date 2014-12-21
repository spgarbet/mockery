-module(mockery_app).
-behaviour(application).

-export([start/2]).
-export([stop/1]).

start(_Type, _Args) ->
    Dispatch = cowboy_router:compile([
        {'_', [{"/mockeries", mockeries_handler, []},
		       {'_',          mock_handler,      []}
		      ]
	    }
    ]),
    cowboy:start_http(my_http_listener, 100, [{port, 8080}],
        [{env, [{dispatch, Dispatch}]}]
    ),
	file:set_cwd("../.."),
    mockery_sup:start_link().

stop(_State) ->
	ok.
