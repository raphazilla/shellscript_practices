#!/usr/bin/env bash
#
# extrai_titulos.sh - Configura agendamentos no cron
#
# Bite:       https://www.exemplo.com
# Autor:      Rapha
# Manutencao: Rapha
#
# ------------------------------------------------------------------ #
#  Este programa irá extrair títulos do blog LXER, colocar em um arquivo de
#  texto e ler mostrando com cores na tela.
#
#  Exemplos:
#      $ ./extrai_titulos.sh
#      Neste exemplo o programa vai extrair os titulos e mostrar na tela.
# ------------------------------------------------------------------ #
# Historico:
#       v1.0 20/02/2024, Rapha:
#           - Inicio do Programa
# ------------------------------------------------------------------ #
# Testado em:
#   bash 5.1.16(1)
# ------------------------------------------------------------------ #

# ----------------------------VARIAVEIS----------------------------- #
ARQUIVO_DE_TITULOS="titulos.txt"

# Cores
VERMELHO="\033[31;1m"
VERDE="\033[32;1m"

# ----------------------------TESTES------------------------------ #
# Lynx instalado?
[ ! -x "$(which lynx)" ] && sudo apt install lynx -y

# ----------------------------EXECUCAO------------------------------ #
lynx -source http://lxer.com/ | grep blurb | sed 's/<div.*line">//;s/<\/span.*//' > titulos.txt

while read -r titulo_lxer
do
  echo -e "${VERMELHO}Titulo: ${VERDE}$titulo_lxer"
done < "$ARQUIVO_DE_TITULOS"

# ------------------------------FIM-------------------------------- #