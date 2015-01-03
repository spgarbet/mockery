%%%-------------------------------------------------------------------
%% @doc mockery http handler
%% @end
%%%-------------------------------------------------------------------
-module(mockeries_handler).
-behaviour(cowboy_http_handler).

%% Application callbacks
-export([init/3
        ,handle/2
        ,terminate/3]).

%% Record for storing the response
-record(state, {}).

%%====================================================================
%% API
%%====================================================================

init(_, Req, Opts) ->
    Req2 = cowboy_req:reply(
                            200
                            ,[ {<<"content-type">>,<<"text/plain">> } ]
                            ,<<"Hello Erlang!">>
                            ,Req),
    {ok, Req2, Opts}.

%%--------------------------------------------------------------------

handle(Req, State=#state{}) ->
  {ok, Req2} = cowboy_req:reply(200, Req),
  {ok, Req2, State}.

%%--------------------------------------------------------------------

terminate(_Reason, _Req, _State) ->
  ok.
