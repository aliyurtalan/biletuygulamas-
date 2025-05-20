import 'package:flutter/material.dart';

void main() {
  runApp(MiniObiletApp());
}

class MiniObiletApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Obilet',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: 'Inter',
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontFamily: 'Inter'),
          displaySmall: TextStyle(fontFamily: 'Inter'),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(fontSize: 18, fontFamily: 'Inter'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: const TextStyle(color: Colors.grey),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.indigo),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      home: AnaSayfa(),
    );
  }
}

class AnaSayfa extends StatefulWidget {
  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  String? nereden;
  String? nereye;
  DateTime? secilenTarih;

  List<String> sehirler = [
    'İstanbul',
    'Ankara',
    'İzmir',
    'Bursa',
    'Antalya',
    'Erbaa',
  ];

  void tarihSec(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.indigo,
            colorScheme: const ColorScheme.light(primary: Colors.indigo),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        secilenTarih = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mini Obilet - Sefer Ara',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.indigo,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Nereden DropdownButtonFormField
            DropdownButtonFormField<String>(
              value: nereden,
              decoration: const InputDecoration(
                labelText: 'Nereden',
                prefixIcon: Icon(Icons.location_on),
              ),
              items: sehirler.map((sehir) {
                return DropdownMenuItem(
                  value: sehir,
                  child: Text(sehir),
                );
              }).toList(),
              onChanged: (String? value) {
                if (value != null) { // Null kontrolü eklendi
                  setState(() {
                    nereden = value;
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            // Nereye DropdownButtonFormField
            DropdownButtonFormField<String>(
              value: nereye,
              decoration: const InputDecoration(
                labelText: 'Nereye',
                prefixIcon: Icon(Icons.flag),
              ),
              items: sehirler.map((sehir) {
                return DropdownMenuItem(
                  value: sehir,
                  child: Text(sehir),
                );
              }).toList(),
              onChanged: (String? value) {
                if (value != null) { // Null kontrolü eklendi
                  setState(() {
                    nereye = value;
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            // Tarih Seçimi ListTile
            ListTile(
              title: Text(secilenTarih == null
                  ? 'Tarih Seç'
                  : 'Seçilen Tarih: ${secilenTarih!.day}.${secilenTarih!.month}.${secilenTarih!.year}'),
              trailing: const Icon(Icons.calendar_today,
                  color: Colors.indigo),
              onTap: () {
                tarihSec(context);
              },
            ),
            const SizedBox(height: 24),
            // Sefer Ara ElevatedButton
            ElevatedButton(
              onPressed: (nereden != null && nereye != null && secilenTarih != null)
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => KoltukSecimSayfasi(
                            nereden: nereden!,
                            nereye: nereye!,
                            tarih: secilenTarih!,
                          ),
                        ),
                      );
                    }
                  : null,
              child: const Text('Sefer Ara'),
            ),
          ],
        ),
      ),
    );
  }
}

class KoltukSecimSayfasi extends StatefulWidget {
  final String nereden;
  final String nereye;
  final DateTime tarih;

  KoltukSecimSayfasi(
      {required this.nereden, required this.nereye, required this.tarih});

  @override
  _KoltukSecimSayfasiState createState() => _KoltukSecimSayfasiState();
}

class _KoltukSecimSayfasiState extends State<KoltukSecimSayfasi> {
  List<bool> secilenKoltuklar = List.generate(30, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Koltuk Seçimi',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.indigo,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nereden: ${widget.nereden}',
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w500)),
            Text('Nereye: ${widget.nereye}',
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w500)),
            Text(
                'Tarih: ${widget.tarih.day}.${widget.tarih.month}.${widget.tarih.year}',
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w500)),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: secilenKoltuklar.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        secilenKoltuklar[index] = !secilenKoltuklar[index];
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: secilenKoltuklar[index]
                            ? Colors.green
                            : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          if (secilenKoltuklar[index])
                            BoxShadow(
                              color: Colors.green.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          (index + 1).toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: secilenKoltuklar.contains(true)
                  ? () {
                      // Seçilen koltuk numaralarını bir liste olarak al
                      List<int> secilenKoltukNumaralari = [];
                      for (int i = 0; i < secilenKoltuklar.length; i++) {
                        if (secilenKoltuklar[i]) {
                          secilenKoltukNumaralari.add(i);
                        }
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BiletOlusturmaSayfasi(
                            nereden: widget.nereden,
                            nereye: widget.nereye,
                            tarih: widget.tarih,
                            secilenKoltuklar: secilenKoltukNumaralari,
                          ),
                        ),
                      );
                    }
                  : null,
              child: const Text('Bileti Onayla'),
            ),
          ],
        ),
      ),
    );
  }
}

class BiletOlusturmaSayfasi extends StatelessWidget {
  final String nereden;
  final String nereye;
  final DateTime tarih;
  final List<int> secilenKoltuklar;

  BiletOlusturmaSayfasi(
      {required this.nereden,
      required this.nereye,
      required this.tarih,
      required this.secilenKoltuklar});

  @override
  Widget build(BuildContext context) {
    // Koltuk numaralarını string'e çevir
    String koltukNumaralariString = "";
    for (int i = 0; i < secilenKoltuklar.length; i++) {
      koltukNumaralariString += (secilenKoltuklar[i] + 1).toString(); // 1 ekleyerek koltuk numarasını düzeltiyoruz.
      if (i < secilenKoltuklar.length - 1) {
        koltukNumaralariString += ", "; // Virgül ve boşluk ekle
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bilet Oluşturma',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.indigo,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nereden: $nereden',
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w500)),
            Text('Nereye: $nereye',
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w500)),
            Text('Tarih: ${tarih.day}.${tarih.month}.${tarih.year}',
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w500)),
            Text(
                'Seçilen Koltuklar: $koltukNumaralariString',
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w500)),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Bilet Oluşturuldu',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    content: const Text(
                        'Seçilen sefer için biletiniz oluşturulmuştur.',
                        style: TextStyle(fontSize: 16)),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                        child: const Text('Tamam',
                            style: TextStyle(fontSize: 16)),
                      ),
                    ],
                  ),
                );
              },
              child: const Text('Bileti Onayla'),
            ),
          ],
        ),
      ),
    );
  }
}
