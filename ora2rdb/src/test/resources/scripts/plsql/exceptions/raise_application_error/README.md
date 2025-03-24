  
### [raise_application_error_inside_anonymous_block.sql](raise_application_error_inside_anonymous_block.sql)

Тест показывает вызов пользовательского исключения 

Пользователь создает исключение и связывает код ошибки с этим исключением

    past_due  EXCEPTION;              
    PRAGMA EXCEPTION_INIT (past_due, -20000);

Затем вызывает это исключения процедурой **RAISE_APPLICATION_ERROR**

    RAISE_APPLICATION_ERROR(-20000, 'Account past due.');

При конвертации создается исключение 

    CREATE EXCEPTION past_due 'past_due exception';

Затем вызывается командой

    EXCEPTION past_due( 'Account past due.');


Аналогично для других тестов **'raise_application_error_inside_...'** 

----------------------------

### [raise_application_error_system_exception.sql](raise_application_error_system_exception.sql)

В этом тесте исключение вызывается по коду ошибки , оно не объявлено поользователем 

При конвертации создается исключение с именем **CUSTOM_EXCEPTION**

    CREATE EXCEPTION CUSTOM_EXCEPTION
    'error';
    
и вызывается командой

    EXCEPTION CUSTOM_EXCEPTION( 'Salary cannot be negative.');


