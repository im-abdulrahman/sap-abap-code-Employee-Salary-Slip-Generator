*&---------------------------------------------------------------------*
*& Report Z_REHAN15
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_REHAN15.

SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME TITLE TITLE1.
  PARAMETERS : P_ID TYPE CHAR10.
SELECTION-SCREEN END OF BLOCK B1.

* -------- declare table --------
TABLES : ZREHAN_EMP.

* -------- FETCH DATA -----------
SELECT SINGLE *
  FROM ZREHAN_EMP
  INTO @DATA(ls_emp)
  WHERE EMP_ID = @P_ID.

* -------- PRINT IF RECORD FOUND -----
  START-OF-SELECTION.
IF sy-subrc = 0.

  DATA : C_HRA TYPE P,
         C_DA  TYPE P,
         C_PF  TYPE P,
         C_NP  TYPE P.
  C_HRA = ( ls_emp-EMP_SAL * ls_emp-EMP_HRA ) / 100.
  C_DA  = ( ls_emp-EMP_SAL * ls_emp-EMP_DA  ) / 100.
  C_PF  = ( ls_emp-EMP_SAL * ls_emp-EMP_PF  ) / 100.
  C_NP  = ls_emp-EMP_SAL + C_HRA + C_DA - C_PF.

    WRITE: / 'Employee Details:'.
    WRITE: / '-------------------------------',
           / 'Emplyee Name:' , ls_emp-EMP_NAME,
           / '-------------------------------',
           / 'Emplyee Salary (INR):   ' , ls_emp-EMP_SAL,
           / 'Salary + HRA (20%):' , C_HRA,
           / 'Salary + DA  (15%):' , C_DA,
           / 'Salary - PF  (12%):' , C_PF,
           / '-------------------------------',
           / 'Net Pay (INR):     ' , C_NP.

ENDIF.