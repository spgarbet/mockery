%%%-------------------------------------------------------------------
%% @doc mockery http handler
%% @end
%%%-------------------------------------------------------------------
-module(mock_handler).
-behaviour(cowboy_handler).

%% Application callbacks
-export([init/2,
         handle/2,
         terminate/3]).

-import(string, ['++'/2]).

%%====================================================================
%% API
%%====================================================================

init(Req, Opts) ->
  {ok, handle(Req, Opts), Opts}.


%%--------------------------------------------------------------------

handle(Req, Opts) ->
  erlang:display("mock_handler:init"),
  URI             = extract_uri(Req),
  Method          = cowboy_req:method(Req),
  {_, Body, _}    = cowboy_req:body(Req),
  {ok, Res, Meta} = mock:read(Method, URI, Body),
  cowboy_req:reply(status(Meta), header(Meta), Res, Req).
  
%%--------------------------------------------------------------------

terminate(_Reason, _Req, _State) ->
  ok.

%%====================================================================
%% Internal functions
%%====================================================================

% Since cowboy, mucks up the URI, this gets it back
extract_uri(Path, <<"">>) ->
  binary_to_list(Path);
extract_uri(Path, QS) ->
  binary_to_list(Path) ++ "?" ++ binary_to_list(QS).

extract_uri(Req) ->
  Path = cowboy_req:path(Req),
  QS   = cowboy_req:qs(Req),
  extract_uri(Path, QS).

%%--------------------------------------------------------------------

% Delete meta info, remaining is assumed to be header response
header(X) ->
  X2 = proplists:delete(<<"Status">>,  X ),
  X3 = proplists:delete(<<"URI">>,     X2),
  X4 = proplists:delete(<<"Request">>, X3),
  X4.

%%--------------------------------------------------------------------

% Extract status from meta info
status(X) ->
  proplists:get_value(<<"Status">>, X).

