import 'package:flutter/material.dart';

class BiletOlusturmaSayfasi extends StatefulWidget {
  final String nereden;
  final String nereye;
  final DateTime tarih;
  final List<int> secilenKoltuklar;

  const BiletOlusturmaSayfasi({
    required this.nereden,
    required this.nereye,
    required this.tarih,
    required this.secilenKoltuklar,
    Key? key,
  }) : super(key: key);

  @override
  _BiletOlusturmaSayfasiState createState() => _BiletOlusturmaSayfasiState();
}

class _BiletOlusturmaSayfasiState extends State<BiletOlusturmaSayfasi> {
  final TextEditingController adController = TextEditingController();
  final TextEditingController soyadController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String tarihStr =
        "${widget.tarih.day}.${widget.tarih.month}.${widget.tarih.year}";

    return Scaffold(
      appBar: AppBar(
        title: Text("Bilet Oluştur"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text("Sefer Bilgileri", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text("Nereden: ${widget.nereden}"),
            Text("Nereye: ${widget.nereye}"),
            Text("Tarih: $tarihStr"),
            Text("Koltuklar: ${widget.secilenKoltuklar.map((k) => "K${k + 1}").join(', ')}"),
            SizedBox(height: 20),
            TextField(
              controller: adController,
              decoration: InputDecoration(labelText: "Ad"),
            ),
            SizedBox(height: 10),
            TextField(
              controller: soyadController,
              decoration: InputDecoration(labelText: "Soyad"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (adController.text.isEmpty || soyadController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Lütfen ad ve soyad girin.")),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Bilet Oluşturuldu"),
                      content: Text(
                        "${adController.text} ${soyadController.text} için bilet oluşturuldu.\n"
                        "Koltuklar: ${widget.secilenKoltuklar.map((k) => "K${k + 1}").join(', ')}",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
                          child: Text("Tamam"),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: Text("Bileti Oluştur"),
              style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 45)),
            ),
          ],
        ),
      ),
    );
  }
}

