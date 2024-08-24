import 'package:flutter/material.dart';
import '../models/wishlist_product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _wishlist = [
    Product(name: '이츠굿텐 남녀공용 여행용 배낭 방수 크로스백 메신저백', price: '24,900원', imageUrl: 'https://image7.coupangcdn.com/image/vendor_inventory/0efa/a06441eb8f831c8936daceb93101fb02ff58a3382deafdb2a3c0526ef20e.jpg', isRocketShipping: true),
    Product(name: '코멧 특대형 일회용 마스크 XL, 100매, 블랙, 1개', price: '9,990원', imageUrl: 'https://image8.coupangcdn.com/image/retail/images/13267445609757000-60cb0f1e-1e4d-42cc-b2d0-53430ff6c1f6.jpg', isRocketShipping: true),
    Product(name: '브레빌 바리스타 익스프레스 임프레스 커피머신', price: '1,210,000원', imageUrl: 'https://image10.coupangcdn.com/image/retail/images/2024/02/07/15/2/b9856ee4-d306-450b-8730-d5040fb56844.jpg', isRocketShipping: true),
    Product(name: 'Apple 2023 맥북 프로 14 M3', price: '2,557,680원', imageUrl: 'https://image9.coupangcdn.com/image/retail/images/2119768668797193-b109eb1a-fd30-4420-850f-04faf0aea2f9.jpg', isRocketShipping: true),
    Product(name: '운동기구 아령 0.5kg 1kg 1.5kg 2kg 3kg 덤벨 2개1세트', price: '14,300원', imageUrl: 'https://image6.coupangcdn.com/image/vendor_inventory/images/2016/07/06/15/9/dce7e557-9276-4a45-9f00-37b97dfc203f.jpg', isRocketShipping: false),
    Product(name: '자이스 렌즈 와이프 클리너', price: '14,820원', imageUrl: 'https://image9.coupangcdn.com/image/retail/images/2606949545276165-43e7b62b-9a60-40fd-a4ae-fc5dc6d3b5d5.jpg', isRocketShipping: true),
    Product(name: '룩트 유기농귀리 그래놀라 25g', price: '2,200원', imageUrl: 'https://image7.coupangcdn.com/image/vendor_inventory/c8f5/bd8bbfe8548a239c8abfaecb2dc9d992d4cf1cebfd65ab6b7738198cfe37.jpg', isRocketShipping: false),
    Product(name: '어반룩북 스퀘어넥 반팔 시원 니트', price: '15,120원', imageUrl: 'https://image8.coupangcdn.com/image/vendor_inventory/78bf/c8ea4ade8569eacdc675c9d4be4f6bcce677b65b0aa3bcc605a3861f4be0.jpg', isRocketShipping: true),
    Product(name: '지나송 로망 아일렛 봉포함 이중 암막커튼 세트', price: '86,400원', imageUrl: 'https://image7.coupangcdn.com/image/retail/images/3912072982258902-2bd2e912-9975-4df8-99f7-ecd5b1743e3f.jpg', isRocketShipping: true),
    Product(name: '아크네스 모이스처 플루이드, 150ml, 1개', price: '8,500원', imageUrl: 'https://image8.coupangcdn.com/image/vendor_inventory/2be8/f204486f115d5d024767f7ae2018c0e81f66bb429bd1bf8d793802636b1e.jpg', isRocketShipping: false),
  ];

  Product? _selectedProduct;

  List<Product> get wishlist => _wishlist;

  Product? get selectedProduct => _selectedProduct;

  void selectProduct(Product product) {
    _selectedProduct = product;
    notifyListeners();
  }
}