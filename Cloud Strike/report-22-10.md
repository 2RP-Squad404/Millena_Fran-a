# Relatório de Estudos
*Nome do Estágiario:* Millena França
*Data:* 22/10

*Conteúdos:*  
1. **[Mascaramento de Dados (DLP)](#mascaramento-de-dados-dlp)**
2. **[Validação dos Dados das Tabelas](#validação-dos-dados-das-tabelas)**

## Resumo dos módulos 
### Mascaramento de Dados (DLP)

A Google Cloud Data Loss Prevention (DLP) API é uma ferramenta que permite proteger dados sensíveis e confidenciais. Ela utiliza algoritmos de aprendizado de máquina para identificar e classificar informações sigilosas, como número de cartão de crédito, CPF ou regras mais específicas.

#### Funcionamento

Seu funcionamento é baseado no processamento de dados e verificação em busca de dados sensíveis, por meio de padrões. A API é capaz de análisar  diferentes tipos de dados como textos, imagens e até áudio.

#### Principais recursos do DLP

1. **Detecção de informações sensíveis:** reconhece padrões e contextos específicos, identificando informações sensíveis
2. **Classificação de Dados:** é capaz de classificar os dados de acordo com seu nível de confidencialidade, possibilitando maior controle das politicas de segurança e sua eficiência
3. **Máscaras e Substituições:** permite a aplicação de máscaras e substituições nos dados sensíveis, funcionalidade útil principalmente quando há necessidade de compartilhar os dados com terceiros, ou até mesmo para um armazenamento mais seguro
4. **Relatórios e auditorias:** essa API oferece recursos avançados para geração de relatórios, permitindo maior controle das empresas sobre o uso e acesso aos dados sensíveis. É possível personalizar os relatórios conforme a necessidade de cada organização

## Possíveis formas de mascarar no projeto

### Integração com o Cloud DLP   
Configurar pipelines de dados ou rotinas ETL no Dataplex que utilizem o DPL para inspecionar e mascarar dados sensiveis, por meio de jobs que processam os dados antes de ações serem executadas dentro do Dataplex.
1. Configurar pipeline no dataplex para extrair os dados
2. Enviar dados para o DLP para realizar o mascaramento dos UUIDS ou outros tipos de dados sensiveis	
3. Voltar os dados para o Dataplex

### Usar SQL para mascarar diretamente no BigQuery
Aplicar funções SQL de mascaramento direto nas consultas, antes de expor os dados. 
Exemplo de mascaramento:
```
SELECT 
  REGEXP_REPLACE(uuid_column, r'[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}', '****-****-****') AS masked_uuid
FROM 
  my_table;
```

### Validação dos Dados das Tabelas

24/10 -  Tentei utilizar o BigQuery junto com o Dataplex para validação de uma tabela de dados. Utilizei uma tabela com dados mockados de cartões e criei duas regras de verificação, uma para análisar se haviam números iguais no campo de id_cartão e outra para ver se o status de algum cartão era diferente de 'ATIVO' e 'CANCELADO', já sabendo qu existiam cartões 'BLOQUEADOS', esperando obter esses resultados como teste para poder aplicar futuramente em tabelas que precisam de verificações reais.

### Ferramenta Análise de qualidade dos Dados

