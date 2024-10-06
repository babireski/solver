# Requisitos

## Haskell

Este projeto requere ter o compilador de Haskell instalado. Isso pode ser feito em sistemas baseados em Ubuntu com o seguinte comando:

```
sudo apt-get install ghc cabal-install

```

## Make

Este projeto requere ter o comando `make` instalado. Isso pode ser feito em sistemas baseados em Ubuntu com o seguinte comando:

`sudo apt-get install make`

# Uso

## Compilação

Para compilar o resolvedor basta, estando na pasta-raiz do projeto, executar o comando `make`, que criará um executável em `out/solve`.

## Execução

Para executar o resolvedor basta, estando na pasta do executável, executar o comando `./solve <filepath>`, sendo `<filepath>` o caminho relativo ou absoluto para o arquivo `.cnf` de entrada. A resposta será impressa no arquivo ` <filepath>.res`.
