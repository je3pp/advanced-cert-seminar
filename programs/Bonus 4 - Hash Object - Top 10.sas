/*  Using a Hiter Object to Find                */
/*  the Top 10 Most Profitable Customer  */
/*  on Non-Sorted Data                                */
data certout.Top10Customer;
   if 0 then
      set cert.CustomerSummary;
   if _N_=1 then
      do;
         declare hash NotSorted(dataset:'cert.CustomerSummary', ordered:'descending');
         NotSorted.definekey('OrderProfit');
         NotSorted.definedata('Customer_ID', 'OrderTotal', 'TotalCost', 'OrderProfit');
         NotSorted.definedone();
         declare hiter Sorted('NotSorted');
      end;

   do i=1 to 10;
      Sorted.next();
      output;
   end;

   stop;
   drop i;
run;

title "Our 10 Most Profitable Customers";

proc sql;
   select * from certout.Top10Customer;
quit;

title;
