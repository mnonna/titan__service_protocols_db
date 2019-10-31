INSERT INTO servicestates (state_desc) VALUES ('PRZYJĘTE');
INSERT INTO servicestates (state_desc) VALUES ('WYKONANE');
INSERT INTO servicestates (state_desc) VALUES ('ZAPŁACONO');

INSERT INTO payments (payment_type_name) VALUES ('GOTÓWKA');
INSERT INTO payments (payment_type_name) VALUES ('KARTA');
INSERT INTO payments (payment_type_name) VALUES ('PRZELEW');

INSERT INTO clients 
(client_name_surname, client_pesel, client_city, client_postal, client_street, client_house_number, client_phone_number,client_email, client_invoice_request, client_nip)
VALUES ('Paweł Skierski','48512356897','Szczecinek','47-452','Rynkowa','4A/2','485895563','skiera@gmail.com',1,'784-485-55-88');

INSERT INTO clients 
(client_name_surname, client_pesel, client_city, client_postal, client_street, client_house_number, client_phone_number,client_email, client_invoice_request, client_nip)
VALUES ('Marcin Nonna','84519562315','Poznań','48-596','Solidarności','3A/3','785658495','mnonna@gmail.com',1,'512-562-45-66');

INSERT INTO protocols (protocol_number, client_id, failure_desc, device_number, device_name, service_cost, payment_type, payment_service_state, protocol_add_time)
VALUES ('59152/2019',1,'Zjebał się laptok','2332WSSASW12DE3','MSI GL63','300',1,1,now());

INSERT INTO protocols (protocol_number, client_id, failure_desc, device_number, device_name, service_cost, payment_type, payment_service_state, protocol_add_time)
VALUES ('59154/2019',1,'Rozjebany komputer PC','789465SWS645SW4WS','Alienware','600',1,1,now());

INSERT INTO protocols (protocol_number, client_id, failure_desc, device_number, device_name, service_cost, payment_type, payment_service_state, protocol_add_time)
VALUES ('59153/2019',2,'Napraw mi kurwa lapka','4832W3SASQ32DN2','Toshiba Satellite','200',1,1,now());

CALL showClientsProtocols('Marcin Nonna');
CALL changeProtocolServiceState('59153/2019',3);
CALL showProtocolsOneState(3);
