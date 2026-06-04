import 'package:flutter/material.dart';

class RevisionScreen extends StatefulWidget {
  const RevisionScreen({super.key});

  @override
  State<RevisionScreen> createState() => _RevisionScreenState();
}

class _RevisionScreenState extends State<RevisionScreen> {
  int selectedTable = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Révision')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            DropdownButtonFormField<int>(
              value: selectedTable,
              decoration: const InputDecoration(
                labelText: 'Choisir une table',
                border: OutlineInputBorder(),
              ),
              items: List.generate(10, (index) {
                final table = index + 1;

                return DropdownMenuItem(
                  value: table,
                  child: Text('Table de $table'),
                );
              }),
              onChanged: (value) {
                if (value == null) return;

                setState(() {
                  selectedTable = value;
                });
              },
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  final multiplier = index + 1;
                  final result = selectedTable * multiplier;

                  return Card(
                    child: ListTile(
                      title: Text(
                        '$selectedTable × $multiplier = $result',
                        style: const TextStyle(fontSize: 22),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
