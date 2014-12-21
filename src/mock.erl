-module(mock).

%-export([store/3, store/4]).
%-export([read/2,  read/3 ]).
-compile(export_all).

-import(string, ['++'/2, substr/2, substr/3]).

-define(ROOT, "./mocks/").

% Verb, look into prop list to map between cowboy verb and needs here

% Hash method
urlsafe_encode64(Bin)           -> Bin2 = base64:encode(Bin),
                                   Bin3 = re:replace(binary_to_list(Bin2), "\\+", "-", [global, {return,list}]),
                                   re:replace(Bin3, "/", "_", [global, {return,list}]).
hash(Data)                      -> Hash = urlsafe_encode64(crypto:hash(sha, Data)),
                                   {substr(Hash, 1, 2), substr(Hash, 3)}.
 
% Given key, construct 2-part hash, directory / filename
name(Verb, URI, Req)            -> I = binary_to_list(Verb),
                                   hash(list_to_binary(I ++ URI ++ Req)).

ensure_exists(Dir)              -> ensure_exists(Dir, file:list_dir(?ROOT ++ Dir)).
ensure_exists(_,  {ok, _})      -> ok;
ensure_exists(Dir, _)           -> file:make_dir(?ROOT ++ Dir).
           

store(Verb, URI, Req, Res, Hdr) -> {Dir, File} = name(Verb, URI, Req),
                                   ensure_exists(Dir),
                              	   Filename = ?ROOT ++ Dir ++ "/" ++ File,
                                   {ok, _} = file:write_file(Filename ++ ".res", Res),
							       file:write_file(Filename ++ ".nfo", Hdr).

read(Verb, URI, Req)            -> {Dir, File} = name(Verb, URI, Req),
                                   N = ?ROOT ++ Dir ++ "/" ++ File,
                                   {ok, Res}  = file:read_file(N++".res"),
								   {ok, Meta} = file:read_file(N++".nfo"),
								   {Meta2}    = jiffy:decode(Meta),
								   {ok, Res, Meta2}.

