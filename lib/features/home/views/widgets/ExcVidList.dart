import 'package:flutter/material.dart';
import 'package:save_knee_23/constants.dart';
import 'package:url_launcher/url_launcher.dart';

import 'fetch_subnails.dart';

class ExcVidList extends StatelessWidget {
  const ExcVidList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: urlList.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            Uri url = Uri.parse(urlList[index]);
            launchUrl(url);
          },
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ColorFiltered(
                    colorFilter:
                        const ColorFilter.mode(Colors.white70, BlendMode.hue),
                    child: Image.network(
                      getYoutubeThumbnail(urlList[index]),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  const Icon(
                    Icons.play_circle_outline_sharp,
                    color: Color.fromRGBO(255, 255, 255, 30),
                    size: 30,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
