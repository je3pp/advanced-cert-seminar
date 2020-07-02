%reset

/* Using a DATA step
   1. Concatenate Card and Suit with ' of ' in between
   2. When row=25, write value to macro variable myCard */
data _null_;
   set cert.cards;
   where Row=25;
   call symputx('myCard',catx(' of ',Card,Suit));
run;

%put NOTE: &=myCard;

/* Delete myCard from the global symbol table */
%symdel MyCard;

/* Using PROC SQL 
   1. Concatenate Card and Suit with ' of ' in between
   2. When row=13, write value to macro variable myCard */
proc sql noprint;
   select catx(' of ',Card,Suit)
      into :myCard
      from cert.cards
      where Row=13
   ;
quit;

%put NOTE: &=myCard;

/* Delete myCard from the global symbol table */
%symdel MyCard;
