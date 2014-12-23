%%%-------------------------------------------------------------------
%% @doc mockery public API
%% @end
%%%-------------------------------------------------------------------
-module(mockery_app).
-behaviour(application).

%% Application callbacks
-export([start/2
        ,stop/1]).

%%====================================================================
%% API
%%====================================================================

start(_StartType, _StartArgs) ->
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

%%--------------------------------------------------------------------

stop(_State) ->
  ok.

%%====================================================================
%% Internal functions
%%====================================================================

