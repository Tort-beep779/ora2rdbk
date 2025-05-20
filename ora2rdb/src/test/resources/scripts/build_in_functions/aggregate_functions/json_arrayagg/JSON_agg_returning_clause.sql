select json_arrayagg (option_r returning varchar2(50 BYTE)) from options;

select json_arrayagg (option_r returning varchar2(50 CHAR)) from options;

select json_arrayagg (option_r returning CLOB) from options;

select json_arrayagg (option_r returning BLOB) from options;