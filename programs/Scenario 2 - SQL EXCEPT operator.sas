/*  Part 1  */
title "Customer IDs which did not respond to the campaign";
proc sql;
   select id from cert.campaign  
      except 
   select id from cert.responded
   ;
quit;


/*  Part 2  */
title "Customers who did not respond to the campaign";
proc sql;
   select ID, Name
      from cert.customers
         where ID in (select ID from cert.campaign  
                         except 
                      select id from cert.responded)
   ;
quit;
title;

/*  Bonus Question  */
title "Customers who did respond to the campaign";
proc sql;
   select ID, Name
      from cert.customers
         where ID in (select ID from cert.campaign  
                         intersect 
                      select id from cert.responded)
   ;
quit;

title;