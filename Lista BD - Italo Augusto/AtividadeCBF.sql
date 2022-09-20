Create database CBF;
Use CBF;

create table Jogador (
	BID int not null,
    nome varchar(40) not null,
    datanasc date not null,
    origem varchar(20) null,
    constraint pk_jogador primary key (BID)
);
create table Campeonato (
	BIDJogador int not null,
    premio varchar(30) not null,
    constraint pk_campeonato primary key (BIDJogador,premio),
    constraint fk_campeonato foreign key (BIDJogador) references Jogador(BID) on delete cascade
);

insert into jogador values (33,"Da Silva",'2005-01-11',"Volante");
insert into Campeonato values (33,"Campeonato Brasileiro");

select j.nome,j.datanasc
from Jogador j, Campeonato c
where j.BID = c.BIDJogador and
	c.premio = "Campeonato Brasileiro" and
    j.datanasc >= to_days("2005-01-11");
    
create view Polivalente as
select j.nome, j.origem
from jogador j
where j.origem is not null;

#2)
select j.nome,j.datanasc, j.origem
from Jogador j, Campeonato c, polivalente p
where j.BID = c.BIDJogador and
	c.premio = "Campeonato Brasileiro" and
    j.datanasc >= to_days("2005-01-11") and
    exists (select j.nome, j.origem
			from jogador j
			where j.origem is not null);