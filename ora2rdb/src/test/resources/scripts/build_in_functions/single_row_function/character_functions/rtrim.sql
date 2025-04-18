SELECT RTRIM('<=====>BROWNING<=====>', '<>=') FROM DUAL;
SELECT RTRIM('<=====><=====>', '<>=') FROM DUAL;
SELECT RTRIM('  _ hello _  ') FROM DUAL;
SELECT RTRIM('hello', '') FROM DUAL;
SELECT RTRIM('', 'hello') FROM DUAL;