class ProductCategory {
  static List<String> categoryList = [
    'Accessories',
    'Cosmetics',
    'Jewelry',
    'Shoes',
    'Electronics',
    'Dress',
    'Watches',
  ];

  static Map<String, dynamic> categoryToId = {
    'Accessories': '1',
    'Cosmetics': '2',
    'Jewelry': '3',
    'Shoes': '4',
    'Electronics': '5',
    'Dress': '6',
    'Watches': '7',
  };

  static Map<String, dynamic> idToCategory = {
    '1': 'Accessories',
    '2': 'Cosmetics',
    '3': 'Jewelry',
    '4': 'Shoes',
    '5': 'Electronics',
    '6': 'Dress',
    '7': 'Watches',
  };
}
