# Relatório: Template Regras de Verificação

*Nome do Estágiario:* Millena França
*Data:* 08/11

*Conteúdos:*  
1. **[Sistema de regras quantitativas generalizado](#sistema-de-regras-quantitativas-generalizado)**

## Resumo dos módulos 
### Sistema de qualidade de dados generalizado
As variáveis quantitativas são aquelas que representam valores numéricos ou mensuráveis, como quantidades, saldos, taxas, e datas. A validação dessas variáveis geralmente envolve checagens matemáticas, intervalos e consistências lógicas. O objetivo inicial é que essas regras sejam aplicáveis independentemente do esquema específico, para depois personalizar conforme necessário.

**Estrutura geral das regras**
- **Intervalos permitidos:** garantir que os valores estejam dentro de limites aceitáveis

ex:

```numeroParcelas``` deve ser no máximo 100.
```valorJuros``` deve ser maior ou igual a 0.

- **Consistência matemática:** relacionar variáveis quantitativas para verificar consistência.

ex:

```saldoTotal``` = ```saldoPrincipal``` + ```valorJuros``` + ```valorTarifa``` + ```valorTributo```

- **Integridade cronológica:** Garantir que as datas respeitem a sequência lógica.

ex:

```dataOperacao``` ≤ ```dataVencimento``` 
