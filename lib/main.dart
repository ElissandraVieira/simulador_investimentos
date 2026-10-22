
import 'package:flutter/material.dart';

void main() {
  runApp(const SimuladorApp());
}

// Configuração principal do aplicativo.
class SimuladorApp extends StatelessWidget {
  const SimuladorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simulador de Investimentos',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: const TelaInicial(),
    );
  }
}

// Tela inicial com o formulário dos dois investimentos.
class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  final capitalA = TextEditingController();
  final aplicacaoA = TextEditingController();
  final taxaA = TextEditingController();

  final capitalB = TextEditingController();
  final aplicacaoB = TextEditingController();
  final taxaB = TextEditingController();

  final periodo = TextEditingController();

  // Converte os valores digitados em números.
  double converter(String texto) {
    return double.tryParse(
          texto.trim().replaceAll(',', '.'),
        ) ??
        0;
  }

  // Método reutilizável para criar os campos do formulário.
  Widget campo(
    String titulo,
    TextEditingController controle,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: TextField(
        controller: controle,
        keyboardType:
            const TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          labelText: titulo,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.deepPurple,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }

  // Valida os campos e abre a tela de resultados.
  void calcular() {
    final cA = converter(capitalA.text);
    final aA = converter(aplicacaoA.text);
    final jA = converter(taxaA.text);

    final cB = converter(capitalB.text);
    final aB = converter(aplicacaoB.text);
    final jB = converter(taxaB.text);

    final meses = int.tryParse(periodo.text.trim());

    final campos = [
      capitalA,
      aplicacaoA,
      taxaA,
      capitalB,
      aplicacaoB,
      taxaB,
      periodo,
    ];

    if (campos.any((campo) => campo.text.trim().isEmpty) ||
        meses == null ||
        meses < 1 ||
        cA < 0 ||
        aA < 0 ||
        jA < 0 ||
        jA > 100 ||
        cB < 0 ||
        aB < 0 ||
        jB < 0 ||
        jB > 100) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Preencha todos os campos com valores válidos.',
          ),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TelaResultados(
          capitalA: cA,
          aplicacaoA: aA,
          taxaA: jA,
          capitalB: cB,
          aplicacaoB: aB,
          taxaB: jB,
          meses: meses,
        ),
      ),
    );
  }

  @override
  void dispose() {
    capitalA.dispose();
    aplicacaoA.dispose();
    taxaA.dispose();
    capitalB.dispose();
    aplicacaoB.dispose();
    taxaB.dispose();
    periodo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simulador de Investimentos'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 650),
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const Text(
                'Compare dois investimentos',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Informe os valores para comparar os rendimentos.',
              ),
              const SizedBox(height: 20),

              // Campos do investimento A.
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Investimento A',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      const SizedBox(height: 10),
                      campo('Capital inicial (R\$)', capitalA),
                      campo('Aplicação mensal (R\$)', aplicacaoA),
                      campo('Juros mensais (%)', taxaA),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Campos do investimento B.
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Investimento B',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      const SizedBox(height: 10),
                      campo('Capital inicial (R\$)', capitalB),
                      campo('Aplicação mensal (R\$)', aplicacaoB),
                      campo('Juros mensais (%)', taxaB),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),
              campo('Período em meses', periodo),
              const SizedBox(height: 20),

              // Botão para calcular e comparar.
              ElevatedButton.icon(
                onPressed: calcular,
                icon: const Icon(Icons.bar_chart),
                label: const Text('Comparar investimentos'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(17),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Tela de resultados com os cálculos e a evolução mensal.
class TelaResultados extends StatefulWidget {
  final double capitalA;
  final double aplicacaoA;
  final double taxaA;
  final double capitalB;
  final double aplicacaoB;
  final double taxaB;
  final int meses;

  const TelaResultados({
    super.key,
    required this.capitalA,
    required this.aplicacaoA,
    required this.taxaA,
    required this.capitalB,
    required this.aplicacaoB,
    required this.taxaB,
    required this.meses,
  });

  @override
  State<TelaResultados> createState() =>
      _TelaResultadosState();
}

class _TelaResultadosState extends State<TelaResultados> {
  // Formata os valores para exibição em reais.
  String dinheiro(double valor) {
    return 'R\$ ${valor.toStringAsFixed(2).replaceAll('.', ',')}';
  }

  // Calcula o saldo acumulado de cada mês.
  List<Map<String, double>> gerarEvolucao() {
    double saldoA = widget.capitalA;
    double saldoB = widget.capitalB;

    final lista = <Map<String, double>>[];

    for (int mes = 1; mes <= widget.meses; mes++) {
      saldoA =
          saldoA * (1 + widget.taxaA / 100) + widget.aplicacaoA;

      saldoB =
          saldoB * (1 + widget.taxaB / 100) + widget.aplicacaoB;

      lista.add({
        'mes': mes.toDouble(),
        'A': saldoA,
        'B': saldoB,
      });
    }

    return lista;
  }

  // Estado que guarda a evolução e permite atualizar com setState.
  late List<Map<String, double>> evolucao = gerarEvolucao();

  // Cria um cartão de resumo reutilizável.
  Widget resumo(
    String titulo,
    double montante,
    double totalAplicado,
    double rendimento,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titulo,
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 12),
            const Text('Montante final'),
            Text(
              dinheiro(montante),
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text('Total aplicado'),
            Text(dinheiro(totalAplicado)),
            const SizedBox(height: 10),
            const Text('Rendimento total'),
            Text(
              dinheiro(rendimento),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final saldoA = evolucao.isEmpty
        ? widget.capitalA
        : evolucao.last['A']!;

    final saldoB = evolucao.isEmpty
        ? widget.capitalB
        : evolucao.last['B']!;

    final totalA =
        widget.capitalA + widget.aplicacaoA * widget.meses;

    final totalB =
        widget.capitalB + widget.aplicacaoB * widget.meses;

    final rendimentoA = saldoA - totalA;
    final rendimentoB = saldoB - totalB;

    final vencedor = saldoA > saldoB
        ? 'O investimento A terminou com o maior montante.'
        : saldoB > saldoA
            ? 'O investimento B terminou com o maior montante.'
            : 'Os dois investimentos terminaram empatados.';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultados da comparação'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Resumo dos investimentos',
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),

          resumo(
            'Investimento A',
            saldoA,
            totalA,
            rendimentoA,
          ),

          resumo(
            'Investimento B',
            saldoB,
            totalB,
            rendimentoB,
          ),

          Card(
            color: Colors.deepPurple.shade50,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                vencedor,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          const Text(
            'Evolução mensal comparativa',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Saldo acumulado ao final de cada mês:',
          ),

          const SizedBox(height: 8),

          // Lista comparativa com barras da mesma cor.
          ...evolucao.map((item) {
            final valorA = item['A']!;
            final valorB = item['B']!;

            final maior = [
              valorA,
              valorB,
              1.0,
            ].reduce((a, b) => a > b ? a : b);

            return Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mês ${item['mes']!.toInt()}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('Investimento A: ${dinheiro(valorA)}'),
                    const SizedBox(height: 5),
                    LinearProgressIndicator(
                      value: (valorA / maior).clamp(0.0, 1.0),
                      color: Colors.deepPurple,
                      backgroundColor: Colors.deepPurple.shade100,
                      minHeight: 9,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    const SizedBox(height: 12),
                    Text('Investimento B: ${dinheiro(valorB)}'),
                    const SizedBox(height: 5),
                    LinearProgressIndicator(
                      value: (valorB / maior).clamp(0.0, 1.0),
                      color: Colors.deepPurple,
                      backgroundColor: Colors.deepPurple.shade100,
                      minHeight: 9,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ],
                ),
              ),
            );
          }),

          const SizedBox(height: 16),

          // Atualiza a lista usando setState.
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                evolucao = gerarEvolucao();
              });
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Atualizar resultados'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.all(15),
            ),
          ),

          // Retorna ao formulário para uma nova simulação.
          OutlinedButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back),
            label: const Text('Voltar e simular novamente'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.deepPurple,
            ),
          ),
        ],
      ),
    );
  }
}
