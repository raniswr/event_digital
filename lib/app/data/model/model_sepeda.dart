class ModelSepeda {
  DataSepeda? data;

  ModelSepeda({this.data});

  ModelSepeda.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new DataSepeda.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DataSepeda {
  int? kodeSepeda;
  String? nama;
  String? merk;
  String? jenisSepeda;
  String? peruntukan;
  int? jumlahSpeed;
  String? tanggalLaunching;

  DataSepeda({this.kodeSepeda, this.nama, this.merk, this.jenisSepeda, this.peruntukan, this.jumlahSpeed, this.tanggalLaunching});

  DataSepeda.fromJson(Map<String, dynamic> json) {
    kodeSepeda = json['kode_sepeda'];
    nama = json['nama'];
    merk = json['merk'];
    jenisSepeda = json['jenis_sepeda'];
    peruntukan = json['peruntukan'];
    jumlahSpeed = json['jumlah_speed'];
    tanggalLaunching = json['tanggal_launching'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kode_sepeda'] = this.kodeSepeda;
    data['nama'] = this.nama;
    data['merk'] = this.merk;
    data['jenis_sepeda'] = this.jenisSepeda;
    data['peruntukan'] = this.peruntukan;
    data['jumlah_speed'] = this.jumlahSpeed;
    data['tanggal_launching'] = this.tanggalLaunching;
    return data;
  }
}
