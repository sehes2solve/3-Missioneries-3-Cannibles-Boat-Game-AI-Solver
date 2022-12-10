/*	
 *	State :
 *  [ left bank missionaries, left bank cannibals, Right bank missionaries, Right bank cannibals, boat on left -> 0 , boat on right -> 1 ]
 */

can_move_left_cannibles(s(_,_,_,Rc,Boat), Cannibals_number)       :- Rc >= Cannibals_number , Boat is 1.
can_move_left_missionaries(s(_,_,Rm,_,Boat), Missionaries_number) :- Rm >= Missionaries_number , Boat is 1.
can_move_right_cannibles(s(_,Lc,_,_,Boat), Cannibals_number)      :- Lc >= Cannibals_number , Boat is 0.
can_move_right_missionaries(s(Lm,_,_,_,Boat), Missionaries_number):- Lm >= Missionaries_number , Boat is 0.

/* move left 1 cannible  				*/
/* move left 1 missionary  				*/
/* move left 2 cannibles 				*/
/* move left 2 missionaries  			*/
/* move left 1 cannible & 1 missionary  */

move(s(Lm,Lc,Rm,Rc,Boat),s(Lm,New_Lc,Rm,New_Rc,New_boat)):- 
can_move_left_cannibles(s(Lm,Lc,Rm,Rc,Boat),1),
New_Lc is Lc + 1, New_Rc is Rc - 1, New_boat is 0.

move(s(Lm,Lc,Rm,Rc,Boat),s(New_Lm,Lc,New_Rm,Rc,New_boat)):- 
can_move_left_missionaries(s(Lm,Lc,Rm,Rc,Boat),1),
New_Lm is Lm + 1, New_Rm is Rm - 1, New_boat is 0.

move(s(Lm,Lc,Rm,Rc,Boat),s(Lm,New_Lc,Rm,New_Rc,New_boat)):- 
can_move_left_cannibles(s(Lm,Lc,Rm,Rc,Boat),2),
New_Lc is Lc + 2, New_Rc is Rc - 2, New_boat is 0.

move(s(Lm,Lc,Rm,Rc,Boat),s(New_Lm,Lc,New_Rm,Rc,New_boat)):- 
can_move_left_missionaries(s(Lm,Lc,Rm,Rc,Boat),2),
New_Lm is Lm + 2, New_Rm is Rm - 2, New_boat is 0.

move(s(Lm,Lc,Rm,Rc,Boat),s(New_Lm,New_Lc,New_Rm,New_Rc,New_boat)):- 
can_move_left_cannibles(s(Lm,Lc,Rm,Rc,Boat),1),
can_move_left_missionaries(s(Lm,Lc,Rm,Rc,Boat),1),
New_Lc is Lc + 1, New_Rc is Rc - 1,
New_Lm is Lm + 1, New_Rm is Rm - 1, New_boat is 0.

/* move right 1 cannible  				*/
/* move right 1 missionary  			*/
/* move right 2 cannibles 				*/
/* move right 2 missionaries  			*/
/* move right 1 cannible & 1 missionary */

move(s(Lm,Lc,Rm,Rc,Boat),s(Lm,New_Lc,Rm,New_Rc,New_boat)):- 
can_move_right_cannibles(s(Lm,Lc,Rm,Rc,Boat),1),
New_Lc is Lc - 1, New_Rc is Rc + 1, New_boat is 1.

move(s(Lm,Lc,Rm,Rc,Boat),s(New_Lm,Lc,New_Rm,Rc,New_boat)):- 
can_move_right_missionaries(s(Lm,Lc,Rm,Rc,Boat),1),
New_Lm is Lm - 1, New_Rm is Rm + 1, New_boat is 1.

move(s(Lm,Lc,Rm,Rc,Boat),s(Lm,New_Lc,Rm,New_Rc,New_boat)):- 
can_move_right_cannibles(s(Lm,Lc,Rm,Rc,Boat),2),
New_Lc is Lc - 2, New_Rc is Rc + 2, New_boat is 1.

move(s(Lm,Lc,Rm,Rc,Boat),s(New_Lm,Lc,New_Rm,Rc,New_boat)):- 
can_move_right_missionaries(s(Lm,Lc,Rm,Rc,Boat),2),
New_Lm is Lm - 2, New_Rm is Rm + 2, New_boat is 1.

move(s(Lm,Lc,Rm,Rc,Boat),s(New_Lm,New_Lc,New_Rm,New_Rc,New_boat)):- 
can_move_right_cannibles(s(Lm,Lc,Rm,Rc,Boat),1),
can_move_right_missionaries(s(Lm,Lc,Rm,Rc,Boat),1),
New_Lc is Lc - 1, New_Rc is Rc + 1,
New_Lm is Lm - 1, New_Rm is Rm + 1, New_boat is 1.


missionary_has_been_eaten(s(Lm,Lc,Rm,Rc,_)):-
(Lc > Lm , not(Lm is 0)) ; (Rc > Rm , not(Rm is 0)).

all_cross_river(Intial,Result):-
pass_some(Intial,[Intial],Result).

pass_some(s(3,3,0,0,_),States_path,States_path).

pass_some(State,States_path,Result):-
move(State,Next_state),
not(missionary_has_been_eaten(Next_state)),
not(member(Next_state,States_path)),
pass_some(Next_state,[Next_state|States_path],Result).
