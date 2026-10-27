import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// TODO: Pastikan untuk mengimport file SignInScreen & AuthProvider Anda di sini
import 'Sign_in_screen.dart';
import '../providers/auth_provider.dart';
import '../providers/favorite_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // TODO 1: Hapus bool isSignedIn dan setState lama (Sudah Dihapus)
  // Data fullName tetap dipertahankan secara lokal jika tidak ada di AuthProvider Anda
  String fullName = 'Muhammad Rachmadi';

  @override
  Widget build(BuildContext context) {
    // Menggunakan AuthProvider secara reaktif di dalam build()
    final auth = context.watch<AuthProvider>();
    final favoriteProvider = context.watch<FavoriteProvider>();

    return Scaffold(
      body: Stack(
        children: [
          // Latar ungu di bagian atas
          Container(
            height: 200,
            width: double.infinity,
            color: Colors.deepPurple,
          ),
          // Isi Layar Utama
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                // TODO 2: ProfileHeader (foto profil dan ikon kamera)
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 200 - 50),
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.deepPurple, width: 2),
                            shape: BoxShape.circle,
                          ),
                          child: const CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage('images/placeholder_image.png'),
                          ),
                        ),
                        if (auth.isSignedIn)
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.camera_alt,
                              color: Colors.deepPurple,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // TODO 3: ProfileInfo (info pengguna: Pengguna, Nama, Favorit)
                // Baris 1: Pengguna
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      child: const Row(
                        children: [
                          Icon(Icons.lock, color: Colors.amber),
                          SizedBox(width: 8),
                          Text(
                            'Pengguna',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Text(
                        ': ${auth.isSignedIn ? "Name" : ''}',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Divider(color: Colors.deepPurple[100]),
                const SizedBox(height: 4),

                // Baris 2: Nama
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      child: const Row(
                        children: [
                          Icon(Icons.person, color: Colors.blue),
                          SizedBox(width: 8),
                          Text(
                            'Nama',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Text(
                        ': ${auth.isSignedIn ? fullName : ''}',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    if (auth.isSignedIn) const Icon(Icons.edit),
                  ],
                ),
                const SizedBox(height: 4),
                Divider(color: Colors.deepPurple[100]),
                const SizedBox(height: 4),

                // Baris 3: Favorit
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      child: const Row(
                        children: [
                          Icon(Icons.favorite, color: Colors.red),
                          SizedBox(width: 8),
                          Text(
                            'Favorit',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Text(
                        ': ',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Divider(color: Colors.deepPurple[100]),
                const SizedBox(height: 20),

                // TODO 4 & Instruksi 2: ProfileActions (Tombol Sign In / Sign Out)
                auth.isSignedIn
                    ? ElevatedButton(
                  onPressed: () => context.read<AuthProvider>().signOut(),
                  child: const Text('Sign Out'),
                )
                    : ElevatedButton(
                  onPressed: () {
                    // Membuka SignInScreen menggunakan Navigator.push
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  SignInScreen(), // Sesuaikan dengan nama class SignInScreen Anda
                      ),
                    );
                  },
                  child: const Text('Sign In'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
