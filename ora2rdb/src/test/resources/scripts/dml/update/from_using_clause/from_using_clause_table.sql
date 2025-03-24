UPDATE books b
    SET b.page_count = bpc.PAGE_COUNT
    FROM book_page_count bpc
WHERE b.ISBN = bpc.ISBN;

UPDATE books b
SET b.page_count = bpc.PAGE_COUNT
    USING book_page_count bpc
WHERE b.ISBN = bpc.ISBN;