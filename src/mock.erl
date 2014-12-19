-module(mock).

-export([store/3, store/4]).
-export([read/2,  read/3 ]).

-import(string, ['++'/2, substr/2, substr/3]).

-define(ROOT, "./mocks/").

% Verb, look into prop list to map between cowboy verb and needs here

% Hash method
hash(Data) -> Hash = binary_to_list(base64:encode(crypto:hash(sha, Data))),
              {substr(Hash, 1, 2), substr(Hash, 3)}.
 
% Given key, construct 2-part hash, directory / filename
name(Verb, URI)      -> I = integer_to_list(Verb),
                        hash(list_to_binary(I ++ URI)).
name(Verb, URI, Req) -> I = integer_to_list(Verb),
                        hash(list_to_binary(I ++ URI ++ Req)).


ensure_exists(Dir)          -> ensure_exists(Dir, io:list_dir(?ROOT ++ Dir)).

ensure_exists(_,  {ok, _})  -> ok;
ensure_exists(Dir, _)       -> io:make_dir(?ROOT ++ Dir).
           

store({Dir, File}, Data)    -> ensure_exists(Dir),
                               io:write_file(?ROOT ++ Dir ++ "/" ++ File, Data).
store(Verb, URI, Data)      -> N = name(Verb, URI),
                               store(N, Data).    
store(Verb, URI, Req, Data) -> N = name(Verb, URI, Req),
                               store(N, Data).

read({Dir, File})     -> io:read_file(?ROOT ++ Dir ++ "/" ++ File).
read(Verb, URI)       -> N = name(Verb, URI),
                             read(N).    
read(Verb, URI, Req)  -> N = name(Verb, URI, Req),
                             read(N).

