# Relatório: Template Regras de Verificação

*Nome do Estágiario:* Millena França
*Data:* 08/11

*Conteúdos:*  
1. **[Sistema de qualidade de dados generalizado](#sistema-de-qualidade-de-dados-generalizado)**
2. **[Automação](#automação)**

## Resumo dos módulos 
### Sistema de qualidade de dados generalizado
Para criar um sistema de verificação de qualidade de dados que possa ser aplicado de forma generalizada, deve-se começar definindo regras básicas que avaliem aspectos comuns de qualidade (como integridade, validade e exclusividade) para serem aplicadas em qualquer tabela. O objetivo inicial é que essas regras sejam aplicáveis independentemente do esquema específico, para depois personalizar conforme necessário.

**Estrutura geral das regras**
- **Integridade:** Confirma se os campos possuem valores onde esperado, especialmente em colunas obrigatórias.
- **Exclusividade:** Garante a ausência de duplicidade em colunas que devem ter valores únicos
- **Validade:** Verifica se os dados estão no formato esperado

**1. Regra de Integridade**
- Validar se colunas específicas possuem valores não nulos.

Aplicação: Ideal para colunas que não devem ter valores faltantes, como ```id_cliente```, ```num_cartao```, ```id_conta``` 
- Mínimo aceitável: 100%

**2. Regra de Exclusividade**
- Assegurar que as colunas de identificação (como ```id_cliente```) não tenham valores duplicados.

Aplicação: Colunas com IDs únicos, como ```id_cliente```, ```id_cartao```, ```id_conta```
- Mínimo aceitável: 100%

**3. Regra de Validade (regex)**
- Verificar formatos e padrões específicos para campos que seguem regras de formatação ou intervalos
Aplicação: Colunas que possuem formato específico ou intervalo esperado. Exemplo: ```num_cpf_cliente``` (11 dígitos numéricos), ```flg_cartao_cancelado``` (S/N).

### Automação
É possível agendar a tarefa para rodar periodicamente, facilitando a detecção de problemas de qualidade à medida que os dados são inseridos ou atualizados.

O Dataplex possui a capacidade de agendar verificações de qualidade de dados automaticamente. Isso é feito criando Tasks e configurando um cronograma (Scheduler), onde é possível definir as execuções para a rotina de verificação, com intervalos de horas, dias, semanas, etc.
