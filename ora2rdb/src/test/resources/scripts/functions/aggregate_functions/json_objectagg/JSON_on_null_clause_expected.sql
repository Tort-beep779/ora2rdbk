select JSON_OBJECTAGG (KEY option_r VALUE id NULL ON NULL) from options;
select JSON_OBJECTAGG (KEY option_r VALUE id ABSENT ON NULL) from options