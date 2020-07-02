options nomprint nosource;
%macro reset;
options nomprint nosource;
filename x "%qsysfunc(pathname(work))/reset_log.txt";
proc printto log=x;
run;
%deletemacvars(p,keep)
%if %SYSMACEXIST (dealer) %then %do;
   %sysmacdelete dealer;
%end;
%if %SYSMACEXIST(doloop) %then %do;
   %sysmacdelete doloop;
%end;
filename x "%qsysfunc(pathname(work))/buffer_heaven.txt";
proc printto;
run;
options source;
filename x;
%mend reset;

%reset
