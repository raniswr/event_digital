class ModelPesanan {
  DataPesanan? data;

  ModelPesanan({this.data});

  ModelPesanan.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new DataPesanan.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DataPesanan {
  String? usersPermissionsUser;
  List<String>? products;
  String? status;
  String? dueDate;
  String? endDate;
  String? notes;

  DataPesanan({this.usersPermissionsUser, this.products, this.status, this.dueDate, this.endDate, this.notes});

  DataPesanan.fromJson(Map<String, dynamic> json) {
    usersPermissionsUser = json['users_permissions_user'];
    products = json['products'].cast<String>();
    status = json['status'];
    dueDate = json['due_date'];
    endDate = json['end_date'];
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['users_permissions_user'] = this.usersPermissionsUser;
    data['products'] = this.products;
    data['status'] = this.status;
    data['due_date'] = this.dueDate;
    data['end_date'] = this.endDate;
    data['notes'] = this.notes;
    return data;
  }
}
