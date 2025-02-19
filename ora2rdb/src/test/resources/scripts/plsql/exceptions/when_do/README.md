### [handle_multiple_exception.sql](handle_multiple_exception.sql)

В тесте демонстируется пример обрабботки сразу нескольких исключений 

В ORACLE исползуется **OR**  , в РБД исключения разделяются запятой 


------------------------------------

### [handle_system_exception.sql](handle_system_exception.sql)

В этом тесте происходит обработка системного исключения
**ZERO_DIVIDE**

В РБД аналогом является совокупность из двух исключений 

**GDSCODE EXCEPTION_INTEGER_DIVIDE_BY_ZERO, GDSCODE EXCEPTION_FLOAT_DIVIDE_BY_ZERO**

--------------------------------

### [handle_user_exception.sql](handle_user_exception.sql)

Обработка пользовательского исключения


-------------------

### [when_others_exception.sql](when_others_exception.sql)

Тестирование конструкции 

    WHEN OTHERS THEN

котороая отлавливает любую ошибку 

Аналог в РБД 

    WHEN ANY