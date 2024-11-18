# Relatório: Template Regras de Verificação

*Nome do Estágiario:* Millena França
*Data:* 12/11

*Conteúdos:*  
1. **[Automação da validação de dados](#automação-da-validação-de-dados)**
## Resumo dos módulos 
### Automação da validação de dados

No Google Cloud, o Dataplex permite agendar verificações de qualidade de dados, mas pode ser útil configurar a execução automática de uma validação toda vez que novos dados são inseridos em uma tabela. Será necessário integrar o Dataplex com outros serviços do Google Cloud, como BigQuery e Cloud Functions, para criar uma automação
x 
- Habilitar o Audit Log para monitorar eventos no BigQuery, como inserções ou atualizações de dados, ativando os logs para os eventos "WRITE" relacionados ao BigQuery.

- Criar um tópico Pub/Sub para receber mensagens de eventos, como inserções de dados na tabela alvo.

- No BigQuery, configure uma detecção de evento para publicar mensagens no Pub/Sub quando dados forem inseridos ou atualizados na tabela.

EX de comando SQL para configurar notificações
```
CREATE NOTIFICATION RULE new_data_notification
ON TABLE `tabela`
TO PUBSUB `projects/projeto/topics/pubsub` 
```
Isso enviará mensagens ao tópico do Pub/Sub sempre que ocorrer uma modificação na tabela.

- Criar uma Cloud Function que será acionada pelas mensagens do Pub/Sub.
Essa função usará a API do Dataplex para iniciar uma execução de validação.

Ex de código para acionar a execução de validação
```
from google.cloud import dataplex_v1
import base64
import json

def trigger_data_scan(event, context):
    """
    Função para acionar um Data Scan no Dataplex.
    É executada automaticamente quando uma mensagem chega no tópico Pub/Sub.
    """
    try:
        # Decodifica a mensagem recebida do Pub/Sub
        message = base64.b64decode(event['data']).decode('utf-8')
        data = json.loads(message)
        print(f"Mensagem recebida do Pub/Sub: {data}")

        # Nome do Data Scan a ser acionado
        scan_name = "projects/seu-projeto/locations/sua-regiao/dataScans/seu-scan-id"

        # Cliente do Dataplex
        client = dataplex_v1.DataplexServiceClient()

        # Aciona o Data Scan
        print(f"Iniciando o Data Scan: {scan_name}")
        client.run_data_scan(name=scan_name)
        print("Data Scan iniciado com sucesso!")

    except Exception as e:
        print(f"Erro ao acionar o Data Scan: {e}")

```

