-- drop schema Salon;
Create schema Salon;

create table Salon.User (
	user_id varchar(50),
	first_name varchar(30) not null,
	last_name varchar(30) not null,
	email varchar(50),
	phone varchar(25) not null,
	role varchar(30) not null,
	
	constraint PK_user_id primary key (user_id),
	constraint UQ_phone unique (phone),
    constraint UQ_email unique (email)
);

insert into Salon.User values ('1','Ana', 'Ankic', 'ana@gmail.com', '1123453', 'manager');
insert into Salon.User values ('2','Aca', 'Aleksic', 'aca@gmail.com', '1123343', 'worker');
insert into Salon.User values ('3','Kosta', 'Kostic', 'kosta@gmail.com', '1134423', 'customer');
insert into Salon.User values ('77','Rile', 'Ristic', 'rile@gmail.com', '11444323', 'worker');
insert into Salon.User values ('6','Kole', 'Kokic', 'kole@gmail.com', '01134423', 'customer');

create table Salon.Customer (
	customer_id varchar(50),
	user_id varchar(50),
	points integer,
	
	constraint PK_customer_id primary key (customer_id),
	constraint UQ_user unique (user_id),
	constraint FK_Customer_User_user_id foreign key (user_id)
	references Salon.User (user_id)
);
insert into Salon.Customer values ('1','3', 5);
insert into Salon.Customer values ('2','6', 15);


create table Salon.Manager (
	manager_id varchar(50),
	user_id varchar(50),

	constraint PK_manager_id primary key (manager_id),
    constraint UQ_user unique (user_id),
	constraint FK_Manager_User_user_id foreign key (user_id)
	references Salon.User (user_id)
);
insert into Salon.Manager values ('1','1');

create table Salon.Worker (
	worker_id varchar(50),
    user_id varchar(50),
	ucin varchar(13),
	active bit,
	start_date date,
	end_date date,
	
	constraint PK_worker_id primary key (worker_id),
    constraint UQ_user unique (user_id),
	constraint FK_Worker_User_user_id foreign key (user_id)
	references Salon.User (user_id),
    constraint UQ_ucin unique (ucin)
    
);
insert into Salon.Worker values ('1','77','2121228581234', 1, "2012-12-11", null);
insert into Salon.Worker values ('2','6','2121228581239', 1, "2002-12-11", null);

create table Salon.Service (
	service_id varchar(50),
	service_name varchar(50),
	actual bit,
	
	constraint PK_service_id primary key (service_id)
);
insert into Salon.Service values ('1', 'Masaza', 1);
insert into Salon.Service values ('2', 'Fizikalna', 1);
insert into Salon.Service values ('3', 'Manikir', 0);
insert into Salon.Service values ('4', 'Pedikir', 1);
insert into Salon.Service values ('5', 'Sminka', 0);

create table Salon.Type_of_service (
	type_of_service_id varchar(50),
	service_id varchar(50),
	name varchar(50),
	description varchar(150),
	price varchar(30),
	actual bit,

	constraint PK_type_of_service_id primary key (type_of_service_id, service_id),
	constraint FK_Type_of_service_service_id foreign key (service_id)
	references Salon.Service (service_id)
);
insert into Salon.Type_of_service values ('1', '1', 'Relaks', 'Opustajuca masaza celog tela', '1000rsd', 1);
insert into Salon.Type_of_service values ('2', '2', 'Ledja i kicma', 'Vezbe za ojacavanje ledja i ispravljanje kicme', '1444rsd', 1);
insert into Salon.Type_of_service values ('3', '3', 'Izlivanje noktiju', 'Crtanje, bojenje, farbanje', '1800rsd', 0);
insert into Salon.Type_of_service values ('4', '4', 'Sredjivanje noktiju na nogama', 'Kompletan tretman noktiju na nogama', '1999rsd', 1);
insert into Salon.Type_of_service values ('5', '5', 'Usluzno sminkanje', 'Sminkanje po izboru', '2500rsd', 0);

create table Salon.Status (
	status_id varchar(50),
	status_name varchar(30),
	description varchar(120),
	
	constraint PK_Status_status_id primary key (status_id)
);
insert into Salon.Status values ('1', 'Aktivna', 'Opis u izradi');
insert into Salon.Status values ('2', 'Uspesna', 'Opis u izradi');
insert into Salon.Status values ('3', 'Neuspesna', 'Opis u izradi');
insert into Salon.Status values ('4', 'Odlozena', 'Opis u izradi');
insert into Salon.Status values ('5', 'Nema informacija', 'Opis u izradi');

create table Salon.Reservation (
	reservation_id varchar(70),
	date date,
	time varchar(25),
	customer_id varchar(50),
	manager_id varchar(50),
	worker_id varchar(50),
	status_id varchar(50),
	type_of_service_id varchar(50),
	confirmation bit,
    price varchar(30),
	description varchar(30),
	
	constraint PK_reservation_id primary key (reservation_id),
	constraint FK_Reservation_customer_id foreign key (customer_id)
	references Salon.Customer (customer_id),
	constraint FK_Reservation_manager_id foreign key (manager_id)
	references Salon.Manager (manager_id),
	constraint FK_Reservation_status_id foreign key (status_id)
	references Salon.Status (status_id),
	constraint FK_Reservation_worker_id foreign key (worker_id)
	references Salon.Worker (worker_id),
	constraint FK_Reservation_type_of_service_id foreign key (type_of_service_id)
	references Salon.type_of_service (type_of_service_id)
);
insert into Salon.Reservation values ('1999999j','2002-08-10', '10:00', '1', '1', '1', '1', '1', 1,'1000din','Rezervacija zakazana.');
insert into Salon.Reservation values ('2','2003-01-12', '12:10', '2', '1', '2', '2', '2', 1,'3000din','Rezervacija zakazana.');
insert into Salon.Reservation values ('3','2004-11-11', '13:30', '1','1', '1', '3', '3', 1,'2000din','Rezervacija zakazana.');
insert into Salon.Reservation values ('4','2005-12-05', '09:02', '2', '1', '2', '4', '4', 1,'1050din','Rezervacija zakazana.');
insert into Salon.Reservation values ('5','2006-12-11', '11:42', '1', '1', '1', '5', '5', 1,'900din','Rezervacija zakazana.');
insert into Salon.Reservation values ('a967a24--870c-11ea-a1c3-448a5b25baef','2006-11-10', '11:42', '1', '1', '1', '5', '5', 0,'900din','Rezervacija zakazana.');
insert into Salon.Reservation values ('100','2006-12-11', '11:42', '1', '1', '1', '5', '5', 1,'900din','TEST REZERVACIJA ZA BRISANJE!');

create table Salon.Notification (
	notification_id integer auto_increment,
	customer_id varchar(50),
	manager_id varchar(50),
	reservation_id varchar(50),
	confirmation bit,
    description varchar(100),
	
	constraint PK_notification_id primary key (notification_id),
	constraint FK_Notification_customer_id foreign key (customer_id)
	references Salon.Customer (customer_id),
	constraint FK_Notification_manager_id foreign key (manager_id)
	references Salon.Manager (manager_id),
    constraint FK_Notification_reservation_id foreign key (reservation_id)
	references Salon.Reservation (reservation_id)
);

insert into Salon.Notification values (1,'1','1','1',1,'Opis 1');
insert into Salon.Notification values (2,'2','1','2',0,'Opis 1');
insert into Salon.Notification values (3,'1','1','3',0,'Opis 1');
insert into Salon.Notification values (4,'1','1','4',1,'Opis 1');
insert into Salon.Notification values (5,'2','1','5',0,'Opis 1');
insert into Salon.Notification values (100,'2','1',NULL,0,'TEST PRIMER');

-- DROP TRIGGER Salon.AddNotification

delimiter //
create trigger Salon.AddNotification
after insert
on Salon.Reservation
FOR EACH ROW

BEGIN
	declare id_customer integer;
    declare id_manager integer;
    declare id_reservation integer;
    declare confirmation bit;
    
    set id_customer := New.customer_id;
    set id_manager := New.manager_id;
    set id_reservation := New.reservation_id;
    set confirmation := 0;
    
	   INSERT INTO Salon.Notification (customer_id, manager_id, reservation_id, confirmation) 
	   values (id_customer, id_manager, id_reservation, confirmation);
       
END;//

delimiter //
CREATE trigger Salon.CheckUICN
before insert
on Salon.Worker
for each row

BEGIN
    DECLARE ucin varchar(13);
    set ucin := replace(New.ucin,' ', '');
    
    IF(CHAR_LENGTH(ucin) != 13) THEN 
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Uicn is not valid';
    END IF;

END;//

-- DROP TRIGGER Salon.CheckWorkerStatus;
delimiter //
CREATE trigger Salon.CheckWorkerStatus
before insert
on Salon.reservation
for each row

BEGIN
set @active_worker = (select active from worker where worker_id=new.worker_id);

IF (@active_worker<> ( true ))THEN
	SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Worker is not active';
    END IF;
END;//