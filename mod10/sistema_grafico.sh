#!/usr/bin/env bash
#
# sistema_de_usuarios.sh - gerencia usuarios GUI
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
#       v1.0 28/02/2024, Rapha:
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

# -------------------------------TESTES----------------------------------------- #
[ ! -e "$ARQUIVO_BANCO_DE_DADOS" ] && echo "ERRO. Arquivo nao existe." && exit 1
[ ! -r "$ARQUIVO_BANCO_DE_DADOS" ] && echo "ERRO. Arquivo nao tem permissao de leitura." && exit 1
[ ! -w "$ARQUIVO_BANCO_DE_DADOS" ] && echo "ERRO. Arquivo nao tem permissao de escrita." && exit 1
[ ! -x "$(which dialog)" ] && sudo apt install dialog 1> /dev/null 2>&1

# -------------------------------FUNCOES----------------------------------------- #
ListaUsuarios () {
  egrep -v "^#|^$" "$ARQUIVO_BANCO_DE_DADOS" | sort -h | tr : ' ' > "$TEMP"
  dialog --title "Lista de Usuarios" --textbox "$TEMP" 20 40
  rm -f "$TEMP"
}

ValidaExistenciaUsuario () {
  grep -i -q "$1$SEP" "$ARQUIVO_BANCO_DE_DADOS"
}



# -------------------------------EXECUCAO----------------------------------------- #
while :
do
  acao=$(dialog --title "Gerenciamento de Usuarios 2.0" \
                --stdout \
                --menu "Escolha uma das opções abaixo:" \
                0 0 0 \
                listar "Listar todos os Usuarios do sistema" \
                remover "Remover um Usuario do sistema" \
                inserir "Inserir um novo Usuario no sistema")
  [ $? -ne 0 ] && exit

  case $acao in
    listar)  ListaUsuarios  ;;
    inserir)
      ultimo_id=$(egrep -v "^#|^$" "$ARQUIVO_BANCO_DE_DADOS" | sort -h | tail -n 1 | cut -d $SEP -f 1)
      proximo_id=$(($ultimo_id+1))

      nome=$(dialog --title "Cadastro de Usuarios" --stdout --inputbox "Digite o seu nome" 0 0)
      [ ! "$nome" ] && exit 1

      ValidaExistenciaUsuario "$nome" && {
        dialog --title "ERRO FATAL!" --msgbox "Usuario ja cadastrado no sistema!" 6 40
        exit 1
      }

      email=$(dialog --title "Cadastro de Usuarios" --stdout --inputbox "Digite o seu E-mail" 0 0)
      [ $? -ne 0 ] && continue

      echo "$proximo_id$SEP$nome$SEP$email" >> "$ARQUIVO_BANCO_DE_DADOS"
      dialog --title "SUCESSO!" --msgbox "Usuario cadastrado com sucesso!" 6 40

      ListaUsuarios
    ;;
    remover)
      usuarios=$(egrep "^#|^$" -v "$ARQUIVO_BANCO_DE_DADOS" | sort -h | cut -d $SEP -f 1,2 | sed 's/:/ "/;s/$/"/')
      id_usuario=$(eval dialog --stdout --menu \"Escolha um Usuario:\" 0 0 0 $usuarios)
      [ $? -ne 0 ] && continue

      grep -i -v "^$id_usuario$SEP" "$ARQUIVO_BANCO_DE_DADOS" > "$TEMP"
      mv "$TEMP" "$ARQUIVO_BANCO_DE_DADOS"

      dialog --msgbox "Usuario removido com sucesso!"
      ListaUsuarios
    ;;
  esac
done
# ------------------------------FIM-------------------------------- #