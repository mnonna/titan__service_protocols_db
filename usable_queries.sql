/*
	WYBÓR PROTOKOŁÓW DLA DANEGO KLIENTA
*/
DELIMITER //
CREATE PROCEDURE showClientsProtocols(paramClientName VARCHAR(50)) 
BEGIN
	SELECT *FROM protocols WHERE client_id = (SELECT clients.client_id FROM clients WHERE clients.client_name_surname = paramClientName);
END //
DELIMITER ;
/*
/////////////////////////
*/


/*
	ZMIANA STANU SERWISOWANIA
*/

DELIMITER //
CREATE PROCEDURE changeProtocolServiceState(paramProtocolNumber VARCHAR(10),paramState TINYINT) 
BEGIN
	UPDATE protocols SET protocols.payment_service_state = paramState WHERE protocols.protocol_number = paramProtocolNumber; 
END //
DELIMITER ;
/*
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
*/

/*
	WYŚWIETLENIE WSZYSTKICH PROTOKOŁÓW SPEŁNIAJĄCYCH DANY STAN
*/

DELIMITER //
CREATE PROCEDURE showProtocolsOneState(paramState TINYINT) 
BEGIN
	SELECT clients.client_name_surname AS 'Imię i Nazwisko',clients.client_nip AS 'NIP',
	   clients.client_pesel AS 'PESEL', protocols.protocol_number AS 'Numer protokołu', protocols.failure_desc AS 'Opis usterki',
	   protocols.device_name AS 'Nazwa urządzenia', protocols.device_number AS 'Numer seryjny',
       protocols.service_cost AS 'Koszt',protocols.protocol_add_time AS 'Data wpisania protokołu' ,
       (SELECT payments.payment_type_name FROM payments WHERE protocols.payment_type = payments.payment_id) AS 'Rodzaj zapłaty',
       (SELECT state_desc FROM servicestates WHERE protocols.payment_service_state = state_id) AS 'Stan serwisowania' 
	FROM clients 
	LEFT JOIN protocols ON clients.client_id = protocols.client_id WHERE protocols.payment_service_state = paramState;
END //
DELIMITER ;
/*
/////////////////////////////////////////////////////////////////////
*/

