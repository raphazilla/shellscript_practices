#!/usr/bin/env bash
#
# tarefa3.sh - Script com para concluir a tarefa3
#
# Site: https://www.exemplo.com
# Autor: Rapha
# Manutencao: Rapha
#
# ------------------------------------------------------------------ #
# Descricao completa do programa/script
#
# Exemplos:
#   $ ./tarefa3.sh
#   Nexte examplo os script sera executado no modo de debug 1.
# ------------------------------------------------------------------ #
# Historico:
#       v1.0 15/02/2024, Rapha:
#           - Inicio do Programa
#           - Ajustada a estrutura do programa
#           - Adicionado cabecalho e comentarios
# ------------------------------------------------------------------ #
# Testado em:
#   bash 5.1.16(1)
# ------------------------------------------------------------------ #
# Agradeciomentos:
#
#   Mateus Muller - Por fazer um conteudo excelente
# ------------------------------------------------------------------ #

# ----------------------------VARIAVEIS----------------------------- #
COMECO=0
FIM=100

# -----------------------------TESTES------------------------------- #
# Testa se o COMECO e maior que o FIM
[ $COMECO -ge $FIM ] && exit 1


# ----------------------------EXECUCAO------------------------------ #
for i in $(seq $COMECO $FIM) # Repete do COMECO ao FIM
do 
    for j in $(seq $i $FIM) # Repete N vezes ate FIM
    do
        printf "*"
    done
    printf "\n" # Quebra de linha
done