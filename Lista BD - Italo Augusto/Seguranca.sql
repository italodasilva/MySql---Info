create database ultimaativ;
use ultimaativ;

create table Produto(
	codigo int not null,
    marca varchar(20) not null,
    nome varchar(40) not null,
    constraint pk_Produto primary key (codigo)
);

create table Venda(
	ID int not null,
    datas date not null,
    valor float not null,
	constraint pk_Venda primary key (ID)
);

create table ProdRegitrarVenda(
	codigoProd int not null,
    IDVenda int not null,
    constraint pk_ProdRegitrarVenda primary key(codigoProd, IDVenda),
    constraint fk_ProdRegitrar foreign key(codigoProd)
		references Produto(codigoProd) on delete cascade,
	constraint fk_RegistrarVenda foreign key(IDVenda)
		references Venda(IDVenda) on delete cascade
);

create table Auditoria(
	ID int not null,
    total varchar(15) not null,
    desvio varchar(25) not null,
    dataAntes date not null,
    dataDepois date not null
);

delimiter //
create trigger Segurança after update
on Venda for each row
begin
	declare quantidade int;
    declare diferença double;
    select count(*) into quantidade
    from ProdRegistrarVenda r 
    where r.IDVenda=New.ID;
    set diferença = New.valor - old.valor;
    insert into Auditoria values (New.ID, quantidade, diferença, Old.datas, New.datas);
end //
delimiter ; 