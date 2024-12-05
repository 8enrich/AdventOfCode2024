# Advent of Code 2024

Repositório das minhas soluções do Advent of Code 2024 em [Lua](https://www.lua.org/).

## Versão do Lua
A versão do Lua utilizada neste repositório é a **5.3**.

## Requisitos

É necessário ter o **LuaRocks** instalado para gerenciar as dependências do Lua.

## Como instalar as dependências

Para instalar as dependências necessárias, execute o seguinte comando:

```bash
sudo lua install.lua
```

## Variáveis de ambiente

É necessário configurar a variável de ambiente para a session do Advent of Code.

1. Crie um arquivo .env na raiz do projeto.

2. No arquivo .env, adicione a seguinte linha, substituindo seu_codigo_de_sessao pelo seu código de sessão do Advent of Code:

```bash
SESSION=seu_codigo_de_sessao
```

Você pode encontrar seu código de sessão inspecionando os cookies no seu navegador após fazer login no site do [Advent of Code](https://adventofcode.com/).

## Como usar:

Para criar o código do próximo dia, execute o seguinte comando:

```bash
lua new_day.lua
```
