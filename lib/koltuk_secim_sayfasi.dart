import 'package:flutter/material.dart';

class KoltukSecimSayfasi extends StatefulWidget {
  const KoltukSecimSayfasi({Key? key}) : super(key: key);

  @override
  _KoltukSecimSayfasiState createState() => _KoltukSecimSayfasiState();
}

class _KoltukSecimSayfasiState extends State<KoltukSecimSayfasi> {
  List<bool> secilenKoltuklar = List.generate(30, (index) => false);
  List<int> doluKoltuklar = [3, 7, 12, 19]; // Örnek dolu koltuklar

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Koltuk Seçimi"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            _buildLegend(),
            SizedBox(height: 12),
            Expanded(
              child: GridView.builder(
                itemCount: secilenKoltuklar.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6, // Satır başına 6 koltuk
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  bool secili = secilenKoltuklar[index];
                  bool dolu = doluKoltuklar.contains(index);
                  Color renk = dolu
                      ? Colors.orange
                      : secili
                          ? Colors.green
                          : Colors.grey[300]!;

                  return GestureDetector(
                    onTap: dolu
                        ? null
                        : () {
                            setState(() {
                              secilenKoltuklar[index] = !secili;
                            });
                          },
                    child: Container(
                      decoration: BoxDecoration(
                        color: renk,
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 2,
                            offset: Offset(1, 1),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.event_seat, size: 20, color: Colors.black87),
                          SizedBox(height: 2),
                          Text(
                            "K${index + 1}",
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 12),
            ElevatedButton.icon(
              icon: Icon(Icons.check),
              onPressed: secilenKoltuklar.contains(true)
                  ? () {
                      final secilenler = secilenKoltuklar
                          .asMap()
                          .entries
                          .where((entry) => entry.value)
                          .map((entry) => "K${entry.key + 1}")
                          .join(", ");

                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Koltuk Onayı"),
                          content: Text("Seçilen Koltuklar: $secilenler"),
                          actions: [
                            TextButton(
                              child: Text("Tamam"),
                              onPressed: () => Navigator.pop(context),
                            )
                          ],
                        ),
                      );
                    }
                  : null,
              label: Text("Onayla"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 45),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _legendItem(Colors.grey[300]!, "Boş"),
        _legendItem(Colors.green, "Seçili"),
        _legendItem(Colors.orange, "Dolu"),
      ],
    );
  }

  Widget _legendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(3)),
        ),
        SizedBox(width: 4),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }
}
