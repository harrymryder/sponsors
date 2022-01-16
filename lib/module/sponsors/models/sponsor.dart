class Sponsor {
  const Sponsor({
    required this.id,
    required this.name,
    required this.logo,
    required this.images,
  });

  final int id;
  final String name;
  final String logo;
  final List images;

  List<Object> get props => [id, name, logo, images];
}
