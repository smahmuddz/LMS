declare
staff_id number;
begin
staff_id := LMS_STAFF_DETAIL_SEQ.nextval;
        insert into LMS_STAFF_DETAIL(STAFF_ID,STAFF_NAME,DESIGNATION,GENDER,DEPARTMENT,CONTACT_NUMBER)
        Values(staff_id,:P8_STAFF_NAME, :P8_DESIGNATION, :P8_GENDER, :P8_DEPARTMENT,:P8_CONTACT_NUMBER );
        commit;
        
        insert into LMS_BORROWER (BORROWER_ID,ENTITY_OWNER_FK,ENTITY_TYPE)
values(LMS_BORROWER_SEQ.nextval, staff_id, 'FACULTY');
        :P8_STAFF_NAME  := '';
        :P8_DESIGNATION := '';
        :P8_GENDER := '';
        :P8_DEPARTMENT := '';
        :P8_CONTACT_NUMBER :='';
end;