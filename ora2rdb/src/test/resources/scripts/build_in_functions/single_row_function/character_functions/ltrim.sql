SELECT LTRIM('<=====>BROWNING<=====>', '<>=') FROM DUAL;
SELECT LTRIM('<=====><=====>', '<>=') FROM DUAL;
SELECT LTRIM('  _ hello') FROM DUAL;
SELECT LTRIM('hello', '') FROM DUAL;
SELECT LTRIM('', 'hello') FROM DUAL;