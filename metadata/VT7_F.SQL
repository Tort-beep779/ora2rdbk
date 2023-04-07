--
-- Create Schema Script
--   Database Version            : 19.0.0.0.0
--   Database Compatible Level   : 19.0.0.0.0
--   Script Compatible Level     : 19.0.0.0.0
--   Toad Version                : 16.0.90.1509
--   DB Connect String           : 172.26.44.110:1521/VT7
--   Schema                      : VTAPP
--   Script Created by           : SYS
--   Script Created at           : 07/03/2023 15:36:43
--   Notes                       : 
--

-- Object Counts: 
--   Roles: 3           System Privileges: 6    Roles: 0            Grants: 28 
--   Users: 1           System Privileges: 41   Roles: 3                Grants: 141          
--   Tablespaces: 2     Datafiles: 1        Tempfiles: 1 
-- 
--   Contexts: 2 
--   Directories: 14 
--   Indexes: 4         Columns: 5          
--   Object Privileges: 4 
--   Packages: 6        Lines of Code: 2240 
--   Package Bodies: 6  Lines of Code: 6933 
--   Sequences: 1 
--   Tables: 2          Columns: 20         Constraints: 7      
--   Views: 1           Columns: 6          


-- "Set define off" turns off substitution variables.
Set define off; 

--
-- DATA_PUMP_DIR  (Directory) 
--
CREATE OR REPLACE DIRECTORY 
DATA_PUMP_DIR AS 
'C:\app\oracle\admin\vt7\dpdump/';


--
-- JAVA$JOX$CUJS$DIRECTORY$  (Directory) 
--
CREATE OR REPLACE DIRECTORY 
JAVA$JOX$CUJS$DIRECTORY$ AS 
'C:\ORACLE\JAVAVM\ADMIN\';


--
-- OPATCH_INST_DIR  (Directory) 
--
CREATE OR REPLACE DIRECTORY 
OPATCH_INST_DIR AS 
'C:\oracle\OPatch';


--
-- OPATCH_LOG_DIR  (Directory) 
--
CREATE OR REPLACE DIRECTORY 
OPATCH_LOG_DIR AS 
'C:\oracle\rdbms\log';


--
-- OPATCH_SCRIPT_DIR  (Directory) 
--
CREATE OR REPLACE DIRECTORY 
OPATCH_SCRIPT_DIR AS 
'C:\oracle\QOpatch';


--
-- ORACLECLRDIR  (Directory) 
--
CREATE OR REPLACE DIRECTORY 
ORACLECLRDIR AS 
'C:\oracle\bin\clr';


--
-- ORACLE_BASE  (Directory) 
--
CREATE OR REPLACE DIRECTORY 
ORACLE_BASE AS 
'C:\app\oracle';


--
-- ORACLE_HOME  (Directory) 
--
CREATE OR REPLACE DIRECTORY 
ORACLE_HOME AS 
'C:\oracle';


--
-- ORACLE_OCM_CONFIG_DIR  (Directory) 
--
CREATE OR REPLACE DIRECTORY 
ORACLE_OCM_CONFIG_DIR AS 
'C:\oracle\ccr\state';


--
-- ORACLE_OCM_CONFIG_DIR2  (Directory) 
--
CREATE OR REPLACE DIRECTORY 
ORACLE_OCM_CONFIG_DIR2 AS 
'C:\oracle\ccr\state';


--
-- SDO_DIR_ADMIN  (Directory) 
--
CREATE OR REPLACE DIRECTORY 
SDO_DIR_ADMIN AS 
'C:\oracle/md/admin';


--
-- SDO_DIR_WORK  (Directory) 
--
CREATE OR REPLACE DIRECTORY 
SDO_DIR_WORK AS 
'';


--
-- XMLDIR  (Directory) 
--
CREATE OR REPLACE DIRECTORY 
XMLDIR AS 
'C:\oracle\rdbms\xml';


--
-- XSDDIR  (Directory) 
--
CREATE OR REPLACE DIRECTORY 
XSDDIR AS 
'C:\oracle\rdbms\xml\schema';


--
-- TEMP  (Tablespace) 
--
CREATE TEMPORARY TABLESPACE TEMP
TEMPFILE 
  'C:\APP\ORACLE\ORADATA\VT7\TEMP01.DBF' SIZE 134M AUTOEXTEND ON NEXT 640K MAXSIZE UNLIMITED
TABLESPACE GROUP ''
EXTENT MANAGEMENT LOCAL UNIFORM SIZE 1M
FLASHBACK ON;


--
-- VTAPP_DATA  (Tablespace) 
--
CREATE TABLESPACE VTAPP_DATA
DATAFILE 
  'C:\APP\ORACLE\ORADATA\VT7\VTAPP_DATA01.DBF' SIZE 1000M AUTOEXTEND ON NEXT 100M MAXSIZE UNLIMITED
LOGGING
DEFAULT 
  NO INMEMORY
ONLINE
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;


--
-- VT_INTERNAL  (Profile) 
--
CREATE PROFILE VT_INTERNAL LIMIT
  SESSIONS_PER_USER DEFAULT
  CPU_PER_SESSION DEFAULT
  CPU_PER_CALL DEFAULT
  CONNECT_TIME DEFAULT
  IDLE_TIME DEFAULT
  LOGICAL_READS_PER_SESSION DEFAULT
  LOGICAL_READS_PER_CALL DEFAULT
  COMPOSITE_LIMIT DEFAULT
  PRIVATE_SGA DEFAULT
  FAILED_LOGIN_ATTEMPTS DEFAULT
  INACTIVE_ACCOUNT_TIME DEFAULT
  PASSWORD_LIFE_TIME UNLIMITED
  PASSWORD_REUSE_TIME DEFAULT
  PASSWORD_REUSE_MAX DEFAULT
  PASSWORD_LOCK_TIME UNLIMITED
  PASSWORD_GRACE_TIME UNLIMITED
  PASSWORD_VERIFY_FUNCTION DEFAULT;


--
-- AQ_ADMINISTRATOR_ROLE  (Role) 
--
CREATE ROLE AQ_ADMINISTRATOR_ROLE NOT IDENTIFIED;

-- Object privileges granted to AQ_ADMINISTRATOR_ROLE
GRANT SELECT ON SYS.AQ$INTERNET_USERS TO AQ_ADMINISTRATOR_ROLE;
GRANT SELECT ON SYS.AQ$_PROPAGATION_STATUS TO AQ_ADMINISTRATOR_ROLE;
GRANT SELECT ON SYS.AQ$_UNFLUSHED_DEQUEUES TO AQ_ADMINISTRATOR_ROLE;
GRANT SELECT ON SYS.DBA_AQ_AGENTS TO AQ_ADMINISTRATOR_ROLE;
GRANT SELECT ON SYS.DBA_AQ_AGENT_PRIVS TO AQ_ADMINISTRATOR_ROLE;
GRANT SELECT ON SYS.DBA_QUEUES TO AQ_ADMINISTRATOR_ROLE;
GRANT SELECT ON SYS.DBA_QUEUE_SCHEDULES TO AQ_ADMINISTRATOR_ROLE;
GRANT SELECT ON SYS.DBA_QUEUE_SUBSCRIBERS TO AQ_ADMINISTRATOR_ROLE;
GRANT SELECT ON SYS.DBA_QUEUE_TABLES TO AQ_ADMINISTRATOR_ROLE;
GRANT SELECT ON SYS.DBA_SUBSCR_REGISTRATIONS TO AQ_ADMINISTRATOR_ROLE;
GRANT EXECUTE ON SYS.DBMS_AQ TO AQ_ADMINISTRATOR_ROLE;
GRANT EXECUTE ON SYS.DBMS_AQADM TO AQ_ADMINISTRATOR_ROLE;
GRANT EXECUTE ON SYS.DBMS_AQELM TO AQ_ADMINISTRATOR_ROLE;
GRANT EXECUTE ON SYS.DBMS_AQIN TO AQ_ADMINISTRATOR_ROLE;
GRANT EXECUTE ON SYS.DBMS_AQJMS_INTERNAL TO AQ_ADMINISTRATOR_ROLE;
GRANT EXECUTE ON SYS.DBMS_AQ_IMPORT_INTERNAL TO AQ_ADMINISTRATOR_ROLE;
GRANT EXECUTE ON SYS.DBMS_RULE_EXIMP TO AQ_ADMINISTRATOR_ROLE;
GRANT EXECUTE ON SYS.DBMS_TRANSFORM TO AQ_ADMINISTRATOR_ROLE;
GRANT SELECT ON SYS.GV_$AQ TO AQ_ADMINISTRATOR_ROLE;
GRANT SELECT ON SYS.V_$AQ TO AQ_ADMINISTRATOR_ROLE;
GRANT SELECT ON WMSYS.AQ$WM$EVENT_QUEUE_TABLE TO AQ_ADMINISTRATOR_ROLE;
GRANT SELECT ON WMSYS.AQ$WM$EVENT_QUEUE_TABLE_R TO AQ_ADMINISTRATOR_ROLE;
GRANT SELECT ON WMSYS.AQ$WM$EVENT_QUEUE_TABLE_S TO AQ_ADMINISTRATOR_ROLE;

-- System privileges granted to AQ_ADMINISTRATOR_ROLE
BEGIN
SYS.DBMS_RULE_ADM.GRANT_SYSTEM_PRIVILEGE(
  PRIVILEGE    => SYS.DBMS_RULE_ADM.CREATE_EVALUATION_CONTEXT_OBJ,
  GRANTEE      => 'AQ_ADMINISTRATOR_ROLE',
  GRANT_OPTION => TRUE);
END;
/
BEGIN
SYS.DBMS_RULE_ADM.GRANT_SYSTEM_PRIVILEGE(
  PRIVILEGE    => SYS.DBMS_RULE_ADM.CREATE_RULE_OBJ,
  GRANTEE      => 'AQ_ADMINISTRATOR_ROLE',
  GRANT_OPTION => TRUE);
END;
/
BEGIN
SYS.DBMS_RULE_ADM.GRANT_SYSTEM_PRIVILEGE(
  PRIVILEGE    => SYS.DBMS_RULE_ADM.CREATE_RULE_SET_OBJ,
  GRANTEE      => 'AQ_ADMINISTRATOR_ROLE',
  GRANT_OPTION => TRUE);
END;
/
BEGIN
SYS.DBMS_AQADM.GRANT_SYSTEM_PRIVILEGE (
  PRIVILEGE    => 'DEQUEUE_ANY',
  GRANTEE      => 'AQ_ADMINISTRATOR_ROLE',
  ADMIN_OPTION => TRUE);
END;
/
BEGIN
SYS.DBMS_AQADM.GRANT_SYSTEM_PRIVILEGE (
  PRIVILEGE    => 'ENQUEUE_ANY',
  GRANTEE      => 'AQ_ADMINISTRATOR_ROLE',
  ADMIN_OPTION => TRUE);
END;
/
BEGIN
SYS.DBMS_AQADM.GRANT_SYSTEM_PRIVILEGE (
  PRIVILEGE    => 'MANAGE_ANY',
  GRANTEE      => 'AQ_ADMINISTRATOR_ROLE',
  ADMIN_OPTION => TRUE);
END;
/


--
-- AQ_USER_ROLE  (Role) 
--
CREATE ROLE AQ_USER_ROLE NOT IDENTIFIED;

-- Object privileges granted to AQ_USER_ROLE
GRANT SELECT ON SYS.AQ$_UNFLUSHED_DEQUEUES TO AQ_USER_ROLE;
GRANT EXECUTE ON SYS.DBMS_AQ TO AQ_USER_ROLE;
GRANT EXECUTE ON SYS.DBMS_AQIN TO AQ_USER_ROLE;
GRANT EXECUTE ON SYS.DBMS_AQJMS_INTERNAL TO AQ_USER_ROLE;
GRANT EXECUTE ON SYS.DBMS_TRANSFORM TO AQ_USER_ROLE;


--
-- JAVAUSERPRIV  (Role) 
--
CREATE ROLE JAVAUSERPRIV NOT IDENTIFIED;


--
-- VTAPP  (User) 
--
CREATE USER VTAPP
  IDENTIFIED BY <password>
  HTTP DIGEST DISABLE
  DEFAULT TABLESPACE VTAPP_DATA
  TEMPORARY TABLESPACE TEMP
  PROFILE VT_INTERNAL
  ACCOUNT UNLOCK;

-- 3 Roles for VTAPP 
--
-- AQ_ADMINISTRATOR_ROLE  (Role) 
--
GRANT AQ_ADMINISTRATOR_ROLE TO VTAPP WITH ADMIN OPTION;
--
-- AQ_USER_ROLE  (Role) 
--
GRANT AQ_USER_ROLE TO VTAPP WITH ADMIN OPTION;
--
-- JAVAUSERPRIV  (Role) 
--
GRANT JAVAUSERPRIV TO VTAPP;
ALTER USER VTAPP DEFAULT ROLE ALL;

-- 41 System Privileges for VTAPP 
GRANT ADMINISTER DATABASE TRIGGER TO VTAPP;
GRANT ALTER PROFILE TO VTAPP;
GRANT ALTER SESSION TO VTAPP WITH ADMIN OPTION;
GRANT ALTER SYSTEM TO VTAPP;
GRANT ALTER USER TO VTAPP;
GRANT ANALYZE ANY DICTIONARY TO VTAPP;
GRANT AUDIT SYSTEM TO VTAPP;
GRANT CREATE ANY CONTEXT TO VTAPP;
GRANT CREATE ANY DIRECTORY TO VTAPP;
GRANT CREATE ANY PROCEDURE TO VTAPP WITH ADMIN OPTION;
GRANT CREATE ANY SYNONYM TO VTAPP;
GRANT CREATE ANY VIEW TO VTAPP;
GRANT CREATE DATABASE LINK TO VTAPP;
GRANT CREATE JOB TO VTAPP;
GRANT CREATE MATERIALIZED VIEW TO VTAPP;
GRANT CREATE PROCEDURE TO VTAPP;
GRANT CREATE PROFILE TO VTAPP;
GRANT CREATE ROLE TO VTAPP;
GRANT CREATE SEQUENCE TO VTAPP;
GRANT CREATE SESSION TO VTAPP WITH ADMIN OPTION;
GRANT CREATE TABLE TO VTAPP WITH ADMIN OPTION;
GRANT CREATE TRIGGER TO VTAPP;
GRANT CREATE TYPE TO VTAPP;
GRANT CREATE USER TO VTAPP;
GRANT CREATE VIEW TO VTAPP;
GRANT DEBUG ANY PROCEDURE TO VTAPP WITH ADMIN OPTION;
GRANT DEBUG CONNECT SESSION TO VTAPP WITH ADMIN OPTION;
BEGIN
SYS.DBMS_AQADM.GRANT_SYSTEM_PRIVILEGE (
  PRIVILEGE    => 'DEQUEUE_ANY',
  GRANTEE      => 'VTAPP',
  ADMIN_OPTION => TRUE);
END;
/
GRANT DROP ANY CONTEXT TO VTAPP;
GRANT DROP ANY DIRECTORY TO VTAPP;
GRANT DROP ANY ROLE TO VTAPP;
GRANT DROP ANY TYPE TO VTAPP;
GRANT DROP PROFILE TO VTAPP;
GRANT DROP USER TO VTAPP;
BEGIN
SYS.DBMS_AQADM.GRANT_SYSTEM_PRIVILEGE (
  PRIVILEGE    => 'ENQUEUE_ANY',
  GRANTEE      => 'VTAPP',
  ADMIN_OPTION => TRUE);
END;
/
GRANT GRANT ANY ROLE TO VTAPP;
BEGIN
SYS.DBMS_AQADM.GRANT_SYSTEM_PRIVILEGE (
  PRIVILEGE    => 'MANAGE_ANY',
  GRANTEE      => 'VTAPP',
  ADMIN_OPTION => TRUE);
END;
/
GRANT MANAGE SCHEDULER TO VTAPP;
GRANT MERGE ANY VIEW TO VTAPP WITH ADMIN OPTION;
GRANT RESTRICTED SESSION TO VTAPP;
GRANT UNLIMITED TABLESPACE TO VTAPP;

-- 141 Object Privileges for VTAPP 
GRANT EXECUTE ON CTXSYS.CTX_DDL TO VTAPP;
GRANT SELECT ON CTXSYS.CTX_INDEX_ERRORS TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.ALL_ARGUMENTS TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.ALL_DB_LINKS TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.ALL_ERRORS TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.ALL_OBJECTS TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.ALL_PROCEDURES TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.ALL_SOURCE TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.ALL_TAB_COLUMNS TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.ALL_USERS TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.ALL_VIEWS TO VTAPP WITH GRANT OPTION;
GRANT EXECUTE ON SYS.AQ$_AGENT TO VTAPP WITH GRANT OPTION;
GRANT EXECUTE ON SYS.AQ$_DEQUEUE_HISTORY TO VTAPP WITH GRANT OPTION;
GRANT EXECUTE ON SYS.AQ$_DEQUEUE_HISTORY_T TO VTAPP WITH GRANT OPTION;
GRANT EXECUTE ON SYS.AQ$_HISTORY TO VTAPP WITH GRANT OPTION;
GRANT EXECUTE ON SYS.AQ$_NOTIFY_MSG TO VTAPP WITH GRANT OPTION;
GRANT EXECUTE ON SYS.AQ$_RECIPIENTS TO VTAPP WITH GRANT OPTION;
GRANT EXECUTE ON SYS.AQ$_SUBSCRIBERS TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.ARGUMENT$ TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.AUDIT_ACTIONS TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.COL$ TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.COM$ TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.DBA_2PC_PENDING TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.DBA_AUDIT_TRAIL TO VTAPP;
GRANT SELECT ON SYS.DBA_COL_COMMENTS TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.DBA_CONSTRAINTS TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.DBA_CONTEXT TO VTAPP;
GRANT SELECT ON SYS.DBA_DATA_FILES TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.DBA_DB_LINKS TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.DBA_DIRECTORIES TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.DBA_EXTENTS TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.DBA_FREE_SPACE TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.DBA_INDEXES TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.DBA_IND_COLUMNS TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.DBA_JOBS TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.DBA_JOBS_RUNNING TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.DBA_LOCK TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.DBA_MVIEWS TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.DBA_MVIEW_LOGS TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.DBA_OBJECTS TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.DBA_PENDING_TRANSACTIONS TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.DBA_PLSQL_OBJECT_SETTINGS TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.DBA_PROFILES TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.DBA_QUEUES TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.DBA_QUEUE_SUBSCRIBERS TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.DBA_ROLES TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.DBA_ROLE_PRIVS TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.DBA_SCHEDULER_JOBS TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.DBA_SCHEDULER_JOB_ARGS TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.DBA_SCHEDULER_JOB_LOG TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.DBA_SCHEDULER_JOB_RUN_DETAILS TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.DBA_SCHEDULER_RUNNING_JOBS TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.DBA_SEGMENTS TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.DBA_SYS_PRIVS TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.DBA_TABLES TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.DBA_TABLESPACES TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.DBA_TAB_COLUMNS TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.DBA_TAB_COMMENTS TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.DBA_TAB_PRIVS TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.DBA_TEMP_FILES TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.DBA_TRIGGERS TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.DBA_USERS TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.DBA_VIEWS TO VTAPP WITH GRANT OPTION;
GRANT EXECUTE ON SYS.DBMS_ALERT TO VTAPP;
GRANT EXECUTE ON SYS.DBMS_AQ TO VTAPP WITH GRANT OPTION;
GRANT EXECUTE ON SYS.DBMS_AQADM TO VTAPP WITH GRANT OPTION;
GRANT EXECUTE ON SYS.DBMS_AQIN TO VTAPP WITH GRANT OPTION;
GRANT EXECUTE ON SYS.DBMS_AQJMS TO VTAPP WITH GRANT OPTION;
GRANT EXECUTE ON SYS.DBMS_CRYPTO TO VTAPP;
GRANT EXECUTE ON SYS.DBMS_FLASHBACK TO VTAPP;
GRANT EXECUTE ON SYS.DBMS_HPROF TO VTAPP;
GRANT EXECUTE ON SYS.DBMS_LOCK TO VTAPP;
GRANT SELECT ON SYS.DBMS_LOCK_ALLOCATED TO VTAPP WITH GRANT OPTION;
GRANT EXECUTE ON SYS.DBMS_MONITOR TO VTAPP;
GRANT EXECUTE ON SYS.DBMS_PIPE TO VTAPP;
GRANT EXECUTE ON SYS.DBMS_REDEFINITION TO VTAPP;
GRANT EXECUTE ON SYS.DBMS_SYSTEM TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.FND_ALERT_LOG TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.FND_ORA_PARAMETER TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.GV_$AQ TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.GV_$INSTANCE TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.GV_$LOCK TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.GV_$LOCKED_OBJECT TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.GV_$PARAMETER2 TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.GV_$PROCESS TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.GV_$SESSION TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.GV_$SESSTAT TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.GV_$SGA TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.GV_$SGA_DYNAMIC_COMPONENTS TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.GV_$SQL TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.GV_$SQLAREA TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.GV_$SYSSTAT TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.GV_$TRANSACTION TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.JOBSEQ TO VTAPP;
GRANT SELECT ON SYS.OBJ$ TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.PENDING_TRANS$ TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.PROXY_USERS TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.SOURCE$ TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.USER$ TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.USER_ARGUMENTS TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.USER_COL_COMMENTS TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.USER_CONSTRAINTS TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.USER_CONS_COLUMNS TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.USER_DB_LINKS TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.USER_INDEXES TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.USER_IND_COLUMNS TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.USER_PROCEDURES TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.USER_SOURCE TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.USER_TAB_COLUMNS TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.USER_TRIGGERS TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.USER_VIEWS TO VTAPP WITH GRANT OPTION;
GRANT EXECUTE ON SYS.UTL_FILE TO VTAPP;
GRANT EXECUTE ON SYS.UTL_HTTP TO VTAPP;
GRANT EXECUTE ON SYS.UTL_RECOMP TO VTAPP;
GRANT EXECUTE ON SYS.UTL_SMTP TO VTAPP;
GRANT EXECUTE ON SYS.UTL_TCP TO VTAPP;
GRANT SELECT ON SYS.V_$ACCESS TO VTAPP;
GRANT SELECT ON SYS.V_$BGPROCESS TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.V_$DATABASE TO VTAPP;
GRANT SELECT ON SYS.V_$IM_SEGMENTS TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.V_$INSTANCE TO VTAPP;
GRANT SELECT ON SYS.V_$LOCK TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.V_$MYSTAT TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.V_$NLS_VALID_VALUES TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.V_$OPEN_CURSOR TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.V_$OPTION TO VTAPP;
GRANT SELECT ON SYS.V_$PARAMETER TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.V_$PGASTAT TO VTAPP;
GRANT SELECT ON SYS.V_$PROCESS TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.V_$RESERVED_WORDS TO VTAPP;
GRANT SELECT ON SYS.V_$SESSION TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.V_$SESSTAT TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.V_$SGAINFO TO VTAPP;
GRANT SELECT ON SYS.V_$SGASTAT TO VTAPP;
GRANT SELECT ON SYS.V_$SQL TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.V_$SQLTEXT_WITH_NEWLINES TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.V_$SQL_BIND_CAPTURE TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.V_$SQL_PLAN TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.V_$SQL_PLAN_STATISTICS_ALL TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.V_$STATNAME TO VTAPP WITH GRANT OPTION;
GRANT SELECT ON SYS.V_$SYSSTAT TO VTAPP;

-- 1 Java Privilege for VTAPP 
DECLARE
 KEYNUM NUMBER;
BEGIN
  SYS.DBMS_JAVA.GRANT_PERMISSION(
     grantee           => 'VTAPP'
    ,permission_type   => 'SYS:java.io.FilePermission'
    ,permission_name   => '<<ALL FILES>>'
    ,permission_action => 'read,write,delete'
    ,key               => KEYNUM
    );
END;
/

-- 1 Proxy for VTAPP 
ALTER USER VTAPP
  GRANT CONNECT THROUGH IFSSYS;


--
-- CFREPDPSTATE_CTX  (Context) 
--
CREATE OR REPLACE CONTEXT CFREPDPSTATE_CTX
 USING VTAPP.DOMAIN_SYS
 ACCESSED GLOBALLY;


--
-- DOMAIN_CTX  (Context) 
--
CREATE OR REPLACE CONTEXT DOMAIN_CTX
 USING VTAPP.DOMAIN_SYS
 ACCESSED GLOBALLY;


--
-- INSTALL_TEM_SYS_SEQ  (Sequence) 
--
CREATE SEQUENCE VTAPP.INSTALL_TEM_SYS_SEQ
  START WITH 1
  MAXVALUE 9999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER
  NOKEEP
  NOSCALE
  GLOBAL;


--
-- CF_REP_CUSTOMER_TAB  (Table) 
--
--   Row Count: 0
CREATE TABLE VTAPP.CF_REP_CUSTOMER_TAB
(
  CUSTOMER     VARCHAR2(20 CHAR)                NOT NULL,
  DESCRIPTION  VARCHAR2(2000 CHAR),
  ROWVERSION   DATE                             NOT NULL,
  ROWKEY       VARCHAR2(50 CHAR)                NOT NULL
)
TABLESPACE VTAPP_DATA
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- CF_REP_CUSTOMER_PK  (Index) 
--
--  Dependencies: 
--   CF_REP_CUSTOMER_TAB (Table)
--
CREATE UNIQUE INDEX VTAPP.CF_REP_CUSTOMER_PK ON VTAPP.CF_REP_CUSTOMER_TAB
(CUSTOMER)
TABLESPACE VTAPP_DATA
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );
--
-- CF_REP_CUSTOMER_RK  (Index) 
--
--  Dependencies: 
--   CF_REP_CUSTOMER_TAB (Table)
--
CREATE UNIQUE INDEX VTAPP.CF_REP_CUSTOMER_RK ON VTAPP.CF_REP_CUSTOMER_TAB
(ROWKEY)
TABLESPACE VTAPP_DATA
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );

ALTER TABLE VTAPP.CF_REP_CUSTOMER_TAB ADD (
  CONSTRAINT CF_REP_CUSTOMER_PK
  PRIMARY KEY
  (CUSTOMER)
  USING INDEX VTAPP.CF_REP_CUSTOMER_PK
  ENABLE VALIDATE);

ALTER TABLE VTAPP.CF_REP_CUSTOMER_TAB ADD (
  CONSTRAINT CF_REP_CUSTOMER_RK
  UNIQUE (ROWKEY)
  USING INDEX VTAPP.CF_REP_CUSTOMER_RK
  ENABLE VALIDATE);



--
-- INSTALL_TEM_SYS_TAB  (Table) 
--
--   Row Count: 0
CREATE TABLE VTAPP.INSTALL_TEM_SYS_TAB
(
  LOG_ID         NUMBER                         NOT NULL,
  ACTION         VARCHAR2(30 CHAR),
  CATEGORY       VARCHAR2(30 CHAR),
  CREATED        DATE,
  LAST_MODIFIED  DATE,
  GUID           VARCHAR2(15 CHAR),
  TEXT1          VARCHAR2(1000 CHAR),
  TEXT2          VARCHAR2(1000 CHAR),
  TEXT3          VARCHAR2(1000 CHAR),
  TEXT4          VARCHAR2(1000 CHAR),
  TEXT5          VARCHAR2(1000 CHAR),
  TEXT6          VARCHAR2(1000 CHAR),
  TEXT7          VARCHAR2(1000 CHAR),
  TEXT8          VARCHAR2(1000 CHAR),
  TEXT9          VARCHAR2(1000 CHAR),
  TEXT10         VARCHAR2(1000 CHAR)
)
TABLESPACE VTAPP_DATA
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- INSTALL_TEM_SYS_PK  (Index) 
--
--  Dependencies: 
--   INSTALL_TEM_SYS_TAB (Table)
--
CREATE UNIQUE INDEX VTAPP.INSTALL_TEM_SYS_PK ON VTAPP.INSTALL_TEM_SYS_TAB
(LOG_ID)
TABLESPACE VTAPP_INDEX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );

ALTER TABLE VTAPP.INSTALL_TEM_SYS_TAB ADD (
  CONSTRAINT INSTALL_TEM_SYS_PK
  PRIMARY KEY
  (LOG_ID)
  USING INDEX VTAPP.INSTALL_TEM_SYS_PK
  ENABLE VALIDATE);



--
-- INSTALL_TEM_SYS_IX  (Index) 
--
--  Dependencies: 
--   INSTALL_TEM_SYS_TAB (Table)
--
CREATE INDEX VTAPP.INSTALL_TEM_SYS_IX ON VTAPP.INSTALL_TEM_SYS_TAB
(GUID, ACTION)
TABLESPACE VTAPP_INDEX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );

--
-- CF_REP_CUSTOMER_API  (Package) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CF_REP_CUSTOMER_TAB (Table)
--
CREATE OR REPLACE PACKAGE VTAPP.Cf_Rep_Customer_API IS

module_                   CONSTANT VARCHAR2(6)      := 'PROJ';
lu_name_                  CONSTANT VARCHAR2(30)     := 'CfRepCustomer';
lu_type_                  CONSTANT VARCHAR2(30)     := 'Entity';

-----------------------------------------------------------------------------
-------------------- PUBLIC DECLARATIONS ------------------------------------
-----------------------------------------------------------------------------

TYPE Public_Rec IS RECORD
  (customer                       CF_REP_CUSTOMER_TAB.customer%TYPE,
   "rowid"                        rowid,
   rowversion                     CF_REP_CUSTOMER_TAB.rowversion%TYPE,
   rowkey                         CF_REP_CUSTOMER_TAB.rowkey%TYPE,
   description                    CF_REP_CUSTOMER_TAB.description%TYPE);


-----------------------------------------------------------------------------
-------------------- BASE METHODS -------------------------------------------
-----------------------------------------------------------------------------
-- Get_Key_By_Rowkey
--   Returns a table record with only keys (other attributes are NULL) based on a rowkey.
--
-- Exist
--   Checks if given pointer (e.g. primary key) to an instance of this
--   logical unit exists. If not an exception will be raised.
--
-- Exists
--   Same check as Exist, but returns a BOOLEAN value instead of exception.
--
-- Rowkey_Exist
--   Checks whether the rowkey exists
--   If not an exception will be raised.
--
-- Get_Description
--   Fetches the Description attribute for a record.
--
-- Get_By_Rowkey
--   Fetches a record containing the public attributes by rowkey inparameter.
--
-- Get
--   Fetches a record containing the public attributes.
--
-- Get_Objkey
--   Fetches the objkey attribute for a record.
--
-- Lock__
--   Client-support to lock a specific instance of the logical unit.
--
-- New__
--   Client-support interface to create LU instances.
--   action_ = 'PREPARE'
--   Default values and handle of information to client.
--   The default values are set in procedure Prepare_Insert___.
--   action_ = 'CHECK'
--   Check all attributes before creating new object and handle of
--   information to client. The attribute list is unpacked, checked
--   and prepared (defaults) in procedures Unpack___ and Check_Insert___.
--   action_ = 'DO'
--   Creation of new instances of the logical unit and handle of
--   information to client. The attribute list is unpacked, checked
--   and prepared (defaults) in procedures Unpack___ and Check_Insert___
--   before calling procedure Insert___.
--
-- Modify__
--   Client-support interface to modify attributes for LU instances.
--   action_ = 'CHECK'
--   Check all attributes before modifying an existing object and
--   handle of information to client. The attribute list is unpacked,
--   checked and prepared(defaults) in procedures Unpack___ and Check_Update___.
--   action_ = 'DO'
--   Modification of an existing instance of the logical unit. The
--   procedure unpacks the attributes, checks all values before
--   procedure Update___ is called.
--
-- Remove__
--   Client-support interface to remove LU instances.
--   action_ = 'CHECK'
--   Check whether a specific LU-instance may be removed or not.
--   The procedure fetches the complete record by calling procedure
--   Get_Object_By_Id___. Then the check is made by calling procedure
-----------------------------------------------------------------------------

--@PoReadOnly(Get_Key_By_Rowkey)
FUNCTION Get_Key_By_Rowkey (
   rowkey_ IN VARCHAR2 ) RETURN cf_rep_customer_tab%ROWTYPE;

--@PoReadOnly(Exist)
PROCEDURE Exist (
   customer_ IN VARCHAR2 );

--@PoReadOnly(Exists)
FUNCTION Exists (
   customer_ IN VARCHAR2 ) RETURN BOOLEAN;

--@PoReadOnly(Rowkey_Exist)
PROCEDURE Rowkey_Exist (
   rowkey_ IN VARCHAR2 );

--@PoReadOnly(Get_Description)
FUNCTION Get_Description (
   customer_ IN VARCHAR2 ) RETURN VARCHAR2;

--@PoReadOnly(Get_By_Rowkey)
FUNCTION Get_By_Rowkey (
   rowkey_ IN VARCHAR2 ) RETURN Public_Rec;

--@PoReadOnly(Get)
FUNCTION Get (
   customer_ IN VARCHAR2 ) RETURN Public_Rec;

--@PoReadOnly(Get_Objkey)
FUNCTION Get_Objkey (
   customer_ IN VARCHAR2 ) RETURN VARCHAR2;

--@PoReadOnly(Lock__)
PROCEDURE Lock__ (
   info_       OUT VARCHAR2,
   objid_      IN  VARCHAR2,
   objversion_ IN  VARCHAR2 );

PROCEDURE New__ (
   info_       OUT    VARCHAR2,
   objid_      OUT    VARCHAR2,
   objversion_ OUT    VARCHAR2,
   attr_       IN OUT NOCOPY VARCHAR2,
   action_     IN     VARCHAR2 );

PROCEDURE Modify__ (
   info_       OUT    VARCHAR2,
   objid_      IN     VARCHAR2,
   objversion_ IN OUT NOCOPY VARCHAR2,
   attr_       IN OUT NOCOPY VARCHAR2,
   action_     IN     VARCHAR2 );

PROCEDURE Remove__ (
   info_       OUT VARCHAR2,
   objid_      IN  VARCHAR2,
   objversion_ IN  VARCHAR2,
   action_     IN  VARCHAR2 );

-----------------------------------------------------------------------------
-------------------- FOUNDATION1 METHODS ------------------------------------
-----------------------------------------------------------------------------
-- Init
--   Framework method that initializes this package.
-----------------------------------------------------------------------------

--@PoReadOnly(Init)
PROCEDURE Init;

END Cf_Rep_Customer_API;
/


--
-- CF_REP_DP_STATE_API  (Package) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE PACKAGE VTAPP.Cf_Rep_Dp_State_API IS

module_                   CONSTANT VARCHAR2(6)      := 'PROJ';
lu_name_                  CONSTANT VARCHAR2(30)     := 'CfRepDpState';
lu_type_                  CONSTANT VARCHAR2(30)     := 'Enumeration';

-----------------------------------------------------------------------------
-------------------- PUBLIC DECLARATIONS ------------------------------------
-----------------------------------------------------------------------------

DB_READY                       CONSTANT VARCHAR2(5) := 'READY';

DB_APPROVED                    CONSTANT VARCHAR2(8) := 'APPROVED';

DB_UPDATE                      CONSTANT VARCHAR2(6) := 'UPDATE';


-----------------------------------------------------------------------------
-------------------- BASE METHODS -------------------------------------------
-----------------------------------------------------------------------------
-- Exist
--   Checks if given client value exists. If not an exception will be raised.
--
-- Exist_List
--   Checks if all items in given list of client values exists. If not an exception will be raised.
--
-- Exist_Db
--   Checks if given database value exists. If not an exception will be raised.
--
-- Exist_List_Db
--   Checks if all items in given list of database values exists. If not an exception will be raised.
--
-- Exists
--   Checks if given client value exists and returns TRUE or FALSE.
--
-- Exists_List
--   Checks if all items in given list of client values exists and returns TRUE or FALSE.
--
-- Exists_Db
--   Checks if given database value exists and returns TRUE or FALSE.
--
-- Exists_List_Db
--   Checks if all items in given list of database values exists and returns TRUE or FALSE.
--
-- Enumerate
--   Returns a list of all client values.
--
-- Enumerate_Db
--   Returns a list of all database values.
--
-- Enumerate_Client_And_Db
--   Returns a list of all client and database values.
--
-- Encode
--   Converts a client value to the corresponding database value.
--
-- Encode_List
--   Converts a list of client values to corresponding list of database values.
--
-- Decode
--   Converts a database value to the corresponding client value.
--
-- Decode_List
--   Converts a list of database values to a corresponding list of client values.
--
-- Get_Client_Value
--   Returns the client value based on its index in the full list.
--
-- Get_Db_Value
--   Returns the database value based on its index in the full list.
-----------------------------------------------------------------------------

--@PoReadOnly(Exist)
PROCEDURE Exist (
   client_value_ IN VARCHAR2 );

--@PoReadOnly(Exist_List)
PROCEDURE Exist_List (
   client_list_ IN VARCHAR2 );

--@PoReadOnly(Exist_Db)
PROCEDURE Exist_Db (
   db_value_ IN VARCHAR2 );

--@PoReadOnly(Exist_List_Db)
PROCEDURE Exist_List_Db (
   db_list_ IN VARCHAR2 );

--@PoReadOnly(Exists)
FUNCTION Exists (
   client_value_ IN VARCHAR2 ) RETURN BOOLEAN;

--@PoReadOnly(Exists_List)
FUNCTION Exists_List (
   client_list_ IN VARCHAR2 ) RETURN BOOLEAN;

--@PoReadOnly(Exists_Db)
FUNCTION Exists_Db (
   db_value_ IN VARCHAR2 ) RETURN BOOLEAN;

--@PoReadOnly(Exists_List_Db)
FUNCTION Exists_List_Db (
   db_list_ IN VARCHAR2 ) RETURN BOOLEAN;

--@PoReadOnly(Enumerate)
PROCEDURE Enumerate (
   client_values_ OUT VARCHAR2);

--@PoReadOnly(Enumerate_Db)
PROCEDURE Enumerate_Db (
   db_values_ OUT VARCHAR2);

--@PoReadOnly(Enumerate_Client_And_Db)
PROCEDURE Enumerate_Client_And_Db (
   client_values_ OUT VARCHAR2,
   db_values_     OUT VARCHAR2);

--@PoReadOnly(Encode)
FUNCTION Encode (
   client_value_ IN VARCHAR2 ) RETURN VARCHAR2;

--@PoReadOnly(Encode_List)
FUNCTION Encode_List (
   client_list_ IN VARCHAR2 ) RETURN VARCHAR2;

--@PoReadOnly(Decode)
FUNCTION Decode (
   db_value_ IN VARCHAR2 ) RETURN VARCHAR2;

--@PoReadOnly(Decode_List)
FUNCTION Decode_List (
   db_list_ IN VARCHAR2 ) RETURN VARCHAR2;

--@PoReadOnly(Get_Client_Value)
FUNCTION Get_Client_Value (
   index_ IN NUMBER ) RETURN VARCHAR2;

--@PoReadOnly(Get_Db_Value)
FUNCTION Get_Db_Value (
   index_ IN NUMBER ) RETURN VARCHAR2;

-----------------------------------------------------------------------------
-------------------- LU SPECIFIC PUBLIC METHODS -----------------------------
-----------------------------------------------------------------------------
-- Decode_Lang
-----------------------------------------------------------------------------

--@PoReadOnly(Decode_Lang)
FUNCTION Decode_Lang (
   db_value_ IN VARCHAR2,
   lang_     IN VARCHAR2 DEFAULT 'ru') RETURN VARCHAR2;

-----------------------------------------------------------------------------
-------------------- FOUNDATION1 METHODS ------------------------------------
-----------------------------------------------------------------------------
-- Language_Refreshed
--   Framework method that updates translations to a new language.
--
-- Init
--   Framework method that initializes this package.
-----------------------------------------------------------------------------

--@PoReadOnly(Language_Refreshed)
PROCEDURE Language_Refreshed;

--@PoReadOnly(Init)
PROCEDURE Init;

END Cf_Rep_Dp_State_API;
/


--
-- CLIENT_SYS  (Package) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE PACKAGE VTAPP.CLIENT_SYS IS

module_                   CONSTANT VARCHAR2(6)      := 'FNDBAS';
service_                  CONSTANT VARCHAR2(30)     := 'Client';
lu_name_                  CONSTANT VARCHAR2(30)     := 'Client';
lu_type_                  CONSTANT VARCHAR2(30)     := 'SystemService';

-----------------------------------------------------------------------------
-------------------- PUBLIC DECLARATIONS ------------------------------------
-----------------------------------------------------------------------------

text_separator_     CONSTANT VARCHAR2(1)  := '^';

field_separator_    CONSTANT VARCHAR2(1)  := chr(31);

record_separator_   CONSTANT VARCHAR2(1)  := chr(30);

group_separator_    CONSTANT VARCHAR2(1)  := chr(29);

file_separator_     CONSTANT VARCHAR2(1)  := chr(28);

date_format_        CONSTANT VARCHAR2(30) := 'YYYY-MM-DD-HH24.MI.SS';

timestamp_format_   CONSTANT VARCHAR2(30) := 'YYYY-MM-DD-HH24.MI.SS.FF9';

trunc_date_format_  CONSTANT VARCHAR2(30) := 'YYYY-MM-DD';


-----------------------------------------------------------------------------
-------------------- LU SPECIFIC PUBLIC METHODS -----------------------------
-----------------------------------------------------------------------------
-- Clear_Attr
--   Clears a given attribute record (e.g. nullifies it).
--   Must be called before any calls to Add_To_Attr function.
--
-- Add_To_Attr
--   Adds an attribute name and value at the end of a given
--   attribute record.
--   Adds an attribute name and value at the end of a given
--   attribute record.
--   Adds an attribute name and value at the end of a given
--   attribute record.
--   Adds an attribute name and value at the end of a given
--   attribute record.
--
-- Add_To_Attr
--   Adds an attribute name and value at the end of a given
--   attribute record.
--   Adds an attribute name and value at the end of a given
--   attribute record.
--   Adds an attribute name and value at the end of a given
--   attribute record.
--   Adds an attribute name and value at the end of a given
--   attribute record.
--
-- Add_To_Attr
--   Adds an attribute name and value at the end of a given
--   attribute record.
--   Adds an attribute name and value at the end of a given
--   attribute record.
--   Adds an attribute name and value at the end of a given
--   attribute record.
--   Adds an attribute name and value at the end of a given
--   attribute record.
--
-- Add_To_Attr
--   Adds an attribute name and value at the end of a given
--   attribute record.
--   Adds an attribute name and value at the end of a given
--   attribute record.
--   Adds an attribute name and value at the end of a given
--   attribute record.
--   Adds an attribute name and value at the end of a given
--   attribute record.
--
-- Add_To_Attr_If_Not_Null
--   Adds an attribute name and value at the end of a given
--   attribute record if value is not null.
--   Adds an attribute name and value at the end of a given
--   attribute record if value is not null.
--   Adds an attribute name and value at the end of a given
--   attribute record if value is not null.
--   Adds an attribute name and value at the end of a given
--   attribute record if value is not null.
--
-- Add_To_Attr_If_Not_Null
--   Adds an attribute name and value at the end of a given
--   attribute record if value is not null.
--   Adds an attribute name and value at the end of a given
--   attribute record if value is not null.
--   Adds an attribute name and value at the end of a given
--   attribute record if value is not null.
--   Adds an attribute name and value at the end of a given
--   attribute record if value is not null.
--
-- Add_To_Attr_If_Not_Null
--   Adds an attribute name and value at the end of a given
--   attribute record if value is not null.
--   Adds an attribute name and value at the end of a given
--   attribute record if value is not null.
--   Adds an attribute name and value at the end of a given
--   attribute record if value is not null.
--   Adds an attribute name and value at the end of a given
--   attribute record if value is not null.
--
-- Add_To_Attr_If_Not_Null
--   Adds an attribute name and value at the end of a given
--   attribute record if value is not null.
--   Adds an attribute name and value at the end of a given
--   attribute record if value is not null.
--   Adds an attribute name and value at the end of a given
--   attribute record if value is not null.
--   Adds an attribute name and value at the end of a given
--   attribute record if value is not null.
--
-- Remove_Attr
--
-- Set_Item_Value
--   Set the attribute value for a specific attribute name.
--   If a value already exist, it will be replaced.
--   Set the attribute value for a specific attribute name.
--   If a value already exist, it will be replaced.
--   Set the attribute value for a specific attribute name.
--   If a value already exist, it will be replaced.
--
-- Set_Item_Value
--   Set the attribute value for a specific attribute name.
--   If a value already exist, it will be replaced.
--   Set the attribute value for a specific attribute name.
--   If a value already exist, it will be replaced.
--   Set the attribute value for a specific attribute name.
--   If a value already exist, it will be replaced.
--
-- Set_Item_Value
--   Set the attribute value for a specific attribute name.
--   If a value already exist, it will be replaced.
--   Set the attribute value for a specific attribute name.
--   If a value already exist, it will be replaced.
--   Set the attribute value for a specific attribute name.
--   If a value already exist, it will be replaced.
--
-- Get_Next_From_Attr
--   Fetches the next attribute name and value value from given attribute
--   record. NOTE! Value is always of type VARCHAR2.
--
-- Attr_Value_To_Date
--   Converts a VARCHAR2 value to a DATE value according to client
--   protocol rules.
--   Converts a VARCHAR2 value to a TIMESTAMP value according to client
--   protocol rules.
--
-- Attr_Value_To_Timestamp
--
-- Attr_Value_To_Number
--   Converts a VARCHAR2 value to a NUMBER value according to client
--   protocol rules.
--
-- Attr_Value_To_Integer
--   Converts a VARCHAR2 value to an INTEGER value according to client
--   protocol rules.
--
-- Cut_Item_Value
--
-- Get_Item_Value
--
-- Get_Item_Value_To_Date
--
-- Get_Item_Value_To_Timestamp
--
-- Get_Item_Value_To_Number
--
-- Item_Exist
--
-- Attr_To_Dbms_Output
--   Copies attrtibute string contents to DBMS_OUTPUT.PUT_LINE calls
--   so that contents can be investigated for debug purposes.
--
-- Clear_List
--   Clears a given attribute record (e.g. nullifies it).
--   Must be called before any calls to Add_To_Attr function.
--
-- Add_To_List
--   Adds a value at the end of a given list.
--   Adds a value at the end of a given list.
--   Adds a value at the end of a given list.
--   Adds a value at the end of a given list.
--
-- Add_To_List
--   Adds a value at the end of a given list.
--   Adds a value at the end of a given list.
--   Adds a value at the end of a given list.
--   Adds a value at the end of a given list.
--
-- Add_To_List
--   Adds a value at the end of a given list.
--   Adds a value at the end of a given list.
--   Adds a value at the end of a given list.
--   Adds a value at the end of a given list.
--
-- Add_To_List
--   Adds a value at the end of a given list.
--   Adds a value at the end of a given list.
--   Adds a value at the end of a given list.
--   Adds a value at the end of a given list.
--
-- Get_Next_From_List
--   Fetches the next value from the given list.
--   NOTE! Value is always of type VARCHAR2.
--
-- Get_Next_From_Selection
--   Fetches the next key reference from the given selection.
--   NOTE! Use Get_Key_Reference_Value for retrieving the value for a specific key from the given key reference.
--
-- Get_Key_Reference
--   Return a formatted "Key Reference" string.
--   Return a formatted "Key Reference" string.
--
-- Get_Key_Reference
--   Return a formatted "Key Reference" string.
--   Return a formatted "Key Reference" string.
--
-- Convert_Key_Ref_To_Tab_Keys
--   Convert the Key Reference which is based on the view to a Key Ref based on the table columns.
--
-- Get_New_Key_Reference
--   Return a newly formatted "Key Reference" string based on the old string.
--   The old string need to point to the new column names, if columns have been renamed
--
-- Get_Table_Key_Reference
--
-- Get_Key_Reference_From_Objkey
--
-- Get_Objkey_From_Key_Ref
--
-- Get_Rowkey_From_Key_Ref
--
-- Add_To_Key_Reference
--   Adds a key column with value to the key reference list.
--   Adds a key column with value to the key reference list.
--   Adds a key column with value to the key reference list.
--   Adds a key column with value to the key reference list.
--
-- Add_To_Key_Reference
--   Adds a key column with value to the key reference list.
--   Adds a key column with value to the key reference list.
--   Adds a key column with value to the key reference list.
--   Adds a key column with value to the key reference list.
--
-- Add_To_Key_Reference
--   Adds a key column with value to the key reference list.
--   Adds a key column with value to the key reference list.
--   Adds a key column with value to the key reference list.
--   Adds a key column with value to the key reference list.
--
-- Add_To_Key_Reference
--   Adds a key column with value to the key reference list.
--   Adds a key column with value to the key reference list.
--   Adds a key column with value to the key reference list.
--   Adds a key column with value to the key reference list.
--
-- Get_Key_Reference_Value
--   Retrieves the key reference value for a specific name or index.
--   Retrieves the key reference value for a specific name or index.
--
-- Get_Key_Reference_Value
--   Retrieves the key reference value for a specific name or index.
--   Retrieves the key reference value for a specific name or index.
--
-- Clear_Info
--   Clears all stacked info and warning messages
--
-- Add_Info
--   Adds an info message to the stack.
--
-- Add_Warning
--   Adds a warning message to the stack.
--
-- Get_All_Info
--   Fetches all stacked info and warning messages for delivery to client.
--   Fetches all stacked info and warning messages for delivery to client.
--
-- Get_All_Info
--   Fetches all stacked info and warning messages for delivery to client.
--   Fetches all stacked info and warning messages for delivery to client.
--
-- Get_Trace
--
-- Get_Separator_Info
--   Returns information about the different separators used for
--   structure packing routines. The method is meant to be used from
--   client the environment. Globals are available for the server.
--
-- Append_Info
--
-- Merge_Info
--
-- Sleep
-----------------------------------------------------------------------------

--@PoReadOnly(Clear_Attr)
PROCEDURE Clear_Attr (
   attr_ OUT VARCHAR2 );

--@PoReadOnly(Add_To_Attr)
PROCEDURE Add_To_Attr (
   name_  IN     VARCHAR2,
   value_ IN     VARCHAR2,
   attr_  IN OUT NOCOPY VARCHAR2 );

--@PoReadOnly(Add_To_Attr)
PROCEDURE Add_To_Attr (
   name_  IN     VARCHAR2,
   value_ IN     NUMBER,
   attr_  IN OUT NOCOPY VARCHAR2 );

--@PoReadOnly(Add_To_Attr)
PROCEDURE Add_To_Attr(
   name_  IN     VARCHAR2,
   value_ IN     DATE,
   attr_  IN OUT NOCOPY VARCHAR2 );

--@PoReadOnly(Add_To_Attr)
PROCEDURE Add_To_Attr(
   name_  IN     VARCHAR2,
   value_ IN     TIMESTAMP,
   attr_  IN OUT NOCOPY VARCHAR2 );

--@PoReadOnly(Add_To_Attr_If_Not_Null)
PROCEDURE Add_To_Attr_If_Not_Null (
   name_  IN     VARCHAR2,
   value_ IN     VARCHAR2,
   attr_  IN OUT NOCOPY VARCHAR2 );

--@PoReadOnly(Add_To_Attr_If_Not_Null)
PROCEDURE Add_To_Attr_If_Not_Null (
   name_  IN     VARCHAR2,
   value_ IN     NUMBER,
   attr_  IN OUT NOCOPY VARCHAR2 );

--@PoReadOnly(Add_To_Attr_If_Not_Null)
PROCEDURE Add_To_Attr_If_Not_Null(
   name_  IN     VARCHAR2,
   value_ IN     DATE,
   attr_  IN OUT NOCOPY VARCHAR2 );

--@PoReadOnly(Add_To_Attr_If_Not_Null)
PROCEDURE Add_To_Attr_If_Not_Null(
   name_  IN     VARCHAR2,
   value_ IN     TIMESTAMP,
   attr_  IN OUT NOCOPY VARCHAR2 );

--@PoReadOnly(Remove_Attr)
FUNCTION Remove_Attr (
   name_ IN VARCHAR2,
   attr_ IN VARCHAR2 ) RETURN VARCHAR2;

--@PoReadOnly(Set_Item_Value)
PROCEDURE Set_Item_Value (
   name_  IN     VARCHAR2,
   value_ IN     VARCHAR2,
   attr_  IN OUT NOCOPY VARCHAR2 );

--@PoReadOnly(Set_Item_Value)
PROCEDURE Set_Item_Value (
   name_  IN     VARCHAR2,
   value_ IN     NUMBER,
   attr_  IN OUT NOCOPY VARCHAR2 );

--@PoReadOnly(Set_Item_Value)
PROCEDURE Set_Item_Value (
   name_  IN     VARCHAR2,
   value_ IN     DATE,
   attr_  IN OUT NOCOPY VARCHAR2 );

--@PoReadOnly(Get_Next_From_Attr)
FUNCTION Get_Next_From_Attr (
   attr_  IN     VARCHAR2,
   ptr_   IN OUT NOCOPY NUMBER,
   name_  IN OUT NOCOPY VARCHAR2,
   value_ IN OUT NOCOPY VARCHAR2 ) RETURN BOOLEAN;

--@PoReadOnly(Attr_Value_To_Date)
FUNCTION Attr_Value_To_Date (
   value_ IN VARCHAR2,
   raise_value_error_ BOOLEAN DEFAULT TRUE ) RETURN DATE;

--@PoReadOnly(Attr_Value_To_Timestamp)
FUNCTION Attr_Value_To_Timestamp (
   value_ IN VARCHAR2,
   raise_value_error_ BOOLEAN DEFAULT TRUE ) RETURN TIMESTAMP;

--@PoReadOnly(Attr_Value_To_Number)
FUNCTION Attr_Value_To_Number (
   value_ IN VARCHAR2 ) RETURN NUMBER;

--@PoReadOnly(Attr_Value_To_Integer)
FUNCTION Attr_Value_To_Integer (
   value_ IN VARCHAR2 ) RETURN INTEGER;

--@PoReadOnly(Cut_Item_Value)
FUNCTION Cut_Item_Value (
   name_ IN     VARCHAR2,
   attr_ IN OUT NOCOPY VARCHAR2 ) RETURN VARCHAR2;

--@PoReadOnly(Get_Item_Value)
FUNCTION Get_Item_Value (
   name_ IN VARCHAR2,
   attr_ IN VARCHAR2 ) RETURN VARCHAR2;

--@PoReadOnly(Get_Item_Value_To_Date)
FUNCTION Get_Item_Value_To_Date (
   name_      IN VARCHAR2,
   attr_      IN VARCHAR2,
   lu_name_   IN VARCHAR2,
   method_    IN VARCHAR2 DEFAULT NULL) RETURN DATE;

--@PoReadOnly(Get_Item_Value_To_Timestamp)
FUNCTION Get_Item_Value_To_Timestamp (
   name_      IN VARCHAR2,
   attr_      IN VARCHAR2,
   lu_name_   IN VARCHAR2,
   method_    IN VARCHAR2 DEFAULT NULL) RETURN TIMESTAMP;

--@PoReadOnly(Get_Item_Value_To_Number)
FUNCTION Get_Item_Value_To_Number (
   name_      IN VARCHAR2,
   attr_      IN VARCHAR2,
   lu_name_   IN VARCHAR2,
   method_    IN VARCHAR2 DEFAULT NULL) RETURN NUMBER;

--@PoReadOnly(Item_Exist)
FUNCTION Item_Exist (
   name_ IN VARCHAR2,
   attr_ IN VARCHAR2 ) RETURN BOOLEAN;

--@PoReadOnly(Attr_To_Dbms_Output)
PROCEDURE Attr_To_Dbms_Output (
   attr_ IN VARCHAR2 );

--@PoReadOnly(Clear_List)
PROCEDURE Clear_List (
   list_ OUT VARCHAR2 );

--@PoReadOnly(Add_To_List)
PROCEDURE Add_To_List (
   value_ IN     VARCHAR2,
   list_  IN OUT NOCOPY VARCHAR2 );

--@PoReadOnly(Add_To_List)
PROCEDURE Add_To_List (
   value_ IN     NUMBER,
   list_  IN OUT NOCOPY VARCHAR2 );

--@PoReadOnly(Add_To_List)
PROCEDURE Add_To_List(
   value_ IN     DATE,
   list_  IN OUT NOCOPY VARCHAR2 );

--@PoReadOnly(Add_To_List)
PROCEDURE Add_To_List(
   value_ IN     TIMESTAMP,
   list_  IN OUT NOCOPY VARCHAR2 );

--@PoReadOnly(Get_Next_From_List)
FUNCTION Get_Next_From_List (
   list_  IN     VARCHAR2,
   ptr_   IN OUT NOCOPY NUMBER,
   value_ IN OUT NOCOPY VARCHAR2 ) RETURN BOOLEAN;

--@PoReadOnly(Get_Next_From_Selection)
FUNCTION Get_Next_From_Selection (
   selection_ IN     VARCHAR2,
   ptr_       IN OUT NOCOPY NUMBER,
   key_ref_   IN OUT NOCOPY VARCHAR2 ) RETURN BOOLEAN;

--@PoReadOnly(Get_Key_Reference)
PROCEDURE Get_Key_Reference (
   key_ref_ OUT VARCHAR2,
   lu_name_ IN VARCHAR2,
   objid_ IN VARCHAR2 DEFAULT NULL );

--@PoReadOnly(Get_Key_Reference)
FUNCTION Get_Key_Reference (
   lu_name_ IN VARCHAR2,
   key1_    IN VARCHAR2,
   value1_  IN VARCHAR2,
   key2_    IN VARCHAR2 DEFAULT NULL,
   value2_  IN VARCHAR2 DEFAULT NULL,
   key3_    IN VARCHAR2 DEFAULT NULL,
   value3_  IN VARCHAR2 DEFAULT NULL,
   key4_    IN VARCHAR2 DEFAULT NULL,
   value4_  IN VARCHAR2 DEFAULT NULL,
   key5_    IN VARCHAR2 DEFAULT NULL,
   value5_  IN VARCHAR2 DEFAULT NULL,
   key6_    IN VARCHAR2 DEFAULT NULL,
   value6_  IN VARCHAR2 DEFAULT NULL,
   key7_    IN VARCHAR2 DEFAULT NULL,
   value7_  IN VARCHAR2 DEFAULT NULL,
   key8_    IN VARCHAR2 DEFAULT NULL,
   value8_  IN VARCHAR2 DEFAULT NULL,
   key9_    IN VARCHAR2 DEFAULT NULL,
   value9_  IN VARCHAR2 DEFAULT NULL,
   key10_   IN VARCHAR2 DEFAULT NULL,
   value10_ IN VARCHAR2 DEFAULT NULL,
   key11_   IN VARCHAR2 DEFAULT NULL,
   value11_ IN VARCHAR2 DEFAULT NULL,
   key12_   IN VARCHAR2 DEFAULT NULL,
   value12_ IN VARCHAR2 DEFAULT NULL,
   key13_   IN VARCHAR2 DEFAULT NULL,
   value13_ IN VARCHAR2 DEFAULT NULL,
   key14_   IN VARCHAR2 DEFAULT NULL,
   value14_ IN VARCHAR2 DEFAULT NULL,
   key15_   IN VARCHAR2 DEFAULT NULL,
   value15_ IN VARCHAR2 DEFAULT NULL ) RETURN VARCHAR2;

--@PoReadOnly(Convert_Key_Ref_To_Tab_Keys)
FUNCTION Convert_Key_Ref_To_Tab_Keys (
   lu_name_ IN VARCHAR2,
   key_ref_ IN VARCHAR2) RETURN VARCHAR2;

--@PoReadOnly(Get_New_Key_Reference)
FUNCTION Get_New_Key_Reference (
   lu_name_     IN VARCHAR2,
   old_key_ref_ IN VARCHAR2,
   use_binary_ai_sort_        IN BOOLEAN DEFAULT FALSE,
   for_enum_use_table_column_ IN BOOLEAN DEFAULT FALSE) RETURN VARCHAR2;

--@PoReadOnly(Get_Table_Key_Reference)
PROCEDURE Get_Table_Key_Reference (
   key_ref_ OUT VARCHAR2,
   lu_name_ IN VARCHAR2 );

--@PoReadOnly(Get_Key_Reference_From_Objkey)
FUNCTION Get_Key_Reference_From_Objkey (
   lu_name_ IN VARCHAR2,
   objkey_  IN VARCHAR2 DEFAULT NULL ) RETURN VARCHAR2;

FUNCTION Get_Objkey_From_Key_Ref (
   lu_name_   IN VARCHAR2,
   key_ref_   IN VARCHAR2,
   view_name_ IN VARCHAR2 DEFAULT NULL) RETURN VARCHAR2;

FUNCTION Get_Rowkey_From_Key_Ref (
   lu_name_   IN VARCHAR2,
   key_ref_   IN VARCHAR2) RETURN VARCHAR2;

--@PoReadOnly(Add_To_Key_Reference)
PROCEDURE Add_To_Key_Reference (
   key_ref_ IN OUT NOCOPY VARCHAR2,
   name_    IN     VARCHAR2,
   value_   IN     VARCHAR2 );

--@PoReadOnly(Add_To_Key_Reference)
PROCEDURE Add_To_Key_Reference (
   key_ref_ IN OUT NOCOPY VARCHAR2,
   name_    IN     VARCHAR2,
   value_   IN     NUMBER );

--@PoReadOnly(Add_To_Key_Reference)
PROCEDURE Add_To_Key_Reference (
   key_ref_ IN OUT NOCOPY VARCHAR2,
   name_    IN     VARCHAR2,
   value_   IN     DATE );

--@PoReadOnly(Add_To_Key_Reference)
PROCEDURE Add_To_Key_Reference (
   key_ref_ IN OUT NOCOPY VARCHAR2,
   name_    IN     VARCHAR2,
   value_   IN     TIMESTAMP );

--@PoReadOnly(Get_Key_Reference_Value)
FUNCTION Get_Key_Reference_Value (
   key_ref_ IN VARCHAR2,
   name_    IN VARCHAR2 ) RETURN VARCHAR2;

--@PoReadOnly(Get_Key_Reference_Value)
FUNCTION Get_Key_Reference_Value (
   key_ref_ IN VARCHAR2,
   index_   IN NUMBER ) RETURN VARCHAR2;

--@PoReadOnly(Clear_Info)
PROCEDURE Clear_Info;

--@PoReadOnly(Add_Info)
PROCEDURE Add_Info (
   lu_name_ IN VARCHAR2,
   text_    IN VARCHAR2,
   p1_      IN VARCHAR2 DEFAULT NULL,
   p2_      IN VARCHAR2 DEFAULT NULL,
   p3_      IN VARCHAR2 DEFAULT NULL );

--@PoReadOnly(Add_Warning)
PROCEDURE Add_Warning (
   lu_name_ IN VARCHAR2,
   text_    IN VARCHAR2,
   p1_      IN VARCHAR2 DEFAULT NULL,
   p2_      IN VARCHAR2 DEFAULT NULL,
   p3_      IN VARCHAR2 DEFAULT NULL );

--@PoReadOnly(Get_All_Info)
FUNCTION Get_All_Info (
   max_length_  IN NUMBER ) RETURN VARCHAR2;

--@PoReadOnly(Get_All_Info)
FUNCTION Get_All_Info RETURN VARCHAR2;

--@PoReadOnly(Get_Trace)
PROCEDURE Get_Trace(
   text_ IN OUT NOCOPY CLOB );

--@PoReadOnly(Get_Separator_Info)
PROCEDURE Get_Separator_Info (
   text_sep_   OUT VARCHAR2,
   field_sep_  OUT VARCHAR2,
   record_sep_ OUT VARCHAR2,
   group_sep_  OUT VARCHAR2,
   file_sep_   OUT VARCHAR2 );

--@PoReadOnly(Append_Info)
FUNCTION Append_Info (
   previous_info_ IN VARCHAR2 ) RETURN VARCHAR2;

--@PoReadOnly(Merge_Info)
PROCEDURE Merge_Info (
   previous_info_ IN VARCHAR2 );

--@PoReadOnly(Sleep)
FUNCTION Sleep (
   seconds_ IN VARCHAR2 ) RETURN NUMBER;

-----------------------------------------------------------------------------
-------------------- LU SPECIFIC PRIVATE METHODS ----------------------------
-----------------------------------------------------------------------------
-- Get_System_Info__
-----------------------------------------------------------------------------

FUNCTION Get_System_Info__ RETURN CLOB;

-----------------------------------------------------------------------------
-------------------- FOUNDATION1 METHODS ------------------------------------
-----------------------------------------------------------------------------
-- Init
--   Framework method that initializes this package.
-----------------------------------------------------------------------------

--@PoReadOnly(Init)
PROCEDURE Init;

END CLIENT_SYS;
/


--
-- DOMAIN_SYS  (Package) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE PACKAGE VTAPP.DOMAIN_SYS IS

module_                   CONSTANT VARCHAR2(6)      := 'FNDBAS';
service_                  CONSTANT VARCHAR2(30)     := 'Domain';
lu_name_                  CONSTANT VARCHAR2(30)     := 'Domain';
lu_type_                  CONSTANT VARCHAR2(30)     := 'SystemService';

-----------------------------------------------------------------------------
-------------------- PUBLIC DECLARATIONS ------------------------------------
-----------------------------------------------------------------------------


-----------------------------------------------------------------------------
-------------------- LU SPECIFIC PUBLIC METHODS -----------------------------
-----------------------------------------------------------------------------
-- Get_Db_Values
--
-- Get_Prog_Values
--
-- Get_Translated_Values
--
-- Debug
--
-- Get
--
-- Load_Iid
--
-- Load_State
--
-- Get_Json
-----------------------------------------------------------------------------

--@PoReadOnly(Get_Db_Values)
FUNCTION Get_Db_Values (
   domain_ IN VARCHAR2 ) RETURN VARCHAR2;

--@PoReadOnly(Get_Prog_Values)
FUNCTION Get_Prog_Values (
   domain_ IN VARCHAR2 ) RETURN VARCHAR2;

--@PoReadOnly(Get_Translated_Values)
FUNCTION Get_Translated_Values (
   domain_ IN VARCHAR2,
   lang_code_ IN VARCHAR2 DEFAULT 'ru') RETURN VARCHAR2;

--@PoReadOnly(Debug)
PROCEDURE Debug (
   domain_ IN VARCHAR2 );

--@PoReadOnly(Get)
FUNCTION Get (
   domain_ IN VARCHAR2 ) RETURN VARCHAR2;

--@PoReadOnly(Load_Iid)
PROCEDURE Load_Iid (
   domain_ IN VARCHAR2,
   client_value_list_ IN VARCHAR2,
   db_value_list_ IN VARCHAR2 );

--@PoReadOnly(Load_State)
PROCEDURE Load_State (
   domain_ IN VARCHAR2,
   client_value_list_ IN VARCHAR2,
   db_value_list_ IN VARCHAR2 );


-----------------------------------------------------------------------------
-------------------- LU SPECIFIC PROTECTED METHODS --------------------------
-----------------------------------------------------------------------------
-- Exist_
--
-- Exist_
--
-- Exist_List_
--
-- Exist_List_
--
-- Exist_List_Db_
--
-- Exist_List_Db_
--
-- Enumerate_
--
-- Encode_
--
-- Encode_List_
--
-- Decode_
--
-- Decode_List_
--
-- Decode_Subset_
--
-- Get_Db_Value_
--
-- Get_Client_Value_
--
-- Get_Nls_Client_List_
--
-- Refresh_Language_
--
-- Refresh_Language_
--
-- Refresh_Component_Language_
-----------------------------------------------------------------------------

--@PoReadOnly(Exist_)
PROCEDURE Exist_ (
   lu_name_      IN VARCHAR2,
   client_list_  IN VARCHAR2,
   client_value_ IN VARCHAR2 );

--@PoReadOnly(Exist_)
FUNCTION Exist_ (
   lu_name_      IN VARCHAR2,
   client_list_  IN VARCHAR2,
   client_value_ IN VARCHAR2 ) RETURN BOOLEAN;

--@PoReadOnly(Exist_List_)
PROCEDURE Exist_List_ (
   lu_name_      IN VARCHAR2,
   client_list_  IN VARCHAR2,
   client_value_ IN VARCHAR2 );

--@PoReadOnly(Exist_List_)
FUNCTION Exist_List_ (
   lu_name_      IN VARCHAR2,
   client_list_  IN VARCHAR2,
   client_value_ IN VARCHAR2 ) RETURN BOOLEAN;

--@PoReadOnly(Exist_List_Db_)
PROCEDURE Exist_List_Db_ (
   lu_name_      IN VARCHAR2,
   client_list_  IN VARCHAR2,
   client_value_ IN VARCHAR2 );

--@PoReadOnly(Exist_List_Db_)
FUNCTION Exist_List_Db_ (
   lu_name_      IN VARCHAR2,
   client_list_  IN VARCHAR2,
   client_value_ IN VARCHAR2 ) RETURN BOOLEAN;

--@PoReadOnly(Enumerate_)
FUNCTION Enumerate_ (
   client_list_ IN VARCHAR2 ) RETURN VARCHAR2;

--@PoReadOnly(Encode_)
FUNCTION Encode_ (
   client_list_  IN VARCHAR2,
   db_list_      IN VARCHAR2,
   client_value_ IN VARCHAR2 ) RETURN VARCHAR2;

--@PoReadOnly(Encode_List_)
FUNCTION Encode_List_ (
   client_list_  IN VARCHAR2,
   db_list_      IN VARCHAR2,
   client_value_ IN VARCHAR2 ) RETURN VARCHAR2;

--@PoReadOnly(Decode_)
FUNCTION Decode_ (
   client_list_ IN VARCHAR2,
   db_list_     IN VARCHAR2,
   db_value_    IN VARCHAR2 ) RETURN VARCHAR2;

--@PoReadOnly(Decode_List_)
FUNCTION Decode_List_ (
   client_list_ IN VARCHAR2,
   db_list_     IN VARCHAR2,
   db_value_    IN VARCHAR2 ) RETURN VARCHAR2;

--@PoReadOnly(Decode_Subset_)
FUNCTION Decode_Subset_ (
   client_list_ IN VARCHAR2,
   db_list_     IN VARCHAR2,
   db_sub_list_ IN VARCHAR2 ) RETURN VARCHAR2;

--@PoReadOnly(Get_Db_Value_)
FUNCTION Get_Db_Value_ (
   db_list_ IN VARCHAR2,
   index_   IN NUMBER ) RETURN VARCHAR2;

--@PoReadOnly(Get_Client_Value_)
FUNCTION Get_Client_Value_ (
   client_list_ IN VARCHAR2,
   index_       IN NUMBER ) RETURN VARCHAR2;

--@PoReadOnly(Get_Nls_Client_List_)
FUNCTION Get_Nls_Client_List_ (
   lu_name_     IN  VARCHAR2,
   client_list_ IN  VARCHAR2 ) RETURN VARCHAR2;

PROCEDURE Refresh_Language_;

PROCEDURE Refresh_Language_ (
   lu_   IN VARCHAR2 );

PROCEDURE Refresh_Component_Language_ (
   component_ IN VARCHAR2 );

-----------------------------------------------------------------------------
-------------------- FOUNDATION1 METHODS ------------------------------------
-----------------------------------------------------------------------------
-- Init
--   Framework method that initializes this package.
--
-- Language_Refreshed
-----------------------------------------------------------------------------

--@PoReadOnly(Init)
PROCEDURE Init;

--@PoReadOnly(Language_Refreshed)
PROCEDURE Language_Refreshed (
   domain_            IN VARCHAR2,
   client_value_list_ IN VARCHAR2,
   db_value_list_     IN VARCHAR2,
   type_              IN VARCHAR2 DEFAULT 'IID' );

END DOMAIN_SYS;
/


--
-- ERROR_SYS  (Package) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE PACKAGE VTAPP.ERROR_SYS IS

module_                   CONSTANT VARCHAR2(6)      := 'FNDBAS';
service_                  CONSTANT VARCHAR2(30)     := 'Error';
lu_name_                  CONSTANT VARCHAR2(30)     := 'Error';
lu_type_                  CONSTANT VARCHAR2(30)     := 'SystemService';

-----------------------------------------------------------------------------
-------------------- PUBLIC DECLARATIONS ------------------------------------
-----------------------------------------------------------------------------

Err_Sytem_General EXCEPTION;
   PRAGMA            EXCEPTION_INIT(Err_Sytem_General, -20100);


Err_Appl_General  EXCEPTION;
   PRAGMA            EXCEPTION_INIT(Err_Appl_General, -20105);


Err_Appl_Access   EXCEPTION;
   PRAGMA            EXCEPTION_INIT(Err_Appl_Access, -20106);


Err_Odata_Provider_Access   EXCEPTION;
   PRAGMA            EXCEPTION_INIT(Err_Odata_Provider_Access, -20107);


Err_Record_General  EXCEPTION;
   PRAGMA            EXCEPTION_INIT(Err_Record_General, -20110);


Err_Record_Not_Exist  EXCEPTION;
   PRAGMA            EXCEPTION_INIT(Err_Record_Not_Exist, -20111);


Err_Record_Exist  EXCEPTION;
   PRAGMA            EXCEPTION_INIT(Err_Record_Exist, -20112);


Err_Record_Locked  EXCEPTION;
   PRAGMA            EXCEPTION_INIT(Err_Record_Locked, -20113);


Err_Record_Modified  EXCEPTION;
   PRAGMA            EXCEPTION_INIT(Err_Record_Modified, -20114);


Err_Record_Removed  EXCEPTION;
   PRAGMA            EXCEPTION_INIT(Err_Record_Removed, -20115);


Err_Record_Constraint  EXCEPTION;
   PRAGMA            EXCEPTION_INIT(Err_Record_Constraint, -20116);


Err_Too_Many_Rows  EXCEPTION;
   PRAGMA            EXCEPTION_INIT(Err_Too_Many_Rows, -20117);


Err_Record_Access_Blocked EXCEPTION;
   PRAGMA            exception_init(Err_Record_Access_Blocked, -20118);


Err_Item_General  EXCEPTION;
   PRAGMA            EXCEPTION_INIT(Err_Item_General, -20120);


Err_Item_Insert  EXCEPTION;
   PRAGMA            EXCEPTION_INIT(Err_Item_Insert, -20121);


Err_Item_Update  EXCEPTION;
   PRAGMA            EXCEPTION_INIT(Err_Item_Update, -20122);


Err_Item_Update_If_Null  EXCEPTION;
   PRAGMA            EXCEPTION_INIT(Err_Item_Update_If_Null, -20123);


Err_Item_Format  EXCEPTION;
   PRAGMA            EXCEPTION_INIT(Err_Item_Format, -20124);


Err_Item_Not_Exist  EXCEPTION;
   PRAGMA            EXCEPTION_INIT(Err_Item_Not_Exist, -20125);


Err_State_General  EXCEPTION;
   PRAGMA            EXCEPTION_INIT(Err_State_General, -20130);


Err_State_Not_Exist  EXCEPTION;
   PRAGMA            EXCEPTION_INIT(Err_State_Not_Exist, -20131);


Err_State_Event_Not_Handled  EXCEPTION;
   PRAGMA            EXCEPTION_INIT(Err_State_Event_Not_Handled, -20132);


Err_Security_Checkpoint  EXCEPTION;
   PRAGMA            EXCEPTION_INIT(Err_Security_Checkpoint, -20140);


Err_Component_Not_Exist  EXCEPTION;
   PRAGMA            EXCEPTION_INIT(Err_Component_Not_Exist, -20141);


Err_Deprecated_Error EXCEPTION;
   PRAGMA            EXCEPTION_INIT(Err_Deprecated_Error, -20149);


Err_Compile_Error EXCEPTION;
   PRAGMA            EXCEPTION_INIT(Err_Compile_Error, -20150);


Err_Rowkey_Exist  EXCEPTION;
   PRAGMA            EXCEPTION_INIT(Err_Rowkey_Exist, -20160);


Err_Projection_General  EXCEPTION;
   PRAGMA            exception_init(Err_Projection_General, -20170);


Err_Projection_Not_Exist  EXCEPTION;
   PRAGMA            exception_init(Err_Projection_Not_Exist, -20171);


Err_Projection_Category  EXCEPTION;
   PRAGMA            exception_init(Err_Projection_Category, -20172);


Err_Projection_Group  EXCEPTION;
   PRAGMA            exception_init(Err_Projection_Group, -20173);


Err_Projection_Meta_Not_Exist  EXCEPTION;
   PRAGMA            exception_init(Err_Projection_Meta_Not_Exist, -20174);


Err_Odp_Record_Not_Exist  EXCEPTION;
   PRAGMA            exception_init(Err_Odp_Record_Not_Exist, -20180);


Err_Init_Check_Failure EXCEPTION;
   PRAGMA            exception_init(Err_Init_Check_Failure, -20181);



-----------------------------------------------------------------------------
-------------------- LU SPECIFIC IMPLEMENTATION METHODS ---------------------
-----------------------------------------------------------------------------
-- Get_Formatted_Error_Text
-----------------------------------------------------------------------------

FUNCTION Get_Formatted_Error_Text (
   lu_name_   IN VARCHAR2,
   err_text_  IN VARCHAR2,
   p1_        IN VARCHAR2 DEFAULT NULL,
   p2_        IN VARCHAR2 DEFAULT NULL,
   p3_        IN VARCHAR2 DEFAULT NULL,
   p4_        IN VARCHAR2 DEFAULT NULL,
   p5_        IN VARCHAR2 DEFAULT NULL,
   p6_        IN VARCHAR2 DEFAULT NULL,
   p7_        IN VARCHAR2 DEFAULT NULL,
   p8_        IN VARCHAR2 DEFAULT NULL,
   p9_        IN VARCHAR2 DEFAULT NULL,
   p10_       IN VARCHAR2 DEFAULT NULL,
   lang_code_ IN VARCHAR2 DEFAULT NULL ) RETURN VARCHAR2;

-----------------------------------------------------------------------------
-------------------- LU SPECIFIC PUBLIC METHODS -----------------------------
-----------------------------------------------------------------------------
-- System_General
--   General error method used by the system.
--
-- Appl_General
--   General error method to be used by the logical units.
--
-- Record_General
--   General error method for record tasks with user defined messages.
--
-- Fnd_Record_Not_Exist
--
-- Record_Not_Exist
--   Validation message, used from all <LU>_API.Exist.
--
-- Record_Exist
--   Duplicate key message when registering new records.
--
-- Fnd_Record_Exist
--
-- Rowkey_Exist
--   Duplicate rowkey message when registering new records.
--
-- Fnd_Rowkey_Exist
--
-- Record_Locked
--   Message for row lockings, used by method Lock___.
--
-- Fnd_Record_Locked
--
-- Record_Modified
--   Message when old information are fetched from the database.
--
-- Fnd_Record_Modified
--
-- Record_Removed
--   Message when record removed from the database by another user.
--
-- Fnd_Record_Removed
--
-- Fnd_Record_Removed
--
-- Record_Constraint
--   Message for restricted delete for foreign keys.
--
-- Too_Many_Rows
--
-- Fnd_Too_Many_Rows
--
-- Record_Access_Blocked
--
-- Data_Access_Security
--
-- Appl_Failure
--   General error method to be used within 'initial check' methods
--
-- Item_General
--   General error method for item tasks with used defined messages.
--
-- Item_Insert
--   Message when an illegal attribute is changed at NEW.
--
-- Item_Update
--   Message when an illegal attribute is changed at MODIFY.
--
-- Item_Update_If_Null
--   Message when an illegal attribute is changed at MODIFY.
--
-- Item_Format
--   Message when a bad format is found (often when unpacking attr_).
--
-- Fnd_Item_Format
--
-- Item_Not_Exist
--   Message when unidentified attributes are found (within attr_).
--
-- Component_Not_Exist
--
-- Check_Not_Null
--   Method to check if an attribute is NULL or not.
--   The value is given as a parameter.
--   Method to check if an attribute is NULL or not.
--   The value is given as a parameter.
--   Method to check if an attribute is NULL or not.
--   The value is given as a parameter.
--   Method to check if an attribute is NULL or not.
--   The value is given as a parameter.
--
-- Check_Not_Null
--   Method to check if an attribute is NULL or not.
--   The value is given as a parameter.
--   Method to check if an attribute is NULL or not.
--   The value is given as a parameter.
--   Method to check if an attribute is NULL or not.
--   The value is given as a parameter.
--   Method to check if an attribute is NULL or not.
--   The value is given as a parameter.
--
-- Check_Not_Null
--   Method to check if an attribute is NULL or not.
--   The value is given as a parameter.
--   Method to check if an attribute is NULL or not.
--   The value is given as a parameter.
--   Method to check if an attribute is NULL or not.
--   The value is given as a parameter.
--   Method to check if an attribute is NULL or not.
--   The value is given as a parameter.
--
-- Check_Not_Null
--   Method to check if an attribute is NULL or not.
--   The value is given as a parameter.
--   Method to check if an attribute is NULL or not.
--   The value is given as a parameter.
--   Method to check if an attribute is NULL or not.
--   The value is given as a parameter.
--   Method to check if an attribute is NULL or not.
--   The value is given as a parameter.
--
-- Check_Null
--
-- Check_Null
--
-- Check_Null
--
-- Check_Null
--
-- Check_No_Update
--   Method to check if an attribute is updated or not.
--   The old and the new values are given as parameters.
--   Method to check if an attribute is updated or not.
--   The old and the new values are given as parameters.
--   Method to check if an attribute is updated or not.
--   The old and the new values are given as parameters.
--   Method to check if an attribute is updated or not.
--   The old and the new values are given as parameters.
--
-- Check_No_Update
--   Method to check if an attribute is updated or not.
--   The old and the new values are given as parameters.
--   Method to check if an attribute is updated or not.
--   The old and the new values are given as parameters.
--   Method to check if an attribute is updated or not.
--   The old and the new values are given as parameters.
--   Method to check if an attribute is updated or not.
--   The old and the new values are given as parameters.
--
-- Check_No_Update
--   Method to check if an attribute is updated or not.
--   The old and the new values are given as parameters.
--   Method to check if an attribute is updated or not.
--   The old and the new values are given as parameters.
--   Method to check if an attribute is updated or not.
--   The old and the new values are given as parameters.
--   Method to check if an attribute is updated or not.
--   The old and the new values are given as parameters.
--
-- Check_No_Update
--   Method to check if an attribute is updated or not.
--   The old and the new values are given as parameters.
--   Method to check if an attribute is updated or not.
--   The old and the new values are given as parameters.
--   Method to check if an attribute is updated or not.
--   The old and the new values are given as parameters.
--   Method to check if an attribute is updated or not.
--   The old and the new values are given as parameters.
--
-- Check_Update_If_Null
--   Method to check if an attribute is updated from NULL or not.
--   The old and the new values are given as parameters.
--   Method to check if an attribute is updated from NULL or not.
--   The old and the new values are given as parameters.
--   Method to check if an attribute is updated from NULL or not.
--   The old and the new values are given as parameters.
--   Method to check if an attribute is updated from NULL or not.
--   The old and the new values are given as parameters.
--
-- Check_Update_If_Null
--   Method to check if an attribute is updated from NULL or not.
--   The old and the new values are given as parameters.
--   Method to check if an attribute is updated from NULL or not.
--   The old and the new values are given as parameters.
--   Method to check if an attribute is updated from NULL or not.
--   The old and the new values are given as parameters.
--   Method to check if an attribute is updated from NULL or not.
--   The old and the new values are given as parameters.
--
-- Check_Update_If_Null
--   Method to check if an attribute is updated from NULL or not.
--   The old and the new values are given as parameters.
--   Method to check if an attribute is updated from NULL or not.
--   The old and the new values are given as parameters.
--   Method to check if an attribute is updated from NULL or not.
--   The old and the new values are given as parameters.
--   Method to check if an attribute is updated from NULL or not.
--   The old and the new values are given as parameters.
--
-- Check_Update_If_Null
--   Method to check if an attribute is updated from NULL or not.
--   The old and the new values are given as parameters.
--   Method to check if an attribute is updated from NULL or not.
--   The old and the new values are given as parameters.
--   Method to check if an attribute is updated from NULL or not.
--   The old and the new values are given as parameters.
--   Method to check if an attribute is updated from NULL or not.
--   The old and the new values are given as parameters.
--
-- Check_Lower
--
-- Check_Upper
--
-- Check_Date_Truncated
--
-- Check_Valid_Key_String
--
-- Check_Valid_Identifier
--
-- Trim_Space_Validation
--
-- State_General
--   General error method for state events with user defined messages.
--
-- State_Not_Exist
--   Message when unidentified finite state is found.
--
-- State_Event_Not_Handled
--   Message when an event is not handled by current state.
--
-- Projection_General
--
-- Projection_Not_Exist
--
-- Projection_Category
--
-- Projection_Group
--
-- Projection_Meta_Not_Exist
--
-- Odp_Record_Not_Exist
--
-- Is_Foundation_Error
--   Return true if an error occurred through system service Error_SYS
--
-- Strip_Ora_Error
--
-- Set_Key_Values
-----------------------------------------------------------------------------

--@PoReadOnly(System_General)
PROCEDURE System_General (
   err_text_ IN VARCHAR2,
   p1_       IN VARCHAR2 DEFAULT NULL,
   p2_       IN VARCHAR2 DEFAULT NULL,
   p3_       IN VARCHAR2 DEFAULT NULL );

--@PoReadOnly(Appl_General)
PROCEDURE Appl_General (
   lu_name_   IN VARCHAR2,
   err_text_  IN VARCHAR2,
   p1_        IN VARCHAR2 DEFAULT NULL,
   p2_        IN VARCHAR2 DEFAULT NULL,
   p3_        IN VARCHAR2 DEFAULT NULL,
   lang_code_ IN VARCHAR2 DEFAULT NULL );

--@PoReadOnly(Record_General)
PROCEDURE Record_General (
   lu_name_  IN VARCHAR2,
   err_text_ IN VARCHAR2,
   p1_       IN VARCHAR2 DEFAULT NULL,
   p2_       IN VARCHAR2 DEFAULT NULL,
   p3_       IN VARCHAR2 DEFAULT NULL );

--@PoReadOnly(Fnd_Record_Not_Exist)
PROCEDURE Fnd_Record_Not_Exist (
   lu_name_       IN VARCHAR2 );

--@PoReadOnly(Record_Not_Exist)
PROCEDURE Record_Not_Exist (
   lu_name_  IN VARCHAR2,
   err_text_ IN VARCHAR2 DEFAULT NULL,
   p1_       IN VARCHAR2 DEFAULT NULL,
   p2_       IN VARCHAR2 DEFAULT NULL,
   p3_       IN VARCHAR2 DEFAULT NULL );

--@PoReadOnly(Record_Exist)
PROCEDURE Record_Exist (
   lu_name_  IN VARCHAR2,
   err_text_ IN VARCHAR2 DEFAULT NULL,
   p1_       IN VARCHAR2 DEFAULT NULL,
   p2_       IN VARCHAR2 DEFAULT NULL,
   p3_       IN VARCHAR2 DEFAULT NULL );

--@PoReadOnly(Fnd_Record_Exist)
PROCEDURE Fnd_Record_Exist (
   lu_name_       IN VARCHAR2 );

--@PoReadOnly(Rowkey_Exist)
PROCEDURE Rowkey_Exist (
   lu_name_  IN VARCHAR2,
   rowkey_   IN VARCHAR2 );

--@PoReadOnly(Fnd_Rowkey_Exist)
PROCEDURE Fnd_Rowkey_Exist (
   lu_name_       IN VARCHAR2,
   rowkey_        IN VARCHAR2 );

--@PoReadOnly(Record_Locked)
PROCEDURE Record_Locked (
   lu_name_  IN VARCHAR2,
   err_text_ IN VARCHAR2 DEFAULT NULL,
   p1_       IN VARCHAR2 DEFAULT NULL,
   p2_       IN VARCHAR2 DEFAULT NULL,
   p3_       IN VARCHAR2 DEFAULT NULL );

--@PoReadOnly(Fnd_Record_Locked)
PROCEDURE Fnd_Record_Locked (
   lu_name_       IN VARCHAR2 );

--@PoReadOnly(Record_Modified)
PROCEDURE Record_Modified (
   lu_name_  IN VARCHAR2,
   err_text_ IN VARCHAR2 DEFAULT NULL,
   p1_       IN VARCHAR2 DEFAULT NULL,
   p2_       IN VARCHAR2 DEFAULT NULL,
   p3_       IN VARCHAR2 DEFAULT NULL );

--@PoReadOnly(Fnd_Record_Modified)
PROCEDURE Fnd_Record_Modified (
   lu_name_       IN VARCHAR2 );

--@PoReadOnly(Record_Removed)
PROCEDURE Record_Removed (
   lu_name_  IN VARCHAR2,
   err_text_ IN VARCHAR2 DEFAULT NULL,
   p1_       IN VARCHAR2 DEFAULT NULL,
   p2_       IN VARCHAR2 DEFAULT NULL,
   p3_       IN VARCHAR2 DEFAULT NULL );

--@PoReadOnly(Fnd_Record_Removed)
PROCEDURE Fnd_Record_Removed (
   lu_name_       IN VARCHAR2,
   label_         IN VARCHAR2,
   value_         IN VARCHAR2,
   parent_key_msg_ IN VARCHAR2 );

--@PoReadOnly(Fnd_Record_Removed)
PROCEDURE Fnd_Record_Removed (
   lu_name_       IN VARCHAR2 );

--@PoReadOnly(Record_Constraint)
PROCEDURE Record_Constraint (
   lu_name_  IN VARCHAR2,
   info_     IN VARCHAR2,
   count_    IN VARCHAR2,
   err_text_ IN VARCHAR2 DEFAULT NULL,
   p1_       IN VARCHAR2 DEFAULT NULL,
   p2_       IN VARCHAR2 DEFAULT NULL,
   p3_       IN VARCHAR2 DEFAULT NULL );

--@PoReadOnly(Too_Many_Rows)
PROCEDURE Too_Many_Rows (
   lu_name_  IN VARCHAR2,
   err_text_ IN VARCHAR2 DEFAULT NULL,
   p1_       IN VARCHAR2 DEFAULT NULL,
   p2_       IN VARCHAR2 DEFAULT NULL,
   p3_       IN VARCHAR2 DEFAULT NULL );

--@PoReadOnly(Fnd_Too_Many_Rows)
PROCEDURE Fnd_Too_Many_Rows (
   lu_name_       IN VARCHAR2,
   method_name_   IN VARCHAR2,
   formatted_key_ IN VARCHAR2 );

--@PoReadOnly(Record_Access_Blocked)
PROCEDURE Record_Access_Blocked (
   lu_name_  IN VARCHAR2,
   err_text_ IN VARCHAR2 DEFAULT NULL,
   p1_       IN VARCHAR2 DEFAULT NULL,
   p2_       IN VARCHAR2 DEFAULT NULL,
   p3_       IN VARCHAR2 DEFAULT NULL );

--@PoReadOnly(Data_Access_Security)
PROCEDURE Data_Access_Security (
   lu_name_   IN VARCHAR2,
   err_text_  IN VARCHAR2,
   p1_        IN VARCHAR2 DEFAULT NULL,
   p2_        IN VARCHAR2 DEFAULT NULL,
   p3_        IN VARCHAR2 DEFAULT NULL,
   p4_        IN VARCHAR2 DEFAULT NULL,
   p5_        IN VARCHAR2 DEFAULT NULL,
   p6_        IN VARCHAR2 DEFAULT NULL,
   p7_        IN VARCHAR2 DEFAULT NULL,
   p8_        IN VARCHAR2 DEFAULT NULL,
   p9_        IN VARCHAR2 DEFAULT NULL,
   p10_       IN VARCHAR2 DEFAULT NULL,
   lang_code_ IN VARCHAR2 DEFAULT NULL );

--@PoReadOnly(Appl_Failure)
PROCEDURE Appl_Failure (
   lu_name_    IN VARCHAR2,
   caller_     IN VARCHAR2 DEFAULT NULL,
   err_text_   IN VARCHAR2 DEFAULT NULL,
   err_source_ IN VARCHAR2 DEFAULT NULL,      
   p1_         IN VARCHAR2 DEFAULT NULL,
   p2_         IN VARCHAR2 DEFAULT NULL,
   p3_         IN VARCHAR2 DEFAULT NULL );

--@PoReadOnly(Item_General)
PROCEDURE Item_General (
   lu_name_  IN VARCHAR2,
   item_     IN VARCHAR2,
   err_text_ IN VARCHAR2,
   p1_       IN VARCHAR2 DEFAULT NULL,
   p2_       IN VARCHAR2 DEFAULT NULL,
   p3_       IN VARCHAR2 DEFAULT NULL );

--@PoReadOnly(Item_Insert)
PROCEDURE Item_Insert (
   lu_name_  IN VARCHAR2,
   item_     IN VARCHAR2,
   err_text_ IN VARCHAR2 DEFAULT NULL,
   p1_       IN VARCHAR2 DEFAULT NULL,
   p2_       IN VARCHAR2 DEFAULT NULL,
   p3_       IN VARCHAR2 DEFAULT NULL );

--@PoReadOnly(Item_Update)
PROCEDURE Item_Update (
   lu_name_  IN VARCHAR2,
   item_     IN VARCHAR2,
   err_text_ IN VARCHAR2 DEFAULT NULL,
   p1_       IN VARCHAR2 DEFAULT NULL,
   p2_       IN VARCHAR2 DEFAULT NULL,
   p3_       IN VARCHAR2 DEFAULT NULL );

--@PoReadOnly(Item_Update_If_Null)
PROCEDURE Item_Update_If_Null (
   lu_name_  IN VARCHAR2,
   item_     IN VARCHAR2,
   err_text_ IN VARCHAR2 DEFAULT NULL,
   p1_       IN VARCHAR2 DEFAULT NULL,
   p2_       IN VARCHAR2 DEFAULT NULL,
   p3_       IN VARCHAR2 DEFAULT NULL );

--@PoReadOnly(Item_Format)
PROCEDURE Item_Format (
   lu_name_  IN VARCHAR2,
   item_     IN VARCHAR2,
   value_    IN VARCHAR2,
   err_text_ IN VARCHAR2 DEFAULT NULL,
   p1_       IN VARCHAR2 DEFAULT NULL,
   p2_       IN VARCHAR2 DEFAULT NULL,
   p3_       IN VARCHAR2 DEFAULT NULL );

--@PoReadOnly(Fnd_Item_Format)
PROCEDURE Fnd_Item_Format (
   lu_name_       IN VARCHAR2,
   label_         IN VARCHAR2,
   value_         IN VARCHAR2,
   cause_         IN VARCHAR2 DEFAULT NULL );

--@PoReadOnly(Item_Not_Exist)
PROCEDURE Item_Not_Exist (
   lu_name_  IN VARCHAR2,
   item_     IN VARCHAR2,
   value_    IN VARCHAR2,
   err_text_ IN VARCHAR2 DEFAULT NULL,
   p1_       IN VARCHAR2 DEFAULT NULL,
   p2_       IN VARCHAR2 DEFAULT NULL,
   p3_       IN VARCHAR2 DEFAULT NULL );

--@PoReadOnly(Component_Not_Exist)
PROCEDURE Component_Not_Exist (
   module_  IN VARCHAR2 );

--@PoReadOnly(Check_Not_Null)
PROCEDURE Check_Not_Null (
   lu_name_ IN VARCHAR2,
   item_    IN VARCHAR2,
   value_   IN VARCHAR2 );

--@PoReadOnly(Check_Not_Null)
PROCEDURE Check_Not_Null (
   lu_name_ IN VARCHAR2,
   item_    IN VARCHAR2,
   value_   IN NUMBER );

--@PoReadOnly(Check_Not_Null)
PROCEDURE Check_Not_Null (
   lu_name_ IN VARCHAR2,
   item_    IN VARCHAR2,
   value_   IN DATE );

--@PoReadOnly(Check_Not_Null)
PROCEDURE Check_Not_Null (
   lu_name_ IN VARCHAR2,
   item_    IN VARCHAR2,
   value_   IN TIMESTAMP );

--@PoReadOnly(Check_Null)
PROCEDURE Check_Null (
   lu_name_ IN VARCHAR2,
   item_    IN VARCHAR2,
   value_   IN VARCHAR2 );

--@PoReadOnly(Check_Null)
PROCEDURE Check_Null (
   lu_name_ IN VARCHAR2,
   item_    IN VARCHAR2,
   value_   IN NUMBER );

--@PoReadOnly(Check_Null)
PROCEDURE Check_Null (
   lu_name_ IN VARCHAR2,
   item_    IN VARCHAR2,
   value_   IN DATE );

--@PoReadOnly(Check_Null)
PROCEDURE Check_Null (
   lu_name_ IN VARCHAR2,
   item_    IN VARCHAR2,
   value_   IN TIMESTAMP );

--@PoReadOnly(Check_No_Update)
PROCEDURE Check_No_Update (
   lu_name_   IN VARCHAR2,
   item_      IN VARCHAR2,
   new_value_ IN VARCHAR2,
   old_value_ IN VARCHAR2 );

--@PoReadOnly(Check_No_Update)
PROCEDURE Check_No_Update (
   lu_name_   IN VARCHAR2,
   item_      IN VARCHAR2,
   new_value_ IN NUMBER,
   old_value_ IN NUMBER );

--@PoReadOnly(Check_No_Update)
PROCEDURE Check_No_Update (
   lu_name_   IN VARCHAR2,
   item_      IN VARCHAR2,
   new_value_ IN DATE,
   old_value_ IN DATE );

--@PoReadOnly(Check_No_Update)
PROCEDURE Check_No_Update (
   lu_name_   IN VARCHAR2,
   item_      IN VARCHAR2,
   new_value_ IN TIMESTAMP,
   old_value_ IN TIMESTAMP );

--@PoReadOnly(Check_Update_If_Null)
PROCEDURE Check_Update_If_Null (
   lu_name_   IN VARCHAR2,
   item_      IN VARCHAR2,
   new_value_ IN VARCHAR2,
   old_value_ IN VARCHAR2 );

--@PoReadOnly(Check_Update_If_Null)
PROCEDURE Check_Update_If_Null (
   lu_name_   IN VARCHAR2,
   item_      IN VARCHAR2,
   new_value_ IN NUMBER,
   old_value_ IN NUMBER );

--@PoReadOnly(Check_Update_If_Null)
PROCEDURE Check_Update_If_Null (
   lu_name_   IN VARCHAR2,
   item_      IN VARCHAR2,
   new_value_ IN DATE,
   old_value_ IN DATE );

--@PoReadOnly(Check_Update_If_Null)
PROCEDURE Check_Update_If_Null (
   lu_name_   IN VARCHAR2,
   item_      IN VARCHAR2,
   new_value_ IN TIMESTAMP,
   old_value_ IN TIMESTAMP );

--@PoReadOnly(Check_Lower)
PROCEDURE Check_Lower (
   lu_name_   IN VARCHAR2,
   label_     IN VARCHAR2,
   value_     IN VARCHAR2 );

--@PoReadOnly(Check_Upper)
PROCEDURE Check_Upper (
   lu_name_   IN VARCHAR2,
   label_     IN VARCHAR2,
   value_     IN VARCHAR2 );

--@PoReadOnly(Check_Date_Truncated)
PROCEDURE Check_Date_Truncated (
   lu_name_   IN VARCHAR2,
   label_     IN VARCHAR2,
   value_     IN DATE );

--@PoReadOnly(Check_Valid_Key_String)
PROCEDURE Check_Valid_Key_String (
   key_name_   IN VARCHAR2,
   key_value_  IN VARCHAR2 );

--@PoReadOnly(Check_Valid_Identifier)
PROCEDURE Check_Valid_Identifier (
   name_  IN VARCHAR2,
   value_ IN VARCHAR2);

--@PoReadOnly(Trim_Space_Validation)
PROCEDURE Trim_Space_Validation (
   value_ IN VARCHAR2);

--@PoReadOnly(State_General)
PROCEDURE State_General (
   lu_name_  IN VARCHAR2,
   err_text_ IN VARCHAR2,
   p1_       IN VARCHAR2 DEFAULT NULL,
   p2_       IN VARCHAR2 DEFAULT NULL,
   p3_       IN VARCHAR2 DEFAULT NULL );

--@PoReadOnly(State_Not_Exist)
PROCEDURE State_Not_Exist (
   lu_name_  IN VARCHAR2,
   state_    IN VARCHAR2,
   err_text_ IN VARCHAR2 DEFAULT NULL,
   p1_       IN VARCHAR2 DEFAULT NULL,
   p2_       IN VARCHAR2 DEFAULT NULL,
   p3_       IN VARCHAR2 DEFAULT NULL );

--@PoReadOnly(State_Event_Not_Handled)
PROCEDURE State_Event_Not_Handled (
   lu_name_  IN VARCHAR2,
   event_    IN VARCHAR2,
   state_    IN VARCHAR2,
   err_text_ IN VARCHAR2 DEFAULT NULL,
   p1_       IN VARCHAR2 DEFAULT NULL,
   p2_       IN VARCHAR2 DEFAULT NULL,
   p3_       IN VARCHAR2 DEFAULT NULL );

--@PoReadOnly(Projection_General)
PROCEDURE Projection_General (
   lu_name_  IN VARCHAR2,
   err_text_ IN VARCHAR2,
   p1_       IN VARCHAR2 DEFAULT NULL,
   p2_       IN VARCHAR2 DEFAULT NULL,
   p3_       IN VARCHAR2 DEFAULT NULL );

--@PoReadOnly(Projection_Not_Exist)
PROCEDURE Projection_Not_Exist (
   lu_name_         IN VARCHAR2,
   projection_name_ IN VARCHAR2 );

--@PoReadOnly(Projection_Category)
PROCEDURE Projection_Category (
   lu_name_         IN VARCHAR2,
   projection_name_ IN VARCHAR2,
   category_        IN VARCHAR2 DEFAULT NULL );

--@PoReadOnly(Projection_Group)
PROCEDURE Projection_Group (
   lu_name_         IN VARCHAR2,
   projection_name_ IN VARCHAR2,
   group_           IN VARCHAR2 DEFAULT NULL );

--@PoReadOnly(Projection_Meta_Not_Exist)
PROCEDURE Projection_Meta_Not_Exist (
   lu_name_         IN VARCHAR2,
   projection_name_ IN VARCHAR2 );

--@PoReadOnly(Odp_Record_Not_Exist)
PROCEDURE Odp_Record_Not_Exist (
   lu_name_         IN VARCHAR2 );

--@PoReadOnly(Is_Foundation_Error)
FUNCTION Is_Foundation_Error (
   oracle_no_ IN NUMBER ) RETURN BOOLEAN;

--@PoReadOnly(Strip_Ora_Error)
FUNCTION Strip_Ora_Error (
   sqlerrm_        IN VARCHAR2,
   sqlcode_        IN NUMBER DEFAULT NULL,
   strip_ora_only_ IN BOOLEAN DEFAULT FALSE,
   keep_non_fnd_   IN BOOLEAN DEFAULT TRUE) RETURN VARCHAR2;

PROCEDURE Set_Key_Values (
   key_message_ IN VARCHAR2,
   formatted_keys_ IN VARCHAR2 );

-----------------------------------------------------------------------------
-------------------- LU SPECIFIC PROTECTED METHODS --------------------------
-----------------------------------------------------------------------------
-- Appl_Access_
--   Access errors to be used from system service Security_SYS.
--
-- Odata_Provider_Access_
--   Access errors to be used from Odata Provider Authorization.
--
-- Security_Checkpoint_
--   Security Checkpoint errors to be used from system service Security_SYS.
--   Security Checkpoint errors to be used from system service Security_SYS.
--
-- Compile_Error_
--
-- Compile_Error_
--
-- Deprecated_Error_
-----------------------------------------------------------------------------

--@PoReadOnly(Appl_Access_)
PROCEDURE Appl_Access_ (
   lu_name_ IN VARCHAR2,
   package_ IN VARCHAR2,
   method_  IN VARCHAR2 );

--@PoReadOnly(Odata_Provider_Access_)
PROCEDURE Odata_Provider_Access_ (
   lu_name_   IN VARCHAR2,
   err_text_  IN VARCHAR2,
   p1_        IN VARCHAR2 DEFAULT NULL,
   p2_        IN VARCHAR2 DEFAULT NULL,
   p3_        IN VARCHAR2 DEFAULT NULL );

--@PoReadOnly(Security_Checkpoint_)
PROCEDURE Security_Checkpoint_ (
   msg_ IN VARCHAR2 );

--@PoReadOnly(Compile_Error_)
PROCEDURE Compile_Error_ (
   lu_name_ IN VARCHAR2 );

--@PoReadOnly(Compile_Error_)
PROCEDURE Compile_Error_ (
   lu_name_ IN VARCHAR2,
   details_ IN VARCHAR2);

--@PoReadOnly(Deprecated_Error_)
PROCEDURE Deprecated_Error_ (
   lu_name_ IN VARCHAR2,
   method_name_ IN VARCHAR2 );

-----------------------------------------------------------------------------
-------------------- FOUNDATION1 METHODS ------------------------------------
-----------------------------------------------------------------------------
-- Init
--   Framework method that initializes this package.
-----------------------------------------------------------------------------

--@PoReadOnly(Init)
PROCEDURE Init;

END ERROR_SYS;
/


--
-- INSTALL_TEM_SYS  (Package) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE PACKAGE VTAPP.INSTALL_TEM_SYS IS

module_                   CONSTANT VARCHAR2(6)      := 'FNDBAS';
service_                  CONSTANT VARCHAR2(30)     := 'InstallTem';
lu_name_                  CONSTANT VARCHAR2(30)     := 'InstallTem';
lu_type_                  CONSTANT VARCHAR2(30)     := 'SystemService';

bkg_client_id_ CONSTANT VARCHAR2(64) := 'IFS Applications background job';

-----------------------------------------------------------------------------
-------------------- SERVICE SPECIFIC PRIVATE METHODS -----------------------
-----------------------------------------------------------------------------

PROCEDURE Alter_Job_Queue_Processes__ (
   value_ IN VARCHAR2 );

PROCEDURE Disable_Dbms_Scheduler__ (
   value_ IN VARCHAR2 );

PROCEDURE Enable_All_Queues__;

PROCEDURE Create_Context__;

PROCEDURE Cleanup__;

PROCEDURE Disable_Ial_Scheduler_Proc__;

PROCEDURE Stop_Ial_Scheduler_Proc__;

PROCEDURE Enable_Ial_Scheduler_Proc__;

-----------------------------------------------------------------------------
-------------------- SERVICE SPECIFIC PROTECTED METHODS ---------------------
-----------------------------------------------------------------------------

FUNCTION Get_Installation_Id_ RETURN VARCHAR2;

-----------------------------------------------------------------------------
-------------------- SERVICE SPECIFIC PUBLIC METHODS ------------------------
-----------------------------------------------------------------------------

FUNCTION Disable_Show_Dbms_Jobs RETURN NUMBER;

PROCEDURE Disable_Show_Dbms_Jobs;

PROCEDURE Disable_Scheduler_Processes;

PROCEDURE Enable_Scheduler_Processes;

PROCEDURE Show_Db_Obj_Invalid_Count;

FUNCTION Show_Db_Obj_Invalid_Count RETURN NUMBER;

PROCEDURE Show_Debug_Status;

PROCEDURE Show_Db_Obj_Debug_Count;

FUNCTION Show_Db_Obj_Debug_Count RETURN NUMBER;

FUNCTION Show_Db_Obj_Debug_Exist RETURN NUMBER;

PROCEDURE Show_Dbms_Jobs;

FUNCTION Show_Dbms_Jobs RETURN NUMBER;

PROCEDURE Show_Scheduler_Processes;

FUNCTION Show_Scheduler_Processes RETURN NUMBER;

FUNCTION Show_Jobs_Other_Schema RETURN NUMBER;

PROCEDURE Show_Jobs_Other_Schema;

FUNCTION Show_Jobs_Trgs_Other_Schema RETURN NUMBER;

PROCEDURE Show_Jobs_Trgs_Other_Schema;


PROCEDURE Reset_Job_Queue_Processes;

PROCEDURE Set_Job_Queue_Processes (
   in_no_of_processes_ IN VARCHAR2 );

PROCEDURE Stop_Scheduler_Processes;

PROCEDURE Installation_Support (
   action_    IN VARCHAR2,
   parameter_ IN VARCHAR2,
   module_    IN VARCHAR2 DEFAULT NULL );

PROCEDURE Lu_Installation_Support (
   lu_        IN VARCHAR2,
   action_    IN VARCHAR2,
   parameter_ IN VARCHAR2 DEFAULT NULL );

PROCEDURE Finalize_Installation (
   complete_ VARCHAR2 DEFAULT 'FALSE' );

FUNCTION User_Exist (
   username_ IN VARCHAR2 ) RETURN NUMBER;

FUNCTION Get_Multi_Installation_Mode RETURN BOOLEAN;

PROCEDURE Set_Multi_Installation_Mode (
   multi_delivery_mode_ IN BOOLEAN DEFAULT FALSE );

FUNCTION Disabled_Rowkey_Exist RETURN NUMBER;

FUNCTION Disabled_Sd_Exist RETURN NUMBER;

FUNCTION Unconverted_Lob_Exist RETURN NUMBER;

FUNCTION Dbms_Scheduler_Enabled RETURN VARCHAR2;

FUNCTION Nls_Length_Semantic_Is_Char RETURN VARCHAR2;

FUNCTION Installation_Running RETURN BOOLEAN;

PROCEDURE Gather_Initial_Statistics;

FUNCTION Background_Processing_On RETURN VARCHAR2;

FUNCTION Am_I_Multitenant RETURN BOOLEAN;

-----------------------------------------------------------------------------
-------------------- FOUNDATION1 METHODS ------------------------------------
-----------------------------------------------------------------------------

PROCEDURE Init;

END INSTALL_TEM_SYS;
/


--
-- CF_REP_CUSTOMER_API  (Package Body) 
--
--  Dependencies: 
--   CF_REP_CUSTOMER_API (Package)
--   STANDARD (Package)
--   CF_REP_CUSTOMER_TAB (Table)
--   CLIENT_SYS (Package)
--   ERROR_SYS (Package)
--
CREATE OR REPLACE PACKAGE BODY VTAPP.Cf_Rep_Customer_API IS

-----------------------------------------------------------------------------
-------------------- PRIVATE DECLARATIONS -----------------------------------
-----------------------------------------------------------------------------

TYPE Indicator_Rec IS RECORD
  (customer                       BOOLEAN := FALSE,
   description                    BOOLEAN := FALSE);


-----------------------------------------------------------------------------
-------------------- IMPLEMENTATION METHOD DECLARATIONS ---------------------
-----------------------------------------------------------------------------

FUNCTION Key_Message___ (
   customer_ IN VARCHAR2 ) RETURN VARCHAR2;

FUNCTION Formatted_Key___ (
   customer_ IN VARCHAR2 ) RETURN VARCHAR2;

PROCEDURE Raise_Too_Many_Rows___ (
   customer_ IN VARCHAR2,
   methodname_ IN VARCHAR2 );

PROCEDURE Raise_Record_Not_Exist___ (
   customer_ IN VARCHAR2 );

PROCEDURE Raise_Record_Exist___ (
   rec_ IN cf_rep_customer_tab%ROWTYPE );

PROCEDURE Raise_Constraint_Violated___ (
   rec_ IN cf_rep_customer_tab%ROWTYPE,
   constraint_ IN VARCHAR2 );

PROCEDURE Raise_Item_Format___ (
   name_ IN VARCHAR2,
   value_ IN VARCHAR2 );

PROCEDURE Raise_Record_Modified___ (
   rec_ IN cf_rep_customer_tab%ROWTYPE );

PROCEDURE Raise_Record_Locked___ (
   customer_ IN VARCHAR2 );

PROCEDURE Raise_Record_Removed___ (
   customer_ IN VARCHAR2 );

FUNCTION Lock_By_Id___ (
   objid_      IN VARCHAR2,
   objversion_ IN VARCHAR2 ) RETURN cf_rep_customer_tab%ROWTYPE;

FUNCTION Lock_By_Keys___ (
   customer_ IN VARCHAR2) RETURN cf_rep_customer_tab%ROWTYPE;

FUNCTION Lock_By_Keys_Nowait___ (
   customer_ IN VARCHAR2) RETURN cf_rep_customer_tab%ROWTYPE;

FUNCTION Get_Object_By_Id___ (
   objid_ IN VARCHAR2 ) RETURN cf_rep_customer_tab%ROWTYPE;

FUNCTION Get_Object_By_Keys___ (
   customer_ IN VARCHAR2 ) RETURN cf_rep_customer_tab%ROWTYPE;

FUNCTION Check_Exist___ (
   customer_ IN VARCHAR2 ) RETURN BOOLEAN;

PROCEDURE Get_Version_By_Id___ (
   objid_      IN     VARCHAR2,
   objversion_ IN OUT NOCOPY VARCHAR2 );

PROCEDURE Get_Id_Version_By_Keys___ (
   objid_      IN OUT NOCOPY VARCHAR2,
   objversion_ IN OUT NOCOPY VARCHAR2,
   customer_ IN VARCHAR2 );

PROCEDURE Unpack___ (
   newrec_   IN OUT NOCOPY cf_rep_customer_tab%ROWTYPE,
   indrec_   IN OUT NOCOPY Indicator_Rec,
   attr_     IN OUT NOCOPY VARCHAR2 );

FUNCTION Pack___ (
   rec_ IN cf_rep_customer_tab%ROWTYPE ) RETURN VARCHAR2;

FUNCTION Pack___ (
   rec_ IN cf_rep_customer_tab%ROWTYPE,
   indrec_ IN Indicator_Rec ) RETURN VARCHAR2;

FUNCTION Pack_Table___ (
   rec_ IN cf_rep_customer_tab%ROWTYPE ) RETURN VARCHAR2;

FUNCTION Public_To_Table___ (
   public_ IN Public_Rec ) RETURN cf_rep_customer_tab%ROWTYPE;

FUNCTION Table_To_Public___ (
   rec_ IN cf_rep_customer_tab%ROWTYPE ) RETURN Public_Rec;

PROCEDURE Reset_Indicator_Rec___ (
   indrec_ IN OUT NOCOPY Indicator_Rec );

FUNCTION Get_Indicator_Rec___ (
   rec_ IN cf_rep_customer_tab%ROWTYPE ) RETURN Indicator_Rec;

FUNCTION Get_Indicator_Rec___ (
   oldrec_ IN cf_rep_customer_tab%ROWTYPE,
   newrec_ IN cf_rep_customer_tab%ROWTYPE ) RETURN Indicator_Rec;

PROCEDURE Check_Common___ (
   oldrec_ IN     cf_rep_customer_tab%ROWTYPE,
   newrec_ IN OUT NOCOPY cf_rep_customer_tab%ROWTYPE,
   indrec_ IN OUT NOCOPY Indicator_Rec,
   attr_   IN OUT NOCOPY VARCHAR2 );

PROCEDURE Prepare_Insert___ (
   attr_ IN OUT NOCOPY VARCHAR2 );

PROCEDURE Check_Insert___ (
   newrec_ IN OUT NOCOPY cf_rep_customer_tab%ROWTYPE,
   indrec_ IN OUT NOCOPY Indicator_Rec,
   attr_   IN OUT NOCOPY VARCHAR2 );

PROCEDURE Insert___ (
   objid_      OUT    VARCHAR2,
   objversion_ OUT    VARCHAR2,
   newrec_     IN OUT NOCOPY cf_rep_customer_tab%ROWTYPE,
   attr_       IN OUT NOCOPY VARCHAR2 );

PROCEDURE Prepare_New___ (
   newrec_ IN OUT NOCOPY cf_rep_customer_tab%ROWTYPE );

PROCEDURE New___ (
   newrec_ IN OUT NOCOPY cf_rep_customer_tab%ROWTYPE );

PROCEDURE Check_Update___ (
   oldrec_ IN     cf_rep_customer_tab%ROWTYPE,
   newrec_ IN OUT NOCOPY cf_rep_customer_tab%ROWTYPE,
   indrec_ IN OUT NOCOPY Indicator_Rec,
   attr_   IN OUT NOCOPY VARCHAR2 );

PROCEDURE Update___ (
   objid_      IN     VARCHAR2,
   oldrec_     IN     cf_rep_customer_tab%ROWTYPE,
   newrec_     IN OUT NOCOPY cf_rep_customer_tab%ROWTYPE,
   attr_       IN OUT NOCOPY VARCHAR2,
   objversion_ IN OUT NOCOPY VARCHAR2,
   by_keys_    IN     BOOLEAN DEFAULT FALSE );

PROCEDURE Modify___ (
   newrec_         IN OUT NOCOPY cf_rep_customer_tab%ROWTYPE,
   lock_mode_wait_ IN     BOOLEAN DEFAULT TRUE );

PROCEDURE Check_Delete___ (
   remrec_ IN cf_rep_customer_tab%ROWTYPE );

PROCEDURE Delete___ (
   objid_  IN VARCHAR2,
   remrec_ IN cf_rep_customer_tab%ROWTYPE );

PROCEDURE Delete___ (
   remrec_ IN cf_rep_customer_tab%ROWTYPE );

PROCEDURE Remove___ (
   remrec_         IN OUT NOCOPY cf_rep_customer_tab%ROWTYPE,
   lock_mode_wait_ IN     BOOLEAN DEFAULT TRUE );

-----------------------------------------------------------------------------
-------------------- BASE METHODS -------------------------------------------
-----------------------------------------------------------------------------

--@IgnoreMissingSysinit
FUNCTION Get_Key_By_Rowkey (
   rowkey_ IN VARCHAR2 ) RETURN cf_rep_customer_tab%ROWTYPE
IS

   FUNCTION Base (
      rowkey_ IN VARCHAR2 ) RETURN cf_rep_customer_tab%ROWTYPE
   IS
      rec_ cf_rep_customer_tab%ROWTYPE;
   BEGIN
      SELECT customer
         INTO  rec_.customer
         FROM  cf_rep_customer_tab
         WHERE rowkey = rowkey_;
      RETURN rec_;
   EXCEPTION
      WHEN no_data_found THEN
         RETURN rec_;
      WHEN too_many_rows THEN
         Raise_Too_Many_Rows___(rec_.customer, 'Get_Key_By_Rowkey');
   END Base;

BEGIN
   RETURN Base(rowkey_);
END Get_Key_By_Rowkey;


--@IgnoreMissingSysinit
PROCEDURE Exist (
   customer_ IN VARCHAR2 )
IS

   PROCEDURE Base (
      customer_ IN VARCHAR2 )
   IS
   BEGIN
      IF (NOT Check_Exist___(customer_)) THEN
         Raise_Record_Not_Exist___(customer_);
      END IF;
   END Base;

BEGIN
   Base(customer_);
END Exist;


--@IgnoreMissingSysinit
FUNCTION Exists (
   customer_ IN VARCHAR2 ) RETURN BOOLEAN
IS

   FUNCTION Base (
      customer_ IN VARCHAR2 ) RETURN BOOLEAN
   IS
   BEGIN
      RETURN Check_Exist___(customer_);
   END Base;

BEGIN
   RETURN Base(customer_);
END Exists;


--@IgnoreMissingSysinit
PROCEDURE Rowkey_Exist (
   rowkey_ IN VARCHAR2 )
IS

   PROCEDURE Base (
      rowkey_ IN VARCHAR2 )
   IS
      customer_ cf_rep_customer_tab.customer%TYPE;
   BEGIN
      SELECT customer
      INTO  customer_
      FROM  cf_rep_customer_tab
      WHERE rowkey = rowkey_;
   EXCEPTION
      WHEN no_data_found THEN
         Raise_Record_Not_Exist___(customer_);
      WHEN too_many_rows THEN
         Raise_Too_Many_Rows___(customer_, 'Rowkey_Exist___');
   END Base;

BEGIN
   Base(rowkey_);
END Rowkey_Exist;


--@IgnoreMissingSysinit
FUNCTION Get_Description (
   customer_ IN VARCHAR2 ) RETURN VARCHAR2
IS

   FUNCTION Base (
      customer_ IN VARCHAR2 ) RETURN VARCHAR2
   IS
      temp_ cf_rep_customer_tab.description%TYPE;
   BEGIN
      IF (customer_ IS NULL) THEN
         RETURN NULL;
      END IF;
      SELECT description
         INTO  temp_
         FROM  cf_rep_customer_tab
         WHERE customer = customer_;
      RETURN temp_;
   EXCEPTION
      WHEN no_data_found THEN
         RETURN NULL;
      WHEN too_many_rows THEN
         Raise_Too_Many_Rows___(customer_, 'Get_Description');
   END Base;

BEGIN
   RETURN Base(customer_);
END Get_Description;


--@IgnoreMissingSysinit
FUNCTION Get_By_Rowkey (
   rowkey_ IN VARCHAR2 ) RETURN Public_Rec
IS

   FUNCTION Base (
      rowkey_ IN VARCHAR2 ) RETURN Public_Rec
   IS
      rowrec_ cf_rep_customer_tab%ROWTYPE;
   BEGIN
      rowrec_ := Get_Key_By_Rowkey(rowkey_);
      RETURN Get(rowrec_.customer);
   END Base;

BEGIN
   RETURN Base(rowkey_);
END Get_By_Rowkey;


--@IgnoreMissingSysinit
FUNCTION Get (
   customer_ IN VARCHAR2 ) RETURN Public_Rec
IS

   FUNCTION Base (
      customer_ IN VARCHAR2 ) RETURN Public_Rec
   IS
      temp_ Public_Rec;
   BEGIN
      IF (customer_ IS NULL) THEN
         RETURN NULL;
      END IF;
      SELECT customer, rowid, rowversion, rowkey,
             description
         INTO  temp_
         FROM  cf_rep_customer_tab
         WHERE customer = customer_;
      RETURN temp_;
   EXCEPTION
      WHEN no_data_found THEN
         RETURN NULL;
      WHEN too_many_rows THEN
         Raise_Too_Many_Rows___(customer_, 'Get');
   END Base;

BEGIN
   RETURN Base(customer_);
END Get;


--@IgnoreMissingSysinit
FUNCTION Get_Objkey (
   customer_ IN VARCHAR2 ) RETURN VARCHAR2
IS

   FUNCTION Base (
      customer_ IN VARCHAR2 ) RETURN VARCHAR2
   IS
      rowkey_ cf_rep_customer_tab.rowkey%TYPE;
   BEGIN
      IF (customer_ IS NULL) THEN
         RETURN NULL;
      END IF;
      SELECT rowkey
         INTO  rowkey_
         FROM  cf_rep_customer_tab
         WHERE customer = customer_;
      RETURN rowkey_;
   EXCEPTION
      WHEN no_data_found THEN
         RETURN NULL;
      WHEN too_many_rows THEN
         Raise_Too_Many_Rows___(customer_, 'Get_Objkey');
   END Base;

BEGIN
   RETURN Base(customer_);
END Get_Objkey;


--@IgnoreMissingSysinit
PROCEDURE Lock__ (
   info_       OUT VARCHAR2,
   objid_      IN  VARCHAR2,
   objversion_ IN  VARCHAR2 )
IS

   PROCEDURE Base (
      info_       OUT VARCHAR2,
      objid_      IN  VARCHAR2,
      objversion_ IN  VARCHAR2 )
   IS
      dummy_ cf_rep_customer_tab%ROWTYPE;
   BEGIN
      dummy_ := Lock_By_Id___(objid_, objversion_);
      info_ := Client_SYS.Get_All_Info;
   END Base;

BEGIN
   Base(info_, objid_, objversion_);
END Lock__;


PROCEDURE New__ (
   info_       OUT    VARCHAR2,
   objid_      OUT    VARCHAR2,
   objversion_ OUT    VARCHAR2,
   attr_       IN OUT NOCOPY VARCHAR2,
   action_     IN     VARCHAR2 )
IS

   PROCEDURE Base (
      info_       OUT    VARCHAR2,
      objid_      OUT    VARCHAR2,
      objversion_ OUT    VARCHAR2,
      attr_       IN OUT NOCOPY VARCHAR2,
      action_     IN     VARCHAR2 )
   IS
      newrec_   cf_rep_customer_tab%ROWTYPE;
      indrec_   Indicator_Rec;
   BEGIN
      IF (action_ = 'PREPARE') THEN
         Prepare_Insert___(attr_);
      ELSIF (action_ = 'CHECK') THEN
         Prepare_New___ (newrec_);
         Unpack___(newrec_, indrec_, attr_);
         Check_Insert___(newrec_, indrec_, attr_);
      ELSIF (action_ = 'DO') THEN
         Prepare_New___ (newrec_);
         Unpack___(newrec_, indrec_, attr_);
         Check_Insert___(newrec_, indrec_, attr_);
         Insert___(objid_, objversion_, newrec_, attr_);
      END IF;
      info_ := Client_SYS.Get_All_Info;
   END Base;

BEGIN
   --General_SYS.Init_Method(Cf_Rep_Customer_API.lu_name_, 'Cf_Rep_Customer_API', 'New__');
   Base(info_, objid_, objversion_, attr_, action_);
END New__;


PROCEDURE Modify__ (
   info_       OUT    VARCHAR2,
   objid_      IN     VARCHAR2,
   objversion_ IN OUT NOCOPY VARCHAR2,
   attr_       IN OUT NOCOPY VARCHAR2,
   action_     IN     VARCHAR2 )
IS

   PROCEDURE Base (
      info_       OUT    VARCHAR2,
      objid_      IN     VARCHAR2,
      objversion_ IN OUT NOCOPY VARCHAR2,
      attr_       IN OUT NOCOPY VARCHAR2,
      action_     IN     VARCHAR2 )
   IS
      oldrec_   cf_rep_customer_tab%ROWTYPE;
      newrec_   cf_rep_customer_tab%ROWTYPE;
      indrec_   Indicator_Rec;
   BEGIN
      IF (action_ = 'CHECK') THEN
         oldrec_ := Get_Object_By_Id___(objid_);
         newrec_ := oldrec_;
         Unpack___(newrec_, indrec_, attr_);
         Check_Update___(oldrec_, newrec_, indrec_, attr_);
      ELSIF (action_ = 'DO') THEN
         oldrec_ := Lock_By_Id___(objid_, objversion_);
         newrec_ := oldrec_;
         Unpack___(newrec_, indrec_, attr_);
         Check_Update___(oldrec_, newrec_, indrec_, attr_);
         Update___(objid_, oldrec_, newrec_, attr_, objversion_);
      END IF;
      info_ := Client_SYS.Get_All_Info;
   END Base;

BEGIN
   --General_SYS.Init_Method(Cf_Rep_Customer_API.lu_name_, 'Cf_Rep_Customer_API', 'Modify__');
   Base(info_, objid_, objversion_, attr_, action_);
END Modify__;


PROCEDURE Remove__ (
   info_       OUT VARCHAR2,
   objid_      IN  VARCHAR2,
   objversion_ IN  VARCHAR2,
   action_     IN  VARCHAR2 )
IS

   PROCEDURE Base (
      info_       OUT VARCHAR2,
      objid_      IN  VARCHAR2,
      objversion_ IN  VARCHAR2,
      action_     IN  VARCHAR2 )
   IS
      remrec_ cf_rep_customer_tab%ROWTYPE;
   BEGIN
      IF (action_ = 'CHECK') THEN
         remrec_ := Get_Object_By_Id___(objid_);
         Check_Delete___(remrec_);
      ELSIF (action_ = 'DO') THEN
         remrec_ := Lock_By_Id___(objid_, objversion_);
         Check_Delete___(remrec_);
         Delete___(objid_, remrec_);
      END IF;
      info_ := Client_SYS.Get_All_Info;
   END Base;

BEGIN
   --General_SYS.Init_Method(Cf_Rep_Customer_API.lu_name_, 'Cf_Rep_Customer_API', 'Remove__');
   Base(info_, objid_, objversion_, action_);
END Remove__;


FUNCTION Key_Message___ (
   customer_ IN VARCHAR2 ) RETURN VARCHAR2
IS

   FUNCTION Base (
      customer_ IN VARCHAR2 ) RETURN VARCHAR2
   IS
      msg_ VARCHAR2(4000);
   BEGIN
      RETURN msg_;
   END Base;

BEGIN
   RETURN Base(customer_);
END Key_Message___;


FUNCTION Formatted_Key___ (
   customer_ IN VARCHAR2 ) RETURN VARCHAR2
IS

   FUNCTION Base (
      customer_ IN VARCHAR2 ) RETURN VARCHAR2
   IS
      formatted_key_ VARCHAR2(4000) := customer_;
   BEGIN
      RETURN formatted_key_;
   END Base;

BEGIN
   RETURN Base(customer_);
END Formatted_Key___;


PROCEDURE Raise_Too_Many_Rows___ (
   customer_ IN VARCHAR2,
   methodname_ IN VARCHAR2 )
IS

   PROCEDURE Base (
      customer_ IN VARCHAR2,
      methodname_ IN VARCHAR2 )
   IS
   BEGIN
      Error_SYS.Set_Key_Values(Key_Message___(customer_),
                               Formatted_Key___(customer_));
      Error_SYS.Fnd_Too_Many_Rows(Cf_Rep_Customer_API.lu_name_, methodname_, NULL);
   END Base;

BEGIN
   Base(customer_, methodname_);
END Raise_Too_Many_Rows___;


PROCEDURE Raise_Record_Not_Exist___ (
   customer_ IN VARCHAR2 )
IS

   PROCEDURE Base (
      customer_ IN VARCHAR2 )
   IS
   BEGIN
      Error_SYS.Set_Key_Values(Key_Message___(customer_),
                               Formatted_Key___(customer_));
      Error_SYS.Fnd_Record_Not_Exist(Cf_Rep_Customer_API.lu_name_);
   END Base;

BEGIN
   Base(customer_);
END Raise_Record_Not_Exist___;


PROCEDURE Raise_Record_Exist___ (
   rec_ IN cf_rep_customer_tab%ROWTYPE )
IS

   PROCEDURE Base (
      rec_ IN cf_rep_customer_tab%ROWTYPE )
   IS
   BEGIN
      Error_SYS.Set_Key_Values(Key_Message___(rec_.customer),
                               Formatted_Key___(rec_.customer));
      Error_SYS.Fnd_Record_Exist(Cf_Rep_Customer_API.lu_name_);
   END Base;

BEGIN
   Base(rec_);
END Raise_Record_Exist___;


PROCEDURE Raise_Constraint_Violated___ (
   rec_ IN cf_rep_customer_tab%ROWTYPE,
   constraint_ IN VARCHAR2 )
IS

   PROCEDURE Base (
      rec_ IN cf_rep_customer_tab%ROWTYPE,
      constraint_ IN VARCHAR2 )
   IS
   BEGIN
      Error_SYS.Fnd_Record_Exist(Cf_Rep_Customer_API.lu_name_);
   END Base;

BEGIN
   Base(rec_, constraint_);
END Raise_Constraint_Violated___;


PROCEDURE Raise_Item_Format___ (
   name_ IN VARCHAR2,
   value_ IN VARCHAR2 )
IS

   PROCEDURE Base (
      name_ IN VARCHAR2,
      value_ IN VARCHAR2 )
   IS
   BEGIN
      Error_SYS.Fnd_Item_Format(Cf_Rep_Customer_API.lu_name_, name_, value_);
   END Base;

BEGIN
   Base(name_, value_);
END Raise_Item_Format___;


PROCEDURE Raise_Record_Modified___ (
   rec_ IN cf_rep_customer_tab%ROWTYPE )
IS

   PROCEDURE Base (
      rec_ IN cf_rep_customer_tab%ROWTYPE )
   IS
   BEGIN
      Error_SYS.Set_Key_Values(Key_Message___(rec_.customer),
                               Formatted_Key___(rec_.customer));
      Error_SYS.Fnd_Record_Modified(Cf_Rep_Customer_API.lu_name_);
   END Base;

BEGIN
   Base(rec_);
END Raise_Record_Modified___;


PROCEDURE Raise_Record_Locked___ (
   customer_ IN VARCHAR2 )
IS

   PROCEDURE Base (
      customer_ IN VARCHAR2 )
   IS
   BEGIN
      Error_SYS.Set_Key_Values(Key_Message___(customer_),
                               Formatted_Key___(customer_));
      Error_SYS.Fnd_Record_Locked(Cf_Rep_Customer_API.lu_name_);
   END Base;

BEGIN
   Base(customer_);
END Raise_Record_Locked___;


PROCEDURE Raise_Record_Removed___ (
   customer_ IN VARCHAR2 )
IS

   PROCEDURE Base (
      customer_ IN VARCHAR2 )
   IS
   BEGIN
      Error_SYS.Set_Key_Values(Key_Message___(customer_),
                               Formatted_Key___(customer_));
      Error_SYS.Fnd_Record_Removed(Cf_Rep_Customer_API.lu_name_);
   END Base;

BEGIN
   Base(customer_);
END Raise_Record_Removed___;


FUNCTION Lock_By_Id___ (
   objid_      IN VARCHAR2,
   objversion_ IN VARCHAR2 ) RETURN cf_rep_customer_tab%ROWTYPE
IS

   FUNCTION Base (
      objid_      IN VARCHAR2,
      objversion_ IN VARCHAR2 ) RETURN cf_rep_customer_tab%ROWTYPE
   IS
      row_locked  EXCEPTION;
      PRAGMA      EXCEPTION_INIT(row_locked, -0054);
      rec_        cf_rep_customer_tab%ROWTYPE;
   BEGIN
      SELECT *
         INTO  rec_
         FROM  cf_rep_customer_tab
         WHERE rowid = objid_
         AND    to_char(rowversion,'YYYYMMDDHH24MISS') = objversion_
         FOR UPDATE NOWAIT;
      RETURN rec_;
   EXCEPTION
      WHEN row_locked THEN
         Error_SYS.Fnd_Record_Locked(lu_name_);
      WHEN too_many_rows THEN
         Raise_Too_Many_Rows___(NULL, 'Lock_By_Id___');
      WHEN no_data_found THEN
         BEGIN
            SELECT *
               INTO  rec_
               FROM  cf_rep_customer_tab
               WHERE rowid = objid_;
            Raise_Record_Modified___(rec_);
         EXCEPTION
            WHEN no_data_found THEN
               Error_SYS.Fnd_Record_Removed(lu_name_);
            WHEN too_many_rows THEN
               Raise_Too_Many_Rows___(NULL, 'Lock_By_Id___');
         END;
   END Base;

BEGIN
   RETURN Base(objid_, objversion_);
END Lock_By_Id___;


FUNCTION Lock_By_Keys___ (
   customer_ IN VARCHAR2) RETURN cf_rep_customer_tab%ROWTYPE
IS

   FUNCTION Base (
      customer_ IN VARCHAR2) RETURN cf_rep_customer_tab%ROWTYPE
   IS
      rec_        cf_rep_customer_tab%ROWTYPE;
   BEGIN
      BEGIN
         SELECT *
            INTO  rec_
            FROM  cf_rep_customer_tab
            WHERE customer = customer_
            FOR UPDATE;
         RETURN rec_;
      EXCEPTION
         WHEN no_data_found THEN
            Raise_Record_Removed___(customer_);
         WHEN too_many_rows THEN
            Raise_Too_Many_Rows___(customer_, 'Lock_By_Keys___');
      END;
   END Base;

BEGIN
   RETURN Base(customer_);
END Lock_By_Keys___;


FUNCTION Lock_By_Keys_Nowait___ (
   customer_ IN VARCHAR2) RETURN cf_rep_customer_tab%ROWTYPE
IS

   FUNCTION Base (
      customer_ IN VARCHAR2) RETURN cf_rep_customer_tab%ROWTYPE
   IS
      row_locked  EXCEPTION;
      PRAGMA      EXCEPTION_INIT(row_locked, -0054);
      rec_        cf_rep_customer_tab%ROWTYPE;
   BEGIN
      BEGIN
         SELECT *
            INTO  rec_
            FROM  cf_rep_customer_tab
            WHERE customer = customer_
            FOR UPDATE NOWAIT;
         RETURN rec_;
      EXCEPTION
         WHEN row_locked THEN
            Raise_Record_Locked___(customer_);
         WHEN too_many_rows THEN
            Raise_Too_Many_Rows___(customer_, 'Lock_By_Keys___');
         WHEN no_data_found THEN
            Raise_Record_Removed___(customer_);
      END;
   END Base;

BEGIN
   RETURN Base(customer_);
END Lock_By_Keys_Nowait___;


FUNCTION Get_Object_By_Id___ (
   objid_ IN VARCHAR2 ) RETURN cf_rep_customer_tab%ROWTYPE
IS

   FUNCTION Base (
      objid_ IN VARCHAR2 ) RETURN cf_rep_customer_tab%ROWTYPE
   IS
      lu_rec_ cf_rep_customer_tab%ROWTYPE;
   BEGIN
      SELECT *
         INTO  lu_rec_
         FROM  cf_rep_customer_tab
         WHERE rowid = objid_;
      RETURN lu_rec_;
   EXCEPTION
      WHEN no_data_found THEN
         Error_SYS.Fnd_Record_Removed(lu_name_);
      WHEN too_many_rows THEN
         Raise_Too_Many_Rows___(NULL, 'Get_Object_By_Id___');
   END Base;

BEGIN
   RETURN Base(objid_);
END Get_Object_By_Id___;


--@IgnoreMissingSysinit
FUNCTION Get_Object_By_Keys___ (
   customer_ IN VARCHAR2 ) RETURN cf_rep_customer_tab%ROWTYPE
IS

   FUNCTION Base (
      customer_ IN VARCHAR2 ) RETURN cf_rep_customer_tab%ROWTYPE
   IS
      lu_rec_ cf_rep_customer_tab%ROWTYPE;
   BEGIN
      SELECT *
         INTO  lu_rec_
         FROM  cf_rep_customer_tab
         WHERE customer = customer_;
      RETURN lu_rec_;
   EXCEPTION
      WHEN no_data_found THEN
         RETURN lu_rec_;
      WHEN too_many_rows THEN
         Raise_Too_Many_Rows___(customer_, 'Get_Object_By_Keys___');
   END Base;

BEGIN
   RETURN Base(customer_);
END Get_Object_By_Keys___;


--@IgnoreMissingSysinit
FUNCTION Check_Exist___ (
   customer_ IN VARCHAR2 ) RETURN BOOLEAN
IS

   FUNCTION Base (
      customer_ IN VARCHAR2 ) RETURN BOOLEAN
   IS
      dummy_ NUMBER;
   BEGIN
      SELECT 1
         INTO  dummy_
         FROM  cf_rep_customer_tab
         WHERE customer = customer_;
      RETURN TRUE;
   EXCEPTION
      WHEN no_data_found THEN
         RETURN FALSE;
      WHEN too_many_rows THEN
         Raise_Too_Many_Rows___(customer_, 'Check_Exist___');
   END Base;

BEGIN
   RETURN Base(customer_);
END Check_Exist___;


PROCEDURE Get_Version_By_Id___ (
   objid_      IN     VARCHAR2,
   objversion_ IN OUT NOCOPY VARCHAR2 )
IS

   PROCEDURE Base (
      objid_      IN     VARCHAR2,
      objversion_ IN OUT NOCOPY VARCHAR2 )
   IS
   BEGIN
      SELECT to_char(rowversion,'YYYYMMDDHH24MISS')
         INTO  objversion_
         FROM  cf_rep_customer_tab
         WHERE rowid = objid_;
   EXCEPTION
      WHEN no_data_found THEN
         objversion_ := NULL;
      WHEN too_many_rows THEN
         Raise_Too_Many_Rows___(NULL, 'Get_Version_By_Id___');
   END Base;

BEGIN
   Base(objid_, objversion_);
END Get_Version_By_Id___;


PROCEDURE Get_Id_Version_By_Keys___ (
   objid_      IN OUT NOCOPY VARCHAR2,
   objversion_ IN OUT NOCOPY VARCHAR2,
   customer_ IN VARCHAR2 )
IS

   PROCEDURE Base (
      objid_      IN OUT NOCOPY VARCHAR2,
      objversion_ IN OUT NOCOPY VARCHAR2,
      customer_ IN VARCHAR2 )
   IS
   BEGIN
      SELECT rowid, to_char(rowversion,'YYYYMMDDHH24MISS')
         INTO  objid_, objversion_
         FROM  cf_rep_customer_tab
         WHERE customer = customer_;
   EXCEPTION
      WHEN no_data_found THEN
         objid_      := NULL;
         objversion_ := NULL;
      WHEN too_many_rows THEN
         Raise_Too_Many_Rows___(customer_, 'Get_Id_Version_By_Keys___');
   END Base;

BEGIN
   Base(objid_, objversion_, customer_);
END Get_Id_Version_By_Keys___;


PROCEDURE Unpack___ (
   newrec_   IN OUT NOCOPY cf_rep_customer_tab%ROWTYPE,
   indrec_   IN OUT NOCOPY Indicator_Rec,
   attr_     IN OUT NOCOPY VARCHAR2 )
IS

   PROCEDURE Base (
      newrec_   IN OUT NOCOPY cf_rep_customer_tab%ROWTYPE,
      indrec_   IN OUT NOCOPY Indicator_Rec,
      attr_     IN OUT NOCOPY VARCHAR2 )
   IS
      ptr_   NUMBER;
      name_  VARCHAR2(308);
      value_ VARCHAR2(32000);
      msg_   VARCHAR2(32000);
   BEGIN
      Reset_Indicator_Rec___(indrec_);
      Client_SYS.Clear_Attr(msg_);
      ptr_ := NULL;
      WHILE (Client_SYS.Get_Next_From_Attr(attr_, ptr_, name_, value_)) LOOP
         CASE name_
         WHEN ('CUSTOMER') THEN
            newrec_.customer := value_;
            indrec_.customer := TRUE;
         WHEN ('DESCRIPTION') THEN
            newrec_.description := value_;
            indrec_.description := TRUE;
         ELSE
            Client_SYS.Add_To_Attr(name_, value_, msg_);
         END CASE;
      END LOOP;
      attr_ := msg_;
   EXCEPTION
      WHEN value_error THEN
         Raise_Item_Format___(name_, value_);
   END Base;

BEGIN
   Base(newrec_, indrec_, attr_);
END Unpack___;


FUNCTION Pack___ (
   rec_ IN cf_rep_customer_tab%ROWTYPE ) RETURN VARCHAR2
IS

   FUNCTION Base (
      rec_ IN cf_rep_customer_tab%ROWTYPE ) RETURN VARCHAR2
   IS
      attr_ VARCHAR2(32000);
   BEGIN
      Client_SYS.Clear_Attr(attr_);
      IF (rec_.customer IS NOT NULL) THEN
         Client_SYS.Add_To_Attr('CUSTOMER', rec_.customer, attr_);
      END IF;
      IF (rec_.description IS NOT NULL) THEN
         Client_SYS.Add_To_Attr('DESCRIPTION', rec_.description, attr_);
      END IF;
      RETURN attr_;
   END Base;

BEGIN
   RETURN Base(rec_);
END Pack___;


FUNCTION Pack___ (
   rec_ IN cf_rep_customer_tab%ROWTYPE,
   indrec_ IN Indicator_Rec ) RETURN VARCHAR2
IS

   FUNCTION Base (
      rec_ IN cf_rep_customer_tab%ROWTYPE,
      indrec_ IN Indicator_Rec ) RETURN VARCHAR2
   IS
      attr_ VARCHAR2(32000);
   BEGIN
      Client_SYS.Clear_Attr(attr_);
      IF (indrec_.customer) THEN
         Client_SYS.Add_To_Attr('CUSTOMER', rec_.customer, attr_);
      END IF;
      IF (indrec_.description) THEN
         Client_SYS.Add_To_Attr('DESCRIPTION', rec_.description, attr_);
      END IF;
      RETURN attr_;
   END Base;

BEGIN
   RETURN Base(rec_, indrec_);
END Pack___;


FUNCTION Pack_Table___ (
   rec_ IN cf_rep_customer_tab%ROWTYPE ) RETURN VARCHAR2
IS

   FUNCTION Base (
      rec_ IN cf_rep_customer_tab%ROWTYPE ) RETURN VARCHAR2
   IS
      attr_ VARCHAR2(32000);
   BEGIN
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('CUSTOMER', rec_.customer, attr_);
      Client_SYS.Add_To_Attr('DESCRIPTION', rec_.description, attr_);
      Client_SYS.Add_To_Attr('ROWKEY', rec_.rowkey, attr_);
      RETURN attr_;
   END Base;

BEGIN
   RETURN Base(rec_);
END Pack_Table___;


FUNCTION Public_To_Table___ (
   public_ IN Public_Rec ) RETURN cf_rep_customer_tab%ROWTYPE
IS

   FUNCTION Base (
      public_ IN Public_Rec ) RETURN cf_rep_customer_tab%ROWTYPE
   IS
      rec_ cf_rep_customer_tab%ROWTYPE;
   BEGIN
      rec_.rowversion                     := public_.rowversion;
      rec_.rowkey                         := public_.rowkey;
      rec_.customer                       := public_.customer;
      rec_.description                    := public_.description;
      RETURN rec_;
   END Base;

BEGIN
   RETURN Base(public_);
END Public_To_Table___;


FUNCTION Table_To_Public___ (
   rec_ IN cf_rep_customer_tab%ROWTYPE ) RETURN Public_Rec
IS

   FUNCTION Base (
      rec_ IN cf_rep_customer_tab%ROWTYPE ) RETURN Public_Rec
   IS
      public_ Public_Rec;
   BEGIN
      public_.rowversion                     := rec_.rowversion;
      public_.rowkey                         := rec_.rowkey;
      public_.customer                       := rec_.customer;
      public_.description                    := rec_.description;
      RETURN public_;
   END Base;

BEGIN
   RETURN Base(rec_);
END Table_To_Public___;


PROCEDURE Reset_Indicator_Rec___ (
   indrec_ IN OUT NOCOPY Indicator_Rec )
IS

   PROCEDURE Base (
      indrec_ IN OUT NOCOPY Indicator_Rec )
   IS
      empty_indrec_ Indicator_Rec;
   BEGIN
      indrec_ := empty_indrec_;
   END Base;

BEGIN
   Base(indrec_);
END Reset_Indicator_Rec___;


FUNCTION Get_Indicator_Rec___ (
   rec_ IN cf_rep_customer_tab%ROWTYPE ) RETURN Indicator_Rec
IS

   FUNCTION Base (
      rec_ IN cf_rep_customer_tab%ROWTYPE ) RETURN Indicator_Rec
   IS
      indrec_ Indicator_Rec;
   BEGIN
      indrec_.customer := rec_.customer IS NOT NULL;
      indrec_.description := rec_.description IS NOT NULL;
      RETURN indrec_;
   END Base;

BEGIN
   RETURN Base(rec_);
END Get_Indicator_Rec___;


FUNCTION Get_Indicator_Rec___ (
   oldrec_ IN cf_rep_customer_tab%ROWTYPE,
   newrec_ IN cf_rep_customer_tab%ROWTYPE ) RETURN Indicator_Rec
IS

   FUNCTION Base (
      oldrec_ IN cf_rep_customer_tab%ROWTYPE,
      newrec_ IN cf_rep_customer_tab%ROWTYPE ) RETURN Indicator_Rec
   IS
      indrec_ Indicator_Rec;
   BEGIN
      indrec_.customer := false;
      indrec_.description := false;
      RETURN indrec_;
   END Base;

BEGIN
   RETURN Base(oldrec_, newrec_);
END Get_Indicator_Rec___;


PROCEDURE Check_Common___ (
   oldrec_ IN     cf_rep_customer_tab%ROWTYPE,
   newrec_ IN OUT NOCOPY cf_rep_customer_tab%ROWTYPE,
   indrec_ IN OUT NOCOPY Indicator_Rec,
   attr_   IN OUT NOCOPY VARCHAR2 )
IS

   PROCEDURE Base (
      oldrec_ IN     cf_rep_customer_tab%ROWTYPE,
      newrec_ IN OUT NOCOPY cf_rep_customer_tab%ROWTYPE,
      indrec_ IN OUT NOCOPY Indicator_Rec,
      attr_   IN OUT NOCOPY VARCHAR2 )
   IS
   BEGIN
      Error_SYS.Check_Not_Null(lu_name_, 'CUSTOMER', newrec_.customer);
   END Base;

BEGIN
   Base(oldrec_, newrec_, indrec_, attr_);
END Check_Common___;


PROCEDURE Prepare_Insert___ (
   attr_ IN OUT NOCOPY VARCHAR2 )
IS

   PROCEDURE Base (
      attr_ IN OUT NOCOPY VARCHAR2 )
   IS
   BEGIN
      Client_SYS.Clear_Attr(attr_);
   END Base;

BEGIN
   Base(attr_);
END Prepare_Insert___;


PROCEDURE Check_Insert___ (
   newrec_ IN OUT NOCOPY cf_rep_customer_tab%ROWTYPE,
   indrec_ IN OUT NOCOPY Indicator_Rec,
   attr_   IN OUT NOCOPY VARCHAR2 )
IS

   PROCEDURE Base (
      newrec_ IN OUT NOCOPY cf_rep_customer_tab%ROWTYPE,
      indrec_ IN OUT NOCOPY Indicator_Rec,
      attr_   IN OUT NOCOPY VARCHAR2 )
   IS
      oldrec_ cf_rep_customer_tab%ROWTYPE;
   BEGIN
      Check_Common___(oldrec_, newrec_, indrec_, attr_);
   END Base;

BEGIN
   Base(newrec_, indrec_, attr_);
END Check_Insert___;


PROCEDURE Insert___ (
   objid_      OUT    VARCHAR2,
   objversion_ OUT    VARCHAR2,
   newrec_     IN OUT NOCOPY cf_rep_customer_tab%ROWTYPE,
   attr_       IN OUT NOCOPY VARCHAR2 )
IS

   PROCEDURE Base (
      objid_      OUT    VARCHAR2,
      objversion_ OUT    VARCHAR2,
      newrec_     IN OUT NOCOPY cf_rep_customer_tab%ROWTYPE,
      attr_       IN OUT NOCOPY VARCHAR2 )
   IS
   BEGIN
      newrec_.rowversion := sysdate;
      newrec_.rowkey := sys_guid();
      Client_SYS.Add_To_Attr('OBJKEY', newrec_.rowkey, attr_);
      INSERT
         INTO cf_rep_customer_tab
         VALUES newrec_
         RETURNING rowid INTO objid_;
      objversion_ := to_char(newrec_.rowversion,'YYYYMMDDHH24MISS');
   EXCEPTION
      WHEN dup_val_on_index THEN
         DECLARE
            constraint_ VARCHAR2(4000) :=sqlerrm;
         BEGIN
            IF (constraint_ = 'CF_REP_CUSTOMER_RK') THEN
               Error_SYS.Fnd_Rowkey_Exist(lu_name_, newrec_.rowkey);
            ELSIF (constraint_ = 'CF_REP_CUSTOMER_PK') THEN
               Raise_Record_Exist___(newrec_);
            ELSE
               Raise_Constraint_Violated___(newrec_, constraint_);
            END IF;
         END;
   END Base;

BEGIN
   Base(objid_, objversion_, newrec_, attr_);
END Insert___;


PROCEDURE Prepare_New___ (
   newrec_ IN OUT NOCOPY cf_rep_customer_tab%ROWTYPE )
IS

   PROCEDURE Base (
      newrec_ IN OUT NOCOPY cf_rep_customer_tab%ROWTYPE )
   IS
      attr_    VARCHAR2(32000);
      indrec_  Indicator_Rec;
   BEGIN
      Prepare_Insert___(attr_);
      Unpack___(newrec_, indrec_, attr_);
   END Base;

BEGIN
   Base(newrec_);
END Prepare_New___;


PROCEDURE New___ (
   newrec_ IN OUT NOCOPY cf_rep_customer_tab%ROWTYPE )
IS

   PROCEDURE Base (
      newrec_ IN OUT NOCOPY cf_rep_customer_tab%ROWTYPE )
   IS
      objid_         VARCHAR2(20);
      objversion_    VARCHAR2(100);
      attr_          VARCHAR2(32000);
      indrec_        Indicator_Rec;
   BEGIN
      indrec_ := Get_Indicator_Rec___(newrec_);
      Check_Insert___(newrec_, indrec_, attr_);
      Insert___(objid_, objversion_, newrec_, attr_);
   END Base;

BEGIN
   Base(newrec_);
END New___;


PROCEDURE Check_Update___ (
   oldrec_ IN     cf_rep_customer_tab%ROWTYPE,
   newrec_ IN OUT NOCOPY cf_rep_customer_tab%ROWTYPE,
   indrec_ IN OUT NOCOPY Indicator_Rec,
   attr_   IN OUT NOCOPY VARCHAR2 )
IS

   PROCEDURE Base (
      oldrec_ IN     cf_rep_customer_tab%ROWTYPE,
      newrec_ IN OUT NOCOPY cf_rep_customer_tab%ROWTYPE,
      indrec_ IN OUT NOCOPY Indicator_Rec,
      attr_   IN OUT NOCOPY VARCHAR2 )
   IS
   BEGIN
      --Validate_SYS.Item_Update(lu_name_, 'CUSTOMER', indrec_.customer);
      Check_Common___(oldrec_, newrec_, indrec_, attr_);
   END Base;

BEGIN
   Base(oldrec_, newrec_, indrec_, attr_);
END Check_Update___;


PROCEDURE Update___ (
   objid_      IN     VARCHAR2,
   oldrec_     IN     cf_rep_customer_tab%ROWTYPE,
   newrec_     IN OUT NOCOPY cf_rep_customer_tab%ROWTYPE,
   attr_       IN OUT NOCOPY VARCHAR2,
   objversion_ IN OUT NOCOPY VARCHAR2,
   by_keys_    IN     BOOLEAN DEFAULT FALSE )
IS

   PROCEDURE Base (
      objid_      IN     VARCHAR2,
      oldrec_     IN     cf_rep_customer_tab%ROWTYPE,
      newrec_     IN OUT NOCOPY cf_rep_customer_tab%ROWTYPE,
      attr_       IN OUT NOCOPY VARCHAR2,
      objversion_ IN OUT NOCOPY VARCHAR2,
      by_keys_    IN     BOOLEAN DEFAULT FALSE )
   IS
   BEGIN
      newrec_.rowversion := sysdate;
      IF by_keys_ THEN
         UPDATE cf_rep_customer_tab
            SET ROW = newrec_
            WHERE customer = newrec_.customer;
      ELSE
         UPDATE cf_rep_customer_tab
            SET ROW = newrec_
            WHERE rowid = objid_;
      END IF;
      objversion_ := to_char(newrec_.rowversion,'YYYYMMDDHH24MISS');
   EXCEPTION
      WHEN dup_val_on_index THEN
         DECLARE
            constraint_ VARCHAR2(4000) := sqlerrm;
         BEGIN
            IF (constraint_ = 'CF_REP_CUSTOMER_RK') THEN
               Error_SYS.Fnd_Rowkey_Exist(Cf_Rep_Customer_API.lu_name_, newrec_.rowkey);
            ELSIF (constraint_ = 'CF_REP_CUSTOMER_PK') THEN
               Raise_Record_Exist___(newrec_);
            ELSE
               Raise_Constraint_Violated___(newrec_, constraint_);
            END IF;
         END;
   END Base;

BEGIN
   Base(objid_, oldrec_, newrec_, attr_, objversion_, by_keys_);
END Update___;


PROCEDURE Modify___ (
   newrec_         IN OUT NOCOPY cf_rep_customer_tab%ROWTYPE,
   lock_mode_wait_ IN     BOOLEAN DEFAULT TRUE )
IS

   PROCEDURE Base (
      newrec_         IN OUT NOCOPY cf_rep_customer_tab%ROWTYPE,
      lock_mode_wait_ IN     BOOLEAN DEFAULT TRUE )
   IS
      objid_      VARCHAR2(20);
      objversion_ VARCHAR2(100);
      attr_       VARCHAR2(32000);
      indrec_     Indicator_rec;
      oldrec_     cf_rep_customer_tab%ROWTYPE;
   BEGIN
      IF (lock_mode_wait_) THEN
         oldrec_ := Lock_By_Keys___(newrec_.customer);
      ELSE
         oldrec_ := Lock_By_Keys_Nowait___(newrec_.customer);
      END IF;
      indrec_ := Get_Indicator_Rec___(oldrec_, newrec_);
      Check_Update___(oldrec_, newrec_, indrec_, attr_);
      Update___(objid_, oldrec_, newrec_, attr_, objversion_, TRUE);
   END Base;

BEGIN
   Base(newrec_, lock_mode_wait_);
END Modify___;


PROCEDURE Check_Delete___ (
   remrec_ IN cf_rep_customer_tab%ROWTYPE )
IS

   PROCEDURE Base (
      remrec_ IN cf_rep_customer_tab%ROWTYPE )
   IS
      key_ VARCHAR2(2000);
   BEGIN
      key_ := remrec_.customer||'^';
      --Reference_SYS.Check_Restricted_Delete(lu_name_, key_);
   END Base;

BEGIN
   Base(remrec_);
END Check_Delete___;


PROCEDURE Delete___ (
   objid_  IN VARCHAR2,
   remrec_ IN cf_rep_customer_tab%ROWTYPE )
IS

   PROCEDURE Base (
      objid_  IN VARCHAR2,
      remrec_ IN cf_rep_customer_tab%ROWTYPE )
   IS
      key_ VARCHAR2(2000);
   BEGIN
      key_ := remrec_.customer||'^';
      --Reference_SYS.Do_Cascade_Delete(lu_name_, key_);
      IF (objid_ IS NOT NULL) THEN
         DELETE
            FROM  cf_rep_customer_tab
            WHERE rowid = objid_;
      ELSE
         DELETE
            FROM  cf_rep_customer_tab
            WHERE customer = remrec_.customer;
      END IF;
   END Base;

BEGIN
   Base(objid_, remrec_);
END Delete___;


PROCEDURE Delete___ (
   remrec_ IN cf_rep_customer_tab%ROWTYPE )
IS

   PROCEDURE Base (
      remrec_ IN cf_rep_customer_tab%ROWTYPE )
   IS
   BEGIN
      Delete___(NULL, remrec_);
   END Base;

BEGIN
   Base(remrec_);
END Delete___;


PROCEDURE Remove___ (
   remrec_         IN OUT NOCOPY cf_rep_customer_tab%ROWTYPE,
   lock_mode_wait_ IN     BOOLEAN DEFAULT TRUE )
IS

   PROCEDURE Base (
      remrec_         IN OUT NOCOPY cf_rep_customer_tab%ROWTYPE,
      lock_mode_wait_ IN     BOOLEAN DEFAULT TRUE )
   IS
      oldrec_     cf_rep_customer_tab%ROWTYPE;
   BEGIN
      IF (lock_mode_wait_) THEN
         oldrec_ := Lock_By_Keys___(remrec_.customer);
      ELSE
         oldrec_ := Lock_By_Keys_Nowait___(remrec_.customer);
      END IF;
      Check_Delete___(oldrec_);
      Delete___(NULL, oldrec_);
   END Base;

BEGIN
   Base(remrec_, lock_mode_wait_);
END Remove___;

-----------------------------------------------------------------------------
-------------------- FOUNDATION1 METHODS ------------------------------------
-----------------------------------------------------------------------------


--@IgnoreMissingSysinit
PROCEDURE Init
IS

   PROCEDURE Base
   IS
   BEGIN
      NULL;
   END Base;

BEGIN
   Base;
END Init;

BEGIN
   Init;
END Cf_Rep_Customer_API;
-- [END A7 COMPLETE BLOCK]
/


--
-- CF_REP_DP_STATE_API  (Package Body) 
--
--  Dependencies: 
--   CF_REP_DP_STATE_API (Package)
--   STANDARD (Package)
--   DOMAIN_SYS (Package)
--
CREATE OR REPLACE PACKAGE BODY VTAPP.Cf_Rep_Dp_State_API IS

-----------------------------------------------------------------------------
-------------------- PRIVATE DECLARATIONS -----------------------------------
-----------------------------------------------------------------------------


-----------------------------------------------------------------------------
-------------------- IMPLEMENTATION METHOD DECLARATIONS ---------------------
-----------------------------------------------------------------------------

FUNCTION Get_Db_Values___ RETURN VARCHAR2 DETERMINISTIC;

FUNCTION Get_Client_Values___ RETURN VARCHAR2 DETERMINISTIC;

-----------------------------------------------------------------------------
-------------------- BASE METHODS -------------------------------------------
-----------------------------------------------------------------------------

--@IgnoreMissingSysinit
PROCEDURE Exist (
   client_value_ IN VARCHAR2 )
IS
   
   PROCEDURE Base (
      client_value_ IN VARCHAR2 )
   IS
   BEGIN
      Domain_SYS.Exist_(lu_name_, Domain_SYS.Get_Translated_Values(lu_name_), client_value_);
   END Base;

BEGIN
   Base(client_value_);
END Exist;


--@IgnoreMissingSysinit
PROCEDURE Exist_List (
   client_list_ IN VARCHAR2 )
IS
   
   PROCEDURE Base (
      client_list_ IN VARCHAR2 )
   IS
   BEGIN
      Domain_SYS.Exist_List_(lu_name_, Domain_SYS.Get_Translated_Values(lu_name_), client_list_);
   END Base;

BEGIN
   Base(client_list_);
END Exist_List;


--@IgnoreMissingSysinit
PROCEDURE Exist_Db (
   db_value_ IN VARCHAR2 )
IS
   
   PROCEDURE Base (
      db_value_ IN VARCHAR2 )
   IS
   BEGIN
      Domain_SYS.Exist_(lu_name_, Get_Db_Values___, db_value_);
   END Base;

BEGIN
   Base(db_value_);
END Exist_Db;


--@IgnoreMissingSysinit
PROCEDURE Exist_List_Db (
   db_list_ IN VARCHAR2 )
IS
   
   PROCEDURE Base (
      db_list_ IN VARCHAR2 )
   IS
   BEGIN
      Domain_SYS.Exist_List_Db_(lu_name_, Get_Db_Values___, db_list_);
   END Base;

BEGIN
   Base(db_list_);
END Exist_List_Db;


--@IgnoreMissingSysinit
FUNCTION Exists (
   client_value_ IN VARCHAR2 ) RETURN BOOLEAN
IS
   
   FUNCTION Base (
      client_value_ IN VARCHAR2 ) RETURN BOOLEAN
   IS
   BEGIN
      RETURN Domain_SYS.Exist_(lu_name_, Domain_SYS.Get_Translated_Values(lu_name_), client_value_);
   END Base;

BEGIN
   RETURN Base(client_value_);
END Exists;


--@IgnoreMissingSysinit
FUNCTION Exists_List (
   client_list_ IN VARCHAR2 ) RETURN BOOLEAN
IS
   
   FUNCTION Base (
      client_list_ IN VARCHAR2 ) RETURN BOOLEAN
   IS
   BEGIN
      RETURN Domain_SYS.Exist_List_(lu_name_, Domain_SYS.Get_Translated_Values(lu_name_), client_list_);
   END Base;

BEGIN
   RETURN Base(client_list_);
END Exists_List;


--@IgnoreMissingSysinit
FUNCTION Exists_Db (
   db_value_ IN VARCHAR2 ) RETURN BOOLEAN
IS
   
   FUNCTION Base (
      db_value_ IN VARCHAR2 ) RETURN BOOLEAN
   IS
   BEGIN
      RETURN Domain_SYS.Exist_(lu_name_, Get_Db_Values___, db_value_);
   END Base;

BEGIN
   RETURN Base(db_value_);
END Exists_Db;


--@IgnoreMissingSysinit
FUNCTION Exists_List_Db (
   db_list_ IN VARCHAR2 ) RETURN BOOLEAN
IS
   
   FUNCTION Base (
      db_list_ IN VARCHAR2 ) RETURN BOOLEAN
   IS
   BEGIN
      RETURN Domain_SYS.Exist_List_Db_(lu_name_, Get_Db_Values___, db_list_);
   END Base;

BEGIN
   RETURN Base(db_list_);
END Exists_List_Db;


--@IgnoreMissingSysinit
PROCEDURE Enumerate (
   client_values_ OUT VARCHAR2)
IS
   
   PROCEDURE Base (
      client_values_ OUT VARCHAR2)
   IS
   BEGIN
      client_values_ := Domain_SYS.Enumerate_(Domain_SYS.Get_Translated_Values(lu_name_));
   END Base;

BEGIN
   Base(client_values_);
END Enumerate;


--@IgnoreMissingSysinit
PROCEDURE Enumerate_Db (
   db_values_ OUT VARCHAR2)
IS
   
   PROCEDURE Base (
      db_values_ OUT VARCHAR2)
   IS
   BEGIN
      db_values_ := Domain_SYS.Enumerate_(Get_Db_Values___);
   END Base;

BEGIN
   Base(db_values_);
END Enumerate_Db;


--@IgnoreMissingSysinit
PROCEDURE Enumerate_Client_And_Db (
   client_values_ OUT VARCHAR2,
   db_values_     OUT VARCHAR2)
IS
   
   PROCEDURE Base (
      client_values_ OUT VARCHAR2,
      db_values_     OUT VARCHAR2)
   IS
   BEGIN
      Enumerate(client_values_);
      Enumerate_Db(db_values_);
   END Base;

BEGIN
   Base(client_values_, db_values_);
END Enumerate_Client_And_Db;


--@IgnoreMissingSysinit
FUNCTION Encode (
   client_value_ IN VARCHAR2 ) RETURN VARCHAR2
IS
   
   FUNCTION Base (
      client_value_ IN VARCHAR2 ) RETURN VARCHAR2
   IS
   BEGIN
      RETURN Domain_SYS.Encode_(Domain_SYS.Get_Translated_Values(lu_name_), Get_Db_Values___, client_value_);
   END Base;

BEGIN
   RETURN Base(client_value_);
END Encode;


--@IgnoreMissingSysinit
FUNCTION Encode_List (
   client_list_ IN VARCHAR2 ) RETURN VARCHAR2
IS
   
   FUNCTION Base (
      client_list_ IN VARCHAR2 ) RETURN VARCHAR2
   IS
   BEGIN
      RETURN Domain_SYS.Encode_List_(Domain_SYS.Get_Translated_Values(lu_name_), Get_Db_Values___, client_list_);
   END Base;

BEGIN
   RETURN Base(client_list_);
END Encode_List;


--@IgnoreMissingSysinit
FUNCTION Decode (
   db_value_ IN VARCHAR2 ) RETURN VARCHAR2
IS
   
   FUNCTION Base (
      db_value_ IN VARCHAR2 ) RETURN VARCHAR2
   IS
   BEGIN
      RETURN Domain_SYS.Decode_(Domain_SYS.Get_Translated_Values(lu_name_), Get_Db_Values___, db_value_);
   END Base;

BEGIN
   RETURN Base(db_value_);
END Decode;


--@IgnoreMissingSysinit
FUNCTION Decode_List (
   db_list_ IN VARCHAR2 ) RETURN VARCHAR2
IS
   
   FUNCTION Base (
      db_list_ IN VARCHAR2 ) RETURN VARCHAR2
   IS
   BEGIN
      RETURN Domain_SYS.Decode_List_(Domain_SYS.Get_Translated_Values(lu_name_), Get_Db_Values___, db_list_);
   END Base;

BEGIN
   RETURN Base(db_list_);
END Decode_List;


--@IgnoreMissingSysinit
FUNCTION Get_Client_Value (
   index_ IN NUMBER ) RETURN VARCHAR2
IS
   
   FUNCTION Base (
      index_ IN NUMBER ) RETURN VARCHAR2
   IS
   BEGIN
      RETURN(Domain_SYS.Get_Client_Value_(Domain_SYS.Get_Translated_Values(lu_name_), index_));
   END Base;

BEGIN
   RETURN Base(index_);
END Get_Client_Value;


--@IgnoreMissingSysinit
FUNCTION Get_Db_Value (
   index_ IN NUMBER ) RETURN VARCHAR2
IS
   
   FUNCTION Base (
      index_ IN NUMBER ) RETURN VARCHAR2
   IS
   BEGIN
      RETURN(Domain_SYS.Get_Db_Value_(Get_Db_Values___, index_));
   END Base;

BEGIN
   RETURN Base(index_);
END Get_Db_Value;


--@IgnoreMissingSysinit
FUNCTION Get_Db_Values___ RETURN VARCHAR2 DETERMINISTIC
IS
   
   FUNCTION Base RETURN VARCHAR2 DETERMINISTIC
   IS
   BEGIN
      RETURN('READY^APPROVED^UPDATE^');
   END Base;

BEGIN
   RETURN Base;
END Get_Db_Values___;


--@IgnoreMissingSysinit
FUNCTION Get_Client_Values___ RETURN VARCHAR2 DETERMINISTIC
IS
   
   FUNCTION Base RETURN VARCHAR2 DETERMINISTIC
   IS
   BEGIN
      RETURN('Ready^Approved^Update^');
   END Base;

BEGIN
   RETURN Base;
END Get_Client_Values___;

-----------------------------------------------------------------------------
-------------------- LU SPECIFIC PUBLIC METHODS -----------------------------
-----------------------------------------------------------------------------

--@IgnoreMissingSysinit
FUNCTION Decode_Lang (
   db_value_ IN VARCHAR2,
   lang_     IN VARCHAR2 DEFAULT 'ru') RETURN VARCHAR2
IS
   
   FUNCTION Ext (
      db_value_ IN VARCHAR2,
      lang_     IN VARCHAR2 DEFAULT 'ru') RETURN VARCHAR2
   IS
      
      FUNCTION Base (
         db_value_ IN VARCHAR2 ) RETURN VARCHAR2
      IS
      BEGIN
         RETURN Domain_SYS.Decode_(Domain_SYS.Get_Translated_Values(lu_name_,lang_), Get_Db_Values___, db_value_);
      END Base;
   
   BEGIN
      RETURN Base(db_value_);
   END Ext;

BEGIN
   RETURN Ext(db_value_, lang_);
END Decode_Lang;

-----------------------------------------------------------------------------
-------------------- FOUNDATION1 METHODS ------------------------------------
-----------------------------------------------------------------------------


--@IgnoreMissingSysinit
PROCEDURE Language_Refreshed
IS
   
   PROCEDURE Base
   IS
   BEGIN
      Domain_SYS.Language_Refreshed(lu_name_, Get_Client_Values___, Get_Db_Values___, 'IID');
   END Base;

BEGIN
   Base;
END Language_Refreshed;


--@IgnoreMissingSysinit
PROCEDURE Init
IS
   
   PROCEDURE Base
   IS
   BEGIN
      Domain_SYS.Load_IID(lu_name_, Get_Client_Values___, Get_Db_Values___);
   END Base;

BEGIN
   Base;
END Init;

BEGIN
   Init;
END Cf_Rep_Dp_State_API;
-- [END A7 COMPLETE BLOCK]
/


--
-- CLIENT_SYS  (Package Body) 
--
--  Dependencies: 
--   CLIENT_SYS (Package)
--   DBMS_LOCK (Synonym)
--   DBMS_OUTPUT (Synonym)
--   DBMS_SQL (Synonym)
--   DBMS_UTILITY (Synonym)
--   USER_TAB_COLUMNS (Synonym)
--   STANDARD (Package)
--   ERROR_SYS (Package)
--
CREATE OR REPLACE PACKAGE BODY VTAPP.CLIENT_SYS IS

-----------------------------------------------------------------------------
-------------------- PRIVATE DECLARATIONS -----------------------------------
-----------------------------------------------------------------------------


-----------------------------------------------------------------------------
-------------------- IMPLEMENTATION METHOD DECLARATIONS ---------------------
-----------------------------------------------------------------------------

FUNCTION Get_Max_Current_Info___ (
   current_info_max_length_  IN VARCHAR2 ) RETURN VARCHAR2;

PROCEDURE Get_Key_Ref_Info___ (
   key_ref_    OUT VARCHAR2,
   sql_column_ OUT VARCHAR2,
   view_       IN  VARCHAR2,
   for_table_  IN  BOOLEAN DEFAULT FALSE,
   use_binary_ci_sort_          IN  BOOLEAN DEFAULT FALSE,
   for_enum_use_table_column_   IN  BOOLEAN DEFAULT FALSE);

-----------------------------------------------------------------------------
-------------------- LU SPECIFIC PUBLIC METHODS -----------------------------
-----------------------------------------------------------------------------

PROCEDURE Clear_Attr (
   attr_ OUT VARCHAR2 )
IS
BEGIN
   attr_ := NULL;
END Clear_Attr;


PROCEDURE Add_To_Attr (
   name_  IN     VARCHAR2,
   value_ IN     VARCHAR2,
   attr_  IN OUT NOCOPY VARCHAR2 )
IS
BEGIN
   attr_ := attr_||name_||field_separator_||value_||record_separator_;
END Add_To_Attr;


PROCEDURE Add_To_Attr (
   name_  IN     VARCHAR2,
   value_ IN     NUMBER,
   attr_  IN OUT NOCOPY VARCHAR2 )
IS
BEGIN
   Add_To_Attr(name_, to_char(value_), attr_);
END Add_To_Attr;


PROCEDURE Add_To_Attr(
   name_  IN     VARCHAR2,
   value_ IN     DATE,
   attr_  IN OUT NOCOPY VARCHAR2 )
IS
BEGIN
   Add_To_Attr(name_, to_char(value_, date_format_), attr_);
END Add_To_Attr;


PROCEDURE Add_To_Attr(
   name_  IN     VARCHAR2,
   value_ IN     TIMESTAMP,
   attr_  IN OUT NOCOPY VARCHAR2 )
IS
BEGIN
   Add_To_Attr(name_, to_char(value_, timestamp_format_), attr_);
END Add_To_Attr;


PROCEDURE Add_To_Attr_If_Not_Null (
   name_  IN     VARCHAR2,
   value_ IN     VARCHAR2,
   attr_  IN OUT NOCOPY VARCHAR2 )
IS
BEGIN
   IF (value_ IS NOT NULL) THEN
      Add_To_Attr(name_, value_, attr_);
   END IF;
END Add_To_Attr_If_Not_Null;


PROCEDURE Add_To_Attr_If_Not_Null (
   name_  IN     VARCHAR2,
   value_ IN     NUMBER,
   attr_  IN OUT NOCOPY VARCHAR2 )
IS
BEGIN
   IF (value_ IS NOT NULL) THEN
      Add_To_Attr(name_, value_, attr_);
   END IF;
END Add_To_Attr_If_Not_Null;


PROCEDURE Add_To_Attr_If_Not_Null(
   name_  IN     VARCHAR2,
   value_ IN     DATE,
   attr_  IN OUT NOCOPY VARCHAR2 )
IS
BEGIN
   IF (value_ IS NOT NULL) THEN
      Add_To_Attr(name_, value_, attr_);
   END IF;
END Add_To_Attr_If_Not_Null;


PROCEDURE Add_To_Attr_If_Not_Null(
   name_  IN     VARCHAR2,
   value_ IN     TIMESTAMP,
   attr_  IN OUT NOCOPY VARCHAR2 )
IS
BEGIN
   IF (value_ IS NOT NULL) THEN
      Add_To_Attr(name_, value_, attr_);
   END IF;
END Add_To_Attr_If_Not_Null;


FUNCTION Remove_Attr (
   name_ IN VARCHAR2,
   attr_ IN VARCHAR2 ) RETURN VARCHAR2
IS
   index1_ NUMBER;
   index2_ NUMBER;

BEGIN
   index1_ := instr(record_separator_||attr_, record_separator_||name_||field_separator_);
   IF (index1_ > 0) THEN
      index2_ := instr(record_separator_||attr_, record_separator_, index1_ + 1, 1);
      RETURN(substr(attr_,1,index1_-1)||substr(attr_,index2_));
   END IF;
   RETURN(attr_);
END Remove_Attr;


PROCEDURE Set_Item_Value (
   name_  IN     VARCHAR2,
   value_ IN     VARCHAR2,
   attr_  IN OUT NOCOPY VARCHAR2 )
IS
   index1_ NUMBER;
   index2_ NUMBER;
BEGIN
   index1_ := instr(record_separator_||attr_, record_separator_||name_||field_separator_);
   IF (index1_ > 0) THEN
      index2_ := instr(record_separator_||attr_, record_separator_, index1_ + 1, 1);
      IF index1_ = 1 THEN
         attr_ := name_||field_separator_||value_||record_separator_|| substr(attr_, index2_, LENGTH(attr_) - index2_ +1 );
      ELSE
         attr_ := REPLACE(attr_, substr(attr_, index1_-1, index2_ - index1_), record_separator_||name_||field_separator_||value_);
      END IF;
   ELSE
      Add_To_Attr(name_, value_, attr_);
   END IF;
END Set_Item_Value;


PROCEDURE Set_Item_Value (
   name_  IN     VARCHAR2,
   value_ IN     NUMBER,
   attr_  IN OUT NOCOPY VARCHAR2 )
IS
BEGIN
   Set_Item_Value(name_, to_char(value_), attr_);
END Set_Item_Value;


PROCEDURE Set_Item_Value (
   name_  IN     VARCHAR2,
   value_ IN     DATE,
   attr_  IN OUT NOCOPY VARCHAR2 )
IS
BEGIN
   Set_Item_Value(name_, to_char(value_, date_format_), attr_);
END Set_Item_Value;


FUNCTION Get_Next_From_Attr (
   attr_  IN     VARCHAR2,
   ptr_   IN OUT NOCOPY NUMBER,
   name_  IN OUT NOCOPY VARCHAR2,
   value_ IN OUT NOCOPY VARCHAR2 ) RETURN BOOLEAN
IS
   from_  NUMBER;
   to_    NUMBER;
   index_ NUMBER;
BEGIN
   from_ := nvl(ptr_, 1);
   to_   := instr(attr_, record_separator_, from_);
   IF (to_ > 0) THEN
      index_ := instr(attr_, field_separator_, from_);
      name_  := substr(attr_, from_, index_-from_);
      value_ := substr(attr_, index_+1, to_-index_-1);
      ptr_   := to_+1;
      RETURN(TRUE);
   ELSE
      RETURN(FALSE);
   END IF;
END Get_Next_From_Attr;


FUNCTION Attr_Value_To_Date (
   value_ IN VARCHAR2,
   raise_value_error_ BOOLEAN DEFAULT TRUE ) RETURN DATE
IS
BEGIN
   RETURN(to_date(value_, date_format_));
EXCEPTION
   WHEN OTHERS THEN
      IF raise_value_error_ THEN
         RAISE value_error;
      ELSE
         RAISE;
      END IF;
END Attr_Value_To_Date;


FUNCTION Attr_Value_To_Timestamp (
   value_ IN VARCHAR2,
   raise_value_error_ BOOLEAN DEFAULT TRUE ) RETURN TIMESTAMP
IS
BEGIN
   RETURN(to_timestamp(value_, timestamp_format_));
EXCEPTION
   WHEN OTHERS THEN
      IF raise_value_error_ THEN
         RAISE value_error;
      ELSE
         RAISE;
      END IF;
END Attr_Value_To_Timestamp;


FUNCTION Attr_Value_To_Number (
   value_ IN VARCHAR2 ) RETURN NUMBER
IS
BEGIN
   RETURN(to_number(value_));
END Attr_Value_To_Number;


FUNCTION Attr_Value_To_Integer (
   value_ IN VARCHAR2 ) RETURN INTEGER
IS
   num_value_ NUMBER;
BEGIN
   num_value_ := to_number(value_);
   IF(num_value_ != trunc(num_value_)) THEN
      RAISE value_error;
   END IF;
   RETURN num_value_;
END Attr_Value_To_Integer;


FUNCTION Cut_Item_Value (
   name_ IN     VARCHAR2,
   attr_ IN OUT NOCOPY VARCHAR2 ) RETURN VARCHAR2
IS
   value_   VARCHAR2(32000);
BEGIN
   value_ := Get_Item_Value(name_, attr_);
   attr_ := Remove_Attr(name_, attr_);
   RETURN(value_);
END Cut_Item_Value;


FUNCTION Get_Item_Value (
   name_ IN VARCHAR2,
   attr_ IN VARCHAR2 ) RETURN VARCHAR2
IS
   from_ NUMBER;
   len_  NUMBER;
   to_   NUMBER;
BEGIN
   len_ := length(name_);
   from_ := instr(record_separator_ || attr_, record_separator_ || name_ || field_separator_);
   IF (from_ > 0) THEN
      to_ := instr(attr_, record_separator_, from_ + 1);
      IF (to_ > 0) THEN
         RETURN (substr(attr_, from_ + len_ + 1, to_ - from_ - len_ - 1));
      END IF;
   END IF;
   RETURN (NULL);
END Get_Item_Value;


FUNCTION Get_Item_Value_To_Date (
   name_      IN VARCHAR2,
   attr_      IN VARCHAR2,
   lu_name_   IN VARCHAR2,
   method_    IN VARCHAR2 DEFAULT NULL) RETURN DATE
IS
   value_     VARCHAR2(32000);
BEGIN
   value_ := Get_Item_Value(name_, attr_);
   RETURN(to_date(value_, date_format_));
EXCEPTION
   WHEN value_error THEN
      IF (method_ IS NULL) THEN
         Error_SYS.Item_Format(lu_name_, name_, value_);
      ELSE
         Error_SYS.Item_Format(lu_name_, name_, value_, 'ITEM_VALUE_ERROR: Value error in method :P1 for attribute :P2.', method_, name_);
      END IF;
END Get_Item_Value_To_Date;


FUNCTION Get_Item_Value_To_Timestamp (
   name_      IN VARCHAR2,
   attr_      IN VARCHAR2,
   lu_name_   IN VARCHAR2,
   method_    IN VARCHAR2 DEFAULT NULL) RETURN TIMESTAMP
IS
   value_     VARCHAR2(32000);
BEGIN
   value_ := Get_Item_Value(name_, attr_);
   RETURN(to_date(value_, timestamp_format_));
EXCEPTION
   WHEN value_error THEN
      IF (method_ IS NULL) THEN
         Error_SYS.Item_Format(lu_name_, name_, value_);
      ELSE
         Error_SYS.Item_Format(lu_name_, name_, value_, 'ITEM_VALUE_ERROR: Value error in method :P1 for attribute :P2.', method_, name_);
      END IF;
END Get_Item_Value_To_Timestamp;


FUNCTION Get_Item_Value_To_Number (
   name_      IN VARCHAR2,
   attr_      IN VARCHAR2,
   lu_name_   IN VARCHAR2,
   method_    IN VARCHAR2 DEFAULT NULL) RETURN NUMBER
IS
   value_     VARCHAR2(32000);
BEGIN
   value_ := Get_Item_Value(name_, attr_);
   RETURN(to_number(value_));
EXCEPTION
   WHEN value_error THEN
      IF (method_ IS NULL) THEN
         Error_SYS.Item_Format(lu_name_, name_, value_);
      ELSE
         Error_SYS.Item_Format(lu_name_, name_, value_, 'ITEM_VALUE_ERROR: Value error in method :P1 for attribute :P2.', method_, name_);
      END IF;
END Get_Item_Value_To_Number;


FUNCTION Item_Exist (
   name_ IN VARCHAR2,
   attr_ IN VARCHAR2 ) RETURN BOOLEAN
IS
   from_ NUMBER;
   len_  NUMBER;
BEGIN
   len_ := length(name_);
   from_ := instr(record_separator_ || attr_, record_separator_ || name_ || field_separator_);
   IF (from_ > 0) THEN
      RETURN TRUE;
   ELSE
      RETURN FALSE;
   END IF;
END Item_Exist;


PROCEDURE Attr_To_Dbms_Output (
   attr_ IN VARCHAR2 )
IS
   ptr_     NUMBER;
   name_    VARCHAR2(30);
   value_   VARCHAR2(32767);
   len_     NUMBER;
BEGIN
   ptr_ := NULL;
   WHILE Get_Next_From_Attr(attr_, ptr_, name_, value_) LOOP
      len_ := length(name_)+3+length(value_);
      IF (len_ > 255) THEN
      dbms_output.put_line( name_||'='||
            substr(value_,1,250-length(name_))||' ...');
      ELSE
         dbms_output.put_line( name_||'='||value_);
      END IF;
   END LOOP;
END Attr_To_Dbms_Output;


PROCEDURE Clear_List (
   list_ OUT VARCHAR2 )
IS
BEGIN
   list_ := NULL;
END Clear_List;


PROCEDURE Add_To_List (
   value_ IN     VARCHAR2,
   list_  IN OUT NOCOPY VARCHAR2 )
IS
BEGIN
   list_ := list_||value_||record_separator_;
END Add_To_List;


PROCEDURE Add_To_List (
   value_ IN     NUMBER,
   list_  IN OUT NOCOPY VARCHAR2 )
IS
BEGIN
   Add_To_List(to_char(value_), list_);
END Add_To_List;


PROCEDURE Add_To_List(
   value_ IN     DATE,
   list_  IN OUT NOCOPY VARCHAR2 )
IS
BEGIN
   Add_To_List(to_char(value_, date_format_), list_);
END Add_To_List;


PROCEDURE Add_To_List(
   value_ IN     TIMESTAMP,
   list_  IN OUT NOCOPY VARCHAR2 )
IS
BEGIN
   Add_To_List(to_char(value_, timestamp_format_), list_);
END Add_To_List;


FUNCTION Get_Next_From_List (
   list_  IN     VARCHAR2,
   ptr_   IN OUT NOCOPY NUMBER,
   value_ IN OUT NOCOPY VARCHAR2 ) RETURN BOOLEAN
IS
   from_ NUMBER := nvl(ptr_, 1);
   to_   NUMBER;
BEGIN
   to_ := instr(list_, record_separator_, from_);
   IF (to_ > 0) THEN
      value_ := substr(list_, from_, to_-from_);
      ptr_   := to_+1;
      RETURN TRUE;
   ELSE
      RETURN FALSE;
   END IF;
END Get_Next_From_List;


FUNCTION Get_Next_From_Selection (
   selection_ IN     VARCHAR2,
   ptr_       IN OUT NOCOPY NUMBER,
   key_ref_   IN OUT NOCOPY VARCHAR2 ) RETURN BOOLEAN
IS
   from_ NUMBER := nvl(ptr_, 1);
   to_   NUMBER;
BEGIN
   to_ := instr(selection_, ';', from_);
   IF (to_ > 0) THEN
      key_ref_ := substr(selection_, from_, to_-from_);
      ptr_   := to_+1;
      RETURN TRUE;
   ELSIF (length(selection_) > from_) THEN
      key_ref_ := substr(selection_, from_);
      ptr_   := length(selection_);
      RETURN TRUE;
   ELSE
      key_ref_ := NULL;
      RETURN FALSE;
   END IF;
END Get_Next_From_Selection;


PROCEDURE Get_Key_Reference (
   key_ref_ OUT VARCHAR2,
   lu_name_ IN VARCHAR2,
   objid_ IN VARCHAR2 DEFAULT NULL )
IS
   c1_           NUMBER;
   ignore_       NUMBER;
   stmt_         VARCHAR2(2000);
   view_         VARCHAR2(30);
   temp_key_ref_ VARCHAR2(32000);
   sql_column_   VARCHAR2(32000);
   --
   -- Cursor to fetch key dictionary information
   --


BEGIN
   key_ref_ := NULL;
END Get_Key_Reference;


FUNCTION Get_Key_Reference (
   lu_name_ IN VARCHAR2,
   key1_    IN VARCHAR2,
   value1_  IN VARCHAR2,
   key2_    IN VARCHAR2 DEFAULT NULL,
   value2_  IN VARCHAR2 DEFAULT NULL,
   key3_    IN VARCHAR2 DEFAULT NULL,
   value3_  IN VARCHAR2 DEFAULT NULL,
   key4_    IN VARCHAR2 DEFAULT NULL,
   value4_  IN VARCHAR2 DEFAULT NULL,
   key5_    IN VARCHAR2 DEFAULT NULL,
   value5_  IN VARCHAR2 DEFAULT NULL,
   key6_    IN VARCHAR2 DEFAULT NULL,
   value6_  IN VARCHAR2 DEFAULT NULL,
   key7_    IN VARCHAR2 DEFAULT NULL,
   value7_  IN VARCHAR2 DEFAULT NULL,
   key8_    IN VARCHAR2 DEFAULT NULL,
   value8_  IN VARCHAR2 DEFAULT NULL,
   key9_    IN VARCHAR2 DEFAULT NULL,
   value9_  IN VARCHAR2 DEFAULT NULL,
   key10_   IN VARCHAR2 DEFAULT NULL,
   value10_ IN VARCHAR2 DEFAULT NULL,
   key11_   IN VARCHAR2 DEFAULT NULL,
   value11_ IN VARCHAR2 DEFAULT NULL,
   key12_   IN VARCHAR2 DEFAULT NULL,
   value12_ IN VARCHAR2 DEFAULT NULL,
   key13_   IN VARCHAR2 DEFAULT NULL,
   value13_ IN VARCHAR2 DEFAULT NULL,
   key14_   IN VARCHAR2 DEFAULT NULL,
   value14_ IN VARCHAR2 DEFAULT NULL,
   key15_   IN VARCHAR2 DEFAULT NULL,
   value15_ IN VARCHAR2 DEFAULT NULL ) RETURN VARCHAR2
IS
   TYPE keytab_type IS TABLE OF VARCHAR2(2000) INDEX BY BINARY_INTEGER;
   keytab_    keytab_type;
   valtab_    keytab_type;
   temp_      VARCHAR2(2000);
   count_     NUMBER;
   temp_key_ref_ VARCHAR2(32000);
BEGIN
   --
   -- Fill parameter values into the table structure
   --
   count_ := 1;
   keytab_(count_) := key1_;
   valtab_(count_) := value1_;
   IF (key2_ IS NOT NULL) THEN
      count_ := 2;
      keytab_(count_) := key2_;
      valtab_(count_) := value2_;
   END IF;
   IF (key3_ IS NOT NULL) THEN
      count_ := 3;
      keytab_(count_) := key3_;
      valtab_(count_) := value3_;
   END IF;
   IF (key4_ IS NOT NULL) THEN
      count_ := 4;
      keytab_(count_) := key4_;
      valtab_(count_) := value4_;
   END IF;
   IF (key5_ IS NOT NULL) THEN
      count_ := 5;
      keytab_(count_) := key5_;
      valtab_(count_) := value5_;
   END IF;
   IF (key6_ IS NOT NULL) THEN
      count_ := 6;
      keytab_(count_) := key6_;
      valtab_(count_) := value6_;
   END IF;
   IF (key7_ IS NOT NULL) THEN
      count_ := 7;
      keytab_(count_) := key7_;
      valtab_(count_) := value7_;
   END IF;
   IF (key8_ IS NOT NULL) THEN
      count_ := 8;
      keytab_(count_) := key8_;
      valtab_(count_) := value8_;
   END IF;
   IF (key9_ IS NOT NULL) THEN
      count_ := 9;
      keytab_(count_) := key9_;
      valtab_(count_) := value9_;
   END IF;
   IF (key10_ IS NOT NULL) THEN
      count_ := 10;
      keytab_(count_) := key10_;
      valtab_(count_) := value10_;
   END IF;
   IF (key11_ IS NOT NULL) THEN
      count_ := 11;
      keytab_(count_) := key11_;
      valtab_(count_) := value11_;
   END IF;
   IF (key12_ IS NOT NULL) THEN
      count_ := 12;
      keytab_(count_) := key12_;
      valtab_(count_) := value12_;
   END IF;
   IF (key13_ IS NOT NULL) THEN
      count_ := 13;
      keytab_(count_) := key13_;
      valtab_(count_) := value13_;
   END IF;
   IF (key14_ IS NOT NULL) THEN
      count_ := 14;
      keytab_(count_) := key14_;
      valtab_(count_) := value14_;
   END IF;
   IF (key15_ IS NOT NULL) THEN
      count_ := 15;
      keytab_(count_) := key15_;
      valtab_(count_) := value15_;
   END IF;
   --
   -- Sort by using 'bubble sort' algorithm
   --
   FOR n IN 1..count_-1 LOOP
      FOR m IN REVERSE n+1..count_ LOOP
         IF (keytab_(m) < keytab_(m-1)) THEN
            temp_ := keytab_(m);
            keytab_(m) := keytab_(m-1);
            keytab_(m-1) := temp_;
            temp_ := valtab_(m);
            valtab_(m) := valtab_(m-1);
            valtab_(m-1) := temp_;
         END IF;
      END LOOP;
   END LOOP;
   --
   -- Create the sorted key reference list
   --
   temp_key_ref_ := NULL;
   FOR n IN 1..count_ LOOP
      temp_key_ref_ := temp_key_ref_||keytab_(n)||'='||valtab_(n)||text_separator_;
   END LOOP;
   RETURN(temp_key_ref_);
END Get_Key_Reference;


FUNCTION Convert_Key_Ref_To_Tab_Keys (
   lu_name_ IN VARCHAR2,
   key_ref_ IN VARCHAR2) RETURN VARCHAR2
IS
   base_view_name_  VARCHAR2(128);
   key_count_       NUMBER;
   new_key_ref_     VARCHAR2(32000);


BEGIN

   RETURN new_key_ref_;
END Convert_Key_Ref_To_Tab_Keys;


FUNCTION Get_New_Key_Reference (
   lu_name_     IN VARCHAR2,
   old_key_ref_ IN VARCHAR2,
   use_binary_ai_sort_        IN BOOLEAN DEFAULT FALSE,
   for_enum_use_table_column_ IN BOOLEAN DEFAULT FALSE) RETURN VARCHAR2
IS
   base_table_name_     VARCHAR2(128);
   base_view_name_      VARCHAR2(128);
   --key_cols_          Utility_SYS.STRING_TABLE;
   key_count_           NUMBER;
   new_key_ref_         VARCHAR2(32000);
   sql_col_string_      VARCHAR2(32000);
   tab_key_ref_string_  VARCHAR2(32000);
   tab_key_count_       NUMBER;
   dummy_               NUMBER;
   data_cursor_         NUMBER;
   stmt_                VARCHAR2(32000);
BEGIN

   -- if the relevant referenced record cannot be found will return the old key ref
   IF dummy_ > 0 THEN
      RETURN new_key_ref_;
   ELSE
      RETURN old_key_ref_;
   END IF;
END Get_New_Key_Reference;


PROCEDURE Get_Table_Key_Reference (
   key_ref_ OUT VARCHAR2,
   lu_name_ IN VARCHAR2 )
IS
   view_         VARCHAR2(30);
   temp_key_ref_ VARCHAR2(32000);
   table_ VARCHAR2(100);
BEGIN
   key_ref_ := NULL;
END Get_Table_Key_Reference;


FUNCTION Get_Key_Reference_From_Objkey (
   lu_name_ IN VARCHAR2,
   objkey_  IN VARCHAR2 DEFAULT NULL ) RETURN VARCHAR2
IS
   c1_           NUMBER;
   ignore_       NUMBER;
   stmt_         VARCHAR2(2000);
   view_         VARCHAR2(30);
   temp_key_ref_ VARCHAR2(32000);
   sql_column_   VARCHAR2(2000);
   --
   -- Cursor to fetch key dictionary information
   --
   key_ref_ VARCHAR2(32000);
   objkey_col_ VARCHAR2(30);
BEGIN
   key_ref_ := NULL;

   -- By now we should be having a valid view name

END Get_Key_Reference_From_Objkey;


FUNCTION Get_Objkey_From_Key_Ref (
   lu_name_   IN VARCHAR2,
   key_ref_   IN VARCHAR2,
   view_name_ IN VARCHAR2 DEFAULT NULL) RETURN VARCHAR2
IS
   key_count_  NUMBER;
   stmt_       VARCHAR2(32000);
   view_       VARCHAR2(128);
   objkey_     VARCHAR2(4000);
   key_column_ VARCHAR2(128);
   value_delimeter_pos_ NUMBER;
   cursor_     NUMBER;
   ignore_     NUMBER;

   TYPE column_data_types IS TABLE OF VARCHAR2(100) INDEX BY VARCHAR2(128);
   column_data_type_tab_ column_data_types;
BEGIN

   FOR rec_ IN (SELECT column_name, data_type FROM user_tab_columns WHERE table_name = view_) LOOP
      column_data_type_tab_(rec_.column_name) := rec_.data_type;
   END LOOP;
   stmt_ := 'SELECT OBJKEY FROM '||view_ ||' WHERE ';

   cursor_ := dbms_sql.open_cursor;
   --@ApproveDynamicStatement(2017-08-23,chmulk)
   dbms_sql.parse(cursor_, stmt_, dbms_sql.native);
   dbms_sql.define_column(cursor_, 1, objkey_, 2000);
  /* FOR i_ IN 1..key_count_ LOOP
      dbms_sql.bind_variable(cursor_, ':B'||i_, bind_values_(i_));
   END LOOP;*/
   --fetch should return only one row
   ignore_ := dbms_sql.execute_and_fetch(cursor_, TRUE);
   dbms_sql.column_value(cursor_, 1, objkey_);
   dbms_sql.close_cursor(cursor_);
   RETURN objkey_;
EXCEPTION
   WHEN no_data_found THEN
      IF dbms_sql.is_open(cursor_) THEN
         dbms_sql.close_cursor(cursor_);
      END IF;
      RETURN NULL;
   WHEN OTHERS THEN
      IF dbms_sql.is_open(cursor_) THEN
         dbms_sql.close_cursor(cursor_);
      END IF;
      RAISE;
END Get_Objkey_From_Key_Ref;


FUNCTION Get_Rowkey_From_Key_Ref (
   lu_name_   IN VARCHAR2,
   key_ref_   IN VARCHAR2) RETURN VARCHAR2
IS
   key_count_  NUMBER;
   stmt_       VARCHAR2(32000);
   table_      VARCHAR2(128);
   objkey_     VARCHAR2(4000);
   key_column_ VARCHAR2(128);
   value_delimeter_pos_ NUMBER;
   cursor_     NUMBER;
   ignore_     NUMBER;
   table_key_ref_ VARCHAR2(32000);

   TYPE column_data_types IS TABLE OF VARCHAR2(100) INDEX BY VARCHAR2(128);
   column_data_type_tab_ column_data_types;
BEGIN

null;
END Get_Rowkey_From_Key_Ref;


PROCEDURE Add_To_Key_Reference (
   key_ref_ IN OUT NOCOPY VARCHAR2,
   name_    IN     VARCHAR2,
   value_   IN     VARCHAR2 )
IS
BEGIN
   key_ref_ := key_ref_||name_||'='||value_||text_separator_;
END Add_To_Key_Reference;


PROCEDURE Add_To_Key_Reference (
   key_ref_ IN OUT NOCOPY VARCHAR2,
   name_    IN     VARCHAR2,
   value_   IN     NUMBER )
IS
BEGIN
   Add_To_Key_Reference(key_ref_, name_, to_char(value_));
END Add_To_Key_Reference;


PROCEDURE Add_To_Key_Reference (
   key_ref_ IN OUT NOCOPY VARCHAR2,
   name_    IN     VARCHAR2,
   value_   IN     DATE )
IS
BEGIN
   Add_To_Key_Reference(key_ref_, name_, to_char(value_, date_format_));
END Add_To_Key_Reference;


PROCEDURE Add_To_Key_Reference (
   key_ref_ IN OUT NOCOPY VARCHAR2,
   name_    IN     VARCHAR2,
   value_   IN     TIMESTAMP )
IS
BEGIN
   Add_To_Key_Reference(key_ref_, name_, to_timestamp(value_, timestamp_format_));
END Add_To_Key_Reference;


FUNCTION Get_Key_Reference_Value (
   key_ref_ IN VARCHAR2,
   name_    IN VARCHAR2 ) RETURN VARCHAR2
IS
   first_pos_  NUMBER;
   second_pos_ NUMBER;
BEGIN
   first_pos_  := instr(text_separator_||key_ref_, text_separator_||name_||'=') + length(name_) + 1;
   second_pos_ := instr(text_separator_||key_ref_, text_separator_, first_pos_ + 1);
   IF (first_pos_ = length(name_) + 1) THEN
      -- Not found
      RETURN(NULL);
   ELSE
      RETURN(substr(key_ref_, first_pos_, second_pos_ - first_pos_ - 1));
   END IF;
END Get_Key_Reference_Value;


FUNCTION Get_Key_Reference_Value (
   key_ref_ IN VARCHAR2,
   index_   IN NUMBER ) RETURN VARCHAR2
IS
   keyval_     VARCHAR2(2000);
   first_pos_  NUMBER;
   second_pos_ NUMBER;
BEGIN
   IF (index_ = 1) THEN
      keyval_ := substr(key_ref_, instr(key_ref_, '=') + 1,
                        instr(key_ref_, text_separator_, index_) - instr(key_ref_, '=') - 1);
   ELSE
      first_pos_  := instr(key_ref_, '=', 1, index_) + 1;
      second_pos_ := instr(key_ref_, text_separator_, 1, index_ );
      keyval_     := substr(key_ref_, first_pos_, second_pos_ - first_pos_);
   END IF;
   RETURN(keyval_);
END Get_Key_Reference_Value;


PROCEDURE Clear_Info
IS
BEGIN
   null;
END Clear_Info;


PROCEDURE Add_Info (
   lu_name_ IN VARCHAR2,
   text_    IN VARCHAR2,
   p1_      IN VARCHAR2 DEFAULT NULL,
   p2_      IN VARCHAR2 DEFAULT NULL,
   p3_      IN VARCHAR2 DEFAULT NULL )
IS
   line_ VARCHAR2(2048);
   err_msg_  VARCHAR2(2000);
BEGIN
   line_ := ltrim(substr(text_, instr(text_, ':') + 1));
   line_ := replace(line_,':P1',p1_);
   line_ := replace(line_,':P2',p2_);
   line_ := replace(line_,':P3',p3_);
END Add_Info;


PROCEDURE Add_Warning (
   lu_name_ IN VARCHAR2,
   text_    IN VARCHAR2,
   p1_      IN VARCHAR2 DEFAULT NULL,
   p2_      IN VARCHAR2 DEFAULT NULL,
   p3_      IN VARCHAR2 DEFAULT NULL )
IS
   line_ VARCHAR2(2048);
   err_msg_ VARCHAR2(3000);
BEGIN

   line_ := ltrim(substr(text_, instr(text_, ':') + 1));
   line_ := replace(line_,':P1',p1_);
   line_ := replace(line_,':P2',p2_);
   line_ := replace(line_,':P3',p3_);

END Add_Warning;


FUNCTION Get_All_Info (
   max_length_  IN NUMBER ) RETURN VARCHAR2
IS
   info_ VARCHAR2(32000);
BEGIN
   info_ := Get_Max_Current_Info___(max_length_);
   Clear_Info ;
   RETURN(info_);
END Get_All_Info;


FUNCTION Get_All_Info RETURN VARCHAR2
IS
   info_ VARCHAR2(2000);
BEGIN
   info_ := Get_Max_Current_Info___(2000);
   Clear_Info ;
   RETURN(info_);
END Get_All_Info;


PROCEDURE Get_Trace(
   text_ IN OUT NOCOPY CLOB )
IS
   category_arr_  dbms_utility.lname_array;
BEGIN
   null;
END Get_Trace;


PROCEDURE Get_Separator_Info (
   text_sep_   OUT VARCHAR2,
   field_sep_  OUT VARCHAR2,
   record_sep_ OUT VARCHAR2,
   group_sep_  OUT VARCHAR2,
   file_sep_   OUT VARCHAR2 )
IS
BEGIN
   text_sep_   := text_separator_;
   field_sep_  := field_separator_;
   record_sep_ := record_separator_;
   group_sep_  := group_separator_;
   file_sep_   := file_separator_;
END Get_Separator_Info;


FUNCTION Append_Info (
   previous_info_ IN VARCHAR2 ) RETURN VARCHAR2
IS
BEGIN
   RETURN(Get_All_Info(32000) || previous_info_);
EXCEPTION
   WHEN value_error THEN
      Error_SYS.Appl_General(service_, 'APPEND: Info message is too long.');
END Append_Info;


PROCEDURE Merge_Info (
   previous_info_ IN VARCHAR2 )
IS
BEGIN
   null;
END Merge_Info;


FUNCTION Sleep (
   seconds_ IN VARCHAR2 ) RETURN NUMBER
IS
BEGIN
   Dbms_Lock.Sleep(seconds_);
   RETURN(seconds_);
END Sleep;

-----------------------------------------------------------------------------
-------------------- LU SPECIFIC PRIVATE METHODS ----------------------------
-----------------------------------------------------------------------------

FUNCTION Get_System_Info__ RETURN CLOB
IS
   msg_                    CLOB ;
   local_date_format_   CONSTANT VARCHAR2(10) := 'YYYY-MM-DD';

  begin
   RETURN(msg_);
END Get_System_Info__;

-----------------------------------------------------------------------------
-------------------- LU SPECIFIC IMPLEMENTATION METHODS ---------------------
-----------------------------------------------------------------------------

FUNCTION Get_Max_Current_Info___ (
   current_info_max_length_  IN VARCHAR2 ) RETURN VARCHAR2
IS
   string_  VARCHAR2(32767) := current_info_max_length_;
BEGIN
   string_ := Substr(string_, 1, Instr(string_, record_separator_, -1));
   RETURN(string_);
END Get_Max_Current_Info___;


PROCEDURE Get_Key_Ref_Info___ (
   key_ref_    OUT VARCHAR2,
   sql_column_ OUT VARCHAR2,
   view_       IN  VARCHAR2,
   for_table_  IN  BOOLEAN DEFAULT FALSE,
   use_binary_ci_sort_          IN  BOOLEAN DEFAULT FALSE,
   for_enum_use_table_column_   IN  BOOLEAN DEFAULT FALSE)
IS
   key_ref_field_name_  VARCHAR2(32000);
   key_ref_select_name_ VARCHAR2(32000);
   stmt_str_            VARCHAR2(1000);

   TYPE KeyInfoCurTyp   IS REF CURSOR;


BEGIN
   sql_column_ := '''';

   stmt_str_ := 'SELECT column_name, column_datatype, enumeration,table_column_name
      FROM   dictionary_sys_view_column_tab
      WHERE  view_name = :view_
      AND    type_flag IN (''P'',''K'')';
   IF (use_binary_ci_sort_) THEN
      stmt_str_ := stmt_str_ || ' ORDER BY NLSSORT(COLUMN_NAME,''NLS_SORT=BINARY_CI'')';
   ELSE
      stmt_str_ := stmt_str_ || ' ORDER BY column_name';
   END IF;



   IF sql_column_ IS NOT NULL THEN
      sql_column_ := sql_column_ || '''';
   END IF;
END Get_Key_Ref_Info___;

-----------------------------------------------------------------------------
-------------------- FOUNDATION1 METHODS ------------------------------------
-----------------------------------------------------------------------------


--@IgnoreMissingSysinit
PROCEDURE Init
IS

   PROCEDURE Base
   IS
   BEGIN
      NULL;
   END Base;

BEGIN
   Base;
END Init;

BEGIN
   Init;
END CLIENT_SYS;
-- [END A7 COMPLETE BLOCK]
/


--
-- DOMAIN_SYS  (Package Body) 
--
--  Dependencies: 
--   DOMAIN_SYS (Package)
--   DBMS_SESSION (Synonym)
--   USER_PROCEDURES (Synonym)
--   STANDARD (Package)
--   CLIENT_SYS (Package)
--   ERROR_SYS (Package)
--
CREATE OR REPLACE PACKAGE BODY VTAPP.DOMAIN_SYS IS

-----------------------------------------------------------------------------
-------------------- PRIVATE DECLARATIONS -----------------------------------
-----------------------------------------------------------------------------

separator_      CONSTANT VARCHAR2(1)  := Client_SYS.field_separator_;

suffix_         CONSTANT VARCHAR2(30) := '_CTX';

ctx_length_     CONSTANT NUMBER       := 4000;

list_separator_ CONSTANT VARCHAR2(1)  := ';';


-----------------------------------------------------------------------------
-------------------- IMPLEMENTATION METHOD DECLARATIONS ---------------------
-----------------------------------------------------------------------------

FUNCTION Client_Value_Is_List___ (client_value_ IN VARCHAR2 ) RETURN BOOLEAN;

FUNCTION Get_First_Nonexistent_Item___ (
     client_list_ IN VARCHAR2,
     client_value_ IN VARCHAR2,
     delimiter_ IN VARCHAR2) RETURN VARCHAR2;

FUNCTION Exist_Single___ (
	client_list_ IN VARCHAR2,
	client_value_item_ IN VARCHAR2 ) RETURN BOOLEAN;

FUNCTION Exist_Multi___ (
	client_list_ IN VARCHAR2,
	client_value_list_ IN VARCHAR2,
   delimiter_ IN VARCHAR2) RETURN BOOLEAN;

FUNCTION Encode_Single___ (
   client_list_  IN VARCHAR2,
   db_list_      IN VARCHAR2,
   client_value_ IN VARCHAR2 ) RETURN VARCHAR2;

FUNCTION Encode_Multi___ (
   client_list_  IN VARCHAR2,
   db_list_      IN VARCHAR2,
   client_value_ IN VARCHAR2 ) RETURN VARCHAR2;

FUNCTION Decode_Single___ (
   client_list_ IN VARCHAR2,
   db_list_     IN VARCHAR2,
   db_value_    IN VARCHAR2 ) RETURN VARCHAR2;

FUNCTION Decode_Multi___ (
   client_list_ IN VARCHAR2,
   db_list_     IN VARCHAR2,
   db_value_    IN VARCHAR2 ) RETURN VARCHAR2;

FUNCTION Get_Ctx_Values___ (
   domain_ IN VARCHAR2,
   value_  IN VARCHAR2 DEFAULT NULL ) RETURN VARCHAR2;

PROCEDURE Set_Ctx_Values___ (
   context_    IN VARCHAR2,
   attribute_  IN VARCHAR2,
   value_      IN VARCHAR2 );

FUNCTION Get_Client_Values___ (
   domain_ IN VARCHAR2 ) RETURN VARCHAR2;

FUNCTION Is_Domain_Loaded___ (
   domain_ IN VARCHAR2 ) RETURN VARCHAR2;

PROCEDURE Load_Translations___ (
   domain_ IN VARCHAR2,
   type_   IN VARCHAR2 DEFAULT 'IID' );

PROCEDURE Run_Statement___ (
   stmt_ IN VARCHAR2 );

-----------------------------------------------------------------------------
-------------------- LU SPECIFIC PUBLIC METHODS -----------------------------
-----------------------------------------------------------------------------

FUNCTION Get_Db_Values (
   domain_ IN VARCHAR2 ) RETURN VARCHAR2
IS
BEGIN
   RETURN(Get_Ctx_Values___(domain_, 'DB'));
END Get_Db_Values;


FUNCTION Get_Prog_Values (
   domain_ IN VARCHAR2 ) RETURN VARCHAR2
IS
BEGIN
   RETURN(Get_Ctx_Values___(domain_, 'PROG'));
END Get_Prog_Values;


FUNCTION Get_Translated_Values (
   domain_ IN VARCHAR2,
   lang_code_ IN VARCHAR2 DEFAULT 'ru' ) RETURN VARCHAR2
IS
BEGIN
   RETURN(nvl(Get_Ctx_Values___(domain_, lang_code_), Get_Client_Values___(domain_)));
END Get_Translated_Values;


PROCEDURE Debug (
   domain_ IN VARCHAR2 )
IS
BEGIN
null;
END Debug;


FUNCTION Get (
   domain_ IN VARCHAR2 ) RETURN VARCHAR2
IS
   msg_ VARCHAR2(32767) :=domain_;
BEGIN
   RETURN(msg_);
END Get;


PROCEDURE Load_Iid (
   domain_ IN VARCHAR2,
   client_value_list_ IN VARCHAR2,
   db_value_list_ IN VARCHAR2 )
IS
BEGIN
   IF (Domain_SYS.Is_Domain_Loaded___(domain_) = 'FALSE') THEN
      Language_Refreshed(domain_, client_value_list_, db_value_list_, 'IID');
   END IF;
END Load_Iid;


PROCEDURE Load_State (
   domain_ IN VARCHAR2,
   client_value_list_ IN VARCHAR2,
   db_value_list_ IN VARCHAR2 )
IS
BEGIN
   IF (Domain_SYS.Is_Domain_Loaded___(domain_) = 'FALSE') THEN
      Language_Refreshed(domain_, client_value_list_, db_value_list_, 'STATE');
   END IF;
END Load_State;


-----------------------------------------------------------------------------
-------------------- LU SPECIFIC PROTECTED METHODS --------------------------
-----------------------------------------------------------------------------

PROCEDURE Exist_ (
   lu_name_      IN VARCHAR2,
   client_list_  IN VARCHAR2,
   client_value_ IN VARCHAR2 )
IS
BEGIN
   IF NOT (Exist_(lu_name_, client_list_, client_value_)) THEN
     Error_SYS.Record_Not_Exist(lu_name_, p1_ => client_value_);
   END IF;
END Exist_;


FUNCTION Exist_ (
   lu_name_      IN VARCHAR2,
   client_list_  IN VARCHAR2,
   client_value_ IN VARCHAR2 ) RETURN BOOLEAN
IS
BEGIN
   RETURN Exist_Single___(client_list_, client_value_);
END Exist_;


PROCEDURE Exist_List_ (
   lu_name_      IN VARCHAR2,
   client_list_  IN VARCHAR2,
   client_value_ IN VARCHAR2 )
IS
BEGIN
   IF NOT (Exist_List_(lu_name_, client_list_, client_value_)) THEN
     Error_SYS.Record_Not_Exist(lu_name_, p1_ => Get_First_Nonexistent_Item___(client_list_,client_value_,list_separator_));
   END IF;
END Exist_List_;


FUNCTION Exist_List_ (
   lu_name_      IN VARCHAR2,
   client_list_  IN VARCHAR2,
   client_value_ IN VARCHAR2 ) RETURN BOOLEAN
IS
BEGIN
   RETURN Exist_Multi___(client_list_, client_value_,list_separator_);
END Exist_List_;


PROCEDURE Exist_List_Db_ (
   lu_name_      IN VARCHAR2,
   client_list_  IN VARCHAR2,
   client_value_ IN VARCHAR2 )
IS
BEGIN
   IF NOT (Exist_List_Db_(lu_name_, client_list_, client_value_)) THEN
     Error_SYS.Record_Not_Exist(lu_name_, p1_ => Get_First_Nonexistent_Item___(client_list_,client_value_,Client_SYS.text_separator_));
   END IF;
END Exist_List_Db_;


FUNCTION Exist_List_Db_ (
   lu_name_      IN VARCHAR2,
   client_list_  IN VARCHAR2,
   client_value_ IN VARCHAR2 ) RETURN BOOLEAN
IS
BEGIN
   RETURN Exist_Multi___(client_list_, client_value_,Client_SYS.text_separator_);
END Exist_List_Db_;


FUNCTION Enumerate_ (
   client_list_ IN VARCHAR2 ) RETURN VARCHAR2
IS
BEGIN
   RETURN(replace(client_list_, '^', separator_));
END Enumerate_;


FUNCTION Encode_ (
   client_list_  IN VARCHAR2,
   db_list_      IN VARCHAR2,
   client_value_ IN VARCHAR2 ) RETURN VARCHAR2
IS
BEGIN
   RETURN Encode_Single___(client_list_, db_list_, client_value_);
END Encode_;


FUNCTION Encode_List_ (
   client_list_  IN VARCHAR2,
   db_list_      IN VARCHAR2,
   client_value_ IN VARCHAR2 ) RETURN VARCHAR2
IS
BEGIN
   RETURN Encode_Multi___(client_list_, db_list_, client_value_);
END Encode_List_;


FUNCTION Decode_ (
   client_list_ IN VARCHAR2,
   db_list_     IN VARCHAR2,
   db_value_    IN VARCHAR2 ) RETURN VARCHAR2
IS
BEGIN
   RETURN Decode_Single___(client_list_, db_list_, db_value_);
END Decode_;


FUNCTION Decode_List_ (
   client_list_ IN VARCHAR2,
   db_list_     IN VARCHAR2,
   db_value_    IN VARCHAR2 ) RETURN VARCHAR2
IS
BEGIN
   RETURN Decode_Multi___(client_list_, db_list_, db_value_);
END Decode_List_;


FUNCTION Decode_Subset_ (
   client_list_ IN VARCHAR2,
   db_list_     IN VARCHAR2,
   db_sub_list_ IN VARCHAR2 ) RETURN VARCHAR2
IS
   db_     NUMBER;
   db2_    NUMBER;
   client_ NUMBER;
   temp_   VARCHAR2(2000);
   temp2_  VARCHAR2(2000);
   index_  NUMBER;
   index2_ NUMBER;
   translated_list_ VARCHAR2(2000);
BEGIN
   db_     := 1;
   LOOP
      index_  := instr(db_sub_list_, '^', db_);
      EXIT WHEN (index_ = 0);

      temp_   := substr(db_sub_list_, db_, index_-db_);
      db_     := index_+1;

      db2_ := 1;
      client_ := 1;
      LOOP
         index2_ := instr(db_list_, '^', db2_);
         EXIT WHEN (index2_ = 0);
         temp2_ := substr(db_list_, db2_,index2_-db2_);
         db2_ := index2_ + 1;
         index2_  := instr(client_list_, '^', client_);
         IF (temp_ = temp2_) THEN
            IF (translated_list_ IS NULL) THEN
               translated_list_ := substr(client_list_, client_, index2_-client_)|| '^';
            ELSE
               translated_list_ := translated_list_ ||substr(client_list_, client_, index2_-client_)|| '^';
            END IF;
         END IF;
         client_ := index2_+1;
      END LOOP;
   END LOOP;
   RETURN translated_list_;
END Decode_Subset_;


FUNCTION Get_Db_Value_ (
   db_list_ IN VARCHAR2,
   index_   IN NUMBER ) RETURN VARCHAR2
IS
   from_ NUMBER;
   to_   NUMBER;
BEGIN
   to_   := instr(db_list_, '^', 1, index_+1);
   IF (index_ = 0) THEN
      RETURN(substr(db_list_, 0, to_-1));
   ELSE
      from_ := instr(db_list_, '^', 1, index_);
      RETURN(substr(db_list_, from_+1, to_-from_-1));
   END IF;
END Get_Db_Value_;


FUNCTION Get_Client_Value_ (
   client_list_ IN VARCHAR2,
   index_       IN NUMBER ) RETURN VARCHAR2
IS
   from_ NUMBER;
   to_   NUMBER;
BEGIN
   to_   := instr(client_list_, '^', 1, index_+1);
   IF (index_ = 0) THEN
      RETURN(substr(client_list_, 0, to_-1));
   ELSE
      from_ := instr(client_list_, '^', 1, index_);
      RETURN(substr(client_list_, from_+1, to_-from_-1));
   END IF;
END Get_Client_Value_;


FUNCTION Get_Nls_Client_List_ (
   lu_name_     IN  VARCHAR2,
   client_list_ IN  VARCHAR2 ) RETURN VARCHAR2
IS
BEGIN
   RETURN(Get_Translated_Values(lu_name_));
END Get_Nls_Client_List_;


PROCEDURE Refresh_Language_
IS
--
-- Changed cursor only to include IID-domains
--
   stmt_                    VARCHAR2(1000);
   refresh_method_ CONSTANT VARCHAR2(20) := 'LANGUAGE_REFRESHED';

   CURSOR lang_ref IS
      SELECT object_name package_name
      FROM   user_procedures p
      WHERE  procedure_name = refresh_method_
      AND    object_name NOT IN ('DOMAIN_SYS', 'CUSTOM_FIELDS_SYS');

BEGIN
   FOR pkg IN lang_ref LOOP
      stmt_ := 'BEGIN ' || pkg.package_name || '.' || refresh_method_||' ; END;';
      -- No need for Assert check as values are fetched from Oracle Dictionary
      -- Assert_SYS.Assert_Is_Package_Method(pkg.package_name, refresh_method_);
      Run_Statement___(stmt_);
   END LOOP;
END Refresh_Language_;


PROCEDURE Refresh_Language_ (
   lu_   IN VARCHAR2 )
IS
--
-- Changed cursor only to include IID-domains
--
   stmt_                    VARCHAR2(1000);
   refresh_method_ CONSTANT VARCHAR2(20) := 'LANGUAGE_REFRESHED';
   pkg_ VARCHAR2(30);
BEGIN
null;
END Refresh_Language_;


PROCEDURE Refresh_Component_Language_ (
   component_ IN VARCHAR2 )
IS
   stmt_                    VARCHAR2(1000);
   refresh_method_ CONSTANT VARCHAR2(20) := 'LANGUAGE_REFRESHED';


BEGIN
null;
END Refresh_Component_Language_;

-----------------------------------------------------------------------------
-------------------- LU SPECIFIC IMPLEMENTATION METHODS ---------------------
-----------------------------------------------------------------------------

FUNCTION Client_Value_Is_List___ (client_value_ IN VARCHAR2 ) RETURN BOOLEAN
IS
BEGIN
  RETURN (SUBSTR(client_value_,0,1) = Client_SYS.text_separator_); --value lists starts with ^
END Client_Value_Is_List___;


FUNCTION Get_First_Nonexistent_Item___ (
     client_list_ IN VARCHAR2,
     client_value_ IN VARCHAR2,
     delimiter_ IN VARCHAR2) RETURN VARCHAR2
IS
     split_str_ VARCHAR2(4000);
     count_ NUMBER;
BEGIN
     split_str_ := LTRIM(client_value_, delimiter_);
     IF (substr(split_str_, length(split_str_), 1) <> delimiter_ ) THEN
        split_str_ := split_str_ || delimiter_;
     END IF;

     RETURN NULL;
END Get_First_Nonexistent_Item___;


FUNCTION Exist_Single___ (
	client_list_ IN VARCHAR2,
	client_value_item_ IN VARCHAR2 ) RETURN BOOLEAN
IS
BEGIN
   IF (('^'||client_list_ NOT LIKE '%^'||client_value_item_||'^%') OR (client_value_item_ IS NULL)) THEN
      RETURN(FALSE);
   ELSE
      RETURN(TRUE);
   END IF;
END Exist_Single___;


FUNCTION Exist_Multi___ (
	client_list_ IN VARCHAR2,
	client_value_list_ IN VARCHAR2,
   delimiter_ IN VARCHAR2) RETURN BOOLEAN
IS
BEGIN
     RETURN (Get_First_Nonexistent_Item___(client_list_, client_value_list_,delimiter_) IS NULL);
END Exist_Multi___;


FUNCTION Encode_Single___ (
   client_list_  IN VARCHAR2,
   db_list_      IN VARCHAR2,
   client_value_ IN VARCHAR2 ) RETURN VARCHAR2
IS
   db_     NUMBER;
   client_ NUMBER;
   temp_   VARCHAR2(2000);
   index_  NUMBER;
BEGIN
   db_     := 1;
   client_ := 1;
   LOOP
      index_  := instr(client_list_, '^', client_);
      EXIT WHEN ( nvl(index_, 0) = 0 );
      temp_   := substr(client_list_, client_, index_-client_);
      client_ := index_+1;
      index_  := instr(db_list_, '^', db_);
      IF (temp_ = client_value_) THEN
         RETURN(substr(db_list_, db_, index_-db_));
      END IF;
      db_ := index_+1;
   END LOOP;
   RETURN(NULL);
END Encode_Single___;


FUNCTION Encode_Multi___ (
   client_list_  IN VARCHAR2,
   db_list_      IN VARCHAR2,
   client_value_ IN VARCHAR2 ) RETURN VARCHAR2
IS
   split_str_ VARCHAR2(4000);
   encoded_ VARCHAR2(4000);
   encoded_item_ VARCHAR2(4000);
   delimiter_ CONSTANT VARCHAR2(1) := Client_SYS.text_separator_;
   count_ NUMBER;

BEGIN
	split_str_ := LTRIM(client_value_, list_separator_);

   IF LENGTH(encoded_) > 0 THEN
      encoded_ := delimiter_ || encoded_;
   END IF;

   RETURN(encoded_);

END Encode_Multi___;


FUNCTION Decode_Single___ (
   client_list_ IN VARCHAR2,
   db_list_     IN VARCHAR2,
   db_value_    IN VARCHAR2 ) RETURN VARCHAR2
IS
   db_     NUMBER;
   client_ NUMBER;
   temp_   VARCHAR2(2000);
   index_  NUMBER;
BEGIN
   db_     := 1;
   client_ := 1;
   LOOP
      index_  := instr(db_list_, '^', db_);
      EXIT WHEN ( nvl(index_, 0) = 0);
      temp_   := substr(db_list_, db_, index_-db_);
      db_     := index_+1;
      index_  := instr(client_list_, '^', client_);
      IF (temp_ = db_value_ OR (temp_ IS NULL AND db_value_ IS NULL)) THEN
         RETURN(substr(client_list_, client_, index_-client_));
      END IF;
      client_ := index_+1;
   END LOOP;
   RETURN(NULL);
END Decode_Single___;


FUNCTION Decode_Multi___ (
   client_list_ IN VARCHAR2,
   db_list_     IN VARCHAR2,
   db_value_    IN VARCHAR2 ) RETURN VARCHAR2
IS
   split_str_ VARCHAR2(4000);
   decoded_ VARCHAR2(4000);
   decoded_item_ VARCHAR2(4000);
   delimiter_ CONSTANT VARCHAR2(1) := Client_SYS.text_separator_;
   count_ NUMBER;

BEGIN
	split_str_ := LTRIM(db_value_, delimiter_);

   decoded_ := RTRIM(decoded_,list_separator_);

   RETURN(decoded_);
END Decode_Multi___;


FUNCTION Get_Ctx_Values___ (
   domain_ IN VARCHAR2,
   value_  IN VARCHAR2 DEFAULT NULL ) RETURN VARCHAR2
IS
   client_id_     CONSTANT VARCHAR2(64) := Sys_Context('USERENV', 'CLIENT_IDENTIFIER');
   context_       CONSTANT VARCHAR2(30) := domain_ ||suffix_;
   context_value_          VARCHAR2(4000);
BEGIN
   -- We would like to have this check, but it is causing a lot of problems right now.
   -- Raise an error if the domain name is not in the Dictionary
   --IF (NOT Dictionary_SYS.Logical_Unit_Is_Installed(domain_)) THEN
   --   Error_SYS.Appl_General(service_, 'NOT_A_LU: The domain [:P1] is not a LU in the Dictionary.', domain_);
   --END IF;
   -- The use of global context does not handle when Client Identifier is set, therefore we need to unset it when fetching from the context
   -- If client identifier is set
   IF (client_id_ IS NOT NULL) THEN
      -- Clear client identifier
      Dbms_Session.Clear_Identifier;
      context_value_ := Sys_Context(context_, nvl(value_, 'PROG'), ctx_length_); -- Use PROG if no language
      -- Set back Client identifier
      Dbms_Session.Set_Identifier(client_id_);
   ELSE
      context_value_ := Sys_Context(context_, nvl(value_, 'PROG'), ctx_length_);  -- Use PROG if no language
   END IF;
   RETURN(context_value_);
EXCEPTION
   -- What ever happens make sure that Client Identifier is set to its original value
   WHEN OTHERS THEN
      Dbms_Session.Set_Identifier(client_id_);
      RAISE;
END Get_Ctx_Values___;


PROCEDURE Set_Ctx_Values___ (
   context_    IN VARCHAR2,
   attribute_  IN VARCHAR2,
   value_      IN VARCHAR2 )
IS
   client_id_     CONSTANT VARCHAR2(64) := Sys_Context('USERENV', 'CLIENT_IDENTIFIER');
BEGIN
   IF (client_id_ IS NOT NULL) THEN
      -- Clear client identifier
      Dbms_Session.Clear_Identifier;
      Dbms_Session.Set_Context(namespace => context_,
                               attribute => attribute_,
                               VALUE     => value_);
      -- Set back Client identifier
      Dbms_Session.Set_Identifier(client_id_);
   ELSE
      Dbms_Session.Set_Context(namespace => context_,
                               attribute => attribute_,
                               VALUE     => value_);
   END IF;
END Set_Ctx_Values___;


FUNCTION Get_Client_Values___ (
   domain_ IN VARCHAR2 ) RETURN VARCHAR2
IS
BEGIN
   RETURN(Get_Ctx_Values___(domain_, 'PROG'));
END Get_Client_Values___;


FUNCTION Is_Domain_Loaded___ (
   domain_ IN VARCHAR2 ) RETURN VARCHAR2
IS
   loaded_        VARCHAR2(5):= nvl(Get_Ctx_Values___(domain_, 'LOADED'), 'FALSE');
   package_name_  VARCHAR2(30);
   no_enumeration EXCEPTION;
   PRAGMA EXCEPTION_INIT(no_enumeration, -6550);
BEGIN
   IF (loaded_ =  'FALSE' ) THEN
      loaded_ := nvl(Get_Ctx_Values___(domain_, 'LOADED'), 'FALSE');
   END IF;
   RETURN(loaded_);
EXCEPTION
   WHEN no_enumeration THEN
      RETURN('FALSE');
END Is_Domain_Loaded___;


PROCEDURE Load_Translations___ (
   domain_ IN VARCHAR2,
   type_   IN VARCHAR2 DEFAULT 'IID' )
IS

   context_       CONSTANT VARCHAR2(30) := domain_ ||suffix_;


BEGIN
null;
END Load_Translations___;


PROCEDURE Run_Statement___ (
   stmt_ IN VARCHAR2 )
IS
BEGIN
   --@ApproveDynamicStatement(2011-05-30,haarse)
   EXECUTE IMMEDIATE stmt_;
END Run_Statement___;

-----------------------------------------------------------------------------
-------------------- FOUNDATION1 METHODS ------------------------------------
-----------------------------------------------------------------------------


--@IgnoreMissingSysinit
PROCEDURE Init
IS

   PROCEDURE Base
   IS
   BEGIN
      NULL;
   END Base;

BEGIN
   Base;
END Init;


--@IgnoreMissingSysinit
PROCEDURE Language_Refreshed (
   domain_            IN VARCHAR2,
   client_value_list_ IN VARCHAR2,
   db_value_list_     IN VARCHAR2,
   type_              IN VARCHAR2 DEFAULT 'IID' )
IS

   PROCEDURE Foundation1 (
      domain_            IN VARCHAR2,
      client_value_list_ IN VARCHAR2,
      db_value_list_     IN VARCHAR2,
      type_              IN VARCHAR2 DEFAULT 'IID' )
   IS
      context_       CONSTANT VARCHAR2(30) := domain_ || suffix_;

      no_context     EXCEPTION;
      PRAGMA EXCEPTION_INIT(no_context, -1031);
   BEGIN
      -- Don't do refresh during installation
      Dbms_Session.Clear_All_Context(context_);
      Set_Ctx_Values___(context_, 'PROG', client_value_list_);
      Set_Ctx_Values___(context_, 'DB', db_value_list_);
      --
   EXCEPTION
      WHEN no_context THEN
         Error_SYS.Appl_General(service_, 'NO_CONTEXT: Context [:P1] seems to be missing.', context_);
   END Foundation1;

BEGIN
   Foundation1(domain_, client_value_list_, db_value_list_, type_);
END Language_Refreshed;

BEGIN
   Init;
END DOMAIN_SYS;
-- [END A7 COMPLETE BLOCK]
/


--
-- ERROR_SYS  (Package Body) 
--
--  Dependencies: 
--   ERROR_SYS (Package)
--   UTL_CALL_STACK (Synonym)
--   DBMS_STANDARD (Package)
--   STANDARD (Package)
--   CLIENT_SYS (Package)
--
CREATE OR REPLACE PACKAGE BODY VTAPP.ERROR_SYS IS

-----------------------------------------------------------------------------
-------------------- PRIVATE DECLARATIONS -----------------------------------
-----------------------------------------------------------------------------

separator_ CONSTANT VARCHAR2(1) := chr(8);

line_feed_ CONSTANT VARCHAR2(1) := chr(10);

line_feed_marker_ CONSTANT VARCHAR2(2) := 'LF';

carriage_return_ CONSTANT VARCHAR2(1) := chr(13);

carriage_return_marker_ CONSTANT VARCHAR2(2) := 'CR';


-----------------------------------------------------------------------------
-------------------- IMPLEMENTATION METHOD DECLARATIONS ---------------------
-----------------------------------------------------------------------------

FUNCTION Get_Space_Validation___ (
   value_ IN VARCHAR2) RETURN VARCHAR2;

PROCEDURE Raise_Application_Error___ (
   error_no_   IN VARCHAR2,
   error_text_ IN VARCHAR2 );

FUNCTION Nls_Translate___ (
   lu_name_   IN VARCHAR2,
   err_text_  IN VARCHAR2,
   lang_code_ IN VARCHAR2 DEFAULT NULL,
   p1_        IN VARCHAR2 DEFAULT NULL,
   p2_        IN VARCHAR2 DEFAULT NULL,
   p3_        IN VARCHAR2 DEFAULT NULL,
   service_name_ IN VARCHAR2 DEFAULT NULL) RETURN VARCHAR2;

FUNCTION Nls_Msg___ (
   lu_name_   IN VARCHAR2,
   err_text_  IN VARCHAR2,
   p1_        IN VARCHAR2 DEFAULT NULL,
   p2_        IN VARCHAR2 DEFAULT NULL,
   p3_        IN VARCHAR2 DEFAULT NULL,
   lang_code_ IN VARCHAR2 DEFAULT NULL,
   service_name_ IN VARCHAR2 DEFAULT NULL) RETURN VARCHAR2;

FUNCTION Nls_Msg_10___ (
   lu_name_   IN VARCHAR2,
   err_text_  IN VARCHAR2,
   p1_        IN VARCHAR2 DEFAULT NULL,
   p2_        IN VARCHAR2 DEFAULT NULL,
   p3_        IN VARCHAR2 DEFAULT NULL,
   p4_        IN VARCHAR2 DEFAULT NULL,
   p5_        IN VARCHAR2 DEFAULT NULL,
   p6_        IN VARCHAR2 DEFAULT NULL,
   p7_        IN VARCHAR2 DEFAULT NULL,
   p8_        IN VARCHAR2 DEFAULT NULL,
   p9_        IN VARCHAR2 DEFAULT NULL,
   p10_       IN VARCHAR2 DEFAULT NULL,
   lang_code_ IN VARCHAR2 DEFAULT NULL ) RETURN VARCHAR2;

FUNCTION Nls_Item_Prompt___ (
   lu_name_ IN VARCHAR2,
   item_    IN VARCHAR2 ) RETURN VARCHAR2;

FUNCTION Nls_Lu_Prompt___ (
   lu_name_ IN VARCHAR2 ) RETURN VARCHAR2;

FUNCTION Get_Key_Reg_Exp___(
   client_string_ IN VARCHAR2) RETURN VARCHAR2;

-----------------------------------------------------------------------------
-------------------- LU SPECIFIC IMPLEMENTATION METHODS ---------------------
-----------------------------------------------------------------------------

FUNCTION Get_Formatted_Error_Text (
   lu_name_   IN VARCHAR2,
   err_text_  IN VARCHAR2,
   p1_        IN VARCHAR2 DEFAULT NULL,
   p2_        IN VARCHAR2 DEFAULT NULL,
   p3_        IN VARCHAR2 DEFAULT NULL,
   p4_        IN VARCHAR2 DEFAULT NULL,
   p5_        IN VARCHAR2 DEFAULT NULL,
   p6_        IN VARCHAR2 DEFAULT NULL,
   p7_        IN VARCHAR2 DEFAULT NULL,
   p8_        IN VARCHAR2 DEFAULT NULL,
   p9_        IN VARCHAR2 DEFAULT NULL,
   p10_       IN VARCHAR2 DEFAULT NULL,
   lang_code_ IN VARCHAR2 DEFAULT NULL ) RETURN VARCHAR2
IS
BEGIN
   RETURN Nls_Msg_10___(lu_name_,err_text_,p1_,p2_,p3_,p4_,p5_,p6_,p7_,p8_,p9_,p10_,lang_code_);
END Get_Formatted_Error_Text;


FUNCTION Get_Space_Validation___ (
   value_ IN VARCHAR2) RETURN VARCHAR2
IS
BEGIN
   IF LENGTH(value_) != LENGTH(LTRIM(value_)) THEN
      RETURN 'LEFT';
   END IF;
   IF LENGTH(value_) != LENGTH(RTRIM(value_)) THEN
      RETURN 'RIGHT';
   END IF;
   RETURN NULL;
END Get_Space_Validation___;


PROCEDURE Raise_Application_Error___ (
   error_no_   IN VARCHAR2,
   error_text_ IN VARCHAR2 )
IS
   call_stack_ VARCHAR2(32000);
   FUNCTION Format_Call_Stack___ RETURN VARCHAR2
   IS
      stack_ VARCHAR2(32000);
      depth_ PLS_INTEGER := Utl_Call_Stack.Dynamic_Depth();
   BEGIN
      FOR i_ IN REVERSE 1 .. depth_ LOOP
         stack_ := stack_ || UTL_Call_Stack.Concatenate_Subprogram(UTL_Call_Stack.Subprogram(i_)) || ' at line ' || To_Char(UTL_Call_Stack.Unit_Line(i_)) || chr(10);
      END LOOP;
      RETURN stack_;
   END Format_Call_Stack___;
BEGIN
   BEGIN
      call_stack_ := Format_Call_Stack___;
      -- Send the error stack
      --Fnd_Context_SYS.Set_Value('EXCEPTION', Fnd_Boolean_API.DB_TRUE);
      -- Conditional compilation for Oracle12c
      --Fnd_Context_SYS.Set_Value('ERROR_CALL_STACK', call_stack_);
      --Log_SYS.Stack_Trace_(Log_SYS.Debug_, call_stack_);
   EXCEPTION
      WHEN OTHERS THEN
         --Fnd_Context_SYS.Set_Value('ERROR_CALL_STACK', Dbms_Utility.Format_Error_Backtrace);
         RAISE;
   END;
   Raise_Application_Error(error_no_, error_text_);
END Raise_Application_Error___;


FUNCTION Nls_Translate___ (
   lu_name_   IN VARCHAR2,
   err_text_  IN VARCHAR2,
   lang_code_ IN VARCHAR2 DEFAULT NULL,
   p1_        IN VARCHAR2 DEFAULT NULL,
   p2_        IN VARCHAR2 DEFAULT NULL,
   p3_        IN VARCHAR2 DEFAULT NULL,
   service_name_ IN VARCHAR2 DEFAULT NULL) RETURN VARCHAR2
IS
   temp_ VARCHAR2(32000);
BEGIN

   RETURN(Nls_Msg___(lu_name_, err_text_, p1_, p2_, p3_, lang_code_,service_name_));
END Nls_Translate___;


FUNCTION Nls_Msg___ (
   lu_name_   IN VARCHAR2,
   err_text_  IN VARCHAR2,
   p1_        IN VARCHAR2 DEFAULT NULL,
   p2_        IN VARCHAR2 DEFAULT NULL,
   p3_        IN VARCHAR2 DEFAULT NULL,
   lang_code_ IN VARCHAR2 DEFAULT NULL,
   service_name_ IN VARCHAR2 DEFAULT NULL) RETURN VARCHAR2
IS
   temp_ VARCHAR2(32000);
BEGIN
   temp_ := replace(err_text_, ':P1', p1_);
   temp_ := replace(temp_, ':P2', p2_);
   temp_ := replace(temp_, ':P3', p3_);
   temp_ := replace(temp_, ':LU', Nls_Lu_Prompt___(lu_name_));
   -- Clear obsolete client info before the error is raised
   Client_SYS.Clear_Info;
   RETURN(substr(temp_,1,1950));
END Nls_Msg___;


FUNCTION Nls_Msg_10___ (
   lu_name_   IN VARCHAR2,
   err_text_  IN VARCHAR2,
   p1_        IN VARCHAR2 DEFAULT NULL,
   p2_        IN VARCHAR2 DEFAULT NULL,
   p3_        IN VARCHAR2 DEFAULT NULL,
   p4_        IN VARCHAR2 DEFAULT NULL,
   p5_        IN VARCHAR2 DEFAULT NULL,
   p6_        IN VARCHAR2 DEFAULT NULL,
   p7_        IN VARCHAR2 DEFAULT NULL,
   p8_        IN VARCHAR2 DEFAULT NULL,
   p9_        IN VARCHAR2 DEFAULT NULL,
   p10_       IN VARCHAR2 DEFAULT NULL,
   lang_code_ IN VARCHAR2 DEFAULT NULL ) RETURN VARCHAR2
IS
   temp_ VARCHAR2(32000);
BEGIN
   temp_ := replace(err_text_, ':P1', p1_);
   temp_ := replace(temp_, ':P2', p2_);
   temp_ := replace(temp_, ':P3', p3_);
   temp_ := replace(temp_, ':P4', p4_);
   temp_ := replace(temp_, ':P5', p5_);
   temp_ := replace(temp_, ':P6', p6_);
   temp_ := replace(temp_, ':P7', p7_);
   temp_ := replace(temp_, ':P8', p8_);
   temp_ := replace(temp_, ':P9', p9_);
   temp_ := replace(temp_, ':P10', p10_);
   temp_ := replace(temp_, ':LU', Nls_Lu_Prompt___(lu_name_));

   RETURN(substr(temp_,1,1950));
END Nls_Msg_10___;


FUNCTION Nls_Item_Prompt___ (
   lu_name_ IN VARCHAR2,
   item_    IN VARCHAR2 ) RETURN VARCHAR2
IS
BEGIN
   RETURN item_;
END Nls_Item_Prompt___;


FUNCTION Nls_Lu_Prompt___ (
   lu_name_ IN VARCHAR2 ) RETURN VARCHAR2
IS
BEGIN
   RETURN lu_name_;
END Nls_Lu_Prompt___;


FUNCTION Get_Key_Reg_Exp___(
   client_string_ IN VARCHAR2) RETURN VARCHAR2
IS
   reg_exp_reserved_list_     VARCHAR2(5) := '.([)]';
   length_                    NUMBER := length(client_string_);
   temp_char_                 VARCHAR2(1);
   temp_multi_chars_          VARCHAR2(32000);
   temp_multichar_encoded_    VARCHAR2(32000);
   temp_multichar_member_     VARCHAR2(1);
   pos_                       NUMBER := 1;
   normal_chars_              VARCHAR2(32000);
   special_chars_             VARCHAR2(32000);
   multiple_chars_            VARCHAR2(32000);
   multiple_seperator_open_   VARCHAR2(1) := '(';
   multiple_seperator_close_  VARCHAR2(1) := ')';

BEGIN
   WHILE pos_ <= length_ LOOP
      temp_char_ := SUBSTR(client_string_, pos_, 1);
      IF temp_char_ = multiple_seperator_open_ AND SUBSTR(client_string_, pos_+1, 1)!= multiple_seperator_open_ THEN
         --extract the multiple character pair
         -- looking for the next matching end paranthesis
         temp_multi_chars_ := SUBSTR(client_string_, pos_+1,INSTR(SUBSTR(client_string_, pos_+1),multiple_seperator_close_)-1);
         --safety precaution to encode special chars if any
         temp_multichar_encoded_ := '';
         FOR i IN 1..LENGTH(temp_multi_chars_) LOOP
            temp_multichar_member_ := SUBSTR(temp_multi_chars_,i,1);
            IF INSTR(reg_exp_reserved_list_,temp_multichar_member_)>0 THEN
               temp_multichar_encoded_ := temp_multichar_encoded_ || '\' ||temp_multichar_member_ ;
            ELSE
               temp_multichar_encoded_ := temp_multichar_encoded_ || temp_multichar_member_ ;
            END IF;
         END LOOP;
         multiple_chars_ := multiple_chars_ || '|' || '(' || temp_multichar_encoded_ || ')';
         pos_ := pos_ + LENGTH(temp_multi_chars_) +1;
      ELSE
         IF temp_char_ = multiple_seperator_close_ AND SUBSTR(client_string_, pos_+1, 1)!= multiple_seperator_close_ THEN
            pos_ := pos_ + 1;
         ELSE
            IF (temp_char_ = multiple_seperator_open_ AND SUBSTR(client_string_, pos_+1, 1) = multiple_seperator_open_) OR  (temp_char_ = multiple_seperator_close_ AND SUBSTR(client_string_, pos_+1, 1) = multiple_seperator_close_) THEN
               pos_ := pos_ +1;
               temp_char_ := SUBSTR(client_string_, pos_, 1);
            END IF;

            IF INSTR(reg_exp_reserved_list_,temp_char_) > 0 THEN
               special_chars_ := special_chars_ || '\' ||temp_char_ ||'|';
            ELSE
               normal_chars_ := normal_chars_ || temp_char_;
            END IF;
            pos_ := pos_ + 1;
         END IF;
      END IF;
   END LOOP;
   -- Create the regular expression
   IF special_chars_ IS NOT NULL  THEN
      special_chars_ := '(' || SUBSTR(special_chars_,1, length(special_chars_)-1) || ')|';
   END IF;
   IF multiple_chars_ IS NOT NULL  THEN
      multiple_chars_ := SUBSTR(multiple_chars_,2, length(multiple_chars_)) || '|';
   END IF;
   normal_chars_ := '['||normal_chars_||']';

   RETURN '(' || special_chars_ || multiple_chars_ || normal_chars_ || ')';
END Get_Key_Reg_Exp___;

-----------------------------------------------------------------------------
-------------------- LU SPECIFIC PUBLIC METHODS -----------------------------
-----------------------------------------------------------------------------

PROCEDURE System_General (
   err_text_ IN VARCHAR2,
   p1_       IN VARCHAR2 DEFAULT NULL,
   p2_       IN VARCHAR2 DEFAULT NULL,
   p3_       IN VARCHAR2 DEFAULT NULL )
IS
   text_ VARCHAR2(2000);
BEGIN
   text_ := err_text_;
   text_ := replace(text_, ':P1', p1_);
   text_ := replace(text_, ':P2', p2_);
   text_ := replace(text_, ':P3', p3_);
   Raise_Application_Error___(-20100, service_||'.'||text_);
END System_General;


PROCEDURE Appl_General (
   lu_name_   IN VARCHAR2,
   err_text_  IN VARCHAR2,
   p1_        IN VARCHAR2 DEFAULT NULL,
   p2_        IN VARCHAR2 DEFAULT NULL,
   p3_        IN VARCHAR2 DEFAULT NULL,
   lang_code_ IN VARCHAR2 DEFAULT NULL )
IS
   text_ VARCHAR2(2000);
BEGIN
   text_ := Nls_Msg___(lu_name_, err_text_, p1_, p2_, p3_, lang_code_);
   Raise_Application_Error___(-20105, lu_name_||'.'||text_);
END Appl_General;


PROCEDURE Record_General (
   lu_name_  IN VARCHAR2,
   err_text_ IN VARCHAR2,
   p1_       IN VARCHAR2 DEFAULT NULL,
   p2_       IN VARCHAR2 DEFAULT NULL,
   p3_       IN VARCHAR2 DEFAULT NULL )
IS
   text_ VARCHAR2(2000);
BEGIN
   text_ := Nls_Msg___(lu_name_, err_text_, p1_, p2_, p3_);
   Raise_Application_Error___(-20110, lu_name_||'.'||text_);
END Record_General;


PROCEDURE Fnd_Record_Not_Exist (
   lu_name_       IN VARCHAR2 )
IS
   text_ VARCHAR2(2000) := Nls_Translate___(lu_name_, 'FND_RECORD_NOT_EXIST: The :LU does not exist.', 'ru',service_name_=>service_);
BEGIN
   Raise_Application_Error___(-20111, lu_name_||'.'||text_);
END Fnd_Record_Not_Exist;


PROCEDURE Record_Not_Exist (
   lu_name_  IN VARCHAR2,
   err_text_ IN VARCHAR2 DEFAULT NULL,
   p1_       IN VARCHAR2 DEFAULT NULL,
   p2_       IN VARCHAR2 DEFAULT NULL,
   p3_       IN VARCHAR2 DEFAULT NULL )
IS
   text_ VARCHAR2(2000);
BEGIN
   IF (err_text_ IS NOT NULL) THEN
      text_ := Nls_Msg___(lu_name_, err_text_, p1_, p2_, p3_);
   ELSE
      IF p1_ IS NOT NULL THEN
         text_ := Nls_Msg___(lu_name_, 'NOTEXIST: The :LU ":P1" does not exist.', p1_,service_name_=>service_);
      ELSE
         text_ := Nls_Msg___(lu_name_, 'NOTEXIST2: The :LU object does not exist.',service_name_=>service_);
      END IF;
   END IF;
   Raise_Application_Error___(-20111, lu_name_||'.'||text_);
END Record_Not_Exist;


PROCEDURE Record_Exist (
   lu_name_  IN VARCHAR2,
   err_text_ IN VARCHAR2 DEFAULT NULL,
   p1_       IN VARCHAR2 DEFAULT NULL,
   p2_       IN VARCHAR2 DEFAULT NULL,
   p3_       IN VARCHAR2 DEFAULT NULL )
IS
   text_ VARCHAR2(2000);
BEGIN
   IF (err_text_ IS NOT NULL) THEN
      text_ := Nls_Msg___(lu_name_, err_text_, p1_, p2_, p3_);
   ELSE
      IF p1_ IS NOT NULL THEN
         text_ := Nls_Msg___(lu_name_, 'EXIST: The :LU ":P1" already exists.', p1_,service_name_=>service_);
      ELSE
         text_ := Nls_Msg___(lu_name_, 'EXIST2: The :LU object already exists.',service_name_=>service_);
      END IF;
   END IF;
   Raise_Application_Error___(-20112, lu_name_||'.'||text_);
END Record_Exist;


PROCEDURE Fnd_Record_Exist (
   lu_name_       IN VARCHAR2 )
IS
   text_ VARCHAR2(2000) := Nls_Translate___(lu_name_, 'FND_RECORD_EXIST: The :LU already exists.', 'ru' ,service_name_=>service_);
BEGIN
   Raise_Application_Error___(-20112, lu_name_||'.'||text_);
END Fnd_Record_Exist;


PROCEDURE Rowkey_Exist (
   lu_name_  IN VARCHAR2,
   rowkey_   IN VARCHAR2 )
IS
   text_ VARCHAR2(2000);
BEGIN
   text_ := Nls_Msg___(service_, 'ROWKEY_EXIST: The rowkey :P2 for ":P1" already exists.', lu_name_, rowkey_,service_name_=>service_);
   Raise_Application_Error___(-20160, lu_name_||'.'||text_);
END Rowkey_Exist;


PROCEDURE Fnd_Rowkey_Exist (
   lu_name_       IN VARCHAR2,
   rowkey_        IN VARCHAR2 )
IS
   text_ VARCHAR2(2000) := Nls_Translate___(lu_name_, 'FND_ROWKEY_EXIST: The rowkey ":P1" for :LU already exists.', 'ru' , rowkey_,service_name_=>service_);
BEGIN
   Raise_Application_Error___(-20160, text_);
END Fnd_Rowkey_Exist;


PROCEDURE Record_Locked (
   lu_name_  IN VARCHAR2,
   err_text_ IN VARCHAR2 DEFAULT NULL,
   p1_       IN VARCHAR2 DEFAULT NULL,
   p2_       IN VARCHAR2 DEFAULT NULL,
   p3_       IN VARCHAR2 DEFAULT NULL )
IS
   text_ VARCHAR2(2000);
BEGIN
   IF (err_text_ IS NOT NULL) THEN
      text_ := Nls_Msg___(lu_name_, err_text_, p1_, p2_, p3_,service_name_=>service_);
   ELSE
      IF p1_ IS NOT NULL THEN
         text_ := Nls_Msg___(lu_name_, 'LOCKED: The :LU ":P1" is locked by another user.', p1_,service_name_=>service_);
      ELSE
         text_ := Nls_Msg___(lu_name_, 'LOCKED2: The :LU object is locked by another user.',service_name_=>service_);
      END IF;
   END IF;
   Raise_Application_Error___(-20113, lu_name_||'.'||text_);
END Record_Locked;


PROCEDURE Fnd_Record_Locked (
   lu_name_       IN VARCHAR2 )
IS
   text_ VARCHAR2(2000) := Nls_Translate___(lu_name_, 'FND_LOCKED: The update could not be performed since the :LU record is currently locked. Please retry the operation.', 'ru' ,service_name_=>service_);
BEGIN
   Raise_Application_Error___(-20113, lu_name_||'.'||text_);
END Fnd_Record_Locked;


PROCEDURE Record_Modified (
   lu_name_  IN VARCHAR2,
   err_text_ IN VARCHAR2 DEFAULT NULL,
   p1_       IN VARCHAR2 DEFAULT NULL,
   p2_       IN VARCHAR2 DEFAULT NULL,
   p3_       IN VARCHAR2 DEFAULT NULL )
IS
   text_ VARCHAR2(2000);
BEGIN
   IF (err_text_ IS NOT NULL) THEN
      text_ := Nls_Msg___(lu_name_, err_text_, p1_, p2_, p3_,service_name_=>service_);
   ELSE
      IF p1_ IS NOT NULL THEN
         text_ := Nls_Msg___(lu_name_, 'MODIFIED: The :LU ":P1" has been modified by another user. Please refresh the object and reenter your changes.', p1_,service_name_=>service_);
      ELSE
         text_ := Nls_Msg___(lu_name_, 'MODIFIED2: The :LU object has been modified by another user. Please refresh the object and reenter your changes.',service_name_=>service_);
      END IF;
   END IF;
   Raise_Application_Error___(-20114, lu_name_||'.'||text_);
END Record_Modified;


PROCEDURE Fnd_Record_Modified (
   lu_name_       IN VARCHAR2 )
IS
   text_ VARCHAR2(2000) := Nls_Translate___(lu_name_, 'FND_MODIFIED: The :LU record has already been changed. Please refresh the record and reenter your changes.', 'ru' ,service_name_=>service_);
BEGIN
   Raise_Application_Error___(-20114, lu_name_||'.'||text_);
END Fnd_Record_Modified;


PROCEDURE Record_Removed (
   lu_name_  IN VARCHAR2,
   err_text_ IN VARCHAR2 DEFAULT NULL,
   p1_       IN VARCHAR2 DEFAULT NULL,
   p2_       IN VARCHAR2 DEFAULT NULL,
   p3_       IN VARCHAR2 DEFAULT NULL )

IS
   text_ VARCHAR2(2000);
BEGIN
   IF (err_text_ IS NOT NULL) THEN
      text_ := Nls_Msg___(lu_name_, err_text_, p1_, p2_, p3_,service_name_=>service_);
   ELSE
      IF p1_ IS NOT NULL THEN
         text_ := Nls_Msg___(lu_name_, 'REMOVED: The :LU ":P1" has been removed by another user.', p1_,service_name_=>service_);
      ELSE
         text_ := Nls_Msg___(lu_name_, 'REMOVED2: The :LU object has been removed by another user.',service_name_=>service_);
      END IF;
   END IF;
   Raise_Application_Error___(-20115, lu_name_||'.'||text_);
END Record_Removed;


PROCEDURE Fnd_Record_Removed (
   lu_name_       IN VARCHAR2,
   label_         IN VARCHAR2,
   value_         IN VARCHAR2,
   parent_key_msg_ IN VARCHAR2 )
IS
   text_ VARCHAR2(2000) := Nls_Translate___(lu_name_, 'The :P1 ":P2" has already been removed by another user.:P3', 'ru' , label_, value_, separator_ || parent_key_msg_,service_);
BEGIN
   Raise_Application_Error___(-20115, lu_name_||'.'||text_);
END Fnd_Record_Removed;


PROCEDURE Fnd_Record_Removed (
   lu_name_       IN VARCHAR2 )
IS
   text_ VARCHAR2(2000) := Nls_Translate___(lu_name_, 'The ":LU" has already been removed by another user.', 'ru' ,service_name_=>service_);
BEGIN
   Raise_Application_Error___(-20115, lu_name_||'.'||text_);
END Fnd_Record_Removed;


PROCEDURE Record_Constraint (
   lu_name_  IN VARCHAR2,
   info_     IN VARCHAR2,
   count_    IN VARCHAR2,
   err_text_ IN VARCHAR2 DEFAULT NULL,
   p1_       IN VARCHAR2 DEFAULT NULL,
   p2_       IN VARCHAR2 DEFAULT NULL,
   p3_       IN VARCHAR2 DEFAULT NULL )
IS
   text_ VARCHAR2(2000);
BEGIN
   IF (err_text_ IS NOT NULL) THEN
      text_ := Nls_Msg___(lu_name_, err_text_, p1_, p2_, p3_,service_name_=>service_);
   ELSE
      IF p1_ IS NOT NULL THEN
         text_ := Nls_Msg___(lu_name_, 'CONSTRAINT: The :LU ":P1" is used by :COUNT rows in another object (:INFO).', p1_,service_name_=>service_);
      ELSE
         text_ := Nls_Msg___(lu_name_, 'CONSTRAINT2: The :LU object is used by :COUNT rows in another object (:INFO).',service_name_=>service_);
      END IF;
      text_ := replace(text_, ':INFO', info_);
      text_ := replace(text_, ':COUNT', count_);
   END IF;
   Raise_Application_Error___(-20116, lu_name_||'.'||text_);
END Record_Constraint;


PROCEDURE Too_Many_Rows (
   lu_name_  IN VARCHAR2,
   err_text_ IN VARCHAR2 DEFAULT NULL,
   p1_       IN VARCHAR2 DEFAULT NULL,
   p2_       IN VARCHAR2 DEFAULT NULL,
   p3_       IN VARCHAR2 DEFAULT NULL )
IS
   text_ VARCHAR2(2000);
BEGIN
   IF (err_text_ IS NOT NULL) THEN
      text_ := Nls_Msg___(lu_name_, err_text_, p1_, p2_, p3_,service_name_=>service_);
   ELSE
      text_ := Nls_Msg___(lu_name_, 'TOO_MANY_ROWS: The method ":P1" in :LU returns more than one row.', p1_,service_name_=>service_);
   END IF;
   Raise_Application_Error___(-20117, lu_name_||'.'||text_);
END Too_Many_Rows;


PROCEDURE Fnd_Too_Many_Rows (
   lu_name_       IN VARCHAR2,
   method_name_   IN VARCHAR2,
   formatted_key_ IN VARCHAR2 )
IS
   text_ VARCHAR2(2000) := Nls_Translate___(lu_name_, 'FND_TOO_MANY_ROWS: The method ":P1" in :LU returns more than one row.', 'ru' , method_name_,service_name_=>service_);
BEGIN
   Raise_Application_Error___(-20117, lu_name_||'.'||text_);
END Fnd_Too_Many_Rows;


PROCEDURE Record_Access_Blocked (
   lu_name_  IN VARCHAR2,
   err_text_ IN VARCHAR2 DEFAULT NULL,
   p1_       IN VARCHAR2 DEFAULT NULL,
   p2_       IN VARCHAR2 DEFAULT NULL,
   p3_       IN VARCHAR2 DEFAULT NULL )
IS
   text_ VARCHAR2(2000);
BEGIN
   IF (err_text_ IS NOT NULL) THEN
      text_ := Nls_Msg___(lu_name_, err_text_, p1_, p2_, p3_,service_name_=>service_);
   ELSE
      text_ := Nls_Msg___(lu_name_, 'ACCESSBLOCKED: :LU is blocked for use.',service_name_=>service_);
   END IF;
   Raise_Application_Error___(-20118, lu_name_||'.'||text_);
END Record_Access_Blocked;


PROCEDURE Data_Access_Security (
   lu_name_   IN VARCHAR2,
   err_text_  IN VARCHAR2,
   p1_        IN VARCHAR2 DEFAULT NULL,
   p2_        IN VARCHAR2 DEFAULT NULL,
   p3_        IN VARCHAR2 DEFAULT NULL,
   p4_        IN VARCHAR2 DEFAULT NULL,
   p5_        IN VARCHAR2 DEFAULT NULL,
   p6_        IN VARCHAR2 DEFAULT NULL,
   p7_        IN VARCHAR2 DEFAULT NULL,
   p8_        IN VARCHAR2 DEFAULT NULL,
   p9_        IN VARCHAR2 DEFAULT NULL,
   p10_       IN VARCHAR2 DEFAULT NULL,
   lang_code_ IN VARCHAR2 DEFAULT NULL )
IS
   text_ VARCHAR2(4000);
BEGIN
   text_ := Nls_Msg_10___(lu_name_, err_text_, p1_, p2_, p3_, p4_, p5_, p6_, p7_, p8_, p9_, p10_, lang_code_);
   -- Clear obsolete client info before the error is raised
   Client_SYS.Clear_Info;
   Raise_Application_Error___(-20119, lu_name_||'.'||text_);
END Data_Access_Security;


PROCEDURE Appl_Failure (
   lu_name_    IN VARCHAR2,
   caller_     IN VARCHAR2 DEFAULT NULL,
   err_text_   IN VARCHAR2 DEFAULT NULL,
   err_source_ IN VARCHAR2 DEFAULT NULL,
   p1_         IN VARCHAR2 DEFAULT NULL,
   p2_         IN VARCHAR2 DEFAULT NULL,
   p3_         IN VARCHAR2 DEFAULT NULL )
IS
   text_ VARCHAR2(2000);
BEGIN
   -- Argument 'err_source_' is currently unused, being defined to be used for debugging purposes.
   IF (err_text_ IS NULL) THEN
      IF (caller_ IS NULL) THEN
         text_ := Nls_Msg___(lu_name_, 'ACCESS_FAILURE: Arguments used to execute current operation are not allowed.',service_name_=>service_);
      ELSE
         text_ := Nls_Msg___(lu_name_, 'ACTION_ACCESS_FAILURE: Arguments used to execute ":CALLER" are not allowed.',service_name_=>service_);
         text_ := replace(text_, ':CALLER', caller_);
      END IF;
   ELSE
      text_ := Nls_Msg___(lu_name_, err_text_, p1_, p2_, p3_,service_name_=>service_);
   END IF;
   Raise_Application_Error___(-20181, lu_name_||'.'||text_);
END Appl_Failure;


PROCEDURE Item_General (
   lu_name_  IN VARCHAR2,
   item_     IN VARCHAR2,
   err_text_ IN VARCHAR2,
   p1_       IN VARCHAR2 DEFAULT NULL,
   p2_       IN VARCHAR2 DEFAULT NULL,
   p3_       IN VARCHAR2 DEFAULT NULL )
IS
   text_ VARCHAR2(2000);
BEGIN
   text_ := Nls_Msg___(lu_name_, err_text_, p1_, p2_, p3_,service_name_=>service_);
   text_ := replace(text_, ':NAME', item_);
   Raise_Application_Error___(-20120, lu_name_||'.'||text_);
END Item_General;


PROCEDURE Item_Insert (
   lu_name_  IN VARCHAR2,
   item_     IN VARCHAR2,
   err_text_ IN VARCHAR2 DEFAULT NULL,
   p1_       IN VARCHAR2 DEFAULT NULL,
   p2_       IN VARCHAR2 DEFAULT NULL,
   p3_       IN VARCHAR2 DEFAULT NULL )
IS
   text_ VARCHAR2(2000);
   temp_ VARCHAR2(100);
BEGIN
   IF (err_text_ IS NOT NULL) THEN
      text_ := Nls_Msg___(lu_name_, err_text_, p1_, p2_, p3_,service_name_=>service_);
   ELSE
      text_ := Nls_Msg___(lu_name_, 'INSERT: Field [:NAME] in :LU may not be specified for new objects.',service_name_=>service_);
      text_ := replace(text_, ':NAME', item_);
   END IF;
   Raise_Application_Error___(-20121, lu_name_||'.'||text_);
END Item_Insert;


PROCEDURE Item_Update (
   lu_name_  IN VARCHAR2,
   item_     IN VARCHAR2,
   err_text_ IN VARCHAR2 DEFAULT NULL,
   p1_       IN VARCHAR2 DEFAULT NULL,
   p2_       IN VARCHAR2 DEFAULT NULL,
   p3_       IN VARCHAR2 DEFAULT NULL )
IS
   text_ VARCHAR2(2000);
   temp_ VARCHAR2(100);
BEGIN
   IF (err_text_ IS NOT NULL) THEN
      text_ := Nls_Msg___(lu_name_, err_text_, p1_, p2_, p3_,service_name_=>service_);
   ELSE
      text_ := Nls_Msg___(lu_name_, 'UPDATE: Field [:NAME] in :LU may not be modified.',service_name_=>service_);
      text_ := replace(text_, ':NAME', item_);
   END IF;
   Raise_Application_Error___(-20122, lu_name_||'.'||text_);
END Item_Update;


PROCEDURE Item_Update_If_Null (
   lu_name_  IN VARCHAR2,
   item_     IN VARCHAR2,
   err_text_ IN VARCHAR2 DEFAULT NULL,
   p1_       IN VARCHAR2 DEFAULT NULL,
   p2_       IN VARCHAR2 DEFAULT NULL,
   p3_       IN VARCHAR2 DEFAULT NULL )
IS
   text_ VARCHAR2(2000);
   temp_ VARCHAR2(100);
BEGIN
   IF (err_text_ IS NOT NULL) THEN
      text_ := Nls_Msg___(lu_name_, err_text_, p1_, p2_, p3_,service_name_=>service_);
   ELSE
      text_ := Nls_Msg___(lu_name_, 'UPDATEIFNULL: Field [:NAME] in :LU may not be modified.',service_name_=>service_);
      text_ := replace(text_, ':NAME', item_);
   END IF;
   Raise_Application_Error___(-20123, lu_name_||'.'||text_);
END Item_Update_If_Null;


PROCEDURE Item_Format (
   lu_name_  IN VARCHAR2,
   item_     IN VARCHAR2,
   value_    IN VARCHAR2,
   err_text_ IN VARCHAR2 DEFAULT NULL,
   p1_       IN VARCHAR2 DEFAULT NULL,
   p2_       IN VARCHAR2 DEFAULT NULL,
   p3_       IN VARCHAR2 DEFAULT NULL )
IS
   text_ VARCHAR2(2000);
   temp_ VARCHAR2(100);
BEGIN
   IF (err_text_ IS NOT NULL) THEN
      text_ := Nls_Msg___(lu_name_, err_text_, p1_, p2_, p3_,service_name_=>service_);
   ELSE
      IF (item_ IS NULL) THEN
         text_ := Nls_Msg___(lu_name_, 'FORMAT: Assignment of an invalid value or value type has occurred in :LU.',service_name_=>service_);
         text_ := replace(text_, ':LU', lu_name_);
      ELSE
         -- Include the value if is reasonably short...
         IF length(value_) < 81 THEN
            text_ := Nls_Msg___(lu_name_, 'FORMAT2: Field [:NAME] in :LU has an invalid value format. The value is: ":VALUE".',service_name_=>service_);
            text_ := replace(text_, ':VALUE', value_);
         ELSE
            text_ := Nls_Msg___(lu_name_, 'FORMAT3: Field [:NAME] in :LU has an invalid value format.',service_name_=>service_);
         END IF;
         text_ := replace(text_, ':NAME', item_);
      END IF;
   END IF;
   Raise_Application_Error___(-20124, lu_name_||'.'||text_);
END Item_Format;


PROCEDURE Fnd_Item_Format (
   lu_name_       IN VARCHAR2,
   label_         IN VARCHAR2,
   value_         IN VARCHAR2,
   cause_         IN VARCHAR2 DEFAULT NULL )
IS
   text_ VARCHAR2(2000) := Nls_Translate___(lu_name_, 'FND_ITEM_FORMAT: The value ":P2" has incorrect format for [:P1] in :LU. :P3', 'ru' , label_, value_, cause_,service_);
   temp_ VARCHAR2(100);
BEGIN
   Raise_Application_Error___(-20124, lu_name_||'.'||text_);
END Fnd_Item_Format;


PROCEDURE Item_Not_Exist (
   lu_name_  IN VARCHAR2,
   item_     IN VARCHAR2,
   value_    IN VARCHAR2,
   err_text_ IN VARCHAR2 DEFAULT NULL,
   p1_       IN VARCHAR2 DEFAULT NULL,
   p2_       IN VARCHAR2 DEFAULT NULL,
   p3_       IN VARCHAR2 DEFAULT NULL )
IS
   text_ VARCHAR2(2000);
   temp_ VARCHAR2(100);
BEGIN
   IF (err_text_ IS NOT NULL) THEN
      text_ := Nls_Msg___(lu_name_, err_text_, p1_, p2_, p3_,service_name_=>service_);
   ELSE
      IF value_ IS NULL THEN
         text_ := Nls_Msg___(lu_name_, 'ITEMNOTEXIST: Field [:NAME] is not a part of :LU.',service_name_=>service_);
      ELSE
         text_ := Nls_Msg___(lu_name_, 'ITEMNOTEXIST2: Field [:NAME] with value ":VALUE" is not a part of :LU.',service_name_=>service_);
         text_ := replace(text_, ':VALUE', value_);
      END IF;
      text_ := replace(text_, ':NAME', item_);
   END IF;
   Raise_Application_Error___(-20125, lu_name_||'.'||text_);
END Item_Not_Exist;


PROCEDURE Component_Not_Exist (
   module_  IN VARCHAR2 )
IS
   text_ VARCHAR2(4000);
BEGIN
   text_ := Nls_Msg___(service_, 'COMPONENT_NOT_EXIST: Component [:P1] is not installed.', module_,service_name_=>service_);
   Raise_Application_Error___(-20141, text_);
END Component_Not_Exist;


PROCEDURE Check_Not_Null (
   lu_name_ IN VARCHAR2,
   item_    IN VARCHAR2,
   value_   IN VARCHAR2 )
IS
   temp_ VARCHAR2(100);
BEGIN
   IF (value_ IS NULL) THEN
      temp_ := Nls_Lu_Prompt___(lu_name_);
      Error_SYS.Item_Format(service_, NULL, NULL, 'NULLVALUE: Field [:P1] is mandatory for :P2 and requires a value.', item_, temp_);
   END IF;
END Check_Not_Null;


PROCEDURE Check_Not_Null (
   lu_name_ IN VARCHAR2,
   item_    IN VARCHAR2,
   value_   IN NUMBER )
IS
BEGIN
   Check_Not_Null(lu_name_, item_, to_char(value_));
END Check_Not_Null;


PROCEDURE Check_Not_Null (
   lu_name_ IN VARCHAR2,
   item_    IN VARCHAR2,
   value_   IN DATE )
IS
BEGIN
   Check_Not_Null(lu_name_, item_, to_char(value_));
END Check_Not_Null;


PROCEDURE Check_Not_Null (
   lu_name_ IN VARCHAR2,
   item_    IN VARCHAR2,
   value_   IN TIMESTAMP )
IS
BEGIN
   Check_Not_Null(lu_name_, item_, to_char(value_));
END Check_Not_Null;


PROCEDURE Check_Null (
   lu_name_ IN VARCHAR2,
   item_    IN VARCHAR2,
   value_   IN VARCHAR2 )
IS
   temp_ VARCHAR2(100);
BEGIN
   IF (value_ IS NOT NULL) THEN
      temp_ := Nls_Lu_Prompt___(lu_name_);
      Error_SYS.Item_Format(service_, NULL, NULL, 'NOTNULLVALUE: Field [:P1] is a system generated value  for :P2 and cannot be set to value :P3.', item_, temp_, value_);
   END IF;
END Check_Null;


PROCEDURE Check_Null (
   lu_name_ IN VARCHAR2,
   item_    IN VARCHAR2,
   value_   IN NUMBER )
IS
BEGIN
   Check_Null(lu_name_, item_, to_char(value_));
END Check_Null;


PROCEDURE Check_Null (
   lu_name_ IN VARCHAR2,
   item_    IN VARCHAR2,
   value_   IN DATE )
IS
BEGIN
   Check_Null(lu_name_, item_, to_char(value_));
END Check_Null;


PROCEDURE Check_Null (
   lu_name_ IN VARCHAR2,
   item_    IN VARCHAR2,
   value_   IN TIMESTAMP )
IS
BEGIN
   Check_Null(lu_name_, item_, to_char(value_));
END Check_Null;


PROCEDURE Check_No_Update (
   lu_name_   IN VARCHAR2,
   item_      IN VARCHAR2,
   new_value_ IN VARCHAR2,
   old_value_ IN VARCHAR2 )
IS
BEGIN
   IF (( old_value_ IS NULL) AND ( new_value_ IS NOT NULL))
      OR (( new_value_ IS NULL) AND ( old_value_ IS NOT NULL))
      OR ( new_value_ != old_value_) THEN
         Item_Update(lu_name_, item_);
   END IF;
END Check_No_Update;


PROCEDURE Check_No_Update (
   lu_name_   IN VARCHAR2,
   item_      IN VARCHAR2,
   new_value_ IN NUMBER,
   old_value_ IN NUMBER )
IS
BEGIN
   IF (( old_value_ IS NULL) AND ( new_value_ IS NOT NULL))
      OR (( new_value_ IS NULL) AND ( old_value_ IS NOT NULL))
      OR ( new_value_ != old_value_) THEN
         Item_Update(lu_name_, item_);
   END IF;
END Check_No_Update;


PROCEDURE Check_No_Update (
   lu_name_   IN VARCHAR2,
   item_      IN VARCHAR2,
   new_value_ IN DATE,
   old_value_ IN DATE )
IS
BEGIN
   IF (( old_value_ IS NULL) AND ( new_value_ IS NOT NULL))
      OR (( new_value_ IS NULL) AND ( old_value_ IS NOT NULL))
      OR ( new_value_ != old_value_) THEN
         Item_Update(lu_name_, item_);
   END IF;
END Check_No_Update;


PROCEDURE Check_No_Update (
   lu_name_   IN VARCHAR2,
   item_      IN VARCHAR2,
   new_value_ IN TIMESTAMP,
   old_value_ IN TIMESTAMP )
IS
BEGIN
   IF (( old_value_ IS NULL) AND ( new_value_ IS NOT NULL))
      OR (( new_value_ IS NULL) AND ( old_value_ IS NOT NULL))
      OR ( new_value_ != old_value_) THEN
         Item_Update(lu_name_, item_);
   END IF;
END Check_No_Update;


PROCEDURE Check_Update_If_Null (
   lu_name_   IN VARCHAR2,
   item_      IN VARCHAR2,
   new_value_ IN VARCHAR2,
   old_value_ IN VARCHAR2 )
IS
BEGIN
   IF (( new_value_ IS NULL) AND ( old_value_ IS NOT NULL))
   OR ( new_value_ != old_value_) THEN
      Item_Update_If_Null(lu_name_, item_);
   END IF;
END Check_Update_If_Null;


PROCEDURE Check_Update_If_Null (
   lu_name_   IN VARCHAR2,
   item_      IN VARCHAR2,
   new_value_ IN NUMBER,
   old_value_ IN NUMBER )
IS
BEGIN
   IF (( new_value_ IS NULL) AND ( old_value_ IS NOT NULL))
   OR ( new_value_ != old_value_) THEN
      Item_Update_If_Null(lu_name_, item_);
   END IF;
END Check_Update_If_Null;


PROCEDURE Check_Update_If_Null (
   lu_name_   IN VARCHAR2,
   item_      IN VARCHAR2,
   new_value_ IN DATE,
   old_value_ IN DATE )
IS
BEGIN
   IF (( new_value_ IS NULL) AND ( old_value_ IS NOT NULL))
   OR ( new_value_ != old_value_) THEN
      Item_Update_If_Null(lu_name_, item_);
   END IF;
END Check_Update_If_Null;


PROCEDURE Check_Update_If_Null (
   lu_name_   IN VARCHAR2,
   item_      IN VARCHAR2,
   new_value_ IN TIMESTAMP,
   old_value_ IN TIMESTAMP )
IS
BEGIN
   IF (( new_value_ IS NULL) AND ( old_value_ IS NOT NULL))
   OR ( new_value_ != old_value_) THEN
      Item_Update_If_Null(lu_name_, item_);
   END IF;
END Check_Update_If_Null;


PROCEDURE Check_Lower (
   lu_name_   IN VARCHAR2,
   label_     IN VARCHAR2,
   value_     IN VARCHAR2 )
IS
   cause_     VARCHAR2(2000);
BEGIN
   IF (value_ != Lower(value_)) THEN
      cause_ := 'FORMAT_LOWERCASE: Should be in lowercase.';
      Fnd_Item_Format(lu_name_, label_, value_, cause_);
   END IF;
END Check_Lower;


PROCEDURE Check_Upper (
   lu_name_   IN VARCHAR2,
   label_     IN VARCHAR2,
   value_     IN VARCHAR2 )
IS
   cause_     VARCHAR2(2000);
BEGIN
   IF (value_ != Upper(value_)) THEN
      cause_ :='FORMAT_UPPERCASE: Should be in uppercase.';
      Fnd_Item_Format(lu_name_, label_, value_, cause_);
   END IF;
END Check_Upper;


PROCEDURE Check_Date_Truncated (
   lu_name_   IN VARCHAR2,
   label_     IN VARCHAR2,
   value_     IN DATE )
IS
   cause_     VARCHAR2(2000);
BEGIN
   IF (value_ != Trunc(value_)) THEN
      cause_ :='DATE_TRUNCATED: Date must be without time.';
      Fnd_Item_Format(lu_name_, label_, to_char( value_) , cause_);
   END IF;
END Check_Date_Truncated;


PROCEDURE Check_Valid_Key_String (
   key_name_   IN VARCHAR2,
   key_value_  IN VARCHAR2 )
IS
   -- NOTE!!! Client_SYS.Text_Separator must not be the first character in the pattern
   --         since caret means negation in Regular Expression.
   --
   -- Client_SYS constants can not be used in Key attributes,
   -- this leads to errors in Client_SYS methods.
   --
   separator_pattern_  CONSTANT VARCHAR2(10) :=  '['||
                                       Client_SYS.field_separator_||
                                       Client_SYS.record_separator_||
                                       Client_SYS.group_separator_||
                                       Client_SYS.file_separator_||
                                       Client_SYS.text_separator_||
                                       ']';

  disallowed_new_line_char_seq_ VARCHAR2(10) := '';
   -- Hndle the user supplies keys
   validate_key_string_ VARCHAR2(32000);
   reg_exp_ VARCHAR2(32000);

   char_     VARCHAR2(20) := NULL;
   location_ VARCHAR2(5);
BEGIN
   validate_key_string_ := 0;
   IF(instr(validate_key_string_,line_feed_marker_)>0) THEN
      disallowed_new_line_char_seq_ := disallowed_new_line_char_seq_ || line_feed_;
      validate_key_string_ := replace(validate_key_string_, line_feed_marker_);
   END IF;
   IF (instr(validate_key_string_,carriage_return_marker_)>0) THEN
      disallowed_new_line_char_seq_ := disallowed_new_line_char_seq_ || carriage_return_;
      validate_key_string_ := replace(validate_key_string_, carriage_return_marker_);
   END IF;
   IF (length(disallowed_new_line_char_seq_) > 0 ) THEN
      char_ := regexp_substr(key_value_, '['||disallowed_new_line_char_seq_||']');
      IF char_ IS NOT NULL THEN
         Error_SYS.Item_Format(service_, NULL, NULL, 'INVALIDKEYVALUENEWLINE: Newline character is not allowed as key value [:P1].', key_name_);
      END IF;
   END IF;
   IF validate_key_string_ != '*' THEN
      reg_exp_ := Get_Key_Reg_Exp___(validate_key_string_);
      char_ := regexp_substr(key_value_, reg_exp_);
      IF char_ IS NOT NULL THEN
         Error_SYS.Item_Format(service_, NULL, NULL, 'INVALIDKEYVALUE2: Character [:P1] is not allowed as key value [:P2].', char_, key_name_);
      END IF;
   END IF;

   char_ := regexp_substr(key_value_, separator_pattern_);
   IF char_ IS NOT NULL THEN
         Error_SYS.Item_Format(service_, NULL, NULL, 'INVALIDKEYVALUE: Illegal character in key value [:P1].', key_name_);
   END IF;
   location_ := Get_Space_Validation___(key_value_);
   IF location_ = 'RIGHT' THEN
      Error_SYS.Item_Format(service_, NULL, NULL, 'INVALIDKEYVALUE3: Trailing spaces are not allowed in key value [:P1].', key_name_);
   ELSIF location_ = 'LEFT' THEN
      Error_SYS.Item_Format(service_, NULL, NULL, 'INVALIDKEYVALUE4: Leading spaces are not allowed in key value [:P1].', key_name_);
   END IF;
END Check_Valid_Key_String;


PROCEDURE Check_Valid_Identifier (
   name_  IN VARCHAR2,
   value_ IN VARCHAR2)
IS
   separator_pattern_ CONSTANT VARCHAR2(10) := '['||
                                          Client_SYS.field_separator_||
                                          Client_SYS.record_separator_||
                                          Client_SYS.group_separator_||
                                          Client_SYS.file_separator_||
                                          ']';

   char_pattern_ CONSTANT VARCHAR2(20) := '[^[:alnum:]_]';

   start_char_pattern_ CONSTANT VARCHAR2(20) := '^[[:digit:]_]';

   char_ VARCHAR2(2);
BEGIN
   char_ := regexp_substr(value_, separator_pattern_);
   IF char_ IS NOT NULL THEN
      Error_SYS.Item_Format(service_, NULL, NULL, 'INVALIDIDENTIFIER1: Illegal character in value [:P1].', name_);
   ELSE
      char_ := regexp_substr(value_, char_pattern_);
      IF char_ IS NOT NULL THEN
         Error_SYS.Item_Format(service_, NULL, NULL, 'INVALIDIDENTIFIER2: Character [:P1] is not allowed in value [:P2].', char_, name_);
      ELSE
         char_ := regexp_substr(value_, start_char_pattern_);
         IF char_ IS NOT NULL THEN
            Error_SYS.Item_Format(service_, NULL, NULL, 'INVALIDIDENTIFIER3: Character [:P1] is not allowed at the begining in value [:P2].', char_, name_);
         END IF;
      END IF;
   END IF;
END Check_Valid_Identifier;


PROCEDURE Trim_Space_Validation (
   value_ IN VARCHAR2)
IS
   location_ VARCHAR2(5);
BEGIN
   location_ := Get_Space_Validation___(value_);
   IF location_ = 'LEFT' THEN
      Error_SYS.Item_Format(service_, NULL, NULL, 'INVALIDLEFTSPACE: Leading spaces are not allowed in value [:P1].', value_);
   ELSIF location_ = 'RIGHT' THEN
      Error_SYS.Item_Format(service_, NULL, NULL, 'INVALIDRIGTSPACE: Trailing spaces are not allowed in value [:P1].', value_);
   END IF;
END Trim_Space_Validation;


PROCEDURE State_General (
   lu_name_  IN VARCHAR2,
   err_text_ IN VARCHAR2,
   p1_       IN VARCHAR2 DEFAULT NULL,
   p2_       IN VARCHAR2 DEFAULT NULL,
   p3_       IN VARCHAR2 DEFAULT NULL )
IS
   text_ VARCHAR2(2000);
BEGIN
   text_ := Nls_Msg___(lu_name_, err_text_, p1_, p2_, p3_,service_name_=>service_);
   Raise_Application_Error___(-20130, lu_name_||'.'||text_);
END State_General;


PROCEDURE State_Not_Exist (
   lu_name_  IN VARCHAR2,
   state_    IN VARCHAR2,
   err_text_ IN VARCHAR2 DEFAULT NULL,
   p1_       IN VARCHAR2 DEFAULT NULL,
   p2_       IN VARCHAR2 DEFAULT NULL,
   p3_       IN VARCHAR2 DEFAULT NULL )
IS
   text_ VARCHAR2(2000);
   temp_ VARCHAR2(100);
BEGIN
   IF (err_text_ IS NOT NULL) THEN
      text_ := Nls_Msg___(lu_name_, err_text_, p1_, p2_, p3_,service_name_=>service_);
   ELSE
      text_ := Nls_Msg___(lu_name_, 'NOTEVENT: State ":STATE" is not valid for :LU.',service_name_=>service_);
      text_ := replace(text_, ':STATE', state_);
   END IF;
   Raise_Application_Error___(-20131, lu_name_||'.'||text_);
END State_Not_Exist;


PROCEDURE State_Event_Not_Handled (
   lu_name_  IN VARCHAR2,
   event_    IN VARCHAR2,
   state_    IN VARCHAR2,
   err_text_ IN VARCHAR2 DEFAULT NULL,
   p1_       IN VARCHAR2 DEFAULT NULL,
   p2_       IN VARCHAR2 DEFAULT NULL,
   p3_       IN VARCHAR2 DEFAULT NULL )
IS
   text_ VARCHAR2(2000);
BEGIN
   IF (err_text_ IS NOT NULL) THEN
      text_ := Nls_Msg___(lu_name_, err_text_, p1_, p2_, p3_,service_name_=>service_);
   ELSE
      IF p1_ IS NOT NULL THEN
         text_ := Nls_Msg___(lu_name_, 'NOTHANDLED: The operation ":EVENT" is not allowed for :LU ":P1" which is in state ":STATE".', p1_,service_name_=>service_);
      ELSE
         text_ := Nls_Msg___(lu_name_, 'NOTHANDLED2: The operation ":EVENT" is not allowed for :LU objects in state ":STATE".',service_name_=>service_);
      END IF;
      text_ := replace(text_, ':EVENT', event_);
      text_ := replace(text_, ':STATE', state_);
   END IF;
   Raise_Application_Error___(-20132, lu_name_||'.'||text_);
END State_Event_Not_Handled;


PROCEDURE Projection_General (
   lu_name_  IN VARCHAR2,
   err_text_ IN VARCHAR2,
   p1_       IN VARCHAR2 DEFAULT NULL,
   p2_       IN VARCHAR2 DEFAULT NULL,
   p3_       IN VARCHAR2 DEFAULT NULL )
IS
   text_ VARCHAR2(2000);
BEGIN
   text_ := Nls_Msg___(lu_name_, err_text_, p1_, p2_, p3_,service_name_=>service_);
   Raise_Application_Error___(-20170, lu_name_||'.'||text_);
END Projection_General;


PROCEDURE Projection_Not_Exist (
   lu_name_         IN VARCHAR2,
   projection_name_ IN VARCHAR2 )
IS
   text_ VARCHAR2(2000);
BEGIN
   text_ := Nls_Translate___(lu_name_, 'Projection_Not_Exist: The projection [:P1] does not exist.', 'ru' , projection_name_, service_name_=>service_);
   Raise_Application_Error___(-20171, lu_name_||'.'||text_);
END Projection_Not_Exist;


PROCEDURE Projection_Category (
   lu_name_         IN VARCHAR2,
   projection_name_ IN VARCHAR2,
   category_        IN VARCHAR2 DEFAULT NULL )
IS
   text_ VARCHAR2(2000);
BEGIN
   IF category_ IS NULL THEN
      text_ := Nls_Translate___(lu_name_, 'Projection_Category: The projection [:P1] is not accessible through this endpoint.', 'ru' , projection_name_, service_name_=>service_);
   ELSE
      text_ := Nls_Translate___(lu_name_, 'Projection_Category2: The projection [:P1] of category [:P2] is not accessible through this endpoint.', 'ru' , projection_name_, category_, service_name_=>service_);
   END IF;
   Raise_Application_Error___(-20172, lu_name_||'.'||text_);
END Projection_Category;


PROCEDURE Projection_Group (
   lu_name_         IN VARCHAR2,
   projection_name_ IN VARCHAR2,
   group_           IN VARCHAR2 DEFAULT NULL )
IS
   text_ VARCHAR2(2000);
BEGIN
   IF group_ IS NULL THEN
      text_ := Nls_Translate___(lu_name_, 'Projection_Group: The projection [:P1] is not accessible through this endpoint.', 'ru' , projection_name_, service_name_=>service_);
   ELSE
      text_ := Nls_Translate___(lu_name_, 'Projection_Group2: The projection [:P1] of service group [:P2] is not accessible through this endpoint.', 'ru' , projection_name_, group_, service_name_=>service_);
   END IF;
   Raise_Application_Error___(-20173, lu_name_||'.'||text_);
END Projection_Group;


PROCEDURE Projection_Meta_Not_Exist (
   lu_name_         IN VARCHAR2,
   projection_name_ IN VARCHAR2 )
IS
   text_ VARCHAR2(2000);
BEGIN
   text_ := Nls_Translate___(lu_name_, 'Projection_Meta_Not_Exist: Metadata for projection [:P1] does not exist.', 'ru' , projection_name_, service_name_=>service_);
   Raise_Application_Error___(-20174, lu_name_||'.'||text_);
END Projection_Meta_Not_Exist;


PROCEDURE Odp_Record_Not_Exist (
   lu_name_         IN VARCHAR2 )
IS
   text_ VARCHAR2(2000);
BEGIN
   text_ := Nls_Translate___(lu_name_, 'ODP_RECORD_NOT_EXIST: The :LU object does not exist.', 'ru' ,service_name_=>service_);
   Raise_Application_Error___(-20180, lu_name_||'.'||text_);
END Odp_Record_Not_Exist;


FUNCTION Is_Foundation_Error (
   oracle_no_ IN NUMBER ) RETURN BOOLEAN
IS
BEGIN
   RETURN oracle_no_ BETWEEN -20199 AND -20100;
END Is_Foundation_Error;


FUNCTION Strip_Ora_Error (
   sqlerrm_        IN VARCHAR2,
   sqlcode_        IN NUMBER DEFAULT NULL,
   strip_ora_only_ IN BOOLEAN DEFAULT FALSE,
   keep_non_fnd_   IN BOOLEAN DEFAULT TRUE) RETURN VARCHAR2
IS
   lsqlcode_ NUMBER;
BEGIN
   IF (sqlcode_ IS NULL AND sqlerrm_ LIKE 'ORA-%') THEN
      lsqlcode_ := to_number(SUBSTR(sqlerrm_, 4, INSTR(sqlerrm_, ':') - 4));
   ELSE
      lsqlcode_ := sqlcode_;
   END IF;
   IF (lsqlcode_ IS NOT NULL) THEN
      IF (Is_Foundation_Error(lsqlcode_)) THEN
         IF (strip_ora_only_) THEN
            -- Remove 'ORA-xyz: ' but keep 'LuName.ERROR_NAME: '
            RETURN trim(SUBSTR(sqlerrm_, INSTR(sqlerrm_, ':') + 2));
         ELSE
            -- Remove 'ORA-xyz: ' and 'LuName.ERROR_NAME: '
            RETURN trim(SUBSTR(sqlerrm_, INSTR(sqlerrm_, ':', 1, 2) + 2));
         END IF;
      ELSE
         IF (keep_non_fnd_) THEN
            -- Keep 'ORA-xyz: '
            RETURN trim(sqlerrm_);
         ELSE
            -- Remove 'ORA-xyz: '
            RETURN trim(SUBSTR(sqlerrm_, INSTR(sqlerrm_, ':') + 2));
         END IF;
      END IF;
   ELSE
      RETURN trim(sqlerrm_);
   END IF;
END Strip_Ora_Error;


PROCEDURE Set_Key_Values (
   key_message_ IN VARCHAR2,
   formatted_keys_ IN VARCHAR2 )
IS
BEGIN
   null;
END Set_Key_Values;

-----------------------------------------------------------------------------
-------------------- LU SPECIFIC PROTECTED METHODS --------------------------
-----------------------------------------------------------------------------

PROCEDURE Appl_Access_ (
   lu_name_ IN VARCHAR2,
   package_ IN VARCHAR2,
   method_  IN VARCHAR2 )
IS
   text_ VARCHAR2(2000);
   temp_ VARCHAR2(100);
BEGIN
   text_ := Nls_Msg___(lu_name_, 'NOACCESS: You do not have privileges to use the ":METHOD" operation for ":LU".',service_name_=>service_);
   text_ := replace(text_, ':METHOD', package_||'.'||method_);
   Raise_Application_Error___(-20106, lu_name_||'.'||text_);
END Appl_Access_;


PROCEDURE Odata_Provider_Access_ (
   lu_name_   IN VARCHAR2,
   err_text_  IN VARCHAR2,
   p1_        IN VARCHAR2 DEFAULT NULL,
   p2_        IN VARCHAR2 DEFAULT NULL,
   p3_        IN VARCHAR2 DEFAULT NULL )
IS
   text_ VARCHAR2(2000);
BEGIN
   text_ := Nls_Msg___(lu_name_, err_text_, p1_, p2_, p3_,service_name_=>service_);
   Raise_Application_Error___(-20107, lu_name_||'.'||text_);
END Odata_Provider_Access_;


PROCEDURE Security_Checkpoint_ (
   msg_ IN VARCHAR2 )
IS
   tmp_msg_ VARCHAR2(32000) := msg_;
BEGIN
   --Message_SYS.Set_Attribute(tmp_msg_, 'TOKEN', Message_SYS.Find_Attribute(msg_, 'TOKEN', ''));
   Raise_Application_Error___(-20140, Client_SYS.record_separator_ || tmp_msg_ || Client_SYS.record_separator_);
END Security_Checkpoint_;


PROCEDURE Compile_Error_ (
   lu_name_ IN VARCHAR2 )
IS
   text_ VARCHAR2(4000);
BEGIN
   text_ := Nls_Msg___(lu_name_, 'COMPILE_ERROR: Error during compilation of LU [:P1].', lu_name_,service_name_=>service_);
   Raise_Application_Error___(-20150, text_);
END Compile_Error_;


PROCEDURE Compile_Error_ (
   lu_name_ IN VARCHAR2,
   details_ IN VARCHAR2)
IS
   text_ VARCHAR2(4000);
BEGIN
   text_ := Nls_Msg___(lu_name_, 'COMPILE_ERROR2: Error during compilation of LU [:P1].' || chr(13) || chr(10) || chr(13) || chr(10) || 'Error details: :P2', lu_name_, details_,service_name_=>service_);
   Raise_Application_Error___(-20150, text_);
END Compile_Error_;


PROCEDURE Deprecated_Error_ (
   lu_name_ IN VARCHAR2,
   method_name_ IN VARCHAR2 )
IS
   text_ VARCHAR2(4000);
BEGIN
   text_ := Nls_Msg___(lu_name_, 'Deprecated_ERROR: Method [:P2] in LU [:P1] is deprecated.', lu_name_, method_name_,service_name_=>service_);
   Raise_Application_Error___(-20149, text_);
END Deprecated_Error_;

-----------------------------------------------------------------------------
-------------------- FOUNDATION1 METHODS ------------------------------------
-----------------------------------------------------------------------------


--@IgnoreMissingSysinit
PROCEDURE Init
IS

   PROCEDURE Base
   IS
   BEGIN
      NULL;
   END Base;

BEGIN
   Base;
END Init;

BEGIN
   Init;
END ERROR_SYS;
-- [END A7 COMPLETE BLOCK]
/


--
-- INSTALL_TEM_SYS  (Package Body) 
--
--  Dependencies: 
--   INSTALL_TEM_SYS (Package)
--   ALL_QUEUES (Synonym)
--   ALL_TRIGGERS (Synonym)
--   CTX_DDL (Synonym)
--   CTX_USER_INDEXES (Synonym)
--   DBA_JOBS_RUNNING (Synonym)
--   DBA_SCHEDULER_JOBS (Synonym)
--   DBA_USERS (Synonym)
--   DBMS_AQADM (Synonym)
--   DBMS_JOB (Synonym)
--   DBMS_LOCK (Synonym)
--   DBMS_OUTPUT (Synonym)
--   DBMS_PARALLEL_EXECUTE (Synonym)
--   DBMS_SCHEDULER (Synonym)
--   DBMS_STATS (Synonym)
--   DUAL (Synonym)
--   GV$SESSION (Synonym)
--   PLITBLM (Synonym)
--   USER_INDEXES (Synonym)
--   USER_JOBS (Synonym)
--   USER_LOBS (Synonym)
--   USER_OBJECTS (Synonym)
--   USER_PARALLEL_EXECUTE_TASKS (Synonym)
--   USER_PLSQL_OBJECT_SETTINGS (Synonym)
--   USER_PROCEDURES (Synonym)
--   USER_QUEUE_TABLES (Synonym)
--   USER_SCHEDULER_JOBS (Synonym)
--   USER_SCHEDULER_RUNNING_JOBS (Synonym)
--   USER_TABLES (Synonym)
--   USER_TAB_COLUMNS (Synonym)
--   USER_TRIGGERS (Synonym)
--   V$DATABASE (Synonym)
--   V$PARAMETER (Synonym)
--   V$PROCESS (Synonym)
--   V$SESSION (Synonym)
--   STANDARD (Package)
--   V_$SESSION (View)
--   INSTALL_TEM_SYS_SEQ (Sequence)
--   INSTALL_TEM_SYS_TAB (Table)
--
CREATE OR REPLACE PACKAGE BODY VTAPP.INSTALL_TEM_SYS IS

   stopped_             CONSTANT VARCHAR2(50)  := '<DISABLED_DURING_IFS_INSTALLATION>';
   stopped_ial_         CONSTANT VARCHAR2(50)  := '<DISABLED_DURING_IFS_INSTALLATION_IAL>';
   trigger_id_          CONSTANT VARCHAR2(50)  := '<DISABLE_ENABLE_TRIGGER>';
   job_queue_proc_      CONSTANT VARCHAR2(50)  := '<JOB_QUEUE_PROCESSES>';
   days_to_keep_        CONSTANT NUMBER        := 30;
   min_no_of_processes_ CONSTANT NUMBER        := 5;
   def_no_of_processes_ CONSTANT NUMBER        := 16;
   large_db_limit_      CONSTANT NUMBER        := 50000000;


-----------------------------------------------------------------------------
-------------------- SERVICE SPECIFIC IMPLEMENTATION METHOD DECLARATIONS ----
-----------------------------------------------------------------------------

PROCEDURE Pre_Installation___ (
   parameter_ IN VARCHAR2 );

PROCEDURE Post_Installation___ (
   parameter_ IN VARCHAR2 );

PROCEDURE Disable_Triggers___ (
   parameter_ IN VARCHAR2 );

PROCEDURE Enable_Triggers___ (
   parameter_ IN VARCHAR2 );

PROCEDURE Refresh_Customobjects___ (
   parameter_ IN VARCHAR2 );

PROCEDURE Compile_Base_Packages___ (
   parameter_ IN VARCHAR2 );

PROCEDURE Bi_Post_Install_Object___ (
   parameter_ IN VARCHAR2 );

PROCEDURE Finalize_Dev_Deploy___ (
   parameter_ IN VARCHAR2 );

PROCEDURE Reset_Job_Queue_Processes___ (
   previous_guid_ INSTALL_TEM_SYS_TAB.guid%TYPE );

FUNCTION Identify_Large_Database___ RETURN NUMBER;

PROCEDURE Enable_New_Processes___;

FUNCTION Check_Queue_Process___ RETURN BOOLEAN;

-----------------------------------------------------------------------------
-------------------- SERVICE SPECIFIC IMPLEMENTATION METHODS ----------------
-----------------------------------------------------------------------------

FUNCTION Get_Init_Parameter___ (
   parameter_name_   IN VARCHAR2 ) RETURN VARCHAR2
IS
   value_ VARCHAR2(10);
BEGIN
   SELECT VALUE
   INTO   value_
   FROM   v$parameter
   WHERE  name = parameter_name_;
   RETURN(value_);
EXCEPTION
   WHEN no_data_found THEN
      RETURN(NULL);
END Get_Init_Parameter___;

PROCEDURE Disable_Idle_Dbms_Jobs___
IS
   TYPE num_arr IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
   job_arr_     num_arr;
   CURSOR get_all_jobs IS
      SELECT job
      FROM user_jobs
      WHERE broken = 'N';
   CURSOR get_job IS
      SELECT job
      FROM user_jobs
      WHERE job NOT IN (SELECT job FROM dba_jobs_running)
      AND broken = 'N';
   PRAGMA autonomous_transaction;
BEGIN
   OPEN  get_all_jobs;
   FETCH get_all_jobs BULK COLLECT INTO job_arr_;
   CLOSE get_all_jobs;
   FOR i IN nvl(job_arr_.FIRST,0)..nvl(job_arr_.LAST,-1) LOOP
      Dbms_Job.Interval(job_arr_(i), 'SYSDATE+1');
      Dbms_Job.Next_Date(job_arr_(i), SYSDATE+1);
   END LOOP;
   COMMIT;
   OPEN  get_job;
   FETCH get_job BULK COLLECT INTO job_arr_;
   CLOSE get_job;
   FOR i IN nvl(job_arr_.FIRST,0)..nvl(job_arr_.LAST,-1) LOOP
      Dbms_Job.Broken(job_arr_(i), TRUE);
   END LOOP;
   COMMIT;
END Disable_Idle_Dbms_Jobs___;

FUNCTION Show_Dbms_Jobs___ RETURN NUMBER
IS
   num_of_jobs_ NUMBER := 0;
   job_name_    VARCHAR2(4000);
   proc_name_   VARCHAR2(100);
   start_pos_   NUMBER;
   CURSOR get_running_jobs IS
      SELECT j.log_user owner, SUBSTR(j.what, 1, 4000) job_name
        FROM user_jobs j, dba_jobs_running jr
      WHERE j.job = jr.job;

   FUNCTION Get_Method___(
      full_action_ IN VARCHAR2) RETURN VARCHAR2
   IS
      action_      VARCHAR2(4000);
      pos_         NUMBER;
   BEGIN
      IF (full_action_ LIKE '%Batch_SYS.Run_Job__(job,%' ) THEN
         pos_ := instr(full_action_, '''');
         action_ := substr(full_action_, pos_ + 1, instr(full_action_, ''')', - 1) - pos_ - 1); -- extract the action..
      ELSE
         action_ := full_action_; -- not entered through Batch_SYS..
      END IF;
      RETURN(action_);
   END Get_Method___;

BEGIN
   Dbms_Output.Put_Line(' ');
   FOR rec IN get_running_jobs LOOP
      num_of_jobs_ := num_of_jobs_ + 1;
      IF (num_of_jobs_ = 1) THEN
         Dbms_Output.Put_Line(' ');
         Dbms_Output.Put_Line('The following dbms_jobs are currently running');
         Dbms_Output.Put_Line('=============================================');
      END IF;
      job_name_ := Get_Method___(rec.job_name);
      Dbms_Output.Put_Line(rec.owner||' '||job_name_);
      start_pos_ := INSTR(UPPER(job_name_), 'TRANSACTION_SYS.PROCESS_ALL_PENDING__');
      IF (start_pos_ > 0) THEN
         BEGIN
            -- ifs_assert_safe mabose 20130823
            EXECUTE IMMEDIATE 'SELECT procedure_name FROM transaction_sys_local_tab WHERE ROWNUM < 2 AND queue_id = :queue_id_ AND state = ''Executing''' INTO proc_name_ USING SUBSTR(job_name_, start_pos_+38, INSTR(job_name_, ',', start_pos_+38)-(start_pos_+38));
            Dbms_Output.Put_Line('   Running job: '||proc_name_);
         EXCEPTION
            WHEN OTHERS THEN
               NULL;
         END;
      END IF;
   END LOOP;
   IF (num_of_jobs_ > 0) THEN
      Dbms_Output.Put_Line(' ');
      Dbms_Output.Put_Line('If you do not want to wait until the currently running dbms_job background jobs are finished, you have to kill the jobs manually (use Fnd_Session_API.Kill_Session if possible).');
   END IF;
   Dbms_Output.Put_Line(' ');
   RETURN num_of_jobs_;
END Show_Dbms_Jobs___;

FUNCTION Show_Db_Obj_Invalid_Count___ RETURN NUMBER
IS
   i_ PLS_INTEGER := 0;
   CURSOR get_inv_obj_count IS
      SELECT object_type,COUNT(*) no_of_invalid
      FROM   user_objects
      WHERE  status = 'INVALID'
      GROUP BY object_type
      UNION
      SELECT 'TEXT INDEX',COUNT(*) no_of_invalid
      FROM   user_indexes t
      WHERE  t.index_type = 'DOMAIN'
      AND    (t.domidx_opstatus != 'VALID' OR t.status = 'INPROGRS')
      GROUP BY t.index_type;
BEGIN
   Dbms_Output.Put_Line(' ');
   Dbms_Output.Put_Line('Checking database objects');
   Dbms_Output.Put_Line('=========================');
   FOR rec_ IN get_inv_obj_count LOOP
      IF i_ = 0 THEN
         Dbms_Output.Put_Line(' ');
         Dbms_Output.Put_Line('WARNING: The following number of invalid objects were found.');
         Dbms_Output.Put_Line(' ');
      END IF;
      Dbms_Output.Put_Line(INITCAP(rec_.object_type)||RPAD(' ',20-LENGTH(rec_.object_type),' ')||rec_.no_of_invalid);
      i_:=i_ + rec_.no_of_invalid;
   END LOOP;
   IF i_ = 0 THEN
      Dbms_Output.Put_Line('OK.');
   END IF;
   RETURN i_;
END Show_Db_Obj_Invalid_Count___;

FUNCTION Show_Db_Obj_Debug_Count___ RETURN NUMBER
IS
   i_ PLS_INTEGER := 0;
   CURSOR get_debug_obj_count IS
      SELECT type, COUNT(*) no_of_invalid
      FROM user_plsql_object_settings
      WHERE plsql_debug = 'TRUE'
      OR plsql_optimize_level < 2
      GROUP BY type;
BEGIN
   Dbms_Output.Put_Line(' ');
   Dbms_Output.Put_Line('Checking database objects');
   Dbms_Output.Put_Line('=========================');
   FOR rec_ IN get_debug_obj_count LOOP
      IF i_ = 0 THEN
         Dbms_Output.Put_Line(' ');
         Dbms_Output.Put_Line('WARNING: The following number of objects with debugging information were found.');
         Dbms_Output.Put_Line(' ');
      END IF;
      Dbms_Output.Put_Line(INITCAP(rec_.type)||RPAD(' ',20-LENGTH(rec_.type),' ')||rec_.no_of_invalid);
      i_:=i_ + rec_.no_of_invalid;
   END LOOP;
   IF i_ = 0 THEN
      Dbms_Output.Put_Line('OK.');
   END IF;
   RETURN i_;
END Show_Db_Obj_Debug_Count___;

FUNCTION Show_Scheduler_Processes___ RETURN NUMBER
IS
   num_of_jobs_ NUMBER := 0;
   proc_name_   VARCHAR2(300);
   start_pos_   NUMBER;
   CURSOR get_running_jobs IS
      SELECT j.owner, j.job_name, j.comments, r.elapsed_time, r.session_id
        FROM user_scheduler_running_jobs r, dba_scheduler_jobs j
       WHERE j.job_name = r.job_name;
BEGIN
   FOR rec IN get_running_jobs LOOP
      num_of_jobs_ := num_of_jobs_ + 1;
      IF (num_of_jobs_ = 1) THEN
         Dbms_Output.Put_Line(' ');
         Dbms_Output.Put_Line('The following F1 jobs are currently running');
         Dbms_Output.Put_Line('===========================================');
      END IF;
      Dbms_Output.Put(Rpad(rec.job_name, 25, ' '));
      Dbms_Output.Put_Line(Ltrim(REPLACE(rec.comments, stopped_)));
      start_pos_ := INSTR(UPPER(rec.comments), 'TRANSACTION_SYS.PROCESS_ALL_PENDING__');
      IF (start_pos_ > 0) THEN
         BEGIN
            -- ifs_assert_safe mabose 20130823
            EXECUTE IMMEDIATE 'SELECT procedure_name FROM transaction_sys_local_tab WHERE ROWNUM < 2 AND sid = :sid AND queue_id = :queue_id_ AND state = ''Executing''' INTO proc_name_ USING rec.session_id, SUBSTR(rec.comments, start_pos_+38, INSTR(rec.comments, ',', start_pos_+38)-(start_pos_+38));
            Dbms_Output.Put_Line('   Running job: '||proc_name_);
         EXCEPTION
            WHEN OTHERS THEN
               NULL;
         END;
      END IF;
   END LOOP;
   IF (num_of_jobs_ > 0) THEN
      Dbms_Output.Put_Line(' ');
      Dbms_Output.Put_Line('Use Install_Tem_SYS.Stop_Scheduler_Processes to stop all currently running F1 jobs if you do not want to wait until they finish.');
   END IF;
   Dbms_Output.Put_Line(' ');
   RETURN num_of_jobs_;
END Show_Scheduler_Processes___;

FUNCTION Show_Jobs_Other_Schema___ RETURN NUMBER
IS
   i_ PLS_INTEGER := 0;
   CURSOR check_jobs IS
      SELECT owner, job_name
      FROM   dba_scheduler_jobs
      WHERE  enabled = 'TRUE'
      AND ((owner NOT IN ('SYS', UPPER('VTAPP'))
      AND   owner NOT LIKE 'ORACLE%')
      OR   (owner = 'SYS'
      AND   job_name IN ('AUTO_SPACE_ADVISOR_JOB', 'GATHER_STATS_JOB')));
BEGIN
   Dbms_Output.Put_Line(' ');
   Dbms_Output.Put_Line('Checking enabled jobs in other schema(s)');
   Dbms_Output.Put_Line('========================================');
   FOR rec_ IN check_jobs LOOP
      IF i_ = 0 THEN
         Dbms_Output.Put_Line(' ');
         Dbms_Output.Put_Line('WARNING: These backgrounds jobs are enabled in other schemas');
         Dbms_Output.Put_Line('         Verify that they do not interfere with the installation process');
         Dbms_Output.Put_Line(' ');
      END IF;
      Dbms_Output.Put_Line(rec_.owner||RPAD(' ',31-LENGTH(rec_.owner),' ')||rec_.job_name);
      i_:=i_ + 1;
   END LOOP;
   IF i_ = 0 THEN
      Dbms_Output.Put_Line('OK.');
   END IF;
   RETURN i_;
END Show_Jobs_Other_Schema___;

FUNCTION Show_Triggers_Other_Schema___ RETURN NUMBER
IS
   i_ PLS_INTEGER := 0;
   CURSOR check_jobs IS
      SELECT owner, table_name, trigger_name
      FROM  all_triggers
      WHERE owner != UPPER('VTAPP')
      AND   table_owner = UPPER('VTAPP')
      AND status = 'ENABLED';
BEGIN
   Dbms_Output.Put_Line(' ');
   Dbms_Output.Put_Line('Checking enabled triggers in other schema(s)');
   Dbms_Output.Put_Line('============================================');
   FOR rec_ IN check_jobs LOOP
      IF i_ = 0 THEN
         Dbms_Output.Put_Line(' ');
         Dbms_Output.Put_Line('WARNING: These triggers are enabled on IFS Applications tables but in other schemas');
         Dbms_Output.Put_Line('         Verify that they do not interfere with the installation process');
         Dbms_Output.Put_Line(' ');
         Dbms_Output.Put_Line('Owner'||RPAD(' ',46,' ')||'Table Name'||RPAD(' ',41,' ')||'Trigger Name');
         Dbms_Output.Put_Line(' ');
      END IF;
      Dbms_Output.Put_Line(rec_.owner||RPAD(' ',51-LENGTH(rec_.owner),' ')||rec_.table_name||RPAD(' ',51-LENGTH(rec_.table_name),' ')||rec_.trigger_name);
      i_:=i_ + 1;
   END LOOP;
   IF i_ = 0 THEN
      Dbms_Output.Put_Line('OK.');
   END IF;
   RETURN i_;
END Show_Triggers_Other_Schema___;



PROCEDURE Pre_Installation___ (
   parameter_ IN VARCHAR2 )
IS
   guid_  INSTALL_TEM_SYS_TAB.guid%TYPE;
   previous_guid_  INSTALL_TEM_SYS_TAB.guid%TYPE;
   reset_ BOOLEAN := FALSE;
   CURSOR check_previous IS
      SELECT guid
      FROM INSTALL_TEM_SYS_TAB
      WHERE log_id = 0;
BEGIN
   OPEN check_previous;
   FETCH check_previous INTO previous_guid_;
   IF check_previous%FOUND AND Get_Multi_Installation_Mode = FALSE THEN
      CLOSE check_previous;
      Dbms_Output.Put_Line('Previous Installation with ID: '||previous_guid_||' was aborted. Settings from this installation will be reverted.');
      Finalize_Installation('RESET');
      reset_ := TRUE;
   ELSE
      CLOSE check_previous;
   END IF;
   BEGIN
      -- Create unique installation id
      SELECT TO_CHAR(logon_time, 'YYYYMMDD HH24MISS')
      INTO guid_
      FROM sys.v_$session
      WHERE audsid = userenv('SESSIONID')
      AND ROWNUM < 2;
      Dbms_Output.Put_Line(' ');
      Dbms_Output.Put_Line('Installation ID: '||guid_);
      Dbms_Output.Put_Line(' ');
      INSERT INTO INSTALL_TEM_SYS_TAB
         (log_id,
          guid)
      VALUES
         (0,
          guid_);
   EXCEPTION
      WHEN dup_val_on_index THEN
         UPDATE INSTALL_TEM_SYS_TAB
         SET guid = guid_
         WHERE log_id = 0;
   END;
   --@ApproveTransactionStatement(2019-04-16,MABOSE)
   COMMIT;
   Disable_Triggers___('DDL_AUDIT_TRG');
   IF reset_ THEN
      Reset_Job_Queue_Processes___(previous_guid_);
   END IF;
   Enable_All_Queues__;
END Pre_Installation___;

PROCEDURE Post_Installation___ (
   parameter_ IN VARCHAR2 )
IS
BEGIN
   NULL;
END Post_Installation___;

PROCEDURE Disable_Triggers___ (
   parameter_ IN VARCHAR2 )
IS
   log_id_  INSTALL_TEM_SYS_TAB.log_id%TYPE;
   dummy_   NUMBER;
   method_  BOOLEAN;
   stmt_    VARCHAR2(1000);
   enable_  VARCHAR2(1000);
   guid_    INSTALL_TEM_SYS_TAB.guid%TYPE := Get_Installation_Id_;
   CURSOR get_method IS
      SELECT 1
      FROM   user_procedures
      WHERE  object_name = 'INSTALLATION_SYS'
      AND    procedure_name  = 'DISABLE_TRIGGER';
   CURSOR get_trigger IS
      SELECT trigger_name
      FROM user_triggers
      WHERE status = 'ENABLED'
      AND trigger_name = NVL(parameter_, trigger_name);
BEGIN
   OPEN get_method;
   FETCH get_method INTO dummy_;
   IF get_method%FOUND THEN
      CLOSE get_method;
      method_ := TRUE;
   ELSE
      CLOSE get_method;
      method_ := FALSE;
   END IF;
   FOR rec_ IN get_trigger LOOP
      BEGIN
         IF method_ THEN
            stmt_ := 'BEGIN Installation_SYS.Disable_Trigger('''||rec_.trigger_name||''', TRUE); END;';
            enable_ := 'BEGIN Installation_SYS.Enable_Trigger('''||rec_.trigger_name||''', TRUE); END;';
         ELSE
            stmt_ := 'ALTER TRIGGER '||rec_.trigger_name||' DISABLE';
            enable_ := 'ALTER TRIGGER '||rec_.trigger_name||' ENABLE';
         END IF;
         -- ifs_assert_safe mabose 20130823
         EXECUTE IMMEDIATE stmt_;
         SELECT INSTALL_TEM_SYS_SEQ.NEXTVAL
         INTO   log_id_
         FROM   dual;
         INSERT INTO INSTALL_TEM_SYS_TAB
            (log_id,
             guid,
             category,
             text1,
             text2,
             text3,
             created,
             last_modified,
             action)
         VALUES
            (log_id_,
             guid_,
             'ENABLE/DISABLE TRIGGER',
             stmt_,
             enable_,
             rec_.trigger_name,
             SYSDATE,
             SYSDATE,
             trigger_id_);
      EXCEPTION
         WHEN OTHERS THEN
            Dbms_Output.Put_Line('Error disable trigger '||rec_.trigger_name||' before installation');
            Dbms_Output.Put_Line(rec_.trigger_name);
            Dbms_Output.Put_Line(SUBSTR(SQLERRM, 11, 2000));
      END;
   END LOOP;
END Disable_Triggers___;

PROCEDURE Enable_Triggers___ (
   parameter_ IN VARCHAR2 )
IS
   status_ user_triggers.status%TYPE;
   guid_   INSTALL_TEM_SYS_TAB.guid%TYPE := Get_Installation_Id_;
   show_info_ BOOLEAN := FALSE;
   CURSOR getlog IS
      SELECT text2, text3, log_id
      FROM INSTALL_TEM_SYS_TAB
      WHERE action = trigger_id_
      AND guid = guid_
      AND category = 'ENABLE/DISABLE TRIGGER'
      AND text4 IS NULL;
   CURSOR get_trigger (trigger_ VARCHAR2) IS
      SELECT status
      FROM user_triggers
      WHERE trigger_name = trigger_;
BEGIN
   FOR rec_ IN getlog LOOP
      BEGIN
         OPEN get_trigger (rec_.text3);
         FETCH get_trigger INTO status_;
         IF get_trigger%FOUND THEN
            CLOSE get_trigger;
            IF status_ = 'ENABLED' THEN
               UPDATE INSTALL_TEM_SYS_TAB
               SET text4 = 'Trigger already enabled during deployment',
                   last_modified = SYSDATE
               WHERE log_id = rec_.log_id;
               -- ifs_assert_safe mabose 20140711
               EXECUTE IMMEDIATE 'BEGIN :show_info := Installation_SYS.Get_Show_Info; END;' USING OUT show_info_;
               IF show_info_ THEN
                  Dbms_Output.Put_Line('Enable_Trigger: Trigger '||rec_.text3|| ' already enabled during deployment.');
               END IF;
            ELSE
               -- ifs_assert_safe mabose 20130823
               EXECUTE IMMEDIATE rec_.text2;
               UPDATE INSTALL_TEM_SYS_TAB
               SET text4 = 'Trigger enabled after database deployment',
                   last_modified = SYSDATE
               WHERE log_id = rec_.log_id;
            END IF;
         ELSE
            CLOSE get_trigger;
            UPDATE INSTALL_TEM_SYS_TAB
            SET text4 = 'Trigger removed during deployment',
                last_modified = SYSDATE
            WHERE log_id = rec_.log_id;
            -- ifs_assert_safe mabose 20140711
            EXECUTE IMMEDIATE 'BEGIN :show_info := Installation_SYS.Get_Show_Info; END;' USING OUT show_info_;
            IF show_info_ THEN
               Dbms_Output.Put_Line('Enable_Trigger: Trigger '||rec_.text3|| ' removed during deployment.');
               END IF;
            END IF;
      EXCEPTION
         WHEN OTHERS THEN
            Dbms_Output.Put_Line('Error enable trigger after installation');
            Dbms_Output.Put_Line(rec_.text2);
            Dbms_Output.Put_Line(SUBSTR(SQLERRM, 11, 2000));
      END;
   END LOOP;
END Enable_Triggers___;


PROCEDURE Refresh_Customobjects___ (
   parameter_ IN VARCHAR2 )
IS
   stmt_       VARCHAR2(200) := 'BEGIN Custom_Obj_SYS.Deploy_All_Custom_Objects; END;';
   error_text_ VARCHAR2(2000);

   invalid_method EXCEPTION;
   PRAGMA EXCEPTION_INIT(invalid_method, -6550);
BEGIN
   -- ifs_assert_safe mabose 20130823
   EXECUTE IMMEDIATE stmt_;
EXCEPTION
   WHEN invalid_method THEN
      NULL;
   WHEN OTHERS THEN
      error_text_ := SQLERRM;
      Dbms_Output.put_line('Unknown error when refreshing Custom Objects.');
      Dbms_Output.put_line(error_text_);
END Refresh_Customobjects___;


PROCEDURE Bi_Post_Install_Object___ (
   parameter_ IN VARCHAR2 )
IS
   stmt_       VARCHAR2(200) := 'BEGIN Biserv_Installation_API.Bi_Post_Installation_Object; END;';

   invalid_method EXCEPTION;
   PRAGMA EXCEPTION_INIT(invalid_method, -6550);
BEGIN
   -- ifs_assert_safe mabose 20160219
   EXECUTE IMMEDIATE stmt_;
EXCEPTION
   WHEN invalid_method THEN
      NULL;
END Bi_Post_Install_Object___;


PROCEDURE Compile_Base_Packages___ (
   parameter_ IN VARCHAR2 )
IS
   package_name_ VARCHAR2(30);
   CURSOR check_state IS
      SELECT object_name
      FROM user_objects
      WHERE object_name IN ('DATABASE_SYS', 'INSTALLATION_SYS', 'DICTIONARY_SYS', 'ERROR_SYS', 'GENERAL_SYS', 'FND_SESSION_API')
      AND object_type = 'PACKAGE BODY'
      AND status = 'INVALID';
   CURSOR get_debug_objects IS
      SELECT name, type
      FROM user_plsql_object_settings
      WHERE name IN ('DATABASE_SYS', 'INSTALLATION_SYS', 'DICTIONARY_SYS', 'ERROR_SYS', 'GENERAL_SYS', 'FND_SESSION_API')
      AND  (plsql_debug = 'TRUE'
      OR    plsql_optimize_level < 2
      OR    nls_length_semantics = 'BYTE')
      ORDER BY DECODE(type, 'PACKAGE', 10,
                            'PACKAGE BODY', 20,
                            'TRIGGER', 30,
                            'PROCEDURE', 40,
                            'FUNCTION', 50,
                            50 ), name;
BEGIN
   IF UPPER(SUBSTR(parameter_, 1, 1)) = 'Y' THEN
      FOR obj_ IN get_debug_objects LOOP
         BEGIN
            IF ( obj_.type = 'PACKAGE' ) THEN
               -- ifs_assert_safe mabose 20140711
               EXECUTE IMMEDIATE 'ALTER PACKAGE ' || obj_.name || ' COMPILE SPECIFICATION PLSQL_OPTIMIZE_LEVEL=2 PLSQL_DEBUG=FALSE NLS_LENGTH_SEMANTICS=CHAR REUSE SETTINGS';
               DBMS_Output.Put_Line('Setting correct length semantic and/or removing debugging information from package specification ' || obj_.name);
            ELSIF ( obj_.type = 'PACKAGE BODY' ) THEN
               -- ifs_assert_safe mabose 20140711
               EXECUTE IMMEDIATE 'ALTER PACKAGE ' || obj_.name || ' COMPILE BODY PLSQL_OPTIMIZE_LEVEL=2 PLSQL_DEBUG=FALSE NLS_LENGTH_SEMANTICS=CHAR REUSE SETTINGS';
               DBMS_Output.Put_Line('Setting correct length semantic and/or removing debugging information from package body ' || obj_.name);
            ELSIF ( obj_.type = 'TRIGGER' ) THEN
               -- ifs_assert_safe mabose 20140711
               EXECUTE IMMEDIATE 'ALTER TRIGGER ' || obj_.name || ' COMPILE PLSQL_OPTIMIZE_LEVEL=2 PLSQL_DEBUG=FALSE NLS_LENGTH_SEMANTICS=CHAR REUSE SETTINGS';
               DBMS_Output.Put_Line('Setting correct length semantic and/or removing debugging information from trigger ' || obj_.name);
            ELSIF ( obj_.type = 'PROCEDURE' ) THEN
               -- ifs_assert_safe mabose 20140711
               EXECUTE IMMEDIATE 'ALTER PROCEDURE ' || obj_.name || ' COMPILE PLSQL_OPTIMIZE_LEVEL=2 PLSQL_DEBUG=FALSE NLS_LENGTH_SEMANTICS=CHAR REUSE SETTINGS';
               DBMS_Output.Put_Line('Setting correct length semantic and/or removing debugging information from procedure ' || obj_.name);
            ELSIF ( obj_.type = 'FUNCTION' ) THEN
               -- ifs_assert_safe mabose 20140711
               EXECUTE IMMEDIATE 'ALTER FUNCTION ' || obj_.name || ' COMPILE PLSQL_OPTIMIZE_LEVEL=2 PLSQL_DEBUG=FALSE NLS_LENGTH_SEMANTICS=CHAR REUSE SETTINGS';
               DBMS_Output.Put_Line('Setting correct length semantic and/or removing debugging information from function ' || obj_.name);
            END IF;
         EXCEPTION
            WHEN OTHERS THEN
               DBMS_Output.Put_Line('Error removing debugging information from object ' || obj_.name);
               DBMS_Output.Put_Line('Error message: ' || SQLERRM);
         END;
      END LOOP;
   END IF;
   OPEN check_state;
   FETCH check_state INTO package_name_;
   WHILE check_state%FOUND LOOP
   -- ifs_assert_safe mabose 20131220
      EXECUTE IMMEDIATE 'ALTER PACKAGE '||package_name_||' COMPILE BODY';
      FETCH check_state INTO package_name_;
   END LOOP;
   CLOSE check_state;
END Compile_Base_Packages___;


PROCEDURE Finalize_Dev_Deploy___ (
   parameter_ IN VARCHAR2 )
IS
   found_ BOOLEAN := FALSE;
   valid_ BOOLEAN := TRUE;
   CURSOR get_post_methods IS
      SELECT INITCAP(SUBSTR(up.object_name, 1, LENGTH(up.object_name)-3)) || SUBSTR(up.object_name, -3) package_name,
             INITCAP(up.procedure_name) procedure_name,
             uo.status
      FROM user_procedures up,
           user_objects uo,
           v$session s
      WHERE up.object_name = uo.object_name
      AND uo.object_type = 'PACKAGE BODY'
      AND up.procedure_name IN ('POST_INSTALLATION_OBJECT', 'POST_INSTALLATION_DATA')
      AND s.audsid = userenv('sessionid')
      AND (parameter_ IS NULL
      OR   UPPER(parameter_) <> 'SESSION'
      OR   GREATEST(uo.created, uo.last_ddl_time, TO_DATE(uo.timestamp, 'YYYY-MM-DD-HH24:MI:SS')) >= s.logon_time)
      ORDER BY up.procedure_name DESC, up.object_name;
BEGIN
   FOR rec_ IN get_post_methods LOOP
      found_ := TRUE;
      Dbms_Output.Put_Line('Running ' || rec_.package_name || '.' || rec_.procedure_name || '...');
      IF (rec_.status = 'INVALID') THEN
         BEGIN
            EXECUTE IMMEDIATE 'ALTER PACKAGE ' || rec_.package_name || ' COMPILE BODY';
         EXCEPTION
            WHEN OTHERS THEN
               valid_ := FALSE;
         END;
      END IF;

      IF valid_ THEN
         BEGIN
            -- ifs_assert_safe mabose 20130823
            EXECUTE IMMEDIATE 'BEGIN ' || rec_.package_name || '.' || rec_.procedure_name || '; END;';
         EXCEPTION
            WHEN OTHERS THEN
               ROLLBACK;
               Dbms_Output.Put_Line(SQLERRM);
         END;
         COMMIT;
      END IF;
   END LOOP;

   IF (NOT found_) THEN
      Dbms_Output.Put_Line('No packages found, skipping...');
   END IF;
END Finalize_Dev_Deploy___;

PROCEDURE Reset_Job_Queue_Processes___ (
   previous_guid_ INSTALL_TEM_SYS_TAB.guid%TYPE )
IS
   job_queue_processes_ INSTALL_TEM_SYS_TAB.text1%TYPE;
   log_id_              INSTALL_TEM_SYS_TAB.log_id%TYPE;
   guid_                INSTALL_TEM_SYS_TAB.guid%TYPE := Get_Installation_Id_;
   rowid_               ROWID;
   CURSOR getlog IS
      SELECT text1, rowid
      FROM INSTALL_TEM_SYS_TAB
      WHERE action = job_queue_proc_
      AND guid = previous_guid_
      AND category = 'JOB_QUEUE_PROCESSES'
      AND text2 IS NULL;
BEGIN
   -- Save the old value
   OPEN getlog;
   FETCH getlog INTO job_queue_processes_, rowid_;
   IF getlog%FOUND THEN
      CLOSE getlog;
      SELECT INSTALL_TEM_SYS_SEQ.NEXTVAL
      INTO   log_id_
      FROM   dual;
      INSERT INTO INSTALL_TEM_SYS_TAB
         (log_id,
          guid,
          category,
          text1,
          created,
          last_modified,
          action)
      VALUES
         (log_id_,
          guid_,
          'RESET_JOB_QUEUE_PROCESSES',
          job_queue_processes_,
          SYSDATE,
          SYSDATE,
          job_queue_proc_);
      UPDATE INSTALL_TEM_SYS_TAB
      SET text2 = 'Reset by next installation',
          last_modified = SYSDATE
      WHERE ROWID = rowid_;
   ELSE
      CLOSE getlog;
   END IF;
END Reset_Job_Queue_Processes___;

FUNCTION Identify_Large_Database___ RETURN NUMBER
IS
   cnt_      NUMBER := 0;
   num_rows_ NUMBER := 0;
   CURSOR get_large_tables IS
      SELECT table_name, num_rows
      FROM User_Tables
      WHERE num_rows IS NOT NULL
      ORDER BY num_rows DESC;
   rec_ get_large_tables%ROWTYPE;
BEGIN
   OPEN get_large_tables;
   FETCH get_large_tables INTO rec_;
   WHILE get_large_tables%FOUND AND cnt_ < 50 AND num_rows_ < large_db_limit_ LOOP
      num_rows_ := num_rows_ + rec_.num_rows;
      cnt_ := cnt_ + 1;
      FETCH get_large_tables INTO rec_;
   END LOOP;
   CLOSE get_large_tables;
   IF num_rows_ > large_db_limit_ THEN
      RETURN 1;
   ELSE
      RETURN 0;
   END IF;
END Identify_Large_Database___;

PROCEDURE Enable_New_Processes___
IS
   job_removed EXCEPTION;
   PRAGMA      EXCEPTION_INIT(job_removed, -27476);
   guid_  INSTALL_TEM_SYS_TAB.guid%TYPE := Get_Installation_Id_;
   CURSOR get_processes IS
      SELECT text3, log_id
      FROM install_tem_sys_tab
      WHERE guid = guid_
      AND   text2 = 'INIT_PROCESSING'
      AND   text4 IS NULL
      AND   category = 'LU_INSTALLATION_SUPPORT';
BEGIN
   FOR rec_ IN get_processes LOOP
      BEGIN
         EXECUTE IMMEDIATE rec_.text3;
         UPDATE install_tem_sys_tab
         SET text4 = 'Background processing started',
             last_modified = SYSDATE
         WHERE log_id = rec_.log_id;
      EXCEPTION
         WHEN job_removed THEN
            UPDATE install_tem_sys_tab
            SET text4 = 'Background job removed by another process',
                last_modified = SYSDATE
            WHERE log_id = rec_.log_id;
         WHEN OTHERS THEN
            Dbms_Output.Put_Line('Error starting background processing');
            Dbms_Output.Put_Line(rec_.text3);
            Dbms_Output.Put_Line(SUBSTR(SQLERRM, 11, 2000));
      END;
   END LOOP;
END Enable_New_Processes___;

FUNCTION Check_Queue_Process___ RETURN BOOLEAN
IS
   dummy_    NUMBER;
   CURSOR check_process IS
      SELECT 1
      FROM v$process
      WHERE pname = 'CJQ0';
BEGIN
   OPEN check_process;
   FETCH check_process INTO dummy_;
   IF check_process%FOUND THEN
      CLOSE check_process;
      RETURN TRUE;
   ELSE
      CLOSE check_process;
      RETURN FALSE;
   END IF;
END Check_Queue_Process___;

-----------------------------------------------------------------------------
-------------------- SERVICE SPECIFIC PRIVATE METHODS -----------------------
-----------------------------------------------------------------------------

PROCEDURE Alter_Job_Queue_Processes__ (
   value_ IN VARCHAR2 )
IS
   continue_ BOOLEAN := TRUE;
   counter_  NUMBER := 0;
BEGIN
   -- ifs_assert_safe mabose 20130823
   EXECUTE IMMEDIATE 'ALTER SYSTEM SET job_queue_processes='||to_char(to_number(value_))||' SCOPE=MEMORY';
   IF Am_I_Multitenant=FALSE THEN
      Dbms_Lock.Sleep(1);
      WHILE continue_ AND counter_ < 20 LOOP
         IF Check_Queue_Process___ THEN
            IF value_ != '0' THEN
               continue_ := FALSE;
            ELSE
               Dbms_Lock.Sleep(3);
            END IF;
         ELSE
            IF value_ = '0' THEN
               continue_ := FALSE;
            ELSE
               Dbms_Lock.Sleep(3);
            END IF;
         END IF;
         counter_ := counter_ + 1;
      END LOOP;
   END IF;
END Alter_Job_Queue_Processes__;

PROCEDURE Disable_Dbms_Scheduler__ (
   value_ IN VARCHAR2 )
IS
BEGIN
   Dbms_Scheduler.Set_Scheduler_Attribute ('SCHEDULER_DISABLED', value_);
END Disable_Dbms_Scheduler__;

PROCEDURE Enable_All_Queues__
IS
   CURSOR get_queues IS
      SELECT name
      FROM all_queues
      WHERE queue_type = 'NORMAL_QUEUE'
      AND TRIM(enqueue_enabled) = 'NO'
      AND owner = UPPER('VTAPP');
BEGIN
   FOR rec_ IN get_queues LOOP
      Dbms_Aqadm.Start_Queue(rec_.name);
   END LOOP;
END Enable_All_Queues__;

PROCEDURE Create_Context__
IS
   dummy_     NUMBER;
   stmt_      VARCHAR2(4000);
   error_msg_ VARCHAR2(4000);
   ctx_error  EXCEPTION;
   PRAGMA     EXCEPTION_INIT(ctx_error, -20000);
   crlf_      CONSTANT VARCHAR2(2) := chr(13)||chr(10);
BEGIN
   BEGIN
      Ctx_Ddl.Create_Policy('BLOB_POLICY', 'CTXSYS.AUTO_FILTER');
      Dbms_Output.Put_Line('Policy BLOB_POLICY created');
   EXCEPTION
      WHEN ctx_error THEN
         error_msg_ := UPPER(SQLERRM);
         IF INSTR(error_msg_, 'DUPLICATE') > 0
         OR  INSTR(error_msg_, 'ALREADY EXIST') > 0 THEN
            Dbms_Output.Put_Line('The policy BLOB_POLICY already exists');
         ELSE
            Dbms_Output.Put_Line('Unhandled error:'||crlf_||error_msg_);
         END IF;
   END;
   BEGIN
      Ctx_Ddl.Create_Section_Group('APPLICATION_SEARCH', 'AUTO_SECTION_GROUP');
      Dbms_Output.Put_Line('Section group APPLICATION_SEARCH created');
   EXCEPTION
      WHEN ctx_error THEN
         error_msg_ := UPPER(SQLERRM);
         IF INSTR(error_msg_, 'DUPLICATE') > 0
         OR  INSTR(error_msg_, 'ALREADY EXIST') > 0 THEN
            Dbms_Output.Put_Line('The section group APPLICATION_SEARCH already exists');
         ELSE
            Dbms_Output.Put_Line('Unhandled error:'||crlf_||error_msg_);
         END IF;
   END;
   BEGIN
      Ctx_Ddl.Create_Preference('APPLICATION_SEARCH_LEXER', 'BASIC_LEXER');
      Dbms_Output.Put_Line('Preference APPLICATION_SEARCH_LEXER created');
   EXCEPTION
      WHEN ctx_error THEN
         error_msg_ := UPPER(SQLERRM);
         IF INSTR(error_msg_, 'DUPLICATE') > 0
         OR  INSTR(error_msg_, 'ALREADY EXIST') > 0 THEN
            Dbms_Output.Put_Line('The preference APPLICATION_SEARCH_LEXER already exists');
         ELSE
            Dbms_Output.Put_Line('Unhandled error:'||crlf_||error_msg_);
         END IF;
   END;
   Ctx_Ddl.Set_Attribute('APPLICATION_SEARCH_LEXER', 'PRINTJOINS', '_');
   BEGIN
      Ctx_Ddl.Create_Preference('APPLICATION_SEARCH_STORAGE', 'BASIC_STORAGE');
      Dbms_Output.Put_Line('Preference APPLICATION_SEARCH_STORAGE created');
   EXCEPTION
      WHEN ctx_error THEN
         error_msg_ := UPPER(SQLERRM);
         IF INSTR(error_msg_, 'DUPLICATE') > 0
         OR  INSTR(error_msg_, 'ALREADY EXIST') > 0 THEN
            Dbms_Output.Put_Line('The preference APPLICATION_SEARCH_STORAGE already exists');
         ELSE
            Dbms_Output.Put_Line('Unhandled error:'||crlf_||error_msg_);
         END IF;
   END;
   Ctx_Ddl.Set_Attribute('APPLICATION_SEARCH_STORAGE','FORWARD_INDEX','TRUE');
   Ctx_Ddl.Set_Attribute('APPLICATION_SEARCH_STORAGE','SAVE_COPY','PLAINTEXT');
   Ctx_Ddl.Set_Attribute('APPLICATION_SEARCH_STORAGE','SAVE_COPY_MAX_SIZE','4000');
END Create_Context__;

PROCEDURE Cleanup__
IS
BEGIN
   DELETE FROM INSTALL_TEM_SYS_TAB
   WHERE created < SYSDATE - days_to_keep_;
END Cleanup__;

PROCEDURE Disable_Ial_Scheduler_Proc__
IS
   table_not_found EXCEPTION;
   PRAGMA          EXCEPTION_INIT(table_not_found, -00942);
   TYPE ref_cursor IS REF CURSOR;
   get_jobs        ref_cursor;
   job_name_       VARCHAR2(128);
   comments_       VARCHAR2(32767);
   num_of_jobs_    NUMBER := 0;
   stmt_           VARCHAR2(32767) := '
      SELECT j.job_name, j.comments
      FROM   batch_queue_method_tab m,
             dba_scheduler_jobs     j,
             dba_scheduler_job_args a
      WHERE  m.method_name = ''Ial_Object_API.Do_Replication__''
      AND    j.owner = Sys_Context(''USERENV'', ''CURRENT_SCHEMA'')
      AND    j.owner = a.owner
      AND    j.job_name = a.job_name
      AND    a.argument_name = ''ACTION_''
      AND    j.enabled = ''TRUE''
      AND    (upper(a.value) LIKE ''TRANSACTION_SYS.PROCESS_ALL_PENDING__('' || m.queue_id || '')%'' OR
              upper(a.value) LIKE ''TRANSACTION_SYS.PROCESS_ALL_PENDING__('' || m.queue_id || '',%'')';
BEGIN
   OPEN get_jobs FOR stmt_;
   LOOP
      FETCH get_jobs INTO job_name_, comments_;
      EXIT WHEN get_jobs%NOTFOUND;
      num_of_jobs_ := num_of_jobs_ + 1;
      IF (num_of_jobs_ = 1) THEN
         Dbms_Output.Put_Line(' ');
         Dbms_Output.Put_Line('The following scheduled F1 jobs were disabled');
         Dbms_Output.Put_Line('=============================================');
      END IF;
      Dbms_Scheduler.Disable(job_name_, TRUE);
      Dbms_Scheduler.Set_Attribute(job_name_, 'COMMENTS', stopped_ial_ || ' ' || comments_);
      Dbms_Output.Put(Rpad(job_name_, 50, ' '));
      Dbms_Output.Put_Line(Ltrim(REPLACE(comments_, stopped_ial_)));
   END LOOP;

   CLOSE get_jobs;
EXCEPTION
   WHEN table_not_found THEN
      NULL;
   WHEN OTHERS THEN
      IF (get_jobs%ISOPEN) THEN
         CLOSE get_jobs;
      END IF;
      RAISE;
END Disable_Ial_Scheduler_Proc__;


PROCEDURE Stop_Ial_Scheduler_Proc__
IS
   table_not_found EXCEPTION;
   PRAGMA          EXCEPTION_INIT(table_not_found, -00942);
   TYPE ref_cursor IS REF CURSOR;
   get_jobs        ref_cursor;
   job_name_       VARCHAR2(128);
   i_              NUMBER := 0;
   stmt_           VARCHAR2(32767) := '
      SELECT j.job_name
      FROM   transaction_sys_local_tab t, all_scheduler_jobs j
      WHERE  t.state = ''Executing''
      AND    t.procedure_name = ''Ial_Object_API.Do_Replication__''
      AND    j.owner = ''VTAPP''
      AND    j.job_name = ''F1JOB_'' || t.process_id';
BEGIN
   OPEN get_jobs FOR stmt_;
   LOOP
      FETCH get_jobs INTO job_name_;
      EXIT WHEN get_jobs%NOTFOUND;
      Dbms_Scheduler.Stop_Job(job_name_);
      i_ := i_ + 1;
      IF (i_ = 1) THEN
         Dbms_Output.Put_Line(' ');
         Dbms_Output.Put_Line('The following running F1 jobs are stopped');
         Dbms_Output.Put_Line('=========================================');
      END IF;
      Dbms_Output.Put_Line(Rpad(job_name_, 31, ' '));
   END LOOP;
   CLOSE get_jobs;
EXCEPTION
   WHEN table_not_found THEN
      NULL;
   WHEN OTHERS THEN
      IF (get_jobs%ISOPEN) THEN
         CLOSE get_jobs;
      END IF;
      RAISE;
END Stop_Ial_Scheduler_Proc__;


PROCEDURE Enable_Ial_Scheduler_Proc__
IS
   num_of_jobs_ NUMBER := 0;
   CURSOR get_jobs IS
      SELECT '"'||job_name||'"' job_name,
             nvl(comments, '-') comments
        FROM user_scheduler_jobs
        WHERE  comments LIKE stopped_ial_ || '%';
BEGIN
   FOR rec IN get_jobs LOOP
      num_of_jobs_ := num_of_jobs_ + 1;
      IF (num_of_jobs_ = 1) THEN
         Dbms_Output.Put_Line(' ');
         Dbms_Output.Put_Line('The following scheduled F1 jobs are enabled');
         Dbms_Output.Put_Line('===========================================');
      END IF;
      Dbms_Output.Put(Rpad(rec.job_name, 31, ' '));
      IF (Instr(rec.comments, stopped_ial_) > 0) THEN
         Dbms_Scheduler.Enable(rec.job_name);
         Dbms_Scheduler.Set_Attribute(rec.job_name,
                                      'COMMENTS',
                                      Ltrim(REPLACE(rec.comments, stopped_ial_)));
      END IF;
      Dbms_Output.Put(Rpad('Enabled:', 11, ' '));
      Dbms_Output.Put_Line(Ltrim(REPLACE(rec.comments, stopped_ial_)));
   END LOOP;
   Dbms_Output.Put_Line(' ');
END Enable_Ial_Scheduler_Proc__;


-----------------------------------------------------------------------------
-------------------- SERVICE SPECIFIC PROTECTED METHODS ---------------------
-----------------------------------------------------------------------------

FUNCTION Get_Installation_Id_ RETURN VARCHAR2
IS
   guid_ INSTALL_TEM_SYS_TAB.guid%TYPE;
   PROCEDURE Store_Guid
   IS
      PRAGMA autonomous_transaction;
   BEGIN
      INSERT INTO INSTALL_TEM_SYS_TAB
            (log_id,
             guid)
      VALUES
            (0,
            guid_);
      COMMIT;
   END Store_Guid;
BEGIN
   BEGIN
      SELECT guid
      INTO guid_
      FROM INSTALL_TEM_SYS_TAB
      WHERE log_id = 0;
   EXCEPTION
      WHEN no_data_found THEN
         SELECT TO_CHAR(logon_time, 'YYYYMMDD HH24MISS')
         INTO guid_
         FROM sys.v_$session
         WHERE audsid = userenv('SESSIONID')
         AND ROWNUM < 2;
         Store_Guid;
   END;
   RETURN guid_;
END Get_Installation_Id_;

-----------------------------------------------------------------------------
-------------------- SERVICE SPECIFIC PUBLIC METHODS ------------------------
-----------------------------------------------------------------------------

FUNCTION Disable_Show_Dbms_Jobs RETURN NUMBER
IS
BEGIN
   Disable_Idle_Dbms_Jobs___;
   RETURN(Show_Dbms_Jobs___);
END Disable_Show_Dbms_Jobs;

PROCEDURE Disable_Show_Dbms_Jobs
IS
   count_   NUMBER;
BEGIN
   Disable_Idle_Dbms_Jobs___;
   count_ := Show_Dbms_Jobs___;
END Disable_Show_Dbms_Jobs;

PROCEDURE Disable_Scheduler_Processes
IS
   num_of_jobs_ NUMBER := 0;
   CURSOR get_jobs IS
      SELECT DISTINCT '"'||usj.job_name||'"' job_name,
             nvl(usj.comments, '-') comments,
             usj.enabled            enabled,
             TO_CHAR(NULL)          task_name,
             TO_CHAR(NULL)          task_comment
      FROM user_scheduler_jobs usj
      UNION
      SELECT DISTINCT '"'||upet.task_name||'"' job_name,
             TO_CHAR(NULL)          comments,
             TO_CHAR(NULL)          enabled,
             upet.task_name         task_name,
             upet.task_comment      task_comment
      FROM  user_parallel_execute_tasks upet;
BEGIN
   FOR rec IN get_jobs LOOP
      num_of_jobs_ := num_of_jobs_ + 1;
      IF (num_of_jobs_ = 1) THEN
         Dbms_Output.Put_Line(' ');
         Dbms_Output.Put_Line('The following scheduled F1 jobs were disabled');
         Dbms_Output.Put_Line('=============================================');
      END IF;
      IF rec.task_name IS NULL THEN
         IF rec.enabled = 'TRUE' THEN
            Dbms_Scheduler.Disable(rec.job_name, TRUE);
            Dbms_Scheduler.Set_Attribute(rec.job_name,
                                         'COMMENTS',
                                         stopped_ || ' ' || rec.comments);
            Dbms_Output.Put(Rpad(rec.job_name, 50, ' '));
            Dbms_Output.Put_Line(Ltrim(REPLACE(rec.comments, stopped_)));
         END IF;
      ELSE
         Dbms_Parallel_Execute.Drop_Task(rec.task_name);
         Dbms_Output.Put(Rpad(rec.task_name, 50, ' '));
         Dbms_Output.Put_Line(Ltrim(rec.task_comment));
      END IF;
   END LOOP;
END Disable_Scheduler_Processes;

PROCEDURE Enable_Scheduler_Processes
IS
   num_of_jobs_ NUMBER := 0;
   CURSOR get_jobs IS
      SELECT '"'||job_name||'"' job_name,
             nvl(comments, '-') comments
        FROM user_scheduler_jobs;
BEGIN
   FOR rec IN get_jobs LOOP
      num_of_jobs_ := num_of_jobs_ + 1;
      IF (num_of_jobs_ = 1) THEN
         Dbms_Output.Put_Line(' ');
         Dbms_Output.Put_Line('The following scheduled F1 jobs are enabled');
         Dbms_Output.Put_Line('===========================================');
      END IF;
      Dbms_Output.Put(Rpad(rec.job_name, 31, ' '));
      IF (Instr(rec.comments, stopped_) > 0) THEN
         Dbms_Scheduler.Enable(rec.job_name);
         Dbms_Scheduler.Set_Attribute(rec.job_name,
                                      'COMMENTS',
                                      Ltrim(REPLACE(rec.comments, stopped_)));
      END IF;
      Dbms_Output.Put(Rpad('Enabled:', 11, ' '));
      Dbms_Output.Put_Line(Ltrim(REPLACE(rec.comments, stopped_)));
   END LOOP;
   Dbms_Output.Put_Line(' ');
END Enable_Scheduler_Processes;

PROCEDURE Show_Db_Obj_Invalid_Count
IS
   i_ NUMBER;
BEGIN
   i_ := Show_Db_Obj_Invalid_Count___;
END Show_Db_Obj_Invalid_Count;


FUNCTION Show_Db_Obj_Invalid_Count RETURN NUMBER
IS
BEGIN
   RETURN(Show_Db_Obj_Invalid_Count___);
END Show_Db_Obj_Invalid_Count;

PROCEDURE Show_Debug_Status
IS
   status_ v$parameter.value%TYPE;
BEGIN
   IF Get_Init_Parameter___('plsql_debug') = 'TRUE'
   OR Get_Init_Parameter___('plsql_optimize_level') < '2' THEN
      Dbms_Output.Put_Line('WARNING: Plsql debugging information is turned on in this database instance!');
   END IF;
END Show_Debug_Status;

PROCEDURE Show_Db_Obj_Debug_Count
IS
   i_ NUMBER;
BEGIN
   i_ := Show_Db_Obj_Debug_Count___;
END Show_Db_Obj_Debug_Count;


FUNCTION Show_Db_Obj_Debug_Count RETURN NUMBER
IS
BEGIN
   RETURN(Show_Db_Obj_Debug_Count___);
END Show_Db_Obj_Debug_Count;


FUNCTION Show_Db_Obj_Debug_Exist RETURN NUMBER
IS
   i_ NUMBER;
   j_ NUMBER;
BEGIN
   i_ := Show_Db_Obj_Debug_Count___;
   SELECT DECODE(i_, 0, 0, 1)
   INTO j_
   FROM dual;
   RETURN(j_);
END Show_Db_Obj_Debug_Exist;

PROCEDURE Show_Dbms_Jobs
IS
   num_of_jobs_ NUMBER := 0;
BEGIN
   num_of_jobs_ := Show_Dbms_Jobs___;
END Show_Dbms_Jobs;

FUNCTION Show_Dbms_Jobs RETURN NUMBER
IS
BEGIN
   RETURN(Show_Dbms_Jobs___);
END Show_Dbms_Jobs;

PROCEDURE Show_Scheduler_Processes
IS
   num_of_jobs_ NUMBER := 0;
BEGIN
   num_of_jobs_ := Show_Scheduler_Processes___;
END Show_Scheduler_Processes;

FUNCTION Show_Scheduler_Processes RETURN NUMBER
IS
BEGIN
   RETURN(Show_Scheduler_Processes___);
END Show_Scheduler_Processes;

FUNCTION Show_Jobs_Other_Schema RETURN NUMBER
IS
BEGIN
   RETURN(Show_Jobs_Other_Schema___);
END Show_Jobs_Other_Schema;

PROCEDURE Show_Jobs_Other_Schema
IS
   num_of_jobs_ NUMBER := 0;
BEGIN
   num_of_jobs_ := Show_Jobs_Other_Schema___;
END Show_Jobs_Other_Schema;

FUNCTION Show_Jobs_Trgs_Other_Schema RETURN NUMBER
IS
BEGIN
   RETURN(Show_Jobs_Other_Schema___ + Show_Triggers_Other_Schema___);
END Show_Jobs_Trgs_Other_Schema;

PROCEDURE Show_Jobs_Trgs_Other_Schema
IS
   num_of_jobs_ NUMBER := 0;
BEGIN
   num_of_jobs_ := Show_Jobs_Other_Schema___ + Show_Triggers_Other_Schema___;
END Show_Jobs_Trgs_Other_Schema;

PROCEDURE Reset_Job_Queue_Processes
IS
   job_queue_processes_ INSTALL_TEM_SYS_TAB.text1%TYPE;
   log_id_              INSTALL_TEM_SYS_TAB.log_id%TYPE;
   guid_                INSTALL_TEM_SYS_TAB.guid%TYPE := Get_Installation_Id_;
   CURSOR getlog IS
      SELECT text1, log_id
      FROM INSTALL_TEM_SYS_TAB
      WHERE action = job_queue_proc_
      AND guid = guid_
      AND category = 'JOB_QUEUE_PROCESSES'
      AND text2 IS NULL;
BEGIN
   OPEN getlog;
   FETCH getlog INTO job_queue_processes_, log_id_;
   IF getlog%FOUND THEN
      CLOSE getlog;
      -- Set back to previous value or def_no_of_processes_ if it has null
      Alter_Job_Queue_Processes__(Nvl(job_queue_processes_, def_no_of_processes_));
      UPDATE INSTALL_TEM_SYS_TAB
      SET text2 = 'Job queue processes reverted to '||job_queue_processes_,
          last_modified = SYSDATE
      WHERE log_id = log_id_;
   ELSE
      CLOSE getlog;
      -- Set to default value, i.e. def_no_of_processes_, if no log is found
      Alter_Job_Queue_Processes__(def_no_of_processes_);
   END IF;
END Reset_Job_Queue_Processes;

PROCEDURE Set_Job_Queue_Processes (
   in_no_of_processes_ IN VARCHAR2 )
IS
   no_of_processes_     NUMBER;
   job_queue_processes_ INSTALL_TEM_SYS_TAB.text1%TYPE;
   log_id_              INSTALL_TEM_SYS_TAB.log_id%TYPE;
   guid_                INSTALL_TEM_SYS_TAB.guid%TYPE := Get_Installation_Id_;
   rowid_               ROWID;
   CURSOR getlog IS
      SELECT text1, rowid
      FROM INSTALL_TEM_SYS_TAB
      WHERE action = job_queue_proc_
      AND guid = guid_
      AND category IN ('JOB_QUEUE_PROCESSES', 'RESET_JOB_QUEUE_PROCESSES');
BEGIN
   BEGIN
      SELECT TRUNC(TO_NUMBER(in_no_of_processes_)) INTO no_of_processes_ FROM dual;
   EXCEPTION
      WHEN invalid_number THEN
         no_of_processes_ := def_no_of_processes_;
         Dbms_Output.Put_Line('PROMPT '||in_no_of_processes_||' is not a correct value for job queue processes interval! By default, '||def_no_of_processes_||' will be used');
   END;
   IF no_of_processes_ < min_no_of_processes_ THEN
      no_of_processes_ := def_no_of_processes_;
      Dbms_Output.Put_Line('PROMPT '||in_no_of_processes_||' is not a correct value for job queue processes interval! By default, '||def_no_of_processes_||' will be used');
   END IF;
   -- Save the old value
   OPEN getlog;
   FETCH getlog INTO job_queue_processes_, rowid_;
   IF getlog%FOUND THEN
      CLOSE getlog;
      DELETE FROM INSTALL_TEM_SYS_TAB WHERE ROWID = rowid_;
   ELSE
      CLOSE getlog;
      job_queue_processes_ := Get_Init_Parameter___('job_queue_processes');
   END IF;
   Alter_Job_Queue_Processes__(no_of_processes_);
   SELECT INSTALL_TEM_SYS_SEQ.NEXTVAL
   INTO   log_id_
   FROM   dual;
   INSERT INTO INSTALL_TEM_SYS_TAB
      (log_id,
       guid,
       category,
       text1,
       created,
       last_modified,
       action)
   VALUES
      (log_id_,
       guid_,
       'JOB_QUEUE_PROCESSES',
       job_queue_processes_,
       SYSDATE,
       SYSDATE,
       job_queue_proc_);
END Set_Job_Queue_Processes;


PROCEDURE Stop_Scheduler_Processes
IS
   already_stopped EXCEPTION;
   PRAGMA EXCEPTION_INIT(already_stopped, -27366);
   i_ NUMBER := 0;
   CURSOR get_running_jobs IS
      SELECT r.job_name
        FROM user_scheduler_running_jobs r;
BEGIN
   Install_Tem_SYS.Disable_Scheduler_Processes;
   FOR rec IN get_running_jobs LOOP
      BEGIN
         Dbms_Scheduler.Stop_Job(rec.job_name);
         i_ := i_ + 1;
         IF (i_ = 1) THEN
            Dbms_Output.Put_Line(' ');
            Dbms_Output.Put_Line('The following running F1 jobs are stopped');
            Dbms_Output.Put_Line('=========================================');
         END IF;
         Dbms_Output.Put_Line(Rpad(rec.job_name, 31, ' '));
      EXCEPTION
         WHEN already_stopped THEN
             NULL;
      END;
   END LOOP;
END Stop_Scheduler_Processes;

PROCEDURE Installation_Support (
   action_    IN VARCHAR2,
   parameter_ IN VARCHAR2,
   module_    IN VARCHAR2 DEFAULT NULL )
IS
BEGIN
   CASE UPPER(action_)
      WHEN 'PRE_INSTALLATION' THEN
         Pre_Installation___(parameter_);
      WHEN 'POST_INSTALLATION' THEN
         Post_Installation___(parameter_);
      WHEN 'DISABLE_TRIGGERS' THEN
         Disable_Triggers___(parameter_);
      WHEN 'ENABLE_TRIGGERS' THEN
         Enable_Triggers___(parameter_);
      WHEN 'COMPILE_BASE_PACKAGES' THEN
         Compile_Base_Packages___(parameter_);
      WHEN 'REFRESH_CUSTOMOBJECTS' THEN
         Refresh_Customobjects___(parameter_);
      WHEN 'BI_POST_INSTALLATION_OBJECT' THEN
         Bi_Post_Install_Object___(parameter_);
      WHEN 'FINALIZE_DEV_DEPLOY' THEN
         Finalize_Dev_Deploy___(parameter_);
      ELSE
         NULL;
   END CASE;
END Installation_Support;

PROCEDURE Lu_Installation_Support (
   lu_        IN VARCHAR2,
   action_    IN VARCHAR2,
   parameter_ IN VARCHAR2 DEFAULT NULL )
IS
   log_id_ INSTALL_TEM_SYS_TAB.log_id%TYPE;
   guid_   INSTALL_TEM_SYS_TAB.guid%TYPE := Get_Installation_Id_;
   installation_mode_ BOOLEAN := FALSE;
BEGIN
   -- ifs_assert_safe mabose 20140331
   EXECUTE IMMEDIATE 'BEGIN :installation_mode := Installation_SYS.Get_Installation_Mode; END;' USING OUT installation_mode_;
   IF installation_mode_ THEN
      SELECT INSTALL_TEM_SYS_SEQ.NEXTVAL
      INTO   log_id_
      FROM   dual;
      INSERT INTO INSTALL_TEM_SYS_TAB
         (log_id,
          guid,
          category,
          text1,
          text2,
          text3,
          created,
          last_modified,
          action)
      VALUES
         (log_id_,
          guid_,
          'LU_INSTALLATION_SUPPORT',
          lu_,
          action_,
          parameter_,
          SYSDATE,
          SYSDATE,
          '<LU_INSTALLATION_SUPPORT>');
   END IF;
END Lu_Installation_Support;


PROCEDURE Finalize_Installation (
   complete_ VARCHAR2 DEFAULT 'FALSE' )
IS
   dummy_       NUMBER;
   appowner_    VARCHAR2(30) := UPPER('VTAPP');
   compile_all_ BOOLEAN := FALSE;
   multi_delivery_ BOOLEAN := Get_Multi_Installation_Mode;
   CURSOR check_top_exist IS
      SELECT 1
      FROM install_tem_sys_tab
      WHERE log_id = 0;
BEGIN
   OPEN check_top_exist;
   FETCH check_top_exist INTO dummy_;
   IF check_top_exist%FOUND THEN
      CLOSE check_top_exist;
      IF complete_ = 'TRUE' THEN
         IF multi_delivery_ = FALSE THEN
            --@ApproveDynamicStatement(2016-11-07,mabose)
            EXECUTE IMMEDIATE 'BEGIN SYS.Utl_Recomp.Recomp_Parallel(8, :schema_); END;' USING appowner_;
            -- ifs_assert_safe mabose 20140417
            EXECUTE IMMEDIATE 'BEGIN Database_SYS.Installation_Summary; END;';
         END IF;
      ELSIF complete_ = 'MULTI' THEN
         --@ApproveDynamicStatement(2016-11-07,mabose)
         EXECUTE IMMEDIATE 'BEGIN Database_SYS.Compile_All_Invalid_Objects; END;';
         --@ApproveDynamicStatement(2019-11-26,mabose)
         EXECUTE IMMEDIATE 'BEGIN Database_SYS.Compile_Schema_(:ial_owner, :compile_other_schema, FALSE); END;' USING 'VTINFO', 'Y';
         -- ifs_assert_safe mabose 20140417
         EXECUTE IMMEDIATE 'BEGIN Database_SYS.Installation_Summary; END;';
      ELSE
         -- ifs_assert_safe mabose 20140129
         EXECUTE IMMEDIATE 'BEGIN Installation_SYS.Create_Component_Package(TRUE); END;';
         Enable_Triggers___(NULL);
      END IF;
      IF complete_ != 'RESET' THEN
         IF (multi_delivery_ = TRUE
         AND complete_ = 'TRUE') THEN
            NULL;
         ELSE
            Reset_Job_Queue_Processes;
            Enable_Scheduler_Processes;
            IF complete_ IN ('TRUE', 'MULTI') THEN
               Enable_New_Processes___;
            END IF;
         END IF;
      END IF;
      IF (multi_delivery_ = TRUE
      AND complete_ = 'TRUE') THEN
         NULL;
      ELSE
         BEGIN
            DELETE FROM install_tem_sys_tab
            WHERE log_id = 0;
         EXCEPTION
            WHEN no_data_found THEN
               NULL;
         END;
      END IF;
   ELSE
      CLOSE check_top_exist;
   END IF;
END Finalize_Installation;


FUNCTION User_Exist (
   username_ IN VARCHAR2 ) RETURN NUMBER
IS
   dummy_ NUMBER;
   CURSOR check_exist IS
      SELECT 1
      FROM dba_users
      WHERE username = username_;
BEGIN
   OPEN check_exist;
   FETCH check_exist INTO dummy_;
   IF check_exist%FOUND THEN
      CLOSE check_exist;
      RETURN 1;
   ELSE
      CLOSE check_exist;
      RETURN 0;
   END IF;
END User_Exist;

FUNCTION Get_Multi_Installation_Mode RETURN BOOLEAN
IS
   text1_ INSTALL_TEM_SYS_TAB.text1%TYPE;
BEGIN
   BEGIN
      SELECT text1
      INTO text1_
      FROM INSTALL_TEM_SYS_TAB
      WHERE log_id = 0;
   EXCEPTION
      WHEN no_data_found THEN
         text1_ := NULL;
   END;
   IF text1_ = 'multi' THEN
      RETURN TRUE;
   ELSE
      RETURN FALSE;
   END IF;
END Get_Multi_Installation_Mode;

PROCEDURE Set_Multi_Installation_Mode (
   multi_delivery_mode_ IN BOOLEAN DEFAULT FALSE )
IS
   guid_  INSTALL_TEM_SYS_TAB.guid%TYPE;
   text1_ INSTALL_TEM_SYS_TAB.text1%TYPE;
BEGIN
   IF multi_delivery_mode_ THEN
      text1_ := 'multi';
   ELSE
      text1_ := NULL;
   END IF;
   BEGIN
      -- Create unique installation id
      SELECT TO_CHAR(logon_time, 'YYYYMMDD HH24MISS')
      INTO guid_
      FROM sys.v_$session
      WHERE audsid = userenv('SESSIONID')
      AND ROWNUM < 2;
      Dbms_Output.Put_Line(' ');
      Dbms_Output.Put_Line('Installation ID: '||guid_);
      Dbms_Output.Put_Line(' ');
      INSERT INTO INSTALL_TEM_SYS_TAB
         (log_id,
          guid,
          text1)
      VALUES
         (0,
          guid_,
          text1_);
   EXCEPTION
      WHEN dup_val_on_index THEN
         UPDATE INSTALL_TEM_SYS_TAB
         SET text1 = text1_
         WHERE log_id = 0;
   END;
END Set_Multi_Installation_Mode;

FUNCTION Disabled_Rowkey_Exist RETURN NUMBER
IS
   dummy_ NUMBER;
BEGIN
   SELECT COUNT(*)
   INTO dummy_
   FROM user_objects
   WHERE object_name = 'DATABASE_SYS';
   IF dummy_ > 0 THEN
      -- ifs_assert_safe mabose 20140905
      EXECUTE IMMEDIATE 'SELECT 1
                         FROM user_tab_columns
                         WHERE column_name = ''ROWKEY''
                         AND  (nullable = ''Y'' OR default_on_null = ''NO'')
                         AND table_name IN (SELECT object_name
                                             FROM user_objects
                                             WHERE object_type = ''TABLE''
                                             AND SUBSTR(object_name, INSTR(object_name, ''_'', -1)) NOT IN (''_CFT'', ''_OLD'')
                                             AND NOT REGEXP_LIKE(SUBSTR(object_name, INSTR(object_name, ''_'', -1)+1),''[0..9]''))
                         AND ROWNUM < 2' INTO dummy_;
      IF NVL(dummy_, 0) > 0 THEN
         RETURN Identify_Large_Database___;
      ELSE
         RETURN 0;
      END IF;
   ELSE
      RETURN 0;
   END IF;
EXCEPTION
   WHEN no_data_found THEN
      RETURN 0;
   WHEN OTHERS THEN
      RETURN Identify_Large_Database___;
END Disabled_Rowkey_Exist;

FUNCTION Disabled_Sd_Exist RETURN NUMBER
IS
   dummy_ NUMBER;
BEGIN
   SELECT COUNT(*)
   INTO dummy_
   FROM user_objects
   WHERE object_name = 'SEARCH_DOMAIN_RUNTIME_TAB';
   IF dummy_ > 0 THEN
      -- ifs_assert_safe mabose 20140905
      EXECUTE IMMEDIATE 'SELECT COUNT(*)
                         FROM dual
                         WHERE EXISTS
                         (SELECT 1
                          FROM search_domain_runtime_tab)' INTO dummy_;
      IF dummy_ > 0 THEN
         RETURN Identify_Large_Database___;
      ELSE
         RETURN 0;
      END IF;
   ELSE
      RETURN 0;
   END IF;
EXCEPTION
   WHEN OTHERS THEN
      RETURN Identify_Large_Database___;
END Disabled_Sd_Exist;

FUNCTION Unconverted_Lob_Exist RETURN NUMBER
IS
   dummy_ NUMBER;
BEGIN
   SELECT COUNT(*)
   INTO dummy_
   FROM dual
   WHERE EXISTS
   (SELECT 1
    FROM user_objects o, user_tab_columns c, user_lobs l
    WHERE o.object_name = c.table_name
    AND o.object_type = 'TABLE'
    AND o.temporary = 'N'
    AND SUBSTR(o.object_name, INSTR(o.object_name, '_', -1)) != '_OLD'
    AND NOT REGEXP_LIKE(SUBSTR(o.object_name, INSTR(o.object_name, '_', -1)+1),'[0..9]')
    AND c.table_name = l.table_name
    AND c.column_name = l.column_name
    AND (l.securefile = 'NO' OR l.in_row = 'NO')
    AND c.table_name NOT LIKE 'VMO%TAB'
    AND c.table_name NOT LIKE 'DR$%'
    AND NOT EXISTS
    (SELECT 1
     FROM ctx_user_indexes t
     WHERE t.idx_table = c.table_name
     AND t.idx_text_name = c.column_name)
    AND NOT EXISTS (
     SELECT 1
     FROM user_queue_tables q
     WHERE q.queue_table = c.table_name));
   IF dummy_ > 0 THEN
      RETURN Identify_Large_Database___;
   ELSE
      RETURN 0;
   END IF;
EXCEPTION
   WHEN OTHERS THEN
      RETURN Identify_Large_Database___;
END Unconverted_Lob_Exist;

FUNCTION Dbms_Scheduler_Enabled RETURN VARCHAR2
IS
   scheduler_disabled_ VARCHAR2(10);
BEGIN
   DBMS_Scheduler.Get_Scheduler_Attribute('SCHEDULER_DISABLED', scheduler_disabled_);
   IF NVL(scheduler_disabled_, 'FALSE') = 'FALSE' THEN
      RETURN 'TRUE';
   ELSE
      RETURN 'FALSE';
   END IF;
END Dbms_Scheduler_Enabled;

FUNCTION Nls_Length_Semantic_Is_Char RETURN VARCHAR2
IS
BEGIN
   IF Get_Init_Parameter___('nls_length_semantics') = 'CHAR' THEN
      RETURN 'TRUE';
   ELSE
      RETURN 'FALSE';
   END IF;
END Nls_Length_Semantic_Is_Char;

FUNCTION Installation_Running RETURN BOOLEAN
IS
   dummy_ NUMBER;
   CURSOR check_installation IS
      SELECT 1
      FROM gv$session
      WHERE module = 'IFS Applications Installer'
      AND action = 'Main Thread';
BEGIN
   OPEN check_installation;
   FETCH check_installation INTO dummy_;
   IF check_installation%FOUND THEN
      CLOSE check_installation;
      RETURN TRUE;
   ELSE
      CLOSE check_installation;
      RETURN FALSE;
   END IF;
END Installation_Running;

PROCEDURE Gather_Initial_Statistics
IS
BEGIN
   DBMS_Stats.Gather_Dictionary_Stats;
   DBMS_Stats.Gather_Database_Stats;
END Gather_Initial_Statistics;

FUNCTION Background_Processing_On RETURN VARCHAR2
IS
BEGIN
   IF Check_Queue_Process___ THEN
      IF Am_I_Multitenant
      AND Get_Init_Parameter___('job_queue_processes') < 1 THEN
         RETURN 'FALSE';
      END IF;
      RETURN 'TRUE';
   ELSE
      RETURN 'FALSE';
   END IF;
END Background_Processing_On;

FUNCTION Am_I_Multitenant RETURN BOOLEAN
IS
   dummy_ NUMBER;
   CURSOR check_multitenant IS
      SELECT 1
      FROM v$database
      WHERE cdb = 'YES';
BEGIN
   OPEN check_multitenant;
   FETCH check_multitenant INTO dummy_;
   IF check_multitenant%FOUND THEN
      CLOSE check_multitenant;
      RETURN TRUE;
   ELSE
      CLOSE check_multitenant;
      RETURN FALSE;
   END IF;
END Am_I_Multitenant ;

-----------------------------------------------------------------------------
-------------------- FOUNDATION1 METHODS ------------------------------------
-----------------------------------------------------------------------------
-- Init
--   Dummy procedure that can be called at database startup to ensure that
--   this package is loaded into memory for performance reasons only.
-----------------------------------------------------------------------------

PROCEDURE Init
IS
BEGIN
   NULL;
END Init;

END INSTALL_TEM_SYS;
/


--
-- CF_REP_CUSTOMER  (View) 
--
--  Dependencies: 
--   CF_REP_CUSTOMER_TAB (Table)
--   CF_REP_DP_STATE_API (Package)
--
CREATE OR REPLACE FORCE VIEW VTAPP.CF_REP_CUSTOMER
(CUSTOMER, DESCRIPTION, DP_STATE, OBJKEY, OBJVERSION, 
 OBJID)
BEQUEATH DEFINER
AS 
SELECT
       customer                       customer,
       description                    description,
       Cf_Rep_Dp_State_API.Decode(customer) dp_state,
       rowkey                         objkey,
       to_char(rowversion,'YYYYMMDDHH24MISS') objversion,
       rowid                          objid
FROM   cf_rep_customer_tab
WITH   READ ONLY;

COMMENT ON TABLE VTAPP.CF_REP_CUSTOMER IS 'LU=CfRepCustomer^PROMPT=Cf Rep Customer^MODULE=PROJ^TABLE=CF_REP_CUSTOMER_TAB^';

COMMENT ON COLUMN VTAPP.CF_REP_CUSTOMER.CUSTOMER IS 'FLAGS=KMI-L^DATATYPE=STRING(20)^PROMPT=Customer^';

COMMENT ON COLUMN VTAPP.CF_REP_CUSTOMER.DESCRIPTION IS 'FLAGS=A-IUL^DATATYPE=STRING(2000)^PROMPT=Description^';


GRANT READ, WRITE ON DIRECTORY DATA_PUMP_DIR TO EXP_FULL_DATABASE;

GRANT READ, WRITE ON DIRECTORY DATA_PUMP_DIR TO IMP_FULL_DATABASE;

GRANT READ, WRITE ON DIRECTORY ORACLE_OCM_CONFIG_DIR TO ORACLE_OCM;

GRANT READ, WRITE ON DIRECTORY ORACLE_OCM_CONFIG_DIR2 TO ORACLE_OCM;
