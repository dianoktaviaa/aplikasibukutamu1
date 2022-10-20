class Tamu{
  int? id;
  String? nama;
  String? telepon;
  String? alamat;
  String? pesan;

  Tamu({this.id, this.nama, this.telepon, this.alamat, this.pesan});

  Map<String, dynamic> toMap(){
    var map = Map<String, dynamic>();

    if(id != null){
      map['id'] = id;
    }
    map['nama'] = nama;
    map['telepon'] = telepon;
    map['alamat'] = alamat;
    map['pesan'] = pesan;

    return map;
  }

  Tamu.fromMap(Map<String, dynamic> map){
    this.id = map['id'];
    this.nama = map['nama'];
    this.telepon = map['telepon'];
    this.alamat = map['alamat'];
    this.pesan = map['pesan'];
  }
}