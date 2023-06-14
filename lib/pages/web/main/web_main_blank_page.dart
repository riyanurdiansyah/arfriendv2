import 'package:arfriendv2/utils/app_text_normal.dart';
import 'package:flutter/material.dart';

class WebMainBlankPage extends StatelessWidget {
  const WebMainBlankPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            // Center(
            //   child: Image.asset(
            //     "assets/images/bg.webp",
            //     width: 350,
            //   ),
            // ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 350,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey.shade100,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/star.webp",
                          ),
                          const SizedBox(
                            width: 14,
                          ),
                          AppTextNormal.labelW400(
                            "Contoh",
                            20,
                            Colors.grey.shade600,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Container(
                      width: 350,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey.shade100,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/star2.webp",
                          ),
                          const SizedBox(
                            width: 14,
                          ),
                          AppTextNormal.labelW400(
                            "Kemampuan",
                            20,
                            Colors.grey.shade600,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Container(
                      width: 350,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey.shade100,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/star3.webp",
                          ),
                          const SizedBox(
                            width: 14,
                          ),
                          AppTextNormal.labelW400(
                            "Batasan",
                            20,
                            Colors.grey.shade600,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 350,
                      height: 125,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey.shade100,
                      ),
                      child: AppTextNormal.labelW400(
                        "Berikan saya marketing strategy yang baik untuk arkademi berdasarkan tren penjualan 1 tahun terakhir",
                        14,
                        Colors.grey.shade600,
                        maxLines: 10,
                        height: 2,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Container(
                      width: 350,
                      height: 125,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey.shade100,
                      ),
                      child: AppTextNormal.labelW400(
                        "Semakin detail pertanyaanmu, semakin relevan respon yang akan diberikan bot",
                        14,
                        Colors.grey.shade600,
                        maxLines: 10,
                        height: 2,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Container(
                      width: 350,
                      height: 125,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey.shade100,
                      ),
                      child: AppTextNormal.labelW400(
                        "Gunakanlah kata 'arkademi' pada pertanyaanmu untuk bisa mendapatkan respon yang sesuai dengan data arkademi",
                        14,
                        Colors.grey.shade600,
                        maxLines: 10,
                        height: 2,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 350,
                      height: 125,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey.shade100,
                      ),
                      child: AppTextNormal.labelW400(
                        "Bantu saya analisa manakah winning channel yang bisa kita maksimalkan untuk meningkatkan awareness dalam campaign arkademi?",
                        14,
                        Colors.grey.shade600,
                        maxLines: 10,
                        height: 2,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Container(
                      width: 350,
                      height: 125,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey.shade100,
                      ),
                      child: AppTextNormal.labelW400(
                        "Menjadi teman brainstorming kamu, dapat memberikan ide, gagasan atau strategi yg relevan dengan kebutuhan kamu sesuai Data Arkademi",
                        14,
                        Colors.grey.shade600,
                        maxLines: 10,
                        height: 2,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Container(
                      width: 350,
                      height: 125,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey.shade100,
                      ),
                      child: AppTextNormal.labelW400(
                        "Tidak bisa jika tidak sesuai Nama File yg disimpan saat ngetrain",
                        14,
                        Colors.grey.shade600,
                        maxLines: 10,
                        height: 2,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 125,
                ),
                AppTextNormal.labelW400(
                  "Copyright  -  Arfriend",
                  16,
                  Colors.grey.shade300,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
