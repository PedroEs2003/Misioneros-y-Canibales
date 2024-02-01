% Facts representing the initial state
initial_state(3, 3, left).

% Facts representing the final state
final_state(state(0, 0, right)).

% Move from left to right
make_move(missionary_left, state(ML, CL, right), state(ML2, CL, left)) :-
    MR is 3 - ML,         % Calculate remaining missionaries on the right
    MR > 0,               % Ensure there are missionaries on the right to move
    ML2 is ML + 1.        % Update the number of missionaries on the left

make_move(cannibal_left, state(ML, CL, right), state(ML, CL2, left)) :-
    CR is 3 - CL,         % Calculate remaining cannibals on the right
    CR > 0,               % Ensure there are cannibals on the right to move
    CL2 is CL + 1.        % Update the number of cannibals on the left

make_move(missionary_right, state(ML, CL, left), state(ML2, CL, right)) :-
    ML > 0,               % Ensure there are missionaries on the left to move
    ML2 is ML - 1.        % Update the number of missionaries on the right

make_move(cannibal_right, state(ML, CL, left), state(ML, CL2, right)) :-
    CL > 0,               % Ensure there are cannibals on the left to move
    CL2 is CL - 1.        % Update the number of cannibals on the right

make_move(two_missionaries_left, state(ML, CL, right), state(ML2, CL, left)) :-
    MR is 3 - ML,         % Calculate remaining missionaries on the right
    MR >= 2,              % Ensure there are at least 2 missionaries on the right
    ML2 is ML + 2.        % Update the number of missionaries on the left

make_move(two_cannibals_left, state(ML, CL, right), state(ML, CL2, left)) :-
    CR is 3 - CL,         % Calculate remaining cannibals on the right
    CR >= 2,              % Ensure there are at least 2 cannibals on the right
    CL2 is CL + 2.        % Update the number of cannibals on the left

make_move(two_missionaries_right, state(ML, CL, left), state(ML2, CL, right)) :-
    ML >= 2,              % Ensure there are at least 2 missionaries on the left
    ML2 is ML - 2.        % Update the number of missionaries on the right

make_move(two_cannibals_right, state(ML, CL, left), state(ML, CL2, right)) :-
    CL >= 2,              % Ensure there are at least 2 cannibals on the left
    CL2 is CL - 2.        % Update the number of cannibals on the right

make_move(missionary_and_cannibal_right, state(ML, CL, left), state(ML2, CL2, right)) :-
    ML > 0,               % Ensure there are missionaries on the left to move
    CL > 0,               % Ensure there are cannibals on the left to move
    ML2 is ML - 1,        % Update the number of missionaries on the right
    CL2 is CL - 1.        % Update the number of cannibals on the right

make_move(missionary_and_cannibal_left, state(ML, CL, right), state(ML2, CL2, left)) :-
    MR is 3 - ML,         % Calculate remaining missionaries on the right
    CR is 3 - CL,         % Calculate remaining cannibals on the right
    MR > 0,               % Ensure there are missionaries on the right to move
    CR > 0,               % Ensure there are cannibals on the right to move
    ML2 is ML + 1,        % Update the number of missionaries on the left
    CL2 is CL + 1.        % Update the number of cannibals on the left

% Valid state check
valid_state(M, C, _) :- M >= 0, C >= 0, M =< 3, C =< 3.

% Goal state
goal_state(state(0, 0, right)).

% Recursive depth-first search
dfs(State, [State], _) :- goal_state(State).
dfs(State, [State | Path], Visited) :-
    make_move(_, State, NewState),
    \+ member(NewState, Visited),
    dfs(NewState, Path, [State | Visited]).

% Solve using depth-first search
solve(Path) :-
    initial_state(M, C, Side),
    dfs(state(M, C, Side), Path, []).
