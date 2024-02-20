#!/usr/bin/env bash
#
# cronsetup.sh - Configura agendamentos no cron
#
# Bite:       https://www.exemplo.com
# Autor:      Rapha
# Manutencao: Rapha
#
# ------------------------------------------------------------------ #
# Configura execucoes programadas no cron atraves de parametros
# informados na linha de COMANDO, facilitando a manutencao.
#
# Exemplos:
#   $ ./cronsetup.sh -s -m
#   Neste examplo os script ira ordenar e colocar em maiusculo.
# ------------------------------------------------------------------ #
# Historico:
#       v1.0 15/02/2024, Rapha:
#           - Inicio do Programa
#       v1.1 20/02/2024, Rapha:
#           - Adicionado funcao de depurar
# ------------------------------------------------------------------ #
# Testado em:
#   bash 5.1.16(1)
# ------------------------------------------------------------------ #

# ----------------------------VARIAVEIS----------------------------- #
MENSAGEM_USO="
    $0 - [OPCOES] <comando>

    -m - minuto
    -h - HORA
    -d - dia do mes
    -M - mes
    -w - dia da semana

    Exemplo: $0 -m 30 -h 2 -d 15 -M 3 -w 1 /path/para/seu/script.sh
"
MINUTO="*"
HORA="*"
DIA_MES="*"
MES="*"
DIA_SEMANA="*"
COMANDO=""
CHAVE_DEBUG=0

# -----------------------------FUNCOES------------------------------ #
Debugar () {
  echo "Debug ------"
  set -x
}

# ----------------------------TESTES------------------------------ #
# Validacao dos parametros
while test -n "$1"; do
    case "$1" in
        -m|--MINUTO) MINUTO="$2"     ;;
        -h|--HORA)   HORA="$2"       ;;
        -d|--DIA)    DIA_MES="$2"    ;;
        -M|--MES)    MES="$2";       ;;
        -w|--SEMANA) DIA_SEMANA="$2" ;;
        -debug) CHAVE_DEBUG=1        ;;
        *)  COMANDO="$1"             ;;
    esac
    shift
done

[ "$CHAVE_DEBUG" -eq 1 ] && Debugar
# Verifica se o comando foi fornecido
if [[ -z "$COMANDO" ]]; then
    echo "$MENSAGEM_USO"
    exit 1
fi

# ----------------------------EXECUCAO------------------------------ #
# Mostra a configuracao proposta
echo "Configuracao proposta:"
echo "$MINUTO $HORA $DIA_MES $MES $DIA_SEMANA $COMANDO"
echo -e "\n"

# Solicita confirmacao
read -p "Deseja aplicar essa configuracao? (S/N): " RESPOSTA
if [[ "$RESPOSTA" =~ ^[Ss]$ ]]; then
    # Adiciona a linha ao crontab
    (crontab -l ; echo "$MINUTO $HORA $DIA_MES $MES $DIA_SEMANA $COMANDO") | crontab -
    echo "Configuracao aplicada com sucesso!"
else
    echo "Configuracao cancelada."
fi
set +x
# ------------------------------FIM-------------------------------- #