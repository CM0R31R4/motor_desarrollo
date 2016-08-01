DECLARE
    TYPE num_array IS TABLE OF NUMBER(10);
    a1 varchar2(255);
    a4 varchar2(255);
    a5 varchar2(255);
    a6 num_array; -- TABLE OF NUMBER(10);
BEGIN
    INFOMEDICA.BANSOLICFOLIOS_PKG.BANSOLICFOLIOS(a1, 99, 3, a4, a5, a6);
END;
/
