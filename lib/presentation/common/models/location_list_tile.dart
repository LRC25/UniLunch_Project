import 'package:flutter/material.dart';

class LocationListTile extends StatelessWidget {
  const LocationListTile({
    Key? key,
    required this.location,
    required this.press,
  }) : super(key: key);

  final String location;
  final VoidCallback press;

  @override Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.6,
      child: ListTile(
        onTap: press,
        horizontalTitleGap: 0,
        leading: Icon(
          Icons.location_pin,
          color: Color(0xFF064244),
        ),
        title: Text(
          location,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        )
      )
    );
  }
}
