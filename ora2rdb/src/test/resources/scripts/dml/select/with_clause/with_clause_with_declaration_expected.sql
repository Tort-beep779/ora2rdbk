CREATE FUNCTION get_domain(url VARCHAR(32765)) RETURNS VARCHAR(32765) AS
    DECLARE pos INTEGER;
    DECLARE len INTEGER;
BEGIN
    pos = POSITION('www.', url);
    len = POSITION('.', SUBSTRING(url FROM pos + 4)) - 1;
RETURN SUBSTRING(url FROM pos + 4 FOR len);
END;

SELECT DISTINCT get_domain(catalog_url)
FROM product_information;