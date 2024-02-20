#!/usr/bin/env bash
#
# tarefa8.sh - Coleta titulo de post do meu blog
#
# Site:       https://www.exemplo.com
# Autor:      Rapha
# Manutencao: Rapha
#
# ------------------------------------------------------------------ #
#  Este programa irá extrair títulos do Meu blog, colocar em um arquivo de
#  texto e ler mostrando com cores na tela.
#
#  Exemplos:
#      $ ./tarefa8.sh
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
lynx -source https://raphazilla.github.io/raphazilla/blog/ | tidy -i -w 1000 -q | grep "card-title" | sed 's/^[ ]*//;s/<h2 class="card-title".*\/">//;s/<\/a.*h2>$//' > titulos.txt

while read -r titulo_blog
do
  echo -e "${VERMELHO}Titulo: ${VERDE}$titulo_blog"
done < "$ARQUIVO_DE_TITULOS"

# ------------------------------FIM-------------------------------- #