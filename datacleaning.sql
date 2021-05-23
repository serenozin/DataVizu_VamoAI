-- Deletando as linhas que possuem 'TooEarly' nos campos de posição 
DELETE FROM mortes  WHERE x_pos = 'TooEarly';

-- Alterando o tipo de dado da coluna x_pos para inteiro
ALTER TABLE mortes
ALTER COLUMN x_pos TYPE INT 
USING x_pos::INT;
-- Alterando o tipo de dado da coluna y_pos para inteiro
ALTER TABLE mortes
ALTER COLUMN y_pos TYPE INT 
USING y_pos::INT;

-- Deletando as linhas onde o campo matador é vazio
DELETE FROM mortes WHERE matador IS NULL;