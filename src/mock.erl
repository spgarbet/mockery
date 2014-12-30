%%%-------------------------------------------------------------------
%% @doc mock response manufacturer
%% @end
%%%-------------------------------------------------------------------
-module(mock).

%% Public API
-export([read/3]).

%% Private methods
-export([urlsafe_encode64/1
         ,hash/1
         ,name/3
         ,ensure_exists/1
         ,ensure_exists/2
         ,store/5
        ]).

-import(string, ['++'/2, substr/2, substr/3]).

%% Constants
-define(ROOT, "./mocks/").

%%====================================================================
%% API
%%====================================================================

read(Verb, URI, Req) ->
  lager:info("Testing out lager. We're in mock:read()"),
  {Dir, File} = name(Verb, URI, Req),
  N = ?ROOT ++ Dir ++ "/" ++ File,
  {ok, Res}  = file:read_file(N++".res"),
  {ok, Meta} = file:read_file(N++".nfo"),
  {Meta2}    = jiffy:decode(Meta),
  {ok, Res, Meta2}.

%%--------------------------------------------------------------------

%%====================================================================
%% Private Methods
%%====================================================================

% Verb, look into prop list to map between cowboy verb and needs here
urlsafe_encode64(Bin) ->
  Bin2 = base64:encode(Bin),
  Bin3 = re:replace(binary_to_list(Bin2), "\\+", "-", [global, {return,list}]),
  re:replace(Bin3, "/", "_", [global, {return,list}]).

%%--------------------------------------------------------------------

% Hash method
hash(Data) ->
  Hash = urlsafe_encode64(crypto:hash(sha, Data)),
  {substr(Hash, 1, 2), substr(Hash, 3)}.

%%--------------------------------------------------------------------

% Given key, construct 2-part hash, directory / filename
name(Verb, URI, Req) ->
  I = binary_to_list(Verb),
  hash(list_to_binary(I ++ URI ++ Req)).

%%--------------------------------------------------------------------

ensure_exists(Dir) ->
  ensure_exists(Dir, file:list_dir(?ROOT ++ Dir)).
ensure_exists(_,  {ok, _}) ->
  ok;
ensure_exists(Dir, _) ->
  file:make_dir(?ROOT ++ Dir).

%%--------------------------------------------------------------------

store(Verb, URI, Req, Res, Hdr) ->
  {Dir, File} = name(Verb, URI, Req),
  ensure_exists(Dir),
  Filename = ?ROOT ++ Dir ++ "/" ++ File,
  {ok, _} = file:write_file(Filename ++ ".res", Res),
  file:write_file(Filename ++ ".nfo", Hdr).


