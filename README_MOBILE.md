# BiblioSMK Flutter

## Membuat proyek
Install Flutter dan Android Studio/Android SDK terlebih dahulu. Buat proyek:
```bash
flutter create bibliosmk
```
Salin `pubspec.yaml` dan folder `lib/` dari paket ini ke proyek tersebut, lalu:
```bash
flutter pub get
```

## Atur alamat API
Buka `lib/services/api.dart`:
- Android Emulator: `http://10.0.2.2:8000/api`
- HP fisik: `http://IP-LAN-PC:8000/api` (misalnya `http://192.168.1.10:8000/api`)
- Browser/Flutter Web pada PC yang sama: `http://127.0.0.1:8000/api`

Untuk pengembangan HTTP lokal, Android dapat memerlukan izin cleartext. Tambahkan `android:usesCleartextTraffic="true"` ke elemen `<application>` pada `android/app/src/main/AndroidManifest.xml` hanya untuk development. Untuk deployment, gunakan HTTPS.

Jalankan backend Laravel terlebih dahulu, kemudian:
```bash
flutter run
```

## Perilaku
- Login/register, token disimpan dengan SharedPreferences, logout menghapus token.
- Registrasi publik hanya membuat role `siswa`.
- Petugas demo dapat mengelola buku dan memproses pinjaman.
- Long-press kartu buku di katalog petugas membuka form edit.
- ID kategori di form CRUD mengikuti ID tabel `categories` (seed awal: 1, 2, 3).
