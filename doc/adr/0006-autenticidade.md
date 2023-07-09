# 6. Utilização de nível de usuário para garantir autenticidade.

Date: 2023-05-15

## Status

Aceito

## Context

Cada usuário pertence a uma republica, esta por sua vez mantém dois tipos de usuários, administrados, que criam e gerenciam as atividades daquela republica e os moradores, que realizam e interagem com as atividades.
Para tal recurso ocorrer de maneira devida, os usuários podem se cadastrar no aplicativo, criar uma organização onde automaticamente se ascende como administrador e por fim, convidar outros usuários. Ou podem se cadastrar e aceitar o convite para fazer parte de uma republica já existente como morador. 

## Decision

No momento do login na plataforma, cada usuário deverá preencher o formulário com o código da sua república, seu usuário e senha pessoal.
Para um nivel maior de segurança, será necessário uma senha forte, que passe pelo teste das seguintes validações, contendo no mínimo: 
 *  Uma letra minúscula;
 *  Uma maiúscula;
 *  Um número;
 *  Um caractere especial;
 *  Comprimento mínimo de oito caracteres.

Para manter estas informações no banco de dados, iremos utilizar de algoritmos de encriptação de dados, por meio da biblioteca Crypto do node, no backend
garantindo dessa forma que os dados privados não sejam expostos de nenhuma maneira

## Consequences

Positivas: 
 * Garante a segurança
 * Dados encryptados vazados não podem ser interpretados

Negativas:
 * Aumenta a complexidade do desenvolvimento login
 * Os requisitos de senha podem atrapalhar a usabilidade do sistema, deixando um pouco mais complexo de ser utilizado
