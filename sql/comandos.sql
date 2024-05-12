-- Estou usando um macbook e por isso não foi possível usar o mesmo programa do curso --
-- Seguem apenas as linhas de código do exercício, fora da ordem --


-- SEMANA 2 --


-- NOVO COLABORADOR --

SELECT * from brh.papel;
INSERT INTO brh.papel (id, nome)
VALUES (8, 'Especialista de Negócios');

SELECT * from brh.endereco;
INSERT INTO brh.endereco (cep, uf, cidade, bairro)
VALUES ('06789-789', 'SP', 'São Paulo', 'Lapa');

SELECT * from brh.colaborador;
INSERT INTO brh.colaborador (matricula, nome, cpf, salario, departamento, cep, logradouro, complemento_endereco)
VALUES ('AA123', 'Fulano de Tal', '000.111.222-34', '7500', 'SEDES', '06789-789', 'Av da Saudade', 'Apto 81');

SELECT * from brh.telefone_colaborador;
INSERT INTO brh.telefone_colaborador (colaborador, numero, tipo)
VALUES ('AA123','(61) 9 9999-9999','M');
INSERT INTO brh.telefone_colaborador (colaborador, numero, tipo)
VALUES ('AA123','(61) 3030-4040','R');

SELECT * from brh.email_colaborador;
INSERT INTO brh.email_colaborador (colaborador, email, tipo)
VALUES ('AA123', 'fulano@email.com', 'P');
INSERT INTO brh.email_colaborador (colaborador, email, tipo)
VALUES ('AA123', 'fulano.tal@brh.com', 'T');

SELECT * from brh.atribuicao;
INSERT INTO brh.atribuicao (projeto, colaborador, papel)
VALUES (5, 'AA123', 8);

SELECT * from brh.dependente;
INSERT INTO brh.dependente (cpf, colaborador, nome, parentesco, data_nascimento)
VALUES ('999.888.777-65', 'AA123', 'Beltrana de Tal', 'Filho(a)', to_date('2015-10-01', 'yyyy-mm-dd'));
INSERT INTO brh.dependente (cpf, colaborador, nome, parentesco, data_nascimento)
VALUES ('111.222.333-45', 'AA123', 'Cicrana de Tal', 'Cônjuge', to_date('1985-01-10', 'yyyy-mm-dd'));


-- ATUALIZAÇÃO DE CADASTRO --

SELECT * from brh.colaborador WHERE matricula = 'M123';
UPDATE brh.colaborador SET nome = 'Maria Mendonça' WHERE matricula = 'M123';

SELECT * from brh.email_colaborador WHERE colaborador = 'M123';
UPDATE brh.email_colaborador SET email = 'maria.mendonca@email.com' WHERE colaborador = 'M123' AND tipo = 'P'; 


-- RELATÔRIO CÔNJUGUES --

SELECT * from brh.dependente;
SELECT colaborador as matricula, nome as dependente, data_nascimento
from brh.dependente WHERE parentesco = 'Cônjuge';

-- RELATÔRIO TELEFONES --

SELECT * from brh.telefone_colaborador;
SELECT colaborador as matricula, numero
from brh.telefone_colaborador WHERE tipo in ('M', 'C') ORDER BY colaborador, numero;

-- RELATÔRIO DE DEPARTAMENTOS --

SELECT * from brh.colaborador;
SELECT sigla as sigla_dpto
from brh.colaborador WHERE cep = '71777-700' AND departamento in ('SECAP', 'SESEG');

-- EXCLUINDO DEPARTAMENTO SECAP --

SELECT * from brh.atribuicao WHERE colaborador in ('H123', 'M123', 'R123', 'W123');
DELETE from brh.atribuicao WHERE colaborador in ('H123', 'M123', 'R123', 'W123');

SELECT * from brh.dependente WHERE colaborador in ('H123', 'M123', 'R123', 'W123');
DELETE from brh.dependente WHERE colaborador in ('H123', 'M123', 'R123', 'W123');

SELECT * from brh.email_colaborador WHERE colaborador in ('H123', 'M123', 'R123', 'W123');
DELETE from brh.email_colaborador WHERE colaborador in ('H123', 'M123', 'R123', 'W123');

SELECT * from brh.telefone_colaborador WHERE colaborador in ('H123', 'M123', 'R123', 'W123');
DELETE from brh.telefone_colaborador WHERE colaborador in ('H123', 'M123', 'R123', 'W123');

SELECT * from brh.colaborador WHERE matricula in ('H123', 'M123', 'R123', 'W123');
DELETE from brh.colaborador WHERE matricula in ('H123', 'M123', 'R123', 'W123');

SELECT * from brh.departamento WHERE sigla = 'SECAP';
DELETE from brh.departamento WHERE sigla = 'SECAP';


-- SEMANA 3 --


-- FILTRANDO DEPENDENTES --

SELECT * FROM brh.colaborador c
INNER JOIN brh.dependente d
ON d.colaborador = c.matricula


SELECT c.nome AS nome_colaborador, d.nome AS nome_dependente, d.data_nascimento extract (month from d.data_nascimento)
from brh.dependente d
INNER JOIN brh.colaborador c
ON c.matricula = d.colaborador
WHERE extract (month from data_nascimento) in (4, 5, 6)
OR upper (nome) LIKE '%h%'
ORDER BY c.nome, d.nome;

-- COLABORADOR COM O MAIOR SALÁRIO --

SELECT nome, salario
FROM brh.colaborador
WHERE salario = (SELECT MAX(salario) FROM brh.colaborador);

-- RELATÓRIO SENIORIDADE --

SELECT matricula, nome, salario, 
(CASE WHEN salario <= 3000 THEN 'Júnior'
      WHEN SALARIO BETWEEN 3000.01 AND 6000 THEN 'Pleno'
      WHEN SALARIO BETWEEN 6000.01 AND 20000 THEN 'Sênior'
      ELSE 'Corpo Diretor' END) AS senioridade   
FROM brh.colaborador
ORDER BY senioridade, nome;

-- QUANTIDADE DE COLABORADORES EM PROJETOS --

SELECT d.nome, p.nome, COUNT(c.matricula) AS quant_colab
FROM brh.departamento d
INNER JOIN brh.colaborador c ON d.sigla = c.departamento
INNER JOIN brh.atribuicao a ON c.matricula = a.colaborador
INNER JOIN brh.projeto p ON a.projeto = p.id
GROUP BY d.nome, p.nome
ORDER BY nome_departamento, nome_projeto;

-- COLABORADORE COM MAIS DEPENDENTE --

SELECT c.nome, COUNT(d.cpf) AS quant_depent
FROM brh.colaborador c
INNER JOIN brh.dependente d
ON c.matricula = d.colaborador
GROUP BY c.nome
HAVING COUNT(d.cpf) >= 2
ORDER BY quant_depent DESC, c.nome;
