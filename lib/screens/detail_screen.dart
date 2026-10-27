import 'package:flutter/material.dart';
import 'package:wisata_candi/models/candi.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:wisata_candi/providers/favorite_provider.dart';

class DetailScreen extends StatelessWidget {
  final Candi candi;

  const DetailScreen({
    super.key,
    required this.candi,
  });

  @override
  Widget build(BuildContext context) {
    // Mengecek apakah candi sudah difavoritkan
    final isFav = context
        .watch<FavoriteProvider>()
        .isFavorite(candi.name);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ========================================
            // DETAIL HEADER: GAMBAR DAN TOMBOL KEMBALI
            // ========================================
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      candi.imageAsset,
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Tombol kembali
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 32,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.shade100
                          .withValues(alpha: 0.8),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                  ),
                ),
              ],
            ),

            // ========================================
            // DETAIL INFO
            // ========================================
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),

                  // Nama candi dan tombol favorit
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          candi.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      // Tombol favorit
                      IconButton(
                        onPressed: () {
                          context
                              .read<FavoriteProvider>()
                              .toggle(candi.name);
                        },
                        icon: Icon(
                          isFav
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: isFav ? Colors.red : null,
                        ),
                      ),
                    ],
                  ),

                  // Informasi lokasi
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(
                        Icons.place,
                        color: Colors.red,
                      ),
                      const SizedBox(width: 8),
                      const SizedBox(
                        width: 70,
                        child: Text(
                          'Lokasi',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(': ${candi.location}'),
                      ),
                    ],
                  ),

                  // Informasi tahun dibangun
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_month,
                        color: Colors.blue,
                      ),
                      const SizedBox(width: 8),
                      const SizedBox(
                        width: 70,
                        child: Text(
                          'Dibangun',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(': ${candi.built}'),
                      ),
                    ],
                  ),

                  // Informasi tipe candi
                  Row(
                    children: [
                      const Icon(
                        Icons.house,
                        color: Colors.green,
                      ),
                      const SizedBox(width: 8),
                      const SizedBox(
                        width: 70,
                        child: Text(
                          'Tipe',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(': ${candi.type}'),
                      ),
                    ],
                  ),

                  // Pemisah
                  const SizedBox(height: 16),
                  Divider(
                    color: Colors.deepPurple.shade100,
                  ),
                  const SizedBox(height: 16),

                  // Deskripsi candi
                  const Text(
                    'Deskripsi',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(candi.description),
                ],
              ),
            ),

            // ========================================
            // DETAIL GALLERY: GALERI GAMBAR
            // ========================================
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(
                    color: Colors.deepPurple.shade100,
                  ),

                  const Text(
                    'Galeri',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: candi.imageUrls.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            right: 8,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              // Aksi saat gambar galeri ditekan
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    child: InteractiveViewer(
                                      child: CachedNetworkImage(
                                        imageUrl:
                                        candi.imageUrls[index],
                                        fit: BoxFit.contain,
                                        placeholder:
                                            (context, url) {
                                          return const SizedBox(
                                            height: 200,
                                            child: Center(
                                              child:
                                              CircularProgressIndicator(),
                                            ),
                                          );
                                        },
                                        errorWidget:
                                            (context, url, error) {
                                          return const Icon(
                                            Icons.error,
                                            size: 50,
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(12),
                                border: Border.all(
                                  color:
                                  Colors.deepPurple.shade100,
                                  width: 2,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius:
                                BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl:
                                  candi.imageUrls[index],
                                  width: 120,
                                  height: 100,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) {
                                    return Container(
                                      width: 120,
                                      height: 100,
                                      color:
                                      Colors.deepPurple.shade50,
                                      child: const Center(
                                        child:
                                        CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      ),
                                    );
                                  },
                                  errorWidget:
                                      (context, url, error) {
                                    return const SizedBox(
                                      width: 120,
                                      height: 100,
                                      child: Icon(
                                        Icons.error,
                                        color: Colors.red,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 4),

                  const Text(
                    'Tap untuk memperbesar',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}