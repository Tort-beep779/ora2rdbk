CREATE PROCEDURE P_Cursorvar_Isopen
SQL SECURITY DEFINER
AS
  /* c1 SYS_REFCURSOR; */
  /* TYPE t_c2 IS REF CURSOR; */
  /* c2 t_c2; */
  /* DECLARE tmp INTEGER; */
 /* BEGIN */
  /* OPEN c1 FOR 'SELECT * FROM employees WHERE job_id = :j' USING 'MANAGER'; */
  /* OPEN c2 FOR SELECT * FROM test_table; */
  /* IF (:tmp is NULL) */
  /* THEN */
     /* EXCEPTION CUSTOM_EXCEPTION( 'Неправильное целочисленное значение');*/
  /* CLOSE c1; */
  /* CLOSE c2; */
  /*EXCEPTION*/
   /* WHEN ANY DO */
   /* BEGIN */
    /* IF c1%ISOPEN */
    /* THEN CLOSE c1; */
    /* END IF; */
    /* IF c2%ISOPEN */
    /* THEN CLOSE c2; */
    /* END IF; */
  /* END */
END;