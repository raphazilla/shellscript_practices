#!/usr/bin/env bash
#
# sistema_de_usuarios.sh - gerencia usuarios
#
# Site:       https://www.exemplo.com
# Autor:      Rapha
# Manutencao: Rapha
#
# ------------------------------------------------------------------ #
#  Este programa irá e um exemplo de com usar um banco de dados em texto.
#
#  Exemplos:
#      $ ./sistema_de_usuarios.sh 
#      
# ------------------------------------------------------------------ #
# Historico:
#       v1.0 27/02/2024, Rapha:
#           - Inicio do Programa
# ------------------------------------------------------------------ #
# Testado em:
#   bash 5.1.16(1)
# ------------------------------------------------------------------ #

# ----------------------------VARIAVEIS----------------------------- #
ARQUIVO_BANCO_DE_DADOS="banco_de_dados.txt"
SEP=:
TEMP=temp.$$
VERDE="\033[32;1m"
VERMELHO="\033[31;1m"

# ------------------------------- TESTES ----------------------------------------- #
[ ! -e "$ARQUIVO_BANCO_DE_DADOS" ] && echo "ERRO. Arquivo nao existe." && exit 1
[ ! -r "$ARQUIVO_BANCO_DE_DADOS" ] && echo "ERRO. Arquivo nao tem permissao de leitura." && exit 1
[ ! -w "$ARQUIVO_BANCO_DE_DADOS" ] && echo "ERRO. Arquivo nao tem permissao de escrita." && exit 1


# ------------------------------- FUNCOES ----------------------------------------- #
MostraUsuarioNaTela () {
  local id="$(echo $1 | cut -d $SEP -f 1)"
  local nome="$(echo $1 | cut -d $SEP -f 2)"
  local email="$(echo $1 | cut -d $SEP -f 3)"

  echo -e "${VERDE}ID: ${VERMELHO}$id"
  echo -e "${VERDE}Nome: ${VERMELHO}$nome"
  echo -e "${VERDE}E-mail: ${VERMELHO}$email"
}

ListaUsuarios () {
  while read -r linha
  do
    [ "$(echo $linha | cut -c1)" = "#" ] && continue
    [ ! "$linha" ] && continue

    MostraUsuarioNaTela "$linha"
  done < "$ARQUIVO_BANCO_DE_DADOS"
}

ValidaExistenciaUsuario () {
  grep -i -q "$1$SEP" "$ARQUIVO_BANCO_DE_DADOS"
}

InsereUsuario () {
  local nome="$(echo $1 | cut -d $SEP -f 2)"

  if ValidaExistenciaUsuario "$nome"
  then
    echo "ERRO. Usuario ja existente!"
  else
    echo "$*" >> "$ARQUIVO_BANCO_DE_DADOS"
    echo "Usuario cadastrado com sucesso!"
  fi
  OrdenaLista
}

ApagaUsuario () {
  ValidaExistenciaUsuario "$1" || return

  grep -i -v "$1$SEP" "$ARQUIVO_BANCO_DE_DADOS" > "$TEMP"
  mv "$TEMP" "$ARQUIVO_BANCO_DE_DADOS"

  echo "Usuario removido com sucesso!"
  OrdenaLista
}

OrdenaLista () {
  sort "$ARQUIVO_BANCO_DE_DADOS" > "$TEMP"
  mv "$TEMP" "$ARQUIVO_BANCO_DE_DADOS"
}


# ----------------------------EXECUCAO------------------------------ #


# ------------------------------FIM-------------------------------- #
