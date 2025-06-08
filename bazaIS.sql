/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2016                    */
/* Created on:     4/6/2024 21:31:02                            */
/*==============================================================*/
CREATE DATABASE bazaIS COLLATE Serbian_Latin_100_CI_AI
GO
use bazaIS

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('KARTICA') and o.name = 'FK_KARTICA_RACUN_KAR_RACUN')
alter table KARTICA
   drop constraint FK_KARTICA_RACUN_KAR_RACUN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('KREDIT') and o.name = 'FK_KREDIT_RACUN_KRE_RACUN')
alter table KREDIT
   drop constraint FK_KREDIT_RACUN_KRE_RACUN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('KREDIT_ZAPOSLEN') and o.name = 'FK_KREDIT_Z_ZAPOSLEN__ZAPOSLEN')
alter table KREDIT_ZAPOSLEN
   drop constraint FK_KREDIT_Z_ZAPOSLEN__ZAPOSLEN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('KREDIT_ZAPOSLEN') and o.name = 'FK_KREDIT_Z_ZAPOSLEN__KREDIT')
alter table KREDIT_ZAPOSLEN
   drop constraint FK_KREDIT_Z_ZAPOSLEN__KREDIT
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('RACUN') and o.name = 'FK_RACUN_KORISNIK__KORISNIK')
alter table RACUN
   drop constraint FK_RACUN_KORISNIK__KORISNIK
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('RACUN') and o.name = 'FK_RACUN_RACUN_KRE_KREDIT')
alter table RACUN
   drop constraint FK_RACUN_RACUN_KRE_KREDIT
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('RACUN_ZAPOSLEN') and o.name = 'FK_RACUN_ZA_ZAPOSLEN__ZAPOSLEN')
alter table RACUN_ZAPOSLEN
   drop constraint FK_RACUN_ZA_ZAPOSLEN__ZAPOSLEN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('RACUN_ZAPOSLEN') and o.name = 'FK_RACUN_ZA_ZAPOSLEN__RACUN')
alter table RACUN_ZAPOSLEN
   drop constraint FK_RACUN_ZA_ZAPOSLEN__RACUN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('TRANSAKCIJA_RACUN') and o.name = 'FK_TRANSAKC_TRANSAKCI_TRANSAKC')
alter table TRANSAKCIJA_RACUN
   drop constraint FK_TRANSAKC_TRANSAKCI_TRANSAKC
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('TRANSAKCIJA_RACUN') and o.name = 'FK_TRANSAKC_TRANSAKCI_RACUN')
alter table TRANSAKCIJA_RACUN
   drop constraint FK_TRANSAKC_TRANSAKCI_RACUN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('TRANSAKCIJA_ZAPOSLEN') and o.name = 'FK_TRANSAKC_ZAPOSLEN__ZAPOSLEN')
alter table TRANSAKCIJA_ZAPOSLEN
   drop constraint FK_TRANSAKC_ZAPOSLEN__ZAPOSLEN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('TRANSAKCIJA_ZAPOSLEN') and o.name = 'FK_TRANSAKC_ZAPOSLEN__TRANSAKC')
alter table TRANSAKCIJA_ZAPOSLEN
   drop constraint FK_TRANSAKC_ZAPOSLEN__TRANSAKC
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('KARTICA')
            and   name  = 'RACUN_KARTICA_FK'
            and   indid > 0
            and   indid < 255)
   drop index KARTICA.RACUN_KARTICA_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('KARTICA')
            and   type = 'U')
   drop table KARTICA
go

if exists (select 1
            from  sysobjects
           where  id = object_id('KORISNIK')
            and   type = 'U')
   drop table KORISNIK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('KREDIT')
            and   name  = 'RACUN_KREDIT2_FK'
            and   indid > 0
            and   indid < 255)
   drop index KREDIT.RACUN_KREDIT2_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('KREDIT')
            and   type = 'U')
   drop table KREDIT
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('KREDIT_ZAPOSLEN')
            and   name  = 'ZAPOSLEN_KREDIT2_FK'
            and   indid > 0
            and   indid < 255)
   drop index KREDIT_ZAPOSLEN.ZAPOSLEN_KREDIT2_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('KREDIT_ZAPOSLEN')
            and   name  = 'ZAPOSLEN_KREDIT_FK'
            and   indid > 0
            and   indid < 255)
   drop index KREDIT_ZAPOSLEN.ZAPOSLEN_KREDIT_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('KREDIT_ZAPOSLEN')
            and   type = 'U')
   drop table KREDIT_ZAPOSLEN
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('RACUN')
            and   name  = 'RACUN_KREDIT_FK'
            and   indid > 0
            and   indid < 255)
   drop index RACUN.RACUN_KREDIT_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('RACUN')
            and   name  = 'KORISNIK_RACUN_FK'
            and   indid > 0
            and   indid < 255)
   drop index RACUN.KORISNIK_RACUN_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('RACUN')
            and   type = 'U')
   drop table RACUN
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('RACUN_ZAPOSLEN')
            and   name  = 'ZAPOSLEN_RACUN2_FK'
            and   indid > 0
            and   indid < 255)
   drop index RACUN_ZAPOSLEN.ZAPOSLEN_RACUN2_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('RACUN_ZAPOSLEN')
            and   name  = 'ZAPOSLEN_RACUN_FK'
            and   indid > 0
            and   indid < 255)
   drop index RACUN_ZAPOSLEN.ZAPOSLEN_RACUN_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('RACUN_ZAPOSLEN')
            and   type = 'U')
   drop table RACUN_ZAPOSLEN
go

if exists (select 1
            from  sysobjects
           where  id = object_id('TRANSAKCIJA')
            and   type = 'U')
   drop table TRANSAKCIJA
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('TRANSAKCIJA_RACUN')
            and   name  = 'TRANSAKCIJA_RACUN2_FK'
            and   indid > 0
            and   indid < 255)
   drop index TRANSAKCIJA_RACUN.TRANSAKCIJA_RACUN2_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('TRANSAKCIJA_RACUN')
            and   name  = 'TRANSAKCIJA_RACUN_FK'
            and   indid > 0
            and   indid < 255)
   drop index TRANSAKCIJA_RACUN.TRANSAKCIJA_RACUN_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('TRANSAKCIJA_RACUN')
            and   type = 'U')
   drop table TRANSAKCIJA_RACUN
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('TRANSAKCIJA_ZAPOSLEN')
            and   name  = 'ZAPOSLEN_TRANSAKCIJA2_FK'
            and   indid > 0
            and   indid < 255)
   drop index TRANSAKCIJA_ZAPOSLEN.ZAPOSLEN_TRANSAKCIJA2_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('TRANSAKCIJA_ZAPOSLEN')
            and   name  = 'ZAPOSLEN_TRANSAKCIJA_FK'
            and   indid > 0
            and   indid < 255)
   drop index TRANSAKCIJA_ZAPOSLEN.ZAPOSLEN_TRANSAKCIJA_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('TRANSAKCIJA_ZAPOSLEN')
            and   type = 'U')
   drop table TRANSAKCIJA_ZAPOSLEN
go

if exists (select 1
            from  sysobjects
           where  id = object_id('ZAPOSLEN')
            and   type = 'U')
   drop table ZAPOSLEN
go

/*==============================================================*/
/* Table: KARTICA                                               */
/*==============================================================*/
create table KARTICA (
   IDKARTICE            int                 not null  ,
   IDRACUNA             int                  not null,
   TIPKARTICE           varchar(20)          not null,
   DATUMIZDAVANJAKARTICE datetime             not null,
   BROJKARTICE          char(16)             not null,
   constraint PK_KARTICA primary key (IDKARTICE)
)
go

/*==============================================================*/
/* Index: RACUN_KARTICA_FK                                      */
/*==============================================================*/




create nonclustered index RACUN_KARTICA_FK on KARTICA (IDRACUNA ASC)
go

/*==============================================================*/
/* Table: KORISNIK                                              */
/*==============================================================*/
create table KORISNIK (
   IDKORISNIK           int                  not null,
   IMEKORISNIKA         varchar(35)          not null,
   PREZIMEKORISNIKA     varchar(35)          not null,
   ULICAKORISNIKA       varchar(50)          not null,
   ULICNIBROJKORISNIKA  varchar(10)          not null,
   EMAILKORISNIKA       varchar(50)          not null,
   KONTAKTKORISNIKA     varchar(15)          not null,
   JMBG                 char(13)             not null,
   KORISNIKKORIME       varchar(999)         not null,
   KORISNIKKORPASSWORD  varchar(999)         not null,
   constraint PK_KORISNIK primary key (IDKORISNIK)
)
go

/*==============================================================*/
/* Table: KREDIT                                                */
/*==============================================================*/
create table KREDIT (
   IDKREDITA            int                  not null,
   IDRACUNA             int                  not null,
   ODOBRENJEKREDITA     datetime             not null,
   IZNOSKREDITA         varchar(999)         not null,
   IZNOSMESECNOGPLACANJAKREDITA varchar(999)         not null,
   ROKZAISPLATUKREDITA  datetime             not null,
   DUGOVANJEKREDITA     varchar(999)         not null,
   STATUSKREDITA        varchar(10)          not null,
   constraint PK_KREDIT primary key (IDKREDITA)
)
go

/*==============================================================*/
/* Index: RACUN_KREDIT2_FK                                      */
/*==============================================================*/




create nonclustered index RACUN_KREDIT2_FK on KREDIT (IDRACUNA ASC)
go

/*==============================================================*/
/* Table: KREDIT_ZAPOSLEN                                       */
/*==============================================================*/
create table KREDIT_ZAPOSLEN (
   IDZAPOSLENOG         int                  not null,
   IDKREDITA            int                  not null,
   constraint PK_KREDIT_ZAPOSLEN primary key (IDZAPOSLENOG, IDKREDITA)
)
go

/*==============================================================*/
/* Index: ZAPOSLEN_KREDIT_FK                                    */
/*==============================================================*/




create nonclustered index ZAPOSLEN_KREDIT_FK on KREDIT_ZAPOSLEN (IDZAPOSLENOG ASC)
go

/*==============================================================*/
/* Index: ZAPOSLEN_KREDIT2_FK                                   */
/*==============================================================*/




create nonclustered index ZAPOSLEN_KREDIT2_FK on KREDIT_ZAPOSLEN (IDKREDITA ASC)
go

/*==============================================================*/
/* Table: RACUN                                                 */
/*==============================================================*/
create table RACUN (
   IDRACUNA             int                   not null,
   IDKREDITA            int                  null,
   IDKORISNIK           int                  not null,
   BROJRACUNA           varchar(40)          not null,
   TIPRACUNA            varchar(20)          not null,
   TRENUTNOSTANJERACUNA varchar(999)         not null,
   DATUMKREIRANJARACUNA datetime             not null,
   DATUMZATVARANJARACUNA datetime             not null,
   STATUSRACUNA         varchar(30)          not null,
   constraint PK_RACUN primary key (IDRACUNA)
)
go

/*==============================================================*/
/* Index: KORISNIK_RACUN_FK                                     */
/*==============================================================*/




create nonclustered index KORISNIK_RACUN_FK on RACUN (IDKORISNIK ASC)
go

/*==============================================================*/
/* Index: RACUN_KREDIT_FK                                       */
/*==============================================================*/




create nonclustered index RACUN_KREDIT_FK on RACUN (IDKREDITA ASC)
go

/*==============================================================*/
/* Table: RACUN_ZAPOSLEN                                        */
/*==============================================================*/
create table RACUN_ZAPOSLEN (
   IDZAPOSLENOG         int                  not null,
   IDRACUNA             int                  not null,
   constraint PK_RACUN_ZAPOSLEN primary key (IDZAPOSLENOG, IDRACUNA)
)
go

/*==============================================================*/
/* Index: ZAPOSLEN_RACUN_FK                                     */
/*==============================================================*/




create nonclustered index ZAPOSLEN_RACUN_FK on RACUN_ZAPOSLEN (IDZAPOSLENOG ASC)
go

/*==============================================================*/
/* Index: ZAPOSLEN_RACUN2_FK                                    */
/*==============================================================*/




create nonclustered index ZAPOSLEN_RACUN2_FK on RACUN_ZAPOSLEN (IDRACUNA ASC)
go

/*==============================================================*/
/* Table: TRANSAKCIJA                                           */
/*==============================================================*/
create table TRANSAKCIJA (
   IDTRANSAKCIJE        int                  not null,
   TIPTRANSAKCIJE       varchar(40)          not null,
   IZNOSTRANSAKCIJE     varchar(999)         not null,
   DATUMTRANSAKCIJE     datetime             not null,
   constraint PK_TRANSAKCIJA primary key (IDTRANSAKCIJE)
)
go

/*==============================================================*/
/* Table: TRANSAKCIJA_RACUN                                     */
/*==============================================================*/
create table TRANSAKCIJA_RACUN (
   IDTRANSAKCIJE        int                  not null,
   IDRACUNA             int                  not null,
   constraint PK_TRANSAKCIJA_RACUN primary key (IDTRANSAKCIJE, IDRACUNA)
)
go

/*==============================================================*/
/* Index: TRANSAKCIJA_RACUN_FK                                  */
/*==============================================================*/




create nonclustered index TRANSAKCIJA_RACUN_FK on TRANSAKCIJA_RACUN (IDTRANSAKCIJE ASC)
go

/*==============================================================*/
/* Index: TRANSAKCIJA_RACUN2_FK                                 */
/*==============================================================*/




create nonclustered index TRANSAKCIJA_RACUN2_FK on TRANSAKCIJA_RACUN (IDRACUNA ASC)
go

/*==============================================================*/
/* Table: TRANSAKCIJA_ZAPOSLEN                                  */
/*==============================================================*/
create table TRANSAKCIJA_ZAPOSLEN (
   IDZAPOSLENOG         int                  not null,
   IDTRANSAKCIJE        int                  not null,
   constraint PK_TRANSAKCIJA_ZAPOSLEN primary key (IDZAPOSLENOG, IDTRANSAKCIJE)
)
go

/*==============================================================*/
/* Index: ZAPOSLEN_TRANSAKCIJA_FK                               */
/*==============================================================*/




create nonclustered index ZAPOSLEN_TRANSAKCIJA_FK on TRANSAKCIJA_ZAPOSLEN (IDZAPOSLENOG ASC)
go

/*==============================================================*/
/* Index: ZAPOSLEN_TRANSAKCIJA2_FK                              */
/*==============================================================*/




create nonclustered index ZAPOSLEN_TRANSAKCIJA2_FK on TRANSAKCIJA_ZAPOSLEN (IDTRANSAKCIJE ASC)
go

/*==============================================================*/
/* Table: ZAPOSLEN                                              */
/*==============================================================*/
create table ZAPOSLEN (
   IDZAPOSLENOG         int                   not null,
   IMEZAPOSLENOG        varchar(30)          not null,
   PREZIMEZAPOSLENOG    varchar(40)          not null,
   POZICIJAZAPOSLENOG   varchar(30)          not null,
   EMAILZAPOSLENOG      varchar(35)          not null,
   ZAPOSLENKORIME       varchar(999)         not null,
   ZAPOSLENKORPASSWORD  varchar(999)         not null,
   constraint PK_ZAPOSLEN primary key (IDZAPOSLENOG)
)
go

alter table KARTICA
   add constraint FK_KARTICA_RACUN_KAR_RACUN foreign key (IDRACUNA)
      references RACUN (IDRACUNA)
go

alter table KREDIT
   add constraint FK_KREDIT_RACUN_KRE_RACUN foreign key (IDRACUNA)
      references RACUN (IDRACUNA)
go

alter table KREDIT_ZAPOSLEN
   add constraint FK_KREDIT_Z_ZAPOSLEN__ZAPOSLEN foreign key (IDZAPOSLENOG)
      references ZAPOSLEN (IDZAPOSLENOG)
go

alter table KREDIT_ZAPOSLEN
   add constraint FK_KREDIT_Z_ZAPOSLEN__KREDIT foreign key (IDKREDITA)
      references KREDIT (IDKREDITA)
go

alter table RACUN
   add constraint FK_RACUN_KORISNIK__KORISNIK foreign key (IDKORISNIK)
      references KORISNIK (IDKORISNIK)
go

alter table RACUN
   add constraint FK_RACUN_RACUN_KRE_KREDIT foreign key (IDKREDITA)
      references KREDIT (IDKREDITA)
go

alter table RACUN_ZAPOSLEN
   add constraint FK_RACUN_ZA_ZAPOSLEN__ZAPOSLEN foreign key (IDZAPOSLENOG)
      references ZAPOSLEN (IDZAPOSLENOG)
go

alter table RACUN_ZAPOSLEN
   add constraint FK_RACUN_ZA_ZAPOSLEN__RACUN foreign key (IDRACUNA)
      references RACUN (IDRACUNA)
go

alter table TRANSAKCIJA_RACUN
   add constraint FK_TRANSAKC_TRANSAKCI_TRANSAKC foreign key (IDTRANSAKCIJE)
      references TRANSAKCIJA (IDTRANSAKCIJE)
go

alter table TRANSAKCIJA_RACUN
   add constraint FK_TRANSAKC_TRANSAKCI_RACUN foreign key (IDRACUNA)
      references RACUN (IDRACUNA)
go

alter table TRANSAKCIJA_ZAPOSLEN
   add constraint FK_TRANSAKC_ZAPOSLEN__ZAPOSLEN foreign key (IDZAPOSLENOG)
      references ZAPOSLEN (IDZAPOSLENOG)
go

alter table TRANSAKCIJA_ZAPOSLEN
   add constraint FK_TRANSAKC_ZAPOSLEN__TRANSAKC foreign key (IDTRANSAKCIJE)
      references TRANSAKCIJA (IDTRANSAKCIJE)
go

