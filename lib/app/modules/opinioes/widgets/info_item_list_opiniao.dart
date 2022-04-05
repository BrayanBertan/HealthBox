import 'package:flutter/material.dart';

class InfoItemListOpiniao extends StatelessWidget {
  const InfoItemListOpiniao({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc eros justo, viverra quis nunc eget, laoreet volutpat nulla.',
            maxLines: 1,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
              'Morbi fermentum ipsum a eros consectetur ultricies. Maecenas scelerisque ut tortor ut maximus. Nullam vulputate, risus non semper malesuada, quam nunc sollicitudin mi, eget dignissim lectus quam sit amet sapien. Aenean volutpat lectus ac ex hendrerit, sit amet efficitur tortor molestie. Curabitur enim risus, venenatis a diam non, gravida fringilla orci. Proin ac hendrerit purus. Mauris id magna eu tellus sodales faucibus. Aenean vitae orci eu tortor lobortis tristique.',
              maxLines: 3,
              overflow: TextOverflow.ellipsis),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
