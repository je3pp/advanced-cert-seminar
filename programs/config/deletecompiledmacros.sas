%macro deletecompiledmacros(Prefix,Keep);
/********************************************************************
 Created by Mark Jordan @SASJedi http://go.sas.com/jedi
 Save the macro source code file (deletemacvars.sas) in the AUTOCALL path. 
 Call the macro with !HELP as the parameter for usage and syntax
 Published 2/18/2019
 https://raw.githubusercontent.com/SASJedi/jedi-sas-tricks/master/deletecompiledmacros.sas
********************************************************************/
%local CompiledMacros ls;
%let Prefix=%qupcase(%superq(Prefix));
%let MsgType=NOTE;
%let ls=%qsysfunc(getoption(ls));
options ls=100;
%if %SUPERQ(Prefix)=? %then %do;
%Syntax:
   %put &MsgType: &SYSMACRONAME macro help document:;
   %put;
   %put &MsgType- Purpose: Deletes compiled macros from the macro catalog.;
   %put;
   %put &MsgType- Syntax: %nrstr(%%)&SYSMACRONAME(<Prefix,Keep>);
   %put;
   %put &MsgType- Prefix: The first few letters of a series of macro names.;
   %put &MsgType-         If null, deletes all compiled macros.;
   %put &MsgType-         (? or !HELP produces this syntax help in the SAS log);
   %put;
   %put &MsgType-   Keep: If not null, keeps the specified compiled macros,;
   %put &MsgType-         otherwise deletes the specified compiled macros.;
   %put;
   options ls=&ls;
   %return;
%end; 
%if %SUPERQ(Prefix)=!HELP %then %goto syntax;
%if %superq(Keep) ne %then %let Keep=%str( NOT );
proc sql noprint;
   select name 
   into :CompiledMacros SEPARATED BY " "
   from dictionary.macros
   where SCOPE="GLOBAL" 
         AND Name not LIKE ('_%')
         AND Name not LIKE 'STUDIO%'
         AND Name not LIKE 'SYS%'
         AND Name not in ('CLIENTMACHINE','GRAPHINIT','GRAPHTERM','OLDPREFS','OLDSNIPPETS','OLDTASKS','SASWORKLOCATION','USERDIR')
   %if %superq(Prefix) ne %then %do;
     AND Name %superq(keep) LIKE "%superq(Prefix)%nrstr(%%)"
   %end;
;
quit;
%if &sqlobs=0 %then %do;
   %put;
   %put NOTE: &SYSMACRONAME did not delete any macro variables because;
   %put NOTE- none met the selection criteria.;
   %put;
   %return;
%end;

%SYMDEL &CompiledMacros;

%if %superq(Prefix) ne %then %do;
   %put &MsgType: (&SYSMACRONAME) Deleted user-defined macro variables with names starting with "%superq(Prefix)";
%end;
%else %do;
   %put &MsgType: (&SYSMACRONAME) Deleted all user-created macro variables;
%end;
%put &MsgType- &CompiledMacros;

%put &MsgType: (&SYSMACRONAME) Remaining Global macro variables:;
%put _global_;
options ls=&ls;
%mend deletemacvars;
