CREATE TYPE t_tf_row AS OBJECT (
  id           NUMBER,
  description  VARCHAR2(50)
);

CREATE TYPE t_tf_tab IS TABLE OF t_tf_row;

CREATE OR REPLACE FUNCTION get_tab_ptf (p_rows IN NUMBER) RETURN t_tf_tab
PIPELINED AS
BEGIN
  /*FOR i IN 1 .. p_rows LOOP
    PIPE ROW(t_tf_row(i, 'Description for ' || i));
  END LOOP;*/

  RETURN;
END;