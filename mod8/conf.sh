#!/usr/bin/env bash
#
# conf.sh - Exemplo usando arquivo de configuracoes
#
# Site:       https://www.exemplo.com
# Autor:      Rapha
# Manutencao: Rapha
#
# ------------------------------------------------------------------ #
#  Este programa ira ler o conteudo de um arquivo de configuracoes
#  e funcionara com base nessas configuracoes.
#
#  Exemplos:
#      $ ./conf.sh
#      Neste exemplo o programa vai extrair os titulos e mostrar na tela.
# ------------------------------------------------------------------ #
# Historico:
#       v1.0 21/02/2024, Rapha:
#           - Inicio do Programa
# ------------------------------------------------------------------ #
# Testado em:
#   bash 5.1.16(1)
# ------------------------------------------------------------------ #

# ----------------------------VARIAVEIS------------------------------ #
ARQUIVO_DE_CONFIGURACAO="configuracao.cf"
USAR_CORES=
USAR_MAIUSCULAS=
MENSAGEM="Mensagem de teste"

VERDE="\033[32;1m"
VERMELHO="\033[31;1m"

# ----------------------------TESTES------------------------------ #
[ ! -r "$ARQUIVO_DE_CONFIGURACAO" ] && echo "Nao temos acesso de leitura" && exit 1

# ----------------------------FUNCOES------------------------------ #
DefinirParametros () {
  local parametro="$(echo $1 | cut -d = -f 1)"
  local valor="$(echo $1 | cut -d = -f 2)"

  case "$parametro" in
    USAR_CORES)      USAR_CORES=$valor      ;;
    USAR_MAIUSCULAS) USAR_MAIUSCULAS=$valor ;;
  esac
}

# ----------------------------EXECUCAO------------------------------ #
while read -r linha
do
  [ "$(echo $linha | cut -c1)" = "#" ] && continue
  [ ! "$linha" ] && continue
  DefinirParametros "$linha"
done < "$ARQUIVO_DE_CONFIGURACAO"

[ $USAR_MAIUSCULAS -eq 1 ] && MENSAGEM="$(echo -e $MENSAGEM | tr a-z A-Z)"
[ $USAR_CORES -eq 1 ] && MENSAGEM="$(echo -e ${VERDE}$MENSAGEM)"

echo "$MENSAGEM"
# ------------------------------FIM-------------------------------- #
