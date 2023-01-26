#!/bin/bash


# O utilizador introduz o que pretende fazer (1-5), se a escolha for "errada", o scrip é encerrado.
read -p "O que pretende fazer? (1) Organizar ficheiros, (2) Procurar um ficheiro e abri-lo, (3) Comprimir um ficheiro, (4) Extrair um ficheiro, (5) Sair: " choice

case $choice in
  1)
    # Aqui é pedido ao utilizador para introduzir o diretório dos ficheiros que pretende organizar
    read -p "Introduza a localização da pasta que quer organizar: " dir

    # Irá ser criado um ficheiro "organizar_ficheiros.txt" dentro da pasta local do script com todos os ficheiros do diretório introduzido, ordenados por ordem alfabética
    ls -l $dir | sort | awk '{print $9}' > organizar_ficheiros.txt
    ;;


  2)
  #Introduzir o nome do ficheiro que procuramos
    read -p "Introduza o nome do ficheiro que procura: " procura

  #Introduzir o diretório onde esse ficheiro se encontra 
    read -p "Introduza o diretório onde o ficheiro se encontra: " diretorio
    grep -r "$procura" $diretorio

    # verificar se o ficheiro foi encontrado. "$?" é a saída do último comando executado, 0 representa sucesso, se sim entra no if, caso contrario executa o echo.
  if [ $? -eq 0 ]; then

    # encontrar o caminho do ficheiro
    file_path=$(grep -r "$procura" $diretorio | awk '{print $1}')
    
    # abrir o ficheiro
    xdg-open "$file_path"

  else
    echo "Nenhum ficheiro encontrado..."
  fi
  ;;

  3)
    #Introduzir o nome da pasta que pretendemos comprimir
    read -p "Introduza o nome da pasta que pretende comprimir: " arquivo

    #Introduzir o diretório onde o resultado irá ficar
    read -p "Introduza o diretório onde a pasta irá ser comprimida: " dir_compr

    #O comando "tar" serve para compactar a pasta especificada na variável "arquivo" em um arquivo .gz. 
    #A variável "$arquivo" é usada para especificar o caminho da pasta que deve ser compactada.
    tar -cvzf $dir_compr/$arquivo.gz $arquivo
    ;;


  4)

    #Introduzir o nome da pasta que pretendemos extrair
    read -p "Introduza o nome da pasta que pretende extrair: " ficheiro

    #Introduzir o diretório onde o resultado irá ficar
    read -p "Introduza o diretório onde a pasta irá ser extraida: " dir_extr


    # O comando "tar" é utilizado para extrair o arquivo especificado na variável "$ficheiro".
    # O comando"-C $dir_extr", usa a opção "-C" para especificar o diretório para onde os arquivos extraídos devem ser colocados.
    # A variável "$dir_extr" é usada para especificar o caminho do diretório de destino.
    tar -xvzf $ficheiro -C $dir_extr
    ;;



#Sair do script
  5)
    echo "A sair do script..."
    exit
    ;;



  *)
    echo "Escolha inválida. A sair do script..."
    exit
    ;;
esac
