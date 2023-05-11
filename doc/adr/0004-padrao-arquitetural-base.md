# 4. Utilização do padrão MVC como CS 3 camadas

Date: 2023-05-11

## Status

Aceito

## Contexto

Após reavaliarmos discutimos que arquitetura podemos aderir que não apenas a de cliente-servidor simples para isso foram levantadas outras arquiteturas que condissessem ao modo do desenvolvimento, com um front-end feito inteiramente em Flutter, um back-end separado em nodeJS e um banco. Para isso notou-se que se encaixaria um modelo MVC como Cliente Servidor de 3 Camadas.

## Decision

Com isso foi decidido que o desenvolvimento da aplicação em Flutter seguirá um design arquitetural de modelo MVC, separando corretamente as Views apenas com componentes de UI que será a interação do usuário, Controller e Models, desse modo mantendo o projeto mais organizado e de melhor manutenção. O Backend que terá suas funções invodas apenas através das Controllers, ficará responsável pela regra de negócio do sistema, e sendo o único que terá interação com o Banco de Dados.

## Consequences

Positivas:
- Maior coesão para o nosso sistema visto que cada parte do projeto terá responsabilidades mais bem definidas
- Facilidade de Manutenção e Reusabilidade

Negativas: 
- Reavaliação do código já implementado e refatoração para garantir a modularidade
- Adaptação dos membros do desenvolvimento a seguirem o modelo MVC para aqueles não acostumados a desenvolverem nessa arquitetura

