%%%-------------------------------------------------------------------
%% @doc mock response manufacturer
%% @end
%%%-------------------------------------------------------------------
-module(mock).

%% Public API
-export([read/3, store/5]).

-import(string, ['++'/2, substr/2, substr/3]).

%%====================================================================
%% API
%%====================================================================

read(Verb, URI, Req) ->
  {Dir, File} = name(Verb, URI, Req),
  N           = filename(Dir, File),
  %{ok, Res}   = file:read_file(N++".res"),
  %{ok, Meta}  = file:read_file(N++".nfo"),
  {ok, Res}   = get_res(N++".res"),
  {ok, Meta}  = get_meta(N++".nfo"),
  {Meta2}     = jiffy:decode(Meta),
  {ok, Res, Meta2}.

%%--------------------------------------------------------------------

store(Verb, URI, Req, Res, Hdr) ->
  {Dir, File} = name(Verb, URI, Req),
  ensure_exists(Dir),
  Filename = filename(Dir, File),
  {ok, _} = file:write_file(Filename ++ ".res", Res),
  file:write_file(Filename ++ ".nfo", Hdr).

%%--------------------------------------------------------------------

%%====================================================================
%% Private Methods
%%====================================================================

% What directory holds response files
root() ->
    {ok, Dir} = application:get_env(mockery, root),
    Dir.

filename(Dir, File) -> 
    filename:join([root(), Dir, File]).

get_res(Filename) ->
  case file:read_file(Filename) of
    {error, Reason} ->
      % Log error here
      {ok, ""};
    {ok, Res} ->
      {ok, Res}
  end.

get_meta(Filename) ->
  case file:read_file(Filename) of
    {error, Reason} ->
      % Log error here
      {ok, <<"{
            \"URI\": \"/joe?pic=1\",
            \"Status\": 200,
            \"Request\": \"\",
            \"Content-Type\": \"image/jpeg\"
          }">>};
    {ok, Res} ->
      {ok, Res}
  end.
  
% Convert a base64 encoded binary into a filename safe binary
%  + => - (plus is a reserved character in filenames, convert to minus)
%  / => _ (slash is a reserved character in filenames, convert to underscore)
filename_safe_encode64(Bin) ->
  Bin2 = base64:encode(Bin),
  Bin3 = re:replace(binary_to_list(Bin2), "\\+", "-", [global, {return,list}]),
  re:replace(Bin3, "/", "_", [global, {return,list}]).

%%--------------------------------------------------------------------

% Hash method
hash(Data) ->
  Hash = filename_safe_encode64(crypto:hash(sha, Data)),
  {substr(Hash, 1, 2), substr(Hash, 3)}.

%%--------------------------------------------------------------------

% Given key, construct 2-part hash, directory / filename
name(Verb, URI, Req) ->
  I = binary_to_list(Verb),
  hash(list_to_binary(I ++ URI ++ Req)).

%%--------------------------------------------------------------------

% If a requested directory doesn't exist, create it
ensure_exists(Dir) ->
  ensure_exists(Dir, file:list_dir(root() ++ Dir)).
ensure_exists(_,  {ok, _}) ->
  ok;
ensure_exists(Dir, _) ->
  file:make_dir(root() ++ Dir).

%%--------------------------------------------------------------------




