# SRE_Cenario
Infraestrura definida como código para suportar aplicações modernas, obter métricas e logging de forma automatizada e ágil.

# Objetivo 

Este projeto visa provisionar de forma ágil serviços que suportem a execução de aplicações coletando seus logs e métricas de infraestrutura.

Para alcançar este objetivo serão instanciados via docker-compose  uma stack de serviços de metrics e loggins compostas por Prometheus, Node-Exporter, Collectd, CAdivisor, Alerta, MongoDB, Grafana, Elasticsearch, Kibana e Fluentd. Com estas ferramentas é possivel a coleta de informações de infra e logs de aplicação de forma automatizada e gerar visualizações ricas em detalhes e em tempo real.

Aplicações das mais diversas linguagens e tecnologias podem ser suportadas por esta pilha de serviços, atendendo o requisito de estarem em execução utilizando container docker e que estes containers usem Fluentd como login driver, os logs e metricas serão coletos.

O macro diagrama dos serviços pode ser representado pela imagem a seguir:

 ![](imagens/service_diagram.png)
 
 Com esta infraestrutura implantada, logs e métricas estarão disponíveis aos diversos times responsáveis por aumentar a confiabilidade das aplicações, em seus diversos aspectos e contornos.
 
 # Deploy do ambiente
 
Para que seja possível o deploy deste ambiente, é necessário ter acesso a uma docker machine, com ambiente docker no **mínimo na versão 18.06.0-ce** e o binário do docker composse na **versão 1.26.0**. Também é necessário o **git** instalado.

**1.** Execute o git clone para obter o arquivos de implantação.

#git clone https://github.com/jeliasmoreira/sre_cenario.git

**2.** Após o clone do repositório, entre na pasta ./ser_cenario.

#cd ./ser_cenario

**3.** Proceda agora com a execução do shell script de implantação.
#sh deploy.sh

Aguarde até o final da execução e uma saída como a seguir será exibida

Os seguintes serviços estao disponiveis
         App Logging
                 Kibana 10.10.10.10:5601
         Infra Metrics
                 Prometheus 10.10.10.10:9090
                 Alerta 10.10.10.10:10081
                 Grafana 10.10.10.10:3000
                 
Esta saída indica que os serviços estão disponíveis e prontos para o uso no **IP:Porta** apresentado.
         


