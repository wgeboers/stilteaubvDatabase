CREATE USER 'Admin'@'%' IDENTIFIED BY 'AdminPassword'
GRANT ALL PRIVILEGES ON stilteaubv.* TO 'Admin'@'%' WITH GRANT OPTION;

CREATE USER 'SalesPerson'@'%' IDENTIFIED BY 'SalesPassword'
GRANT SELECT, INSERT, UPDATE, DELETE ON stilteaubv.Orders TO 'SalesPerson'@'%' WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE ON stilteaubv.Users TO 'SalesPerson'@'%' WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON stilteaubv.Products TO 'SalesPerson'@'%' WITH GRANT OPTION;

CREATE USER 'Production'@'%' IDENTIFIED BY 'ProductionPassword';
GRANT SELECT, INSERT, UPDATE, DELETE ON stilteaubv.Products TO 'Production'@'%' WITH GRANT OPTION;

CREATE USER 'Customer'@'%' IDENTIFIED BY 'CustomerPassword';
GRANT SELECT ON stilteaubv.orderheaders TO 'Customer'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;

GRANT UPDATE, SELECT ON stilteaubv.users to 'Customer'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;

GRANT SELECT, INSERT ON stilteaubv.orderlines TO 'Customer'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
