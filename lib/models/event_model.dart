class Event {
  final String name;
  final String title;
  final String imageUrl;
  final String description;
  final String eventDateTime;
  final String priceCurrency;
  final String ticketPriceRange;

  Event({
    required this.name,
    required this.title, 
    required this.imageUrl, 
    required this.description,
    required this.eventDateTime,
    required this.priceCurrency,
    required this.ticketPriceRange,
    });
}
