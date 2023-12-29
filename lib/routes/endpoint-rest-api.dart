class Endpoint {
  // static const _url = 'http://172.23.208.1:3000';
  // static const _apiUrl = 'http://192.168.100.175:3000';
  // static const _apiUrl = 'http://3.87.155.252:8080';
  // static const _apiUrl = 'http://192.168.2.108:8080';
  static const _apiUrl = 'http://103.31.38.105:9095';
  static const $httpHeader = {"Content-Type" : "application/json"};

  static const apiCustomer = '$_apiUrl/customers';
  static const apiProduct = '$_apiUrl/products';
  static const apiOrder= '$_apiUrl/orders';
}

abstract class Services<T> {
  Future<void> create(T t) async {}

  Future<List<T>?> read() async {
    return [];
  }

  Future<void> update(T t) async {}

  Future<void> remove(String id) async {}
}
