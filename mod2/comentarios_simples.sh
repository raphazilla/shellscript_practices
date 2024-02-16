#!/usr/bin/env bash

# Lynx instalado?
[ ! -x "$(which lynx)" ] && printf "${YELLOW} Precisamos installar o ${GREEN}Lynx${YELLOW}, por favor, corrija" || printf "${GREEN} Lynx installado em: $(which lynx)\n"

# Sem parametros obrigatorios?
[ -z $1 ] && printf "${RED}[ERRO] - Informe os parametros obrigatorios. Consulte a opcao -h.\n" && exit 1