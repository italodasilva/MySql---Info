create database prova;
use prova;

create table Aluno(
    coda int not null,
	nome varchar(50) not null,
    constraint pk_aluno primary key (coda)
);

create table Professor(
    codp int not null,
	nome varchar(50) not null,
    constraint pk_professor primary key (codp)
);

create table Disciplina(
	nome varchar(50) not null,
    periodo varchar(10),
    codd int not null,
    codp int not null,
    constraint pk_disciplina primary key (codd),
    constraint fk_disciplina foreign key (codp) references Professor (codp)
);

create table Matricula(
	ano year not null,
    semestre varchar(8) not null,
    nota float not null,
    coda int not null,
    codd int not null,
    constraint fk_mataluno foreign key (coda) references Aluno (coda),
    constraint fk_matdisci foreign key (codd) references Disciplina (codd)
    );
    
insert into aluno values(001,"Italo");
insert into aluno values(002,"Kezia");
insert into aluno values(003,"Silia");
insert into aluno values(004,"Messias");
insert into aluno values(005,"Igor");

insert into Professor values(001,"Moises");
insert into Professor values(002,"Laerte");
insert into Professor values(003,"Michele");
insert into Professor values(004,"Alberto");

insert into Disciplina values("Mobile","Tarde",001,001);
insert into Disciplina values("Banco de Dados II","Manhã",002,002);
insert into Disciplina values("PDS I","Tarde",003,003);
insert into Disciplina values("Fisica","Manhã",004,004);

insert into Matricula values(2018,"Primeiro",89,001,001);
insert into Matricula values(2017,"Segundo",69,001,002);
insert into Matricula values(2022,"Primeiro",18,001,003);

insert into Matricula values(2016,"Segundo",19,002,002);
insert into Matricula values(2011,"Segundo",90,002,001);
insert into Matricula values(1978,"Primeiro",55,002,002);

insert into Matricula values(2017,"Primeiro",75,003,003);
insert into Matricula values(2019,"Primeiro",79,003,002);
insert into Matricula values(2020,"Segundo",87.5,003,001);

insert into Matricula values(2013,"Segundo",61,004,002);
insert into Matricula values(2012,"Primeiro",98,004,003);
insert into Matricula values(2017,"Segundo",87,004,004);

insert into Matricula values(2018,"Terceiro",95,005,002);
insert into Matricula values(2016,"Primeiro",96.3,005,003);
insert into Matricula values(2017,"Segundo",87,005,004);

#Numero 1
delimiter &&
create procedure Questao1 (in codigo int)
begin
	select count(m.coda) as "Matriculas Desde 2017", 
	(select count(m.coda) from matricula m where codigo = m.coda and ano >= 2017 and m.nota < 60) as "Matriculas Desde 2017 com nota menor que 60", 
	(select count(m.coda) from matricula m, disciplina d where codigo = m.coda and ano >= 2017 and m.nota < 60 and m.codd = d.codd and d.nome = "Banco de Dados II") as "Matriculas até 2017 que teve notas menores que sessenta em Banco de Dados"
	from matricula m
	where codigo = m.coda and ano >= 2017;
end &&
delimiter ;
call Questao1(001);
call Questao1(002);
call Questao1(003);
call Questao1(004);
call Questao1(005);

#Numero 2

#Usando procedure:
delimiter //
create procedure BuscaAlunosDestaque (in nota double)
begin
	select a.nome, count(m.coda)
	from Aluno a, Matricula m
	where a.coda = m.coda and
	m.nota > 80.0
	group by a.nome;
end //
delimiter ;

#Usando view:
create view BuscaAlunosDestaque as
	select a.nome, count(m.coda)
	from Aluno a, Matricula m
	where a.coda = m.coda and
	m.nota > 80.0
	group by a.nome;

select * from BuscaAlunosDestaque;