# Relatório de Estudos
*Nome do Estágiario:* Millena França
*Data:* 09/10

*Conteúdos:*  
1. **[Governança de Dados](#governança-de-dados)**
   - **[Aplicações no GCP](#aplicações-no-gcp)**
2. **[Dataplex](#dataplex)**
     - **[Integração com Bigquery](#integração-com-bigquery)**
2. **[Data Catalog](#data-catalog)**

## Resumo dos módulos 
### Governança de Dados
É um sistema de regras e procedimentos para controlar o gerenciamento de dados.

- Definição de responsabilidades, políticas e padrões.
Deve garantir que os dados sejam consistentes, confiáveis e que seu uso esteja alinhado com os objetivos de negócios

Leis que impõem padrões rigorosos sobre como os dados pessoais devem ser coletados, armazenados e utilizados:

**LGPD: Lei Geral de Proteção de Dados**

**GDPR: Regulamento Geral de Proteção de Dados**

**Segurança e Privacidade:** Proteja os dados contra acesso não autorizado ou perda, com foco na criptografia, controles de acesso e backups. A governança deve garantir conformidade com regulamentos de privacidade.

#### Aplicações no GCP
- IAM (Identity and Access Management): definir permissões granulares para usuários, grupos e serviços (controle detalhado de quem pode acessar e manipular dados)
- Data Security Best Practices: melhores práticas de segurança, 
como criptografia, gerenciamento de chaves (com Cloud KMS), e aplicação de políticas de privacidade de dados com ferramentas como Cloud DLP.
- Google Cloud Data Catalog:  como usar o Data Catalog para gerenciar seus dados, criando um catálogo de metadados que permita organizar e controlar o acesso a datasets importantes.
- BigQuery Access Control:  métodos de controle de acesso e governança dentro do BigQuery, configurando permissões baseadas em papéis e aplicando políticas de acesso.


### Dataplex
Plataforma de gerenciamento de dados que permite organizar, gerenciar e governar dados em ambientes de data lake, oferecendo controle sobre a forma como os dados são usados, acessados e compartilhados.

Como o Dataplex facilita a governança de dados, promovendo a consistência, qualidade e segurança dos dados:

- **Organização Centralizada:** O Dataplex permite organizar seus dados em **zonas de dados** (data zones), que são camadas lógicas para segmentar dados em diferentes categorias, como dados brutos, processados e prontos para análise.
- **Metadados Uniformes:** A integração com o **Google Cloud Data Catalog** permite gerenciar metadados de forma centralizada, promovendo a consistência na descrição e documentação dos dados, independentemente de sua origem.

**Metadados:** são dados que descrevem outros dados, proporcionando informações sobre o conteúdo, contexto e estrutura de um conjunto de dados. Eles ajudam a entender, gerenciar e utilizar dados de maneira mais eficaz.

- **Perfis de Dados Automáticos:** O Dataplex permite a **criação automática de perfis de dados**, gerando insights sobre a qualidade dos dados, como distribuição de valores, valores nulos ou outliers. Isso permite detectar e corrigir problemas de qualidade antes que os dados sejam usados em análises ou relatórios.
- **Monitoramento e Validação:** O Dataplex fornece ferramentas de monitoramento que permitem rastrear a qualidade dos dados ao longo do tempo, assegurando que os padrões de qualidade estejam sendo mantidos à medida que os dados são processados e movidos entre diferentes zonas.
- **Regras de Qualidade de Dados:** Você pode definir **regras de qualidade de dados** personalizadas para monitorar automaticamente a conformidade dos dados em relação aos critérios definidos, como limites de valores aceitáveis ou a ausência de dados faltantes. O sistema gera alertas caso os dados não atendam aos requisitos estabelecidos.

#### Integração com BigQuery
Veja como o Dataplex se integra ao BigQuery para análise de dados, permitindo que você consulte dados de diferentes fontes em um único local:

**Consulte dados de múltiplas fontes**: permite unificar dados de múltiplas fontes (como Google Cloud Storage, BigQuery, ou sistemas externos) em **zonas de dados**. Essas zonas organizam os dados em categorias lógicas (como dados brutos, dados transformados ou prontos para análise), o que facilita a análise integrada e a governança centralizada.

**Acesse dados facilmente através de catálogos unificados:** integração com data catalog, Isso facilita a descoberta dos datasets no BigQuery e em outras fontes, fornecendo uma interface onde os usuários podem procurar, encontrar e entender dados com base nos metadados associado

**Faça análises unificadas usando SQL no BigQuery, com dados distribuídos em diferentes zonas e formatos:**  O Dataplex permite que dados **não estruturados** (como arquivos CSV, JSON, Parquet, ou outros formatos armazenados no Cloud Storage) sejam expostos ao BigQuery como tabelas externas. Isso significa que, sem necessidade de movimentar os dados, você pode consultá-los diretamente usando o BigQuery, integrando esses dados com outras fontes estruturadas.

Você pode combinar dados estruturados e não estruturados em uma única consulta SQL, promovendo análises abrangentes e mais completas.

Com o Dataplex, você pode **orquestrar processos de ETL** (Extração, Transformação e Carregamento) para preparar e mover dados para o BigQuery. Isso inclui aplicar transformações nos dados e movê-los entre diferentes zonas (por exemplo, de dados brutos para dados prontos para análise) antes de serem analisados no BigQuery.

O Dataplex pode **automatizar a criação de tabelas no BigQuery** a partir de dados novos ou modificados, simplificando o gerenciamento de grandes volumes de dados que fluem para dentro e fora do BigQuery.

**Segurança e Acesso:** Estude como gerenciar políticas de segurança e acesso a dados usando o Dataplex, assegurando que apenas usuários autorizados possam acessar informações sensíveis:

- Atribuir funções baseadas em papéis para usuários ou grupos através do IAM, limitando as ações que poderão ser realizadas. No Dataplex, você pode definir diferentes níveis de acesso para zonas de dados, lakes, e recursos, como tabelas e objetos de dados.

**Exemplos de Funções Comuns no Dataplex:**

- **Viewer:** Pode visualizar dados e metadados, mas não pode editar.
- **Editor:** Pode visualizar e editar dados, mas não pode gerenciar permissões.
- **Admin:** Tem controle total, podendo gerenciar permissões e acessar todos os dados.

Ao criar uma zona, você pode definir políticas de acesso específicas com base na sensibilidade dos dados, atribuindo permissões mais restritas para zonas que contêm dados confidenciais, como dados pessoais ou financeiros.

- **IAM Conditions** - criar regras condicionais para permissões, aplicar restrições mais granulares com base em fatores como **atributos do recurso** ou **atributos do contexto**, como data e hora.
- **definição centralizada de políticas de segurança e governança**. Uma vez definidas, essas políticas são aplicadas automaticamente em todas as fontes de dados

O **Cloud Audit Logs** é integrado ao Dataplex para registrar todas as atividades relacionadas ao acesso e uso de dados. Isso permite que você audite quem acessou ou tentou acessar dados, quais dados foram acessados, e o que foi feito com esses dados.

**Data Loss Prevention (DLP)**

- O **Cloud DLP (Data Loss Prevention)** pode ser usado em conjunto com o Dataplex para detectar, classificar e proteger informações sensíveis, como números de cartão de crédito, informações pessoais ou dados confidenciais de clientes.
- O DLP pode aplicar políticas automáticas para mascarar ou anonimizar dados sensíveis antes de serem acessados, garantindo que dados confidenciais não sejam expostos de forma indevida.

**Criptografia**
- O Dataplex integra-se aos mecanismos de **criptografia nativa** do Google Cloud, onde todos os dados são criptografados em repouso e em trânsito. Isso garante que os dados estejam sempre protegidos, mesmo se forem interceptados.
- O gerenciamento de chaves de criptografia pode ser feito através do **Cloud Key Management Service (KMS)**, permitindo que você gerencie chaves de criptografia personalizadas se necessário.

### Data Catalog

- serviço totalmente gerenciado que permite catalogar e organizar metadados de dados, facilitando a descoberta e a compreensão dos ativos de dados.

Os usuários podem facilmente buscar e descobrir dados por meio de filtros e tags, o que melhora a eficiência na localização de informações relevantes.