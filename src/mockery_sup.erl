%%%-------------------------------------------------------------------
%% @doc mockery top level supervisor.
%% @end
%%%-------------------------------------------------------------------

-module(mockery_sup).
-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervison callbacks
-export([init/1]).

-define(SERVER, ?MODULE).

%%====================================================================
%% API functions
%%====================================================================
%%
start_link() ->
  supervisor:start_link({local, ?SERVER}, ?MODULE, []).

%%====================================================================
%% Supervisor callbacks
%%====================================================================

%% Child :: {Id,StartFunc,Restart,Shutdown,Type,Modules}
init([]) ->
  Procs = [],
  {ok, {{one_for_one, 1, 5}, Procs}}.

%%====================================================================
%% Internal functions
%%====================================================================

