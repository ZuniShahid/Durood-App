import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:durood_app/constants/no_data_widget.dart';
import 'package:durood_app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/app_colors.dart';
import '../../generated/assets.dart';
import '../../models/eram_spirtual_video_model.dart';

class SpirtualVideoScreen extends StatefulWidget {
  const SpirtualVideoScreen({super.key});

  @override
  State<SpirtualVideoScreen> createState() => _SpirtualVideoScreenState();
}

class _SpirtualVideoScreenState extends State<SpirtualVideoScreen> {
  AuthController authController = Get.find();

  Future<List<EramSpirtualVideoModel>> fetchVideoList() async {
    const String apiUrl = 'https://eramsaeed.com/Durood-App/api/videos/eram';

    try {
      var headers = {
        "Authorization": "Bearer ${authController.accessToken.value}",
      };

      var response = await http.get(
        Uri.parse(apiUrl),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        if (jsonResponse['Error'] == false) {
          List<dynamic> videosData = jsonResponse['Videos'];

          List<EramSpirtualVideoModel> videos =
              videosData.map((videoJson) => EramSpirtualVideoModel.fromJson(videoJson)).toList();

          return videos;
        } else {
          throw Exception('API Error: ${jsonResponse['Message']}');
        }
      } else {
        throw Exception('HTTP Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Exception during API call: $e');
    }
  }

  Future<void> _launchUrl(String url) async {
    final Uri _url = Uri.parse(url);

    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  Color getColorForIndex(int index) {
    List<Color> colors = [
      const Color(0xFF6DD3CE),
      const Color(0xFF8367C7),
      const Color(0xFF85CB33),
      const Color(0xFF5DA9E9),
    ];
    return colors[index % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 5.h),
            const Text(
              "Eram's Spiritual Insights",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Expanded(
                  flex: 2,
                  child: Text(
                    "Embark on a journey of enlightenment with Eram's soul-nourishing videos, offering profound insights and reflections on spiritual growth and devotion.",
                    style: TextStyle(
                      color: AppColors.textGrey,
                      fontSize: 16,
                    ),
                  ),
                ),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      Assets.imagesEram,
                      height: 105,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            FutureBuilder<List<EramSpirtualVideoModel>>(
              future: fetchVideoList(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const NoDataWidget(
                    text: 'No Video Available',
                  );
                } else {
                  List<EramSpirtualVideoModel> videos = snapshot.data!;
                  return Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: videos.length,
                      itemBuilder: (context, index) {
                        EramSpirtualVideoModel video = videos[index];
                        Color cardColor = getColorForIndex(index);
                        print("video.video");
                        print(video.video);
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: GestureDetector(
                            onTap: () => _launchUrl(video.video! ?? ''),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                              decoration: BoxDecoration(
                                color: cardColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ListTile(
                                title: Text(
                                  video.title ?? '',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      video.description ?? '',
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.all(1),
                                            child: Icon(
                                              Icons.play_arrow,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        const Text(
                                          'Play',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                trailing: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: SizedBox(
                                    height: 96,
                                    width: 96,
                                    child: CachedNetworkImage(
                                      imageUrl: video.thumbnail ?? '',
                                      height: 96,
                                      width: 96,
                                      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                      errorWidget: (context, url, error) => const Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.error, color: Colors.red),
                                          SizedBox(height: 8),
                                          FittedBox(
                                            fit: BoxFit.contain,
                                            child: Padding(
                                              padding: EdgeInsets.all(4.0),
                                              child: Text(
                                                'Image failed to load, please try again',
                                                style: TextStyle(color: Colors.red),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
