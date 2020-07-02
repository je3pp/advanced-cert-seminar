data certout.adoption;
   if _N_=1 then
      do;
         declare hash Adopt(dataset: 'cert.pets');
         adopt.definekey('ID');
         adopt.definedata('Type','Pet_Name');
         adopt.definedone();
      end;

   set cert.Names;
   if adopt.find() =0;
run;

/*   Method 1  */
data certout.adoption;
   length ID $4. Type $1. Pet_Name $20.;
   if _N_=1 then
      do;
         declare hash Adopt(dataset: 'cert.pets');
         adopt.definekey('ID');
         adopt.definedata('Type','Pet_Name');
         adopt.definedone();
         call missing(ID, Type, Pet_Name);
      end;

   set cert.Names;
   if adopt.find() =0;
run;

title "HASH lookup - method 1";

proc sql;
   select * from certout.adoption;
quit;

/*   Method 2  */
data certout.adoption;
   if 0 then
      set cert.pets;
   if _N_=1 then
      do;
         declare hash Adopt(dataset: 'cert.pets');
         adopt.definekey('ID');
         adopt.definedata('Type','Pet_Name');
         adopt.definedone();
      end;

   set cert.Names;
   if adopt.find() =0;
run;

title "HASH lookup - method 2";

proc sql;
   select * from certout.adoption;
quit;
