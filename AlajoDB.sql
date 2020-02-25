
-- This is my first sql script
create database AlajoDB
use AlajoDB
go
raiserror('Now at the create table section....',0,1)
go 
raiserror('Creating Staff table....',0,1)
go
create table Staff
(
	StaffId nvarchar(10) constraint spk primary key,
	FirstName nvarchar(15) not null,
	LastName nvarchar(15) not null,
	Gender nvarchar(8),
	AuId nvarchar(200) constraint cauk unique,
	Email nvarchar(200) constraint nemailpk unique,
	nPassword nvarchar (200) not null,
	nPasswordSalt nvarchar (200) not null
)
go
raiserror('Creating CustomerAcct table...', 0,1)
create table CustomerAcct
(
	AccNo int IDENTITY(1000000001,1) constraint pkiAcNo primary key,
    FName nvarchar(25) NOT NULL,
    LName nvarchar(25) NOT NULL,
    Gender nvarchar(7),
    [Address] nvarchar(100),
    PhoneNo nvarchar(16),
    OpenDate datetime CONSTRAINT def  DEFAULT getDate(),
    Bal money NOT NULL CONSTRAINT chkmoney CHECK (Bal >= 1000),
    StaffId nvarchar(10) constraint fkidNo Foreign key 
	references Staff(StaffId) on delete set null,
	imageData varbinary(max),
	imageMimeType nvarchar(50)
)
go
raiserror('Creating Transactions table...', 0,1)
create table Transactions
(
	TransId Bigint identity(100000000000001,1) constraint pktranId 
	primary key,
	AccNo int constraint fkTranIacno
	foreign key references CustomerAcct(Accno) on delete set null,
	Amount money not null,
	AmtInWords nvarchar(35),
	TransType nvarchar(15) constraint chkTransType 
	check(TransType in ('Deposit','Withdrawals')),
	TransDate datetime constraint DeftransDate default getDate()
)
go
raiserror('Creating NonClusterd Index',0,1)
create nonclustered index idxStaffId on CustomerAcct (StaffId)
create nonclustered index idxAccNo on Transactions (AccNo)

go
raiserror('Database is now ready for use',0,1)

--select @@SERVERNAME


select *
from customerAcct