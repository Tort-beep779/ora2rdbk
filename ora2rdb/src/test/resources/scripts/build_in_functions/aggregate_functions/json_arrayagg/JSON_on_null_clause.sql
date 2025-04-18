select json_arrayagg (option_r NULL ON NULL returning varchar2(50)) from options;

select json_arrayagg (option_r ABSENT ON NULL returning varchar2(50)) from options;