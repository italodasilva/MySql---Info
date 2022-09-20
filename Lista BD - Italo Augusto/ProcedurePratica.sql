create database Jorge;
use Jorge;

create table Pessoa (
	CPF varchar(14) not null,
    Nome varchar(30) not null,
    
    constraint pk_pessoa primary key (CPF)
);
create table Funcionario (
	CPFPessoa varchar(14) not null,
    salario double not null,
    
    constraint fk_funcionario foreign key (CPFPessoa) references Pessoa (CPF)
);
Insert into Pessoa values ("158.623.066-25","Italo");
Insert into Funcionario values ("158.623.066-25",1800.00);
Select p.CPF, p.Nome, f.salario
from pessoa p, funcionario f
where p.cpf = f.CPFPessoa;

delimiter $
create procedure cadastroRH(in d varchar(14),
							in n varchar(30),
                            in s double,
                            out mensagem text)
begin
		insert into Pessoa values (d, n);
        insert into Funcionario values (d, s);
        if exists (select *
				   from Pessoa p, Funcionario F
                   where p.CPF = f.CPFPessoa and
                   p.CPF = d) then
			set mensagem = 'Cadastro realizado!';
		end if;
end $
delimiter ;
call CadastroRH("158.623.066-25","Italo&Kezia",4.00, @teste);
select @teste;

