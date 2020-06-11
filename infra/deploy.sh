#!/bin/bash


ROOT_DIR_INSTALL=/usr/sre_cenario
rm -f $ROOT_DIR_INSTALL/*.fail


echo -e  "\n Checando se o docker compose esta disponivel "
    docker-compose --version > /dev/null

        if [ $? -gt 0 ]; then
        echo -e   "\n Existe algum problema com sua binário do docker-compose, necessario corrigir, encerrando a execucao deste script "
        touch $ROOT_DIR_INSTALL/compose.fail
        exit
fi

sleep 5

echo -e   "\n Limpando possivel existencia do ambiente "
 docker-compose down -d 2>&1 /dev/null

INTERFACE_PADRAO=$(ip -o -4 route show to default|awk {'print $5'})
IP_LOCAL=$(/sbin/ifconfig $INTERFACE_PADRAO | grep netmask | awk '{print $2}'| cut -f2 -d:)

sleep 10

echo -e   "\n Testando ambiente de execucao"

sleep 10



if [ -d $ROOT_DIR_INSTALL ]; then
    echo -e   "\n Diretório padrão de instação configurado: $ROOT_DIR_INSTALL "
 else
    echo -e   "\n $ROOT_DIR_INSTALL não existe, favor criar e copiar os arquivos de setup para ele "
fi

echo -e   "\n Testando sua conectividade com a internet "
 echo -e   "\n Testando a comunicação com seu Gateway "

    IP_GATEWAY=$(route -n|grep UG|awk '{print $2}')
    ping -c2 $IP_GATEWAY

    if [ $? -gt 0 ]; then
        echo -e   "\n Erro ao se comunicar com o gateway, favor corrigir "
        touch $ROOT_DIR_INSTALL/gateway.fail
fi

echo -e   "\n Testando a resolução de DNS com www.google.com "

    host www.google.com

    if [ $? -gt 0 ]; then
        echo -e   "\n Não é possível resolver nomes no DNS, favor corrigir "
        touch $ROOT_DIR_INSTALL/dns.fail
fi

echo -e   "\n Testando a capacidade de download "

    curl  -s --max-time 15 -skI https://packages.cloud.google.com

    if [ $? -gt 0 ]; then
        echo -e   "\n Sem acesso a internet, favor corrigir "
        touch $ROOT_DIR_INSTALL/internet.fail
fi

FAILS=$(find $ROOT_DIR_INSTALL -iname \*.fail|wc -l)

if [ $FAILS -eq 0 ]; then
    clear
    echo -e   "\n Conectividade de rede OK "
    else
    echo -e   "\n Suas configurações de rede possuem erros, favor corrigir "
    exit
fi


echo -e   "\n Checando integridade do arquivo docker-compose.yml"

 cd $ROOT_DIR_INSTALL/infra
 docker-compose config > /dev/null

  if [ $? -gt 0 ]; then
  echo -e "\n O arquivo docker-compose.yml esta danificado. Parando o processamento "
  exit 
fi

sleep 10

echo -e   "\n Criando ambiente docker-compose.yml"
 cd $ROOT_DIR_INSTALL/infra
 docker-compose up -d

  if [ $? -ne 0 ]; then {
    echo -e "\n Ocorreu algum problema, executando novamente "
  } else {
    cd $ROOT_DIR_INSTALL/infra
    docker-compose up -d
    if [ $? -gt 0 ]; then {
        echo -e "\n O ambiente não foi criado, reveja seu ambiente docker"
        exit 
     } fi    
  }
fi

sleep 10

echo -e   "\n Os seguintes serviços estao disponiveis"
echo -e   "\t App Logging"
echo -e   "\t \t Kibana $IP_LOCAL:$KIBANA_PORT"
echo -e   "\t Infra Metrics "
echo -e   "\t \t Prometheus $IP_LOCAL:$PROMETHEUS_PORT"
echo -e   "\t \t Alerta $IP_LOCAL:$ALERTA_PORT "
echo -e   "\t \t Grafana $IP_LOCAL:$GRAFANA_PORT"