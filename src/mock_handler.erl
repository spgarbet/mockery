-module(mock_handler).
-behaviour(cowboy_http_handler).

-export([init/3]).
-export([handle/2]).
-export([terminate/3]).

-import(string, ['++'/2]).

%-record(state, {}).

init(_Type, Req, _Opts)   -> {ok, Req, no_state}.

% Since cowboy, mucks up the URI, this gets it back
extract_uri(Path, <<"">>) -> binary_to_list(Path);
extract_uri(Path, QS)     -> binary_to_list(Path) ++ "?" ++ binary_to_list(QS).
extract_uri(Req)          -> {Path, _} = cowboy_req:path(Req),
                             {QS, _}   = cowboy_req:qs(Req),
                             extract_uri(Path, QS).

   URI          : a fully qualified URI
   Status       : HTTP status of response
   Content-Type : Content type of response (Can be omitted, freeform text, but has defaults)
   Request      : Body of Request (only available to PUT and POST)
   Response     : Mocked Response 
   
handle(Req, State) ->
    URI = extract_uri(Req),
    {Method, _} = cowboy_req:method(Req),
    {_, Body,   _} = cowboy_req:body(Req),
    % cowboy_req:body_length(Req) may prove helpful
    {ok, Meta, Res} = mock:read(Method, URI, Body),
    {ok, Req2} = cowboy_req:reply(200,
        [
            {<<"content-type">>, <<"text/plain">>}
        ],
        Res, Req),
    {ok, Req2, State}.
        

terminate(_Reason, _Req, _State) ->
    ok.