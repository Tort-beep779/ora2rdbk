CREATE TRIGGER logon_trigger
    ON connect
    AS BEGIN
    RDB$TRACE_MSG('User logged into the database.',  false);
END;

-- Для BEFORE LOGOFF аналог  ON DISCONNECT

-- Для AFTER STARTUP/ BEFORE SHUTDOWN - TODO : подумать
-- Для AFTER DB_ROLE_CHANGE / AFTER SERVERERROR / AFTER SUSPEND / AFTER CLONE / BEFORE UNPLUG / [ BEFORE | AFTER ] SET CONTAINER - закомментировать