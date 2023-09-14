import 'package:flutter/material.dart';
import 'models/event_model.dart';

class EventDetailPage extends StatelessWidget {
  final Event event;

  EventDetailPage({required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(event.name)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FittedBox(child:Text('Event: ${event.description}'), fit:BoxFit.scaleDown),
          Image.network(event.imageUrl, fit:BoxFit.scaleDown),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Date: ${event.eventDateTime}'),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Currency: ${event.priceCurrency}'),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Ticket Price Range: ${event.ticketPriceRange}'),
          ),
        ],
      ),
    );
  }
}
