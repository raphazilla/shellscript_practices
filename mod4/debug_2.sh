#!/usr/bin/env bash
#
# listausuarios.sh - Extrai usuarios do /etc/passwd
#
# Site:       https://www.exemplo.com
# Autor:      Raphazilla
# Manutencao: Raphazilla
#
# ------------------------------------------------------------------ #
# Extrai usuarios do /etc/passwd, havendo a possibilidade de colocar
# em maiusculo e em ordem alfabetica.
#
# Exemplos:
#   $ ./listausuarios.sh -s -m
#   Nexte examplo os script ira ordenar e colocar em maiusculo.
# ------------------------------------------------------------------ #
# Historico:
#       v1.0 20/02/2024, Rapha:
#           - Inicio do Programa
# ------------------------------------------------------------------ #
# Testado em:
#   bash 5.1.16(1)
# ------------------------------------------------------------------ #

# ----------------------------VARIAVEIS----------------------------- #
CHAVE_DEBUG=0
NIVEL_DEBUG=0
# -----------------------------TESTES------------------------------- #

# -----------------------------FUNCOES------------------------------ #
Debugar () {
  [ $1 -le $NIVEL_DEBUG ] && echo "Debug $* ------"
}

Soma () {
  local total=0

  for i in $(seq 1 25); do
      Debugar 1 "Entrei no for com o valor: $i"
      total=$(($total+$i))
      Debugar 2 "Depois da soma: $total"
  done
}
# ----------------------------EXECUCAO------------------------------ #
case "$1" in
  -d) [ $2 ] && NIVEL_DEBUG=$2 ;;
   *) Soma                     ;;
esac

Soma
# ------------------------------------------------------------------ #