import 'package:flutter/material.dart';
import 'database/db_helper.dart';
import 'model/tamu.dart';


class FormTamu extends StatefulWidget {
  final Tamu? tamu;

  FormTamu({this.tamu});

  @override
  _FormTamuState createState() => _FormTamuState();


}

class _FormTamuState extends State<FormTamu> {
  DbHelper db = DbHelper();

  TextEditingController? nama;
  TextEditingController? telepon;
  TextEditingController? alamat;
  TextEditingController? pesan;

  @override
  void initState() {
    nama = TextEditingController(
        text: widget.tamu == null ? '' : widget.tamu!.nama);

    telepon = TextEditingController(
        text: widget.tamu == null ? '' : widget.tamu!.telepon);

    alamat = TextEditingController(
        text: widget.tamu == null ? '' : widget.tamu!.alamat);

    pesan = TextEditingController(
        text: widget.tamu == null ? '' : widget.tamu!.pesan);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Tamu',
        style: TextStyle(color: Colors.deepPurple,
            fontSize: 20,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.deepPurple,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: nama,
              decoration: InputDecoration(
                  labelText: 'Nama',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )
              ),
              cursorColor: Colors.deepPurple,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: telepon,
              decoration: InputDecoration(
                  labelText: 'Telepon',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
              cursorColor: Colors.deepPurple,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: alamat,
              decoration: InputDecoration(
                  labelText: 'Alamat',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
              cursorColor: Colors.deepPurple,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: pesan,
              decoration: InputDecoration(
                  labelText: 'Pesan',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
              ),
              cursorColor: Colors.deepPurple,
              maxLines: 5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 32
            ),
            child: ElevatedButton(
              child:
              (widget.tamu == null)
                  ? Text(
                'Tambah',
                style: TextStyle(color: Colors.white),
              )
                  : Text(
                'Perbaharui',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                upsertTamu();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple,
                fixedSize: const Size(40, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50))),
            ),
          )
        ],
      ),
    );
  }

  Future<void> upsertTamu() async {
    if (widget.tamu != null) {
      await db.updateTamu(Tamu.fromMap({
        'id' : widget.tamu!.id,
        'nama' : nama!.text,
        'telepon' : telepon!.text,
        'alamat' : alamat!.text,
        'pesan' : pesan!.text
      }));
      Navigator.pop(context, 'update');
    } else {
      await db.saveTamu(Tamu(
        nama: nama!.text,
        telepon: telepon!.text,
        alamat: alamat!.text,
        pesan: pesan!.text,
      ));
      Navigator.pop(context, 'simpan');
    }
  }
}