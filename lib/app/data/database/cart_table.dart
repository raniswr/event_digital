// ignore_for_file: constant_identifier_names

import 'package:event_digital/app/data/model/model_detail.dart';
import 'package:sqflite/sqflite.dart';

class CartTable {
  late Database _database;

  CartTable(Database database) {
    _database = database;
  }

  static const _TB_CART = "cart_table";
  static const COL_ID = "id";
  // static const COL_USER_ID = "userId";
  static const COL_TITLE = "title";
  static const COL_SUBNAME = "subname";
  static const COL_PRICE = "price";
  static const COL_IMAGE_URL = "imageUrl";
  static const COL_CHECKED = "checked";

  static const QUERY_CREATE_TABLE = """
        CREATE TABLE IF NOT EXISTS $_TB_CART(
          $COL_ID INTEGER NOT NULL PRIMARY KEY,
          $COL_TITLE TEXT, 
          $COL_SUBNAME TEXT, 
          $COL_IMAGE_URL TEXT, 
          $COL_PRICE INTEGER NOT NULL,
          $COL_CHECKED INTEGER NOT NULL
        )""";

  static const QUERY_DROP_TABLE = """
    DROP TABLE IF EXISTS $_TB_CART
  """;

  Future<void> createTable() async {
    await _database.execute(QUERY_CREATE_TABLE);
  }

  Future<int> insertCart(ModelDetail data) async {
    return await _database.insert(_TB_CART, data.toSqlite());
  }

  Future<List<ModelDetail>> getAllCart() async {
    // String? userId = UserService.find.user?.id;
    try {
      var result = await _database.rawQuery('''
        SELECT * FROM $_TB_CART
        ''');
      return result.map((e) => ModelDetail.fromSqlite(e)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<ModelDetail?> getCartById(String id) async {
    // String? userId = UserService.find.user?.id;
    try {
      var result = await _database.rawQuery('''
        SELECT * FROM $_TB_CART
        WHERE  $COL_ID = ?
        ''', [id]);
      var list = result.map((e) => ModelDetail.fromSqlite(e)).toList();
      return list.first;
    } catch (e) {
      return null;
    }
  }

  Future<List<ModelDetail>> getCheckedCart() async {
    try {
      var result = await _database.rawQuery('''
      SELECT * FROM $_TB_CART
      WHERE $COL_CHECKED = 1
    ''');
      return result.map((e) => ModelDetail.fromSqlite(e)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<int> countCart() async {
    try {
      return Sqflite.firstIntValue(await _database.rawQuery('SELECT COUNT(*) FROM $_TB_CART')) ?? 0;
    } catch (e) {
      return 0;
    }
  }

  Future<int> updateCheckedProduct(String id, int check) async {
    // String? userId = UserService.find.user?.id;
    return await _database.rawUpdate('''
      UPDATE $_TB_CART
      SET $COL_CHECKED = ?
      WHERE $COL_ID = ? 
    ''', [check, id]);
  }

  Future<int> updateCheckedAllProduct(int check) async {
    // String? userId = UserService.find.user?.id;

    return await _database.rawUpdate('''
      UPDATE $_TB_CART
      SET $COL_CHECKED = ?
    ''', [check]);
  }

  Future<int> deleteCartProduct() async {
    return await _database.rawDelete('''
      DELETE FROM $_TB_CART
      WHERE $COL_CHECKED = 1 
    ''');
  }
}
