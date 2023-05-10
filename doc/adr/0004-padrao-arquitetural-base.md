# 4. Utilização do padrão cliente-servidor

Date: 2023-05-09

## Status

Aceito

## Context

Foi necessário discutirmos sobre a escolha do padrão arquitetural do projeto pensando em facilitar o desenvolvimento das partes do sistema. Com isso foi levantado a organização dividida entre a parte do servidor e do cliente, separando o front-end (utilização do dart) e o back-end (API em nodeJS). Com isso, os membros foram direcionados para áreas que já tinham familiaridade com ela. Dessa forma, não houveram outras possibilidades mencionadas para uso.

## Decision

Seria possível trabalhar com outros modelos de arquiteturas, por exemplo utilizando MVC e utilizando um backend também em flutter, no entanto, essa e qualquer outra escolha de arquitetura resultaria na necessidade de uma maior capacitação da equipe, pois como já apresentado, há familiaridade com o modelo cliente-servidor assim como o desenvolvimento de APIs em NodeJS. E pensando nessa capacitação, o tempo é um limitador, logo reduzimos as opções de explorar o desconhecido para trabalhar com esta arquitetura conhecida.

## Consequences

Positivas:
- Familiaridade com os meios de disponibilização do serviço (deploy).

Negativas: 
- Toda alteração no Frontend é necessário a realização de build de toda a aplicação e disponibilizar uma nova versão. 

