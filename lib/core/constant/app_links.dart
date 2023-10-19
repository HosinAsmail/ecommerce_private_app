class AppLinks {
  static const String serverLink =
      'https://housinasmail.000webhostapp.com/ecommerce/admin';
  // ================================= Home ================================= //
  static const String homeLink = '$serverLink/home.php';
  // ================================= Categories ================================= //
  static const String categoriesLink = '$serverLink/categories';
  static const String viewCategoriesLink = '$categoriesLink/view.php';
  static const String addCategoriesLink = '$categoriesLink/add.php';
  static const String deleteCategoriesLink = '$categoriesLink/delete.php';
  static const String editCategoriesLink = '$categoriesLink/edit.php';
  // ================================= Products ================================= //
  static const String productsLink = '$serverLink/products';
  static const String viewProductsLink = '$productsLink/view.php';
  static const String addProductsLink = '$productsLink/add.php';
  static const String deleteProductsLink = '$productsLink/delete.php';
  static const String editProductsLink = '$productsLink/edit.php';
  // ================================= Ads ================================= //
  static const String adsLink = '$serverLink/ads';
  static const String viewAdsLink = '$adsLink/view.php';
  static const String addAdsLink = '$adsLink/add.php';
  static const String deleteAdsLink = '$adsLink/delete.php';
  static const String editAdsLink = '$adsLink/edit.php';

  // ================================= Images ================================= //
  static const String imageLink =
      'https://housinasmail.000webhostapp.com/ecommerce/upload';
  static const String imageCategoriesLink = '$imageLink/categories';
  static const String imageProductsLink = '$imageLink/products';

  // ================================= Favorite ================================= //
  static const String favoriteLink = '$serverLink/favorite';
  static const String addFavoriteLink = '$favoriteLink/add.php';
  static const String deleteFavoriteLink = '$favoriteLink/delete.php';
  static const String viewFavoriteLink = '$favoriteLink/view.php';

  // ================================= Cart ================================= //
  static const String cartLink = '$serverLink/cart';
  static const String addCartLink = '$cartLink/add.php';
  static const String deleteCartLink = '$cartLink/delete.php';
  static const String viewCartLink = '$cartLink/view.php';

  // ================================= Address ================================= //
  static const String addressLink = '$serverLink/address';
  static const String addAddressLink = '$addressLink/add.php';
  static const String deleteAddressLink = '$addressLink/delete.php';
  static const String viewAddressLink = '$addressLink/view.php';
  static const String editAddressLink = '$addressLink/edit.php';
  // ================================= Order ================================= //
  static const String orderLink = '$serverLink/order';
  static const String placeOrderLink = '$orderLink/place_order.php';
  static const String pendingOrderLink = '$orderLink/pending_order.php';
  static const String detailsOrderLink = '$orderLink/order_details.php';
  static const String deleteOrderLink = '$orderLink/delete_order.php';
  static const String archiveOrderLink = '$orderLink/archive_order.php';
}
