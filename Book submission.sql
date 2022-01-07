declare
B_ID number(7);
Bo_ID number(7);
FINE number(3);
B_IS_ID number(7);
begin
    
    if(:P11_BOOK_RETURN_FORM = 'FACULTY') then
                select BOOK_ID into B_ID from LMS_BOOK_ISSUE where BOOK_ISSUE_ID =  :P11_BOOK_ISSUE_ID_FAC;
                
                select BORROWER_ID into Bo_ID from LMS_BOOK_ISSUE where BOOK_ISSUE_ID = :P11_BOOK_ISSUE_ID_FAC;
                
                select 10 * (to_number(to_date (sysdate,'MM-DD-YYYY') - to_date(BORROWED_TO_DATE,'MM-DD-YYYY'))) into FINE from LMS_BOOK_ISSUE where BOOK_ISSUE_ID = :P11_BOOK_ISSUE_ID_FAC;
                :P11_DUE_FINE_FACULTY := FINE;
                insert into LMS_BOOK_RETURN(BOOK_RETURN_ID,BOOK_ID,BORROWER_ID,BOOK_ISSUE_ID,RETURN_DATE,FINE)
                values(LMS_BOOK_RETURN_SEQ.nextval, B_ID,Bo_ID,:P11_BOOK_ISSUE_ID_FAC,sysdate, FINE  );
                
                update LMS_BOOK_DETAIL set BOOK_NO_OF_COPIES_CURRENT = BOOK_NO_OF_COPIES_CURRENT+ 1 where BOOK_ID= B_ID;
                
                update LMS_BOOK_ISSUE set BOOK_RT_STATUS = 0 where BOOK_ISSUE_ID = :P11_BOOK_ISSUE_ID_FAC;
                
                
     else
                select BOOK_ID into B_ID from LMS_BOOK_ISSUE where BOOK_ISSUE_ID = :P11_BOOK_ISSUE_ID_STU;
              
                select BORROWER_ID into Bo_ID from LMS_BOOK_ISSUE where BOOK_ISSUE_ID = :P11_BOOK_ISSUE_ID_STU;
                             
                select 10 * (to_number(to_date (sysdate,'MM-DD-YYYY') - to_date(BORROWED_TO_DATE,'MM-DD-YYYY')))  into FINE from LMS_BOOK_ISSUE where BOOK_ISSUE_ID = :P11_BOOK_ISSUE_ID_STU;
                :P11_DUE_FINE_STUDENT := FINE;
                
                 insert into LMS_BOOK_RETURN(BOOK_RETURN_ID,BOOK_ID,BORROWER_ID,BOOK_ISSUE_ID,RETURN_DATE,FINE)
                values(LMS_BOOK_RETURN_SEQ.nextval, B_ID,Bo_ID,:P11_BOOK_ISSUE_ID_STU,sysdate, FINE  );
                
                update LMS_BOOK_DETAIL set BOOK_NO_OF_COPIES_CURRENT = BOOK_NO_OF_COPIES_CURRENT+ 1 where BOOK_ID= B_ID;
                
                update LMS_BOOK_ISSUE set BOOK_RT_STATUS = 0 where BOOK_ISSUE_ID = :P11_BOOK_ISSUE_ID_STU;
               
     end if;
   /* insert into LMS_BOOK_RETURN(BOOK_RETURN_ID,BOOK_ID,BORROWER_ID,BOOK_ISSUE_ID,RETURN_DATE,FINE)
    values(1,1,1,1,'1-1-2000',20);*/
end;