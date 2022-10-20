import 'package:flutter/material.dart';
import 'formtamu.dart';
import 'database/db_helper.dart';
import 'model/tamu.dart';


class ListTamuPage extends StatefulWidget {
  const ListTamuPage({ Key? key }) : super(key: key);

  @override
  _ListTamuPageState createState() => _ListTamuPageState();
}

class _ListTamuPageState extends State<ListTamuPage> {
  List<Tamu> listTamu = [];
  DbHelper db = DbHelper();

  @override
  void initState() {
    _getAllTamu();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
       centerTitle: true,
        title: Text("Data Tamu"),
        titleTextStyle: TextStyle(color: Colors.deepPurple,
            fontSize: 24,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
          itemCount: listTamu.length,
          itemBuilder: (context, index) {
            Tamu tamu = listTamu[index];
            return Padding(
              padding: const EdgeInsets.only(
                  top: 20
              ),
              child: ListTile(
                shape: BeveledRectangleBorder(
                  side: BorderSide(width: 0.5, color: Colors.deepPurple)
                ),
                leading: Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.deepPurple,
                ),
                title: Text(
                    '${tamu.nama}',
                  style: TextStyle(
                      color: Colors.deepPurple,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                ),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("Telepon: ${tamu.telepon}",
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'poppins')),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("Alamat: ${tamu.alamat}",
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'poppins')),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("Pesan: ${tamu.pesan}",
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'poppins')),
                    )
                  ],
                ),
                trailing:
                FittedBox(
                  fit: BoxFit.fill,
                  child: Row(
                    children: [
                      // button edit
                      IconButton(
                          onPressed: () {
                            _openFormEdit(tamu);
                          },
                          icon: Icon(Icons.edit),
                        color: Colors.deepPurple,
                      ),
                      // button hapus
                      IconButton(
                        icon: Icon(Icons.delete),
                        color: Colors.deepPurple,
                        onPressed: (){
                          //membuat dialog konfirmasi hapus
                          AlertDialog hapus = AlertDialog(
                            title: Text("Informasi"),
                            content: Container(
                              height: 100,
                              child: Column(
                                children: [
                                  Text(
                                      "Yakin ingin menghapus data ${tamu.nama}"
                                  )
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: (){
                                    _deleteTamu(tamu, index);
                                    Navigator.pop(context);
                                  },
                                  child: Text("Ya",
                                  style: TextStyle(color: Colors.deepPurple),),
                              ),
                              TextButton(
                                child: Text('Tidak',
                                style: TextStyle(color: Colors.deepPurple),),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                          showDialog(context: context, builder: (context) => hapus);
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
      //membuat button mengapung di bagian bawah kanan layar

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_circle_outline_sharp), backgroundColor: Colors.deepPurple,
        onPressed: (){
          _openFormCreate();
        },
      ),


    );
  }

  Future<void> _getAllTamu() async {
    //list menampung data dari database
    var list = await db.getAllTamu();

    //ada perubahanan state
    setState(() {
      //hapus data pada listKontak
      listTamu.clear();

      //lakukan perulangan pada variabel list
      list!.forEach((tamu) {

        //masukan data ke listKontak
        listTamu.add(Tamu.fromMap(tamu));
      });
    });
  }

  Future<void> _deleteTamu(Tamu tamu, int position) async {
    await db.deleteTamu(tamu.id!);
    setState(() {
      listTamu.removeAt(position);
    });
  }

  // membuka halaman tambah Kontak
  Future<void> _openFormCreate() async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => FormTamu()));
    if (result == 'save') {
      await _getAllTamu();
    }
  }

  //membuka halaman edit Kontak
  Future<void> _openFormEdit(Tamu tamu) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => FormTamu(tamu: tamu,)));
    if (result == 'update') {
      await _getAllTamu();
    }
  }
}