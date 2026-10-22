# Simulador de Investimentos: Comparação de Rendimentos

## Sobre o projeto

Este projeto foi desenvolvido em Flutter e Dart para simular e comparar os rendimentos de dois investimentos diferentes utilizando juros compostos.

O aplicativo permite que o usuário informe os valores iniciais, as aplicações mensais, as taxas de juros e o período da simulação. Ao final, apresenta os resultados e a evolução mensal dos investimentos.

## Objetivo

Desenvolver um aplicativo que facilite a comparação entre dois investimentos, mostrando o montante final, o total aplicado e o rendimento obtido em cada simulação.

## Funcionalidades

- Formulário para cadastrar os dados de dois investimentos.
- Entrada do capital inicial de cada investimento.
- Definição das aplicações mensais.
- Configuração das taxas de juros mensais.
- Definição do período em meses.
- Cálculo dos rendimentos com juros compostos.
- Comparação dos montantes finais e dos rendimentos.
- Lista comparativa da evolução mensal.
- Barras visuais para comparar os saldos acumulados.
- Navegação entre a tela de entrada e a tela de resultados.
- Opção para retornar e realizar uma nova simulação.

## Tecnologias utilizadas

- Flutter
- Linguagem Dart
- Visual Studio Code
- Git e GitHub

## Como executar o projeto

1. Instale o Flutter e configure o ambiente de desenvolvimento.
2. Clone este repositório ou baixe os arquivos do projeto.
3. Abra a pasta do projeto no Visual Studio Code.
4. Abra o terminal na pasta principal do projeto.
5. Execute o comando:

```bash
flutter pub get
```

6. Execute o aplicativo no Google Chrome:

```bash
flutter run -d chrome
```

## Como utilizar

1. Informe o capital inicial do investimento A.
2. Informe a aplicação mensal e a taxa de juros mensal do investimento A.
3. Preencha os mesmos dados para o investimento B.
4. Informe o período da simulação em meses.
5. Clique em **Comparar investimentos**.
6. Consulte os montantes finais, os totais aplicados e os rendimentos.
7. Analise a evolução mensal e compare os dois investimentos.
8. Utilize a opção de voltar para realizar outra simulação.

## Método de cálculo

O saldo é atualizado mensalmente pela fórmula:

Saldo final do mês = saldo anterior × (1 + taxa mensal) + aplicação mensal

A taxa de juros é convertida de porcentagem para número decimal durante o cálculo.

O rendimento total corresponde ao montante final menos o capital inicial e todas as aplicações mensais realizadas.

**Observação:** a simulação considera a aplicação mensal ao final de cada mês, depois da incidência dos juros. Os valores são estimativas matemáticas e não incluem impostos, taxas ou variações reais do mercado financeiro.

## Organização do projeto

- `lib/main.dart`: contém a interface, o formulário, a navegação, os cálculos e a tela de resultados.
- `pubspec.yaml`: contém as configurações e dependências do projeto Flutter.
- `README.md`: apresenta a documentação do projeto.


## Autoria

Trabalho acadêmico desenvolvido para o desafio **Simulador de Investimentos: Comparação de Rendimentos**.
