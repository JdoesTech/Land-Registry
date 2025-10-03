Create Database land_registry;

use land_registry;

create table users(
    userID binary(16) primary key,
    username varchar(255) not null unique,
    password_hash varchar(255) not null,
    role enum('admin', 'staff' , 'owner', 'buyer'),
    created_at datetime default current_timestamp
);

create table owners(
ownerID int primary key,
owner_name varchar(100) not null,
Phone int(10) not null,
email varchar(50) not null, 
date_of_Birth date not null,
userID binary(16),
foreign key (userID) references users(userID)
    on delete cascade,
);


create table land (
landID binary(16) primary key,
title varchar(100) not null,
date_of_purchase datetime not null,
price_of_purchase decimal(12,2) check (price_of_purchase >= 0),
ownerID int not null, 
location_ varchar(100) not null,
area decimal(10,2) check(area > 0),
status enum('available', 'sold', 'under_negotiation') default 'available',
created_at timestamp default current_timestamp,
foreign key (ownerID) references owners(ownerID) 
	on delete cascade
    on delete cascade
);

create table buyers(
buyerID int primary key,
buyerName varchar(100) not null,
Phone int(10) not null,
email varchar(50) not null,
Date_of_Birth date not null,
created_at datetime default current_timestamp,
userID binary(16),
foreign key (userID) references users(userID)
    on delete cascade
);

create table enquiry (
enquiryID int primary key auto_increment,
date_of_first_enquiry datetime not null,
buyerID int not null,
landID binary(16) not null,
enquiry_date datetime default current_timestamp,
enquiry_status enum('pending', 'active', 'resolved', 'closed') default,
foreign key (buyerID) references buyers(buyerID),
    on delete cascade
    on delete cascade,
foreign key (landID) references land(landID)
    on delete cascade
    on delete cascade
constraint unique (buyerID, landID)
);

create table transfer(
    transferID int primary key auto_increment,
    landID binary(16) not null,
    oldOwnerID int not null,
    newOwnerID int not null,
    transfer_type enum("sale", "inheritance", "gift", "reparation"),
    transfer_date datetime default current_timestamp,
    foreign key (landID) references land(landID)
        on delete cascade,
    foreign key (oldOwnerID) references owners(ownerID)
        on delete cascade,
    foreign key (newOwnerID) references buyers(buyerID)
        on delete cascade
);

create table transactions(
    transactionID  int primary key auto_increment,
    transferID int,
    buyerID int not null,
    landID binary(16) not null,
    amount decimal(10,2),
    transaction_date datetime default current_timestamp,
    foreign key (transferID) references transfer(transferID)
);

delimiter //

create trigger check_sale_transfer
before insert on transactions
for each row
begin
    declare trans_type('sale', 'inheritance', 'gift', 'reparation');

    select transfer_type into trans_type
    from transfer
    where transferID = new.transferID;

    if trans_type <> 'sale' then
        signal sqlstate '45000'
        set message_text = 'Transfer type must be sale for transactions';
    end if;
end;

//
delimiter;

create table land_history(
    historyID binary(16) primary key,
    landID binary(16) not null,
    previousOwnerID int not null,
    newerOwnerID int not null,
    date_of_transfer datetime default current_timestamp,
    change_type 

);

create index idx_land_owner_id on land(ownerID);
create index idx_enquiry_buyer_id on enquiry(buyerID);
create index idx_enquiry_land_id on enquiry(landID);