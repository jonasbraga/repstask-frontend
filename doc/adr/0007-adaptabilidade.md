# 7. Adaptabilidade do aplicativo para utilização em outras linhas de negócio
Date: 2023-05-15

## Status

Aceito

## Context

O sistema reptask é um gerenciador de tarefas gamificado, o que incentiva os usuários a completar as tarefas atribuidas para ganhar pontos e trocar estes por benefícios a serem definidos pelos próprios usuários

## Decision

O sistema será desenvolvido com o intuito não só de aplicação em repúblicas, mas sim também em qualquer outra área da qual exista a necessidade de resolução de tarefas,
como por exemplo uma casa de familia, em que os usuários possam ser os filhos, e os administradoroes os pais.
Para atingir este objetivo, nosso aplicativo será desenvolvido com uma orientação de manter o sistema genérico, sendo um gerenciador de tarefas universal


## Consequences

Positivas: 
 * Aumenta o escopo de utilização
 * Não impacta a utilização dos usuários iniciais (moradores de república)

Negativas:
 * Limita as customizações
 * Aumenta a complexidade para planejamento de novas features que são relevantes para todos os usuários
