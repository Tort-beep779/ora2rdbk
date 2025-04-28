select JSON_OBJECTAGG (KEY option_r VALUE id RETURNING varchar2(50)) from options;
select JSON_OBJECTAGG (KEY option_r VALUE id RETURNING varchar2(50 char)) from options;
select JSON_OBJECTAGG (KEY option_r VALUE id RETURNING varchar2(50 byte)) from options;
select JSON_OBJECTAGG (KEY option_r VALUE id RETURNING clob) from options;
select JSON_OBJECTAGG (KEY option_r VALUE id RETURNING blob) from options;