import 'package:flutter/material.dart';

class KoltukSecimSayfasi extends StatefulWidget {
  @override
  _KoltukSecimSayfasiState createState() => _KoltukSecimSayfasiState();
}

class _KoltukSecimSayfasiState extends State<KoltukSecimSayfasi> {
  List<int> seciliKoltuklar = [];

  // Koltuk düzeni: 4 satır x 4 koltuk (örnek)
  final int satirSayisi = 4;
  final int koltukSayisi = 4;

  Widget _koltuk(int numara) {
    bool secili = seciliKoltuklar.contains(numara);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (secili) {
            seciliKoltuklar.remove(numara);
          } else {
            seciliKoltuklar.add(numara);
          }
        });
      },
      child: Container(
        margin: EdgeInsets.all(6),
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: secili ? Colors.green : Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black),
        ),
        child: Center(child: Text('$numara')),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> koltuklar = [];

    int koltukNumarasi = 1;
    for (int i = 0; i < satirSayisi; i++) {
      List<Widget> satir = [];
      for (int j = 0; j < koltukSayisi; j++) {
        satir.add(_koltuk(koltukNumarasi));
        koltukNumarasi++;
      }
      koltuklar.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: satir,
      ));
    }

    return Scaffold(
      appBar: AppBar(title: Text('Koltuk Seçimi')),
      body: Column(
        children: [
          SizedBox(height: 20),
          ...koltuklar,
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: seciliKoltuklar.isNotEmpty
                ? () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'Seçilen koltuklar: ${seciliKoltuklar.join(', ')}'),
                      ),
                    );
                  }
                : null,
            child: Text('Devam Et'),
          ),
        ],
      ),
    );
  }
}
