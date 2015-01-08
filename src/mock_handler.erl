%%%-------------------------------------------------------------------
%% @doc mockery http handler
%% @end
%%%-------------------------------------------------------------------
-module(mock_handler).

%% Application callbacks
-export([init/2
        ,content_types_provided/2
        ,hello_to_html/2
        ,hello_to_json/2
        ,hello_to_text/2]).

%% Internal Functions
-export([get_mock/1
        ,extract_uri/1
        ,extract_uri/2]).

-import(string, ['++'/2]).

%%====================================================================
%% API
%%====================================================================

init(Req, Opts) ->
  {cowboy_rest, Req, Opts}.

%%--------------------------------------------------------------------

content_types_provided(Req, State) ->
  {[
    {<<"text/html">>, hello_to_html},
    {<<"application/json">>, hello_to_json},
    {<<"text/plain">>, hello_to_text}
  ], Req, State}.

hello_to_html(Req, State) ->
  Body = <<"<html>
<head>
  <meta charset=\"utf-8\">
  <title>REST Hello World!</title>
</head>
<body>
  <p>REST Hello World as HTML!</p>
</body>
</html>">>,
  {Body, Req, State}.

hello_to_json(Req, State) ->
  %Body = <<"{\"rest\": \"Hello World!\"}">>,
  {ok, Body} = get_mock(Req),
  {Body, Req, State}.

hello_to_text(Req, State) ->
  {<<"REST Hello World as text!">>, Req, State}.

%%====================================================================
%% Internal functions
%%====================================================================

get_mock(Req) ->
  URI             = extract_uri(Req),
  Method     = cowboy_req:method(Req),
  {_, Body, _}    = cowboy_req:body(Req),
  {ok, _Res, Meta} = mock:read(Method, URI, Body),
  %{ok, Req2}      = cowboy_req:reply(status(Meta), header(Meta), Res, Req),
  %{ok, Req2, State}.
  {ok, Meta}.

%%--------------------------------------------------------------------

%% @doc Since cowboy, mucks up the URI, this gets it back
extract_uri(Path, <<"">>) ->
  binary_to_list(Path);
extract_uri(Path, QS) ->
  binary_to_list(Path) ++ "?" ++ binary_to_list(QS).

extract_uri(Req) ->
  Path = cowboy_req:path(Req),
  QS   = cowboy_req:qs(Req),
  extract_uri(Path, QS).

%%--------------------------------------------------------------------

%%% @doc Delete meta info, remaining is assumed to be header response
%header(X) ->
%  X2 = proplists:delete(<<"Status">>,  X ),
%  X3 = proplists:delete(<<"URI">>,     X2),
%  X4 = proplists:delete(<<"Request">>, X3),
%  X4.
%
%%%--------------------------------------------------------------------
%
%%% @doc Extract status from meta info
%status(X) ->
%  proplists:get_value(<<"Status">>, X).
%
%%====================================================================
%% Callback methods for the REST handler
%%====================================================================

