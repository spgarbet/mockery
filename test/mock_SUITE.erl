-module(mock_SUITE).

-include_lib("common_test/include/ct.hrl").
-export([all/0]).
-export([test1/1, test2/1]).

all() -> [test1,test2].

test1(_Config) ->
  "R0VU" = mock:urlsafe_encode64(<<"GET">>).

test2(_Config) ->
  ok.
