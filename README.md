# SRE_Cenario
Infraestrura definida como código para suportar aplicações modernas, obter métricas e logging de forma automatizada e ágil.

# Objetivo 

Este projeto visa provisionar de forma ágil serviços que suportem a execução de aplicações coletando seus logs e métricas de infraestrutura.

Para alcançar este objetivo serão instanciados via docker-compose  uma stack de serviços de metrics e loggins compostas por Prometheus, Node-Exporter, Collectd, CAdivisor, Alerta, MongoDB, Grafana, Elasticsearch, Kibana e Fluentd. Com estas ferramentas é possivel a coleta de informações de infra e logs de aplicação de forma automatizada e gerar visualizações ricas em detalhes e em tempo real.

Aplicações das mais diversas linguagens e tecnologias podem ser suportadas por esta pilha de serviços, atendendo o requisito de estarem em execução utilizando container docker e que estes containers usem Fluentd como login driver, os logs e metricas serão coletos.

O macro diagrama dos serviços pode ser representado pela imagem a seguir:

