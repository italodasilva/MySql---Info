create database ativbiblioteca;
use ativbiblioteca;

create table Pessoa (
	nome varchar(50) not null,
    CPF varchar(14) not null,
    constraint pk_pessoa primary key (CPF)
);
create table Cliente (
	CPF varchar(14) not null,
	logradouro varchar(60) not null,
    CEP varchar(10) not null,
    Bairro varchar(30) not null,
    constraint pk_cliente primary key (CPF),
	constraint fk_Cliente foreign key (CPF) references Pessoa (CPF)
);
create table Autor (
    CPF varchar(14) not null,
    nacionalidade varchar(20),
    constraint pk_Autor primary key (CPF),
    constraint fk_Autor foreign key (CPF) references Pessoa (CPF)
);
create table EmailPessoa (
	PessoaCPF varchar(14) not null,
    email varchar(60) not null,
	constraint pk_EmailPessoa primary key (PessoaCPF),
	constraint fk_EmailPessoa foreign key (PessoaCPF) references Pessoa (CPF)
);
create table FormacaoAutor (
	AutorCPF varchar(14) not null,
	formacao varchar(30) not null,
    constraint pk_FormacaoAutor primary key (AutorCPF),
    constraint fk_FormacaoAutor foreign key (AutorCPF) references Autor (CPF)
);
create table Editora (
	Codigo varchar(20) not null,
    Nome varchar(30) not null,
    constraint pk_Editora primary key (Codigo)
);
create table Livro (
	CodigoEditora varchar(20) not null,
	ISBN varchar(20) not null,
    Titulo varchar(50) not null,
    Custo varchar(10) not null,
    constraint pk_Livro primary key (ISBN,CodigoEditora),
    constraint fk_Livro foreign key (CodigoEditora) references Editora (Codigo)
);
create table Exemplar (
	ISBNLivro varchar(20) not null,
	Codigo varchar(20) not null,
    DataAquisicao date not null,
    constraint pk_exemplar primary key (Codigo,ISBNLivro),
    constraint fk_exemplar foreign key (ISBNLivro) references Livro (ISBN)
);
create table CliExemEmprestimo (
	ClienteCPF varchar(50) not null,
    ExemplarCodigo varchar(20) not null,
    DataEmprestimo date not null,
    constraint pk_Emprestimo primary key (ClienteCPF,ExemplarCodigo),
    constraint fk_Emprestimo foreign key (ClienteCPF) references Cliente (CPF),
    constraint fk_Emprestim foreign key (ExemplarCodigo) references Exemplar (Codigo)
);
create table LivAutAutoria (
	ISBNLivro varchar(20) not null,
    CPFAutor varchar(14) not null,
    constraint pk_LivAutAutoria primary key (ISBNLivro,CPFAutor),
    constraint fk_LivAutAutoria foreign key (ISBNLivro) references Livro (ISBN),
    constraint fk_LivAutAutori foreign key (CPFAutor) references Autor (CPF)
);

#Alternativa 1
Select p.nome, ep.email
from pessoa p, autor a, emailpessoa ep
where a.cpf = p.cpf and
	p.cpf = ep.pessoacpf;

#Alternativa 2
create view EmailAutorCadastrado as
Select p.nome as Autor, ep.email as Email
from pessoa p, autor a, emailpessoa ep
where a.cpf = p.cpf and
	p.cpf = ep.pessoacpf;

#Alternativa 3
select eac.autor, eac.email
from EmailAutorCadastrado eac
where length(eac.email) < 3;
