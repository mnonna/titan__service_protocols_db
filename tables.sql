CREATE TABLE servicestates(
	state_id TINYINT AUTO_INCREMENT UNIQUE,
    state_desc VARCHAR(20) UNIQUE,
    
    PRIMARY KEY(state_id)
);

CREATE TABLE payments(
	payment_id TINYINT AUTO_INCREMENT UNIQUE,
    payment_type_name VARCHAR(10) NOT NULL UNIQUE,
    
    PRIMARY KEY(payment_id)
);

CREATE TABLE clients(
	client_id INT AUTO_INCREMENT UNIQUE,
    client_name_surname VARCHAR(50) NOT NULL UNIQUE,
    client_pesel VARCHAR(11) NOT NULL UNIQUE,
    client_city VARCHAR(40) NOT NULL,
    client_postal VARCHAR(6) NOT NULL,
    client_street VARCHAR(20) NOT NULL,
    client_house_number VARCHAR(5) NOT NULL,
    client_phone_number VARCHAR(15) UNIQUE,
    client_phone_job VARCHAR(15) UNIQUE,
    client_email VARCHAR(50),
    client_invoice_request BOOLEAN NOT NULL,
    client_nip VARCHAR(13) UNIQUE,
    
    PRIMARY KEY(client_id)
);

CREATE TABLE protocols (
	protocol_id INT AUTO_INCREMENT UNIQUE,
    protocol_number VARCHAR(10) UNIQUE,
    client_id INT NOT NULL,
    failure_desc VARCHAR(200) NOT NULL,
    device_number VARCHAR(25) NOT NULL,
    device_name VARCHAR(30) NOT NULL,
    service_cost VARCHAR(3) NOT NULL,
    payment_type TINYINT NOT NULL,
    payment_service_state TINYINT NOT NULL,
    protocol_add_time DATETIME NOT NULL,
    protocol_achievmenet DATE,
    
    PRIMARY KEY(protocol_id),
    FOREIGN KEY(payment_type) REFERENCES payments(payment_id),
    FOREIGN KEY(client_id) REFERENCES clients(client_id),
    FOREIGN KEY (payment_service_state) REFERENCES servicestates(state_id)
);

CREATE TABLE protocolsimages(
	article_id INT AUTO_INCREMENT UNIQUE,
    protocol_id INT UNIQUE NOT NULL,
    images LONGBLOB,
    
    PRIMARY KEY (article_id),
    FOREIGN KEY (protocol_id) REFERENCES protocols(protocol_id)
);

CREATE VIEW clientsprotocols
AS
SELECT clients.client_name_surname AS 'Imię i Nazwisko',clients.client_nip AS 'NIP',
	   clients.client_pesel AS 'PESEL', protocols.protocol_number AS 'Numer protokołu', protocols.failure_desc AS 'Opis usterki',
	   protocols.device_name AS 'Nazwa urządzenia', protocols.device_number AS 'Numer seryjny',
       protocols.service_cost AS 'Koszt',protocols.protocol_add_time AS 'Data wpisania protokołu' ,
       (SELECT payments.payment_type_name FROM payments WHERE protocols.payment_type = payments.payment_id) AS 'Rodzaj zapłaty',
       (SELECT state_desc FROM servicestates WHERE protocols.payment_service_state = state_id) AS 'Stan serwisowania' 
FROM clients 
LEFT JOIN protocols ON clients.client_id = protocols.client_id;
	