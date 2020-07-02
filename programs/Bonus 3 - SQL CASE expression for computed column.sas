proc sql;
   select * from cert.pets;
quit;
/*  Conditionally populate a column using SQL  */
/*    Code = 1 -> Status='Adopted'             */
/*    Code = 2 -> Status='Pending'             */
/*    Code = 3 -> Status='Available'           */

/* Flexible syntax */
proc sql;
   create table certout.AdoptionStatus as
      select *, 
         case
            when Code =1  then 'Adopted'  
            when Code =2  then 'Pending' 
            when Code =3  then 'Available' 
            else 'Bad Code' 
         end 
      as Status
         from cert.pets
   ;
quit;

/* Succinct syntax */
proc sql;
   create table certout.AdoptionStatus as
      select *, 
         case (code)
            when (1)  then 'Adopted'  
            when (2)  then 'Pending' 
            when (3)  then 'Available' 
            else 'Bad Code' 
         end 
      as Status
         from cert.pets
   ;
quit;

/* Verify the results */
proc sql;
   select ID, Pet_Name, Status
      from certout.AdoptionStatus
   ;
quit;
