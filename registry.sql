Create Database land_registry;

use land_registry;

create table owners(
ID int primary key,
owner_name varchar(100) not null,
Phone int(10) not null,
email varchar(50) not null, 
date_of_Birth date not null
);

create table land (
ID binary(16) primary key,
title varchar(100) not null,
date_of_purchase datetime not null,
price_of_purchase float(2) check (price_of_purchase >= 0),
ownerID int not null, 
foreign key (ownerID) references owners(ID) 
	ON DELETE CASCADE
        ON UPDATE CASCADE,
);

create table buyers(
buyerID int primary key,
buyerName varchar(100) not null,
Phone int(10) not null,
email varchar(50) not null,
Date_of_Birth date not null
);

create table enquiry (
enquiryID int primary key auto_increment,
date_of_first_enquiry datetime not null,
buyerID int not null,
landID binary(16) not null,
foreign key (buyerID) references buyers(buyerID),
	ON DELETE CASCADE
        ON UPDATE CASCADE,
foreign key (landID) references land(ID)
	ON DELETE CASCADE
        ON UPDATE CASCADE,
);

create index idx_land_owner_id on land(ownerID);
create index idx_enquiry_buyer_id on enquiry(buyerID);
create index idx_enquiry_land_id on enquiry(landID);