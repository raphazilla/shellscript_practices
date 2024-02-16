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
#       v1.0 15/02/2024, Rapha:
#           - Inicio do Programa
#       v1.1 15/02/2024, Rapha:
#           - Mudando if para case
#       v1.2 15/02/2024, Rapha:
#           - Flags adicionadas
# ------------------------------------------------------------------ #
# Testado em:
#   bash 5.1.16(1)
# ------------------------------------------------------------------ #

# ----------------------------VARIAVEIS----------------------------- #
USUARIOS="$(cat /etc/passwd | cut -d : -f 1)"
MENSAGEM_USO="
    $0 - [OPCOES]

    -h - Menu de ajuda
    -v - Versao do programa
    -s - Ordenar a saida
    -m - Coloca em maiusculo
"
VERSAO="v1.3"
CHAVE_ORDENA=0
CHAVE_MAIUSCULO=0
# -----------------------------TESTES------------------------------- #

# -----------------------------FUNCOES------------------------------ #

# ----------------------------EXECUCAO------------------------------ #
set -x
while test -n "$1"
do
    case "$1" in
        -h) echo "$MENSAGEM_USO" && exit 0              ;;
        -v) echo "$VERSAO" && exit 0                    ;;
        -s) CHAVE_ORDENA=1                              ;;
        -m) CHAVE_MAIUSCULO=1                           ;;
        *) echo "Opcao invalida, valide o -h" && exit 1 ;;
    esac
    shift
done
set +x

[ $CHAVE_ORDENA -eq 1 ]    && USUARIOS=$(echo "$USUARIOS" | sort)
[ $CHAVE_MAIUSCULO -eq 1 ] && USUARIOS=$(echo "$USUARIOS" | tr [a-z] [A-Z])

echo "$USUARIOS"
# ------------------------------------------------------------------ #