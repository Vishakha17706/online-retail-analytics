-- schema.sql · Online Retail II (real UCI dataset, cleaned)
-- ------------------------------------------------------------------
-- Two tables at the invoice-LINE grain, loaded by data/clean_data.py:
--   sales   -- valid positive-quantity, positive-price product lines
--   returns -- cancellation lines (Invoice starting 'C', negative quantity)
-- Money is GBP. Dates are stored as ISO text ('YYYY-MM-DD HH:MM:SS').
-- ------------------------------------------------------------------

DROP TABLE IF EXISTS sales;
DROP TABLE IF EXISTS returns;

CREATE TABLE sales (
    invoice         TEXT    NOT NULL,            -- 6-digit invoice no.
    stock_code      TEXT    NOT NULL,            -- product code (service codes removed)
    description     TEXT,                        -- product name
    quantity        INTEGER NOT NULL,            -- > 0 in this table
    invoice_date    TEXT    NOT NULL,            -- 'YYYY-MM-DD HH:MM:SS'
    price           REAL    NOT NULL,            -- unit price, GBP, > 0
    revenue         REAL    NOT NULL,            -- quantity * price, GBP
    customer_id     INTEGER,                     -- NULL on ~23% of rows (guest/unknown)
    has_customer_id INTEGER NOT NULL DEFAULT 0,  -- 1 = customer_id present, 0 = NULL
    country         TEXT    NOT NULL,
    source_sheet    TEXT                         -- 'Year 2009-2010' | 'Year 2010-2011'
);

CREATE TABLE returns (
    invoice      TEXT    NOT NULL,               -- starts with 'C'
    stock_code   TEXT    NOT NULL,
    description  TEXT,
    quantity     INTEGER NOT NULL,               -- < 0 (returned units)
    invoice_date TEXT    NOT NULL,
    price        REAL    NOT NULL,               -- unit price, GBP, > 0
    revenue      REAL    NOT NULL,               -- quantity * price (negative)
    customer_id  INTEGER,
    country      TEXT    NOT NULL,
    source_sheet TEXT
);

CREATE INDEX idx_sales_invoice   ON sales (invoice);
CREATE INDEX idx_sales_customer  ON sales (customer_id);
CREATE INDEX idx_sales_date      ON sales (invoice_date);
CREATE INDEX idx_sales_country   ON sales (country);
CREATE INDEX idx_sales_stock     ON sales (stock_code);
CREATE INDEX idx_returns_invoice ON returns (invoice);
CREATE INDEX idx_returns_stock   ON returns (stock_code);
