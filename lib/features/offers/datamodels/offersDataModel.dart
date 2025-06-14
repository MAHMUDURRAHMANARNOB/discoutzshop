class Offer {
  final int id;
  final String badge;
  final String name;
  final String slug;
  final String image;
  final String? price;
  final String? offerPrice;
  final String shortDescription;
  final String url;
  final String? sourceUrl;
  final String? couponCode;
  final String startDate;
  final String expiryDate;
  final String status;
  final String categoryName;
  final String brandName;
  final List<String> areas;

  Offer({
    required this.id,
    required this.badge,
    required this.name,
    required this.slug,
    required this.image,
    this.price,
    this.offerPrice,
    required this.shortDescription,
    required this.url,
    this.sourceUrl,
    this.couponCode,
    required this.startDate,
    required this.expiryDate,
    required this.status,
    required this.categoryName,
    required this.brandName,
    required this.areas,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      id: json['id'],
      badge: json['badge'],
      name: json['name'],
      slug: json['slug'],
      image: json['image'],
      price: json['price']?.toString(),
      offerPrice: json['offer_price']?.toString(),
      shortDescription: json['short_description'],
      url: json['url'],
      sourceUrl: json['source_url'],
      couponCode: json['coupon_code'],
      startDate: json['start_date'],
      expiryDate: json['expiry_date'],
      status: json['status'],
      categoryName: json['category_name'],
      brandName: json['brand_name'],
      areas: List<String>.from(json['areas']),
    );
  }
}