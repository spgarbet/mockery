%%%-------------------------------------------------------------------
%% @doc mockery public API
%% @end
%%%-------------------------------------------------------------------
-module(mockery_app).
-behaviour(application).

%% Application callbacks
-export([start/2
        ,stop/1]).

-define(C_ACCEPTORS,  100).

%%====================================================================
%% API
%%====================================================================

start(_StartType, _StartArgs) ->
    erlang:display("mockery_app:start"),
    Routes    = routes(),
    Dispatch  = cowboy_router:compile(Routes),
    Port      = port(),
    TransOpts = [{port, Port}],
    ProtoOpts = [{env, [{dispatch, Dispatch}]}],
    {ok, _}   = cowboy:start_http(http, ?C_ACCEPTORS, TransOpts, ProtoOpts),
    mockery_sup:start_link().

%%--------------------------------------------------------------------

stop(_State) ->
  ok.

%%====================================================================
%% Internal functions
%%====================================================================

routes() ->
    [
        {'_', [{"/mockeries", mockeries_handler, []},
               {'_',          mock_handler,      []}
              ]
      }
    ].

port() ->
    case os:getenv("PORT") of
        false ->
            {ok, Port} = application:get_env(port),
            Port;
        Other ->
            list_to_integer(Other)
    end.
    

