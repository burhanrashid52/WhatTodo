import 'package:flutter/material.dart';
import 'package:flutter_app/pages/places/places_models.dart';

class PlaceWidget extends StatelessWidget {
  PlaceWidget(this.candidates);

  final List<Results> candidates;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: candidates.length,
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        var item = candidates[index];
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.red,
              child: Text("P"),
            ),
            title: Text(item.name),
            subtitle: Text(item.formatted_address),
          ),
        );
      },
    );
  }
}
