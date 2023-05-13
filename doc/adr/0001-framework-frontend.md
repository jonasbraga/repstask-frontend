# 1. Utilização do framework Flutter para o desenvolvimento da aplicação.

Date: 2023-05-09

## Status

Aceito

## Context

Foi preciso escolher um framework e linguagem de programação para nosso front-end pensando em disponibilizar um aplicativo mobile. A aplicação precisa ser leve e rápida, com isso foi pensado também na possibilidade de uma plataforma web para ser executada via navegador, sendo as alternativas:

- Flutter (Dart)
- React (TypeScript)
- React Native (TypeScript)

## Decision

Iremos utilizar Flutter como framework, logo Dart como linguagem de programação.

Dentre as demais opções de tecnologia apontadas no tópico anterior, boa parte dos membros da equipe já tinha familiaridade com o desenvolvimento em typescript e com a biblioteca React. Entretanto, nossa decisão foi pautada no entendimento de que seria mais viável uma aplicação mobile para a proposta e os requisitos levantados até então, ademais consideramos também que já tínhamos um membro com conhecimento e experiência prévia com a linguagem Dart e o framework Flutter.

Flutter — O framework oferece de forma rápida uma ampla seleção de componentes de interface do usuário prontos para uso, acelerando o desenvolvimento sem a necessidade de implementar os componentes manualmente. Ele permite que uma única aplicação seja criada e rodada nos diversos sistemas operacionais mobile e para versão web também.

React Native — A maioria dos componentes precisa ser implementada manualmente por pelo desenvolvedor. O desempenho geral não é tão bom quanto o do Flutter considerando o nosso foco do sistema estar abrangentemente disponível.

## Consequences

Positivas: 
- Como a grande maioria da equipe de front-end nunca tinha visto dart, estudaram e conseguiram desenvolver as atividades corretamente, obtendo assim conhecimento em mais uma stack de tecnologia;
- Alta aceitação das área interessadas em uma aplicação mobile, enquanto comparada com a alternativa da versão web;

Negativas: 
- Foi necessário um tempo maior de dedicação aos estudos e ambientação da tecnologia;


