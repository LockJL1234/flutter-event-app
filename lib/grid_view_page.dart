import 'package:flutter/material.dart';
import 'api/api_service.dart';
import 'models/event_model.dart';
import 'event_detail_page.dart';
import 'package:cached_network_image/cached_network_image.dart';



class GridViewPage extends StatefulWidget {
  @override
  _GridViewPageState createState() => _GridViewPageState();
}

class _GridViewPageState extends State<GridViewPage> {
  final ApiService _apiService = ApiService();
  late Future<List<Event>> _events;

  @override
  void initState() {
    super.initState();

    _events = _apiService.fetchEvents().then((data) => data.map((eventData) => Event(
          name: eventData['name'],
          title: eventData['_embedded']['venues'][0]["country"]["name"],
          imageUrl: eventData['images'][0]['url'],
          description: eventData['classifications'][0]["segment"]["name"],
          eventDateTime: eventData['dates']["start"]["localDate"] + " " + eventData['dates']["start"]["localTime"],
          priceCurrency: eventData.containsKey('priceRanges') ? eventData['priceRanges'][0]["currency"] : "", 
          ticketPriceRange: eventData.containsKey('priceRanges') ? (eventData['priceRanges'][0]["min"].toString() + " - " + eventData['priceRanges'][0]["max"].toString()) : "",
        )).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Events')),
      body: FutureBuilder<List<Event>>(
        future: _events,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print('Error: ${snapshot.error}');
            return Center(child: Text('Error fetching data'));
          } else {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, crossAxisSpacing: 10),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final event = snapshot.data![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EventDetailPage(event: event),
                      ),
                    );
                  },
                  child: GridTile(
                    child: CachedNetworkImage(imageUrl: event.imageUrl),
                    footer: GridTileBar(
                      backgroundColor: Colors.black54,
                      title: Text(event.name),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
