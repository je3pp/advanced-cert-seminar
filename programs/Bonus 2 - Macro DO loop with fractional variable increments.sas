%reset

/* First try */
%macro doLoop;
   %local myVar;
   %let myVar=1;

   %do %while (&myvar<2);
      %let myVar=%sysevalf(&myVar+.25);
      %put &=myVar;
   %end;
%mend doLoop;

%doLoop

/* A solution of sorts */
%macro doLoop;
   %local myVar;
   %let myVar=1;
   /* We could fiddle with this value until it works. */
   /* Try some values less than 2 until it works.    */
   %do %while (&myvar<1.75);
      %let myVar=%sysevalf(&myVar+.25);
      %put &=myVar;
   %end;
%mend doLoop;

%doLoop

/* A better solution */
%macro doLoop;
   %local myVar;
   %let myVar=1;

   %do %while (&myvar<2);
      %let myVar=%sysevalf(&myVar+.25);
      %if &myVar >=2 %then
         %return;
      %put &=myVar;
   %end;
%mend doLoop;

%doLoop