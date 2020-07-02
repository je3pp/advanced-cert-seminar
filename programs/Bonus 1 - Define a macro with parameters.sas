%reset

/* First try */
%macro dealer(list,item);
   %let myCard=%scan(&list,&item);
   %let myCard=%sysfunc(propcase(&myCard));
%mend dealer;

%dealer(CLUBS,diamonds,HEARTS,spades,3)
%put &=myCard;

/* Second try */
%dealer(%nrstr(CLUBS,diamonds,HEARTS,spades),3)
%put &=myCard;

/* Final program */
%macro dealer(list,item);
   %global myCard;
   %let myCard=%scan(&list,&item);
   %let myCard=%sysfunc(propcase(&myCard));
%mend dealer;

%dealer(%nrstr(CLUBS,diamonds,HEARTS,spades),3)
%put &=myCard;