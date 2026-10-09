import 'package:flutter/material.dart';

void main() => runApp(const BiblioApp());

const green = Color(0xFF72B995);
const darkGreen = Color(0xFF285C45);
const pink = Color(0xFFF4C5D8);
const lightPink = Color(0xFFFFF0F5);
const bg = Color(0xFFFFF9FC);
const white = Colors.white;

class Book {
  final String title;
  final String author;
  final String category;
  final String rack;
  final String description;
  final IconData icon;
  final Color coverColor;
  int stock;

  Book({
    required this.title,
    required this.author,
    required this.category,
    required this.stock,
    required this.rack,
    required this.description,
    required this.icon,
    required this.coverColor,
  });
}

class Loan {
  final Book book;
  final String borrower;
  final DateTime borrowDate;
  final DateTime dueDate;
  String status;

  Loan(
    this.book,
    this.borrower, {
    required this.borrowDate,
    required this.dueDate,
    this.status = 'Menunggu',
  });
}

class BiblioApp extends StatelessWidget {
  const BiblioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BiblioSMK',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Arial',
        scaffoldBackgroundColor: bg,
        colorScheme: ColorScheme.fromSeed(
          seedColor: green,
          primary: green,
          secondary: pink,
          surface: white,
        ),
      ),
      home: const LoginPage(),
    );
  }
}

// ==================== LOGIN ====================

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final username = TextEditingController();
  final password = TextEditingController();

  bool hidePassword = true;
  bool isStaff = false;

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }

  void login() {
    if (!formKey.currentState!.validate()) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => LibraryPage(
          name: username.text.trim(),
          isStaff: isStaff,
        ),
      ),
    );
  }

  Widget bubble(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.72),
        shape: BoxShape.circle,
      ),
    );
  }

  InputDecoration inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: green, fontSize: 13),
      prefixIcon: Icon(icon, color: darkGreen),
      filled: true,
      fillColor: bg,
      contentPadding: const EdgeInsets.all(17),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: lightPink),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: green, width: 1.5),
      ),
    );
  }

  Widget roleButton(String text, bool staff) {
    final selected = isStaff == staff;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => isStaff = staff),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: selected ? green : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                staff ? Icons.badge_outlined : Icons.school_outlined,
                size: 18,
                color: selected ? white : darkGreen,
              ),
              const SizedBox(width: 7),
              Text(
                text,
                style: TextStyle(
                  color: selected ? white : darkGreen,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFFE8F1),
              Color(0xFFE5F5EB),
              Color(0xFFFFEAF2),
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -65,
              left: -55,
              child: bubble(210, const Color(0xFF83CBA3)),
            ),
            Positioned(
              top: 100,
              right: -90,
              child: bubble(210, const Color(0xFFEAA8C4)),
            ),
            Positioned(
              bottom: -110,
              left: 45,
              child: bubble(260, const Color(0xFF9ED8B5)),
            ),
            Positioned(
              bottom: 90,
              right: -75,
              child: bubble(170, const Color(0xFFF0B9D0)),
            ),
            const Positioned(
              top: 42,
              right: 35,
              child: Icon(
                Icons.auto_stories_rounded,
                size: 38,
                color: Color(0xAA285C45),
              ),
            ),
            const Positioned(
              bottom: 40,
              right: 35,
              child: Icon(
                Icons.local_florist_rounded,
                size: 38,
                color: Color(0xCCE9A8C4),
              ),
            ),
            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 410),
                    child: Container(
                      padding: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        color: white.withValues(alpha: 0.97),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: lightPink),
                        boxShadow: [
                          BoxShadow(
                            color: pink.withValues(alpha: 0.30),
                            blurRadius: 35,
                            offset: const Offset(0, 14),
                          ),
                        ],
                      ),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 8),
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                color: lightPink,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: const Icon(
                                Icons.menu_book_rounded,
                                color: darkGreen,
                                size: 62,
                              ),
                            ),
                            const SizedBox(height: 18),
                            const Text(
                              'BiblioSMK',
                              style: TextStyle(
                                color: darkGreen,
                                fontSize: 31,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'Perpustakaan Digital SMK',
                              style: TextStyle(
                                color: green,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 30),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Selamat datang! 👋',
                                style: TextStyle(
                                  color: darkGreen,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 7),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Masuk untuk menjelajahi koleksi buku.',
                                style: TextStyle(color: green),
                              ),
                            ),
                            const SizedBox(height: 22),
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: lightPink,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                children: [
                                  roleButton('Siswa', false),
                                  roleButton('Petugas', true),
                                ],
                              ),
                            ),
                            const SizedBox(height: 21),
                            TextFormField(
                              controller: username,
                              textInputAction: TextInputAction.next,
                              decoration: inputDecoration(
                                'NIS / Username',
                                Icons.person_outline_rounded,
                              ),
                              validator: (v) =>
                                  v == null || v.trim().isEmpty
                                      ? 'Username wajib diisi'
                                      : null,
                            ),
                            const SizedBox(height: 15),
                            TextFormField(
                              controller: password,
                              obscureText: hidePassword,
                              onFieldSubmitted: (_) => login(),
                              decoration: inputDecoration(
                                'Password',
                                Icons.lock_outline_rounded,
                              ).copyWith(
                                suffixIcon: IconButton(
                                  onPressed: () => setState(
                                    () => hidePassword = !hidePassword,
                                  ),
                                  icon: Icon(
                                    hidePassword
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: green,
                                  ),
                                ),
                              ),
                              validator: (v) =>
                                  v == null || v.length < 4
                                      ? 'Password minimal 4 karakter'
                                      : null,
                            ),
                            const SizedBox(height: 24),
                            SizedBox(
                              width: double.infinity,
                              height: 53,
                              child: ElevatedButton(
                                onPressed: login,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: darkGreen,
                                  foregroundColor: white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'MASUK',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.8,
                                      ),
                                    ),
                                    SizedBox(width: 9),
                                    Icon(Icons.arrow_forward_rounded),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 22),
                            const Text(
                              'SMK NEGERI 5 SURAKARTA',
                              style: TextStyle(
                                color: darkGreen,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.1,
                              ),
                            ),
                            const SizedBox(height: 7),
                            const Text(
                              'Read more, learn more. ♡',
                              style: TextStyle(
                                color: green,
                                fontSize: 12,
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
          ],
        ),
      ),
    );
  }
}

// ==================== HALAMAN UTAMA ====================

class LibraryPage extends StatefulWidget {
  final String name;
  final bool isStaff;

  const LibraryPage({
    super.key,
    required this.name,
    required this.isStaff,
  });

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  int selectedPage = 0;
  String selectedCategory = 'Semua';
  String searchQuery = '';

  final searchController = TextEditingController();
  final List<Loan> loans = [];

  final List<Book> books = [
    Book(
      title: 'Langkah ke Depan',
      author: 'Raka Pratama',
      category: 'Fiksi',
      stock: 6,
      rack: 'A-01',
      description:
          'Kisah inspiratif tentang keberanian menghadapi perubahan, '
          'mengejar cita-cita, dan belajar dari setiap pengalaman hidup.',
      icon: Icons.explore_rounded,
      coverColor: const Color(0xFFD9EDE0),
    ),
    Book(
      title: 'Dasar Pemrograman',
      author: 'Arief Hidayat',
      category: 'Teknologi',
      stock: 3,
      rack: 'B-02',
      description:
          'Mengenal dasar pemrograman, algoritma, variabel, percabangan, '
          'perulangan, dan cara menyusun program sederhana.',
      icon: Icons.code_rounded,
      coverColor: const Color(0xFFDCE6F8),
    ),
    Book(
      title: 'Jejak Masa Lalu',
      author: 'Dewi Lestari',
      category: 'Sejarah',
      stock: 4,
      rack: 'C-01',
      description:
          'Menelusuri berbagai peristiwa masa lalu dan memahami '
          'bagaimana sejarah membentuk kehidupan masa kini.',
      icon: Icons.account_balance_rounded,
      coverColor: const Color(0xFFF2DFC6),
    ),
    Book(
      title: 'Senja yang Sama',
      author: 'Alya Ramadhani',
      category: 'Fiksi',
      stock: 5,
      rack: 'A-02',
      description:
          'Cerita fiksi tentang persahabatan, keluarga, harapan, '
          'dan perjalanan menemukan arti kebahagiaan.',
      icon: Icons.auto_stories_rounded,
      coverColor: const Color(0xFFF4D8E5),
    ),
    Book(
      title: 'Alam Semesta',
      author: 'Bima Santoso',
      category: 'Sains',
      stock: 2,
      rack: 'D-01',
      description:
          'Mempelajari planet, bintang, galaksi, dan berbagai '
          'fenomena alam semesta melalui penjelasan yang mudah dipahami.',
      icon: Icons.public_rounded,
      coverColor: const Color(0xFFDADCF7),
    ),
    Book(
      title: 'Produktif Era Digital',
      author: 'Nadia Putri',
      category: 'Teknologi',
      stock: 7,
      rack: 'B-03',
      description:
          'Panduan memanfaatkan teknologi digital untuk belajar, '
          'mengatur waktu, berkolaborasi, dan berkarya secara produktif.',
      icon: Icons.laptop_mac_rounded,
      coverColor: const Color(0xFFD8EDEB),
    ),
  ];

  final List<String> categories = [
    'Semua',
    'Fiksi',
    'Sejarah',
    'Teknologi',
    'Sains',
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  List<Book> get filteredBooks => books.where((book) {
        final query = searchQuery.toLowerCase();
        final matchesCategory =
            selectedCategory == 'Semua' ||
                book.category == selectedCategory;
        final matchesSearch =
            book.title.toLowerCase().contains(query) ||
                book.author.toLowerCase().contains(query);
        return matchesCategory && matchesSearch;
      }).toList();

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: darkGreen,
      ),
    );
  }

  void logout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (_) => false,
    );
  }

  void borrowBook(Book book) {
    if (book.stock <= 0) {
      showMessage('Stok buku sedang habis.');
      return;
    }

    final alreadyRequested = loans.any(
      (loan) =>
          loan.book == book &&
          loan.borrower == widget.name &&
          loan.status != 'Ditolak' &&
          loan.status != 'Dikembalikan',
    );

    if (alreadyRequested) {
      showMessage('Kamu masih memiliki pengajuan untuk buku ini.');
      return;
    }

    setState(() {
      loans.add(
        Loan(
          book,
          widget.name,
          borrowDate: DateTime.now(),
          dueDate: DateTime.now().add(const Duration(days: 7)),
        ),
      );
    });

    Navigator.pop(context);
    showMessage('Pengajuan peminjaman berhasil dibuat!');
  }

  @override
  Widget build(BuildContext context) {
    final titles = widget.isStaff
        ? ['Dashboard', 'Data Buku', 'Transaksi', 'Profil']
        : ['Beranda', 'Kategori', 'Riwayat', 'Profil'];

    final pages = widget.isStaff
        ? [
            dashboardPage(),
            bookManagementPage(),
            transactionPage(),
            profilePage(),
          ]
        : [
            homePage(),
            categoryPage(),
            historyPage(),
            profilePage(),
          ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: bg,
        surfaceTintColor: bg,
        title: Row(
          children: [
            Container(
              height: 39,
              width: 39,
              decoration: BoxDecoration(
                color: lightPink,
                borderRadius: BorderRadius.circular(13),
              ),
              child: const Icon(
                Icons.menu_book_rounded,
                color: darkGreen,
              ),
            ),
            const SizedBox(width: 10),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'BiblioSMK',
                  style: TextStyle(
                    fontSize: 18,
                    color: darkGreen,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Perpustakaan Digital',
                  style: TextStyle(fontSize: 10, color: green),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Notifikasi',
            onPressed: () => showMessage('Belum ada notifikasi baru.'),
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: darkGreen,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: lightPink,
              child: Text(
                widget.name.isEmpty ? '?' : widget.name[0].toUpperCase(),
                style: const TextStyle(
                  color: darkGreen,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: IndexedStack(
        index: selectedPage,
        children: pages,
      ),
      bottomNavigationBar: NavigationBar(
        height: 70,
        backgroundColor: white,
        indicatorColor: lightPink,
        selectedIndex: selectedPage,
        onDestinationSelected: (index) {
          setState(() => selectedPage = index);
        },
        destinations: [
          NavigationDestination(
            icon: Icon(
              widget.isStaff
                  ? Icons.dashboard_outlined
                  : Icons.home_outlined,
            ),
            selectedIcon: const Icon(
              Icons.home_rounded,
              color: darkGreen,
            ),
            label: titles[0],
          ),
          NavigationDestination(
            icon: Icon(
              widget.isStaff
                  ? Icons.library_books_outlined
                  : Icons.grid_view_rounded,
            ),
            selectedIcon: const Icon(
              Icons.grid_view_rounded,
              color: darkGreen,
            ),
            label: titles[1],
          ),
          NavigationDestination(
            icon: Icon(
              widget.isStaff
                  ? Icons.swap_horiz_rounded
                  : Icons.history_rounded,
            ),
            selectedIcon: const Icon(
              Icons.history_rounded,
              color: darkGreen,
            ),
            label: titles[2],
          ),
          const NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(
              Icons.person_rounded,
              color: darkGreen,
            ),
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  // ==================== COVER BUKU ====================

  Widget bookCover(Book book, {bool large = false}) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: book.coverColor,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            book.coverColor,
            Color.lerp(book.coverColor, white, 0.35)!,
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -22,
            right: -20,
            child: Container(
              width: large ? 110 : 75,
              height: large ? 110 : 75,
              decoration: BoxDecoration(
                color: white.withValues(alpha: 0.25),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -25,
            left: -15,
            child: Container(
              width: large ? 100 : 65,
              height: large ? 100 : 65,
              decoration: BoxDecoration(
                color: darkGreen.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    book.icon,
                    color: darkGreen,
                    size: large ? 62 : 45,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    book.title.toUpperCase(),
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: darkGreen,
                      fontSize: large ? 15 : 11,
                      fontWeight: FontWeight.w900,
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    width: 35,
                    height: 3,
                    decoration: BoxDecoration(
                      color: darkGreen.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    book.author,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: darkGreen,
                      fontSize: large ? 11 : 9,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 8,
            right: 8,
            child: Icon(
              Icons.menu_book_rounded,
              size: large ? 22 : 17,
              color: darkGreen.withValues(alpha: 0.55),
            ),
          ),
        ],
      ),
    );
  }

  // ==================== BERANDA SISWA ====================

  Widget homePage() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 24),
      children: [
        Text(
          'Halo, ${widget.name} 👋',
          style: const TextStyle(
            fontSize: 26,
            color: darkGreen,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Mau baca apa hari ini?',
          style: TextStyle(fontSize: 15, color: green),
        ),
        const SizedBox(height: 21),
        Container(
          padding: const EdgeInsets.all(21),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [green, Color(0xFF91CDAA)],
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: const Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'A little reading,\na lot of learning ♡',
                      style: TextStyle(
                        fontSize: 20,
                        height: 1.3,
                        color: white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Jelajahi dunia melalui buku.',
                      style: TextStyle(color: white, fontSize: 12),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.auto_stories_rounded,
                size: 65,
                color: white,
              ),
            ],
          ),
        ),
        const SizedBox(height: 23),
        TextField(
          controller: searchController,
          onChanged: (value) => setState(() => searchQuery = value),
          decoration: InputDecoration(
            hintText: 'Cari judul atau pengarang...',
            hintStyle: const TextStyle(fontSize: 13, color: green),
            prefixIcon: const Icon(Icons.search, color: darkGreen),
            suffixIcon: IconButton(
              onPressed: () {
                searchController.clear();
                setState(() => searchQuery = '');
              },
              icon: const Icon(Icons.close_rounded, color: green),
            ),
            filled: true,
            fillColor: white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(17),
              borderSide: const BorderSide(color: lightPink),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(17),
              borderSide: const BorderSide(color: lightPink),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(17),
              borderSide: const BorderSide(color: green),
            ),
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: categories.map((item) {
              final selected = selectedCategory == item;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(item),
                  selected: selected,
                  showCheckmark: false,
                  selectedColor: green,
                  backgroundColor: lightPink,
                  side: BorderSide.none,
                  labelStyle: TextStyle(
                    color: selected ? white : darkGreen,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                  onSelected: (_) => setState(
                    () => selectedCategory = item,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 26),
        sectionHeading(
          'Buku pilihan minggu ini',
          Icons.local_fire_department_rounded,
          'Koleksi pilihan',
        ),
        const SizedBox(height: 14),
        if (filteredBooks.isEmpty)
          emptyState(
            Icons.search_off_rounded,
            'Buku tidak ditemukan',
            'Coba kata kunci atau kategori lainnya.',
          )
        else
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filteredBooks.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 13,
              mainAxisSpacing: 13,
              childAspectRatio: 0.57,
            ),
            itemBuilder: (_, index) => bookCard(filteredBooks[index]),
          ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(17),
          decoration: BoxDecoration(
            color: lightPink,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Row(
            children: [
              Icon(Icons.favorite_rounded, color: darkGreen, size: 28),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Satu buku, seribu cerita, banyak inspirasi.',
                  style: TextStyle(
                    color: darkGreen,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ==================== KARTU BUKU ====================

  Widget bookCard(Book book) {
    return InkWell(
      onTap: () => showBookDetails(book),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFF3E4EB)),
          boxShadow: [
            BoxShadow(
              color: pink.withValues(alpha: 0.13),
              blurRadius: 13,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: bookCover(book),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              book.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: darkGreen,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              book.author,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: green, fontSize: 11),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(
                  Icons.menu_book_rounded,
                  size: 15,
                  color: green,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    'Tersedia ${book.stock}',
                    style: const TextStyle(
                      color: darkGreen,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => showBookDetails(book),
                style: FilledButton.styleFrom(
                  backgroundColor: darkGreen,
                  foregroundColor: white,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  minimumSize: const Size(0, 34),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(11),
                  ),
                ),
                child: const Text(
                  'Detail Buku',
                  style: TextStyle(fontSize: 11),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==================== DETAIL BUKU ====================

  void showBookDetails(Book book) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (sheetContext) => SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 5,
                width: 45,
                decoration: BoxDecoration(
                  color: pink,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: SizedBox(
                  height: 190,
                  width: 140,
                  child: bookCover(book, large: true),
                ),
              ),
              const SizedBox(height: 17),
              Text(
                book.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: darkGreen,
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'Oleh ${book.author}',
                style: const TextStyle(color: green),
              ),
              const Divider(color: lightPink, height: 28),
              detailRow(Icons.category_outlined, 'Kategori', book.category),
              detailRow(Icons.shelves, 'Lokasi rak', book.rack),
              detailRow(
                Icons.inventory_2_outlined,
                'Stok tersedia',
                '${book.stock} buku',
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: bg,
                  borderRadius: BorderRadius.circular(17),
                  border: Border.all(color: lightPink),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tentang buku',
                      style: TextStyle(
                        color: darkGreen,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      book.description,
                      style: const TextStyle(
                        color: darkGreen,
                        fontSize: 13,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              if (!widget.isStaff)
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: book.stock > 0
                        ? () => borrowBook(book)
                        : null,
                    icon: const Icon(Icons.bookmark_add_outlined),
                    label: const Text('AJUKAN PEMINJAMAN'),
                    style: FilledButton.styleFrom(
                      backgroundColor: darkGreen,
                      foregroundColor: white,
                      padding: const EdgeInsets.all(15),
                    ),
                  ),
                ),
              if (widget.isStaff)
                const Text(
                  'Untuk mengubah stok, buka menu Data Buku.',
                  style: TextStyle(color: green),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget detailRow(IconData icon, String title, String value) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: green),
      title: Text(
        title,
        style: const TextStyle(color: green, fontSize: 12),
      ),
      subtitle: Text(
        value,
        style: const TextStyle(
          color: darkGreen,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // ==================== KATEGORI ====================

  Widget categoryPage() {
    final categoryColors = [
      const Color(0xFFD8EDE0),
      lightPink,
      const Color(0xFFE6F1E7),
      const Color(0xFFF5DFE9),
    ];

    final categoryIcons = [
      Icons.auto_stories_rounded,
      Icons.history_edu_rounded,
      Icons.code_rounded,
      Icons.science_rounded,
    ];

    final availableCategories = categories.skip(1).toList();

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'Jelajahi Kategori',
          style: TextStyle(
            fontSize: 25,
            color: darkGreen,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Pilih topik yang kamu sukai.',
          style: TextStyle(color: green),
        ),
        const SizedBox(height: 22),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: lightPink,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.explore_rounded,
                color: darkGreen,
                size: 36,
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Text(
                  '${books.length} koleksi buku siap kamu jelajahi.',
                  style: const TextStyle(
                    color: darkGreen,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: availableCategories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 13,
            mainAxisSpacing: 13,
            childAspectRatio: 0.95,
          ),
          itemBuilder: (_, index) {
            final name = availableCategories[index];
            final count = books.where((b) => b.category == name).length;

            return InkWell(
              onTap: () {
                setState(() {
                  selectedCategory = name;
                  selectedPage = 0;
                });
              },
              borderRadius: BorderRadius.circular(22),
              child: Container(
                padding: const EdgeInsets.all(17),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: lightPink),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 53,
                      width: 53,
                      decoration: BoxDecoration(
                        color: categoryColors[index % categoryColors.length],
                        borderRadius: BorderRadius.circular(17),
                      ),
                      child: Icon(
                        categoryIcons[index % categoryIcons.length],
                        color: darkGreen,
                        size: 28,
                      ),
                    ),
                    Text(
                      name,
                      style: const TextStyle(
                        color: darkGreen,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '$count buku',
                            style: const TextStyle(
                              color: green,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_rounded,
                          color: green,
                          size: 19,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 22),
        const Text(
          'Semua kategori',
          style: TextStyle(
            color: darkGreen,
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        ...categories.map(
          (name) => Card(
            color: white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(color: lightPink),
            ),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: lightPink,
                child: Icon(Icons.menu_book_rounded, color: darkGreen),
              ),
              title: Text(
                name,
                style: const TextStyle(
                  color: darkGreen,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                '${name == 'Semua' ? books.length : books.where((b) => b.category == name).length} koleksi buku',
                style: const TextStyle(color: green, fontSize: 12),
              ),
              trailing: const Icon(
                Icons.chevron_right_rounded,
                color: green,
              ),
              onTap: () => setState(() {
                selectedCategory = name;
                selectedPage = 0;
              }),
            ),
          ),
        ),
      ],
    );
  }

  // ==================== RIWAYAT PEMINJAMAN ====================

  Widget historyPage() {
    final mine = loans
        .where((loan) => loan.borrower == widget.name)
        .toList()
        .reversed
        .toList();

    final active = mine.where((l) => l.status == 'Dipinjam').length;
    final waiting = mine.where((l) => l.status == 'Menunggu').length;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'Riwayat Buku',
          style: TextStyle(
            fontSize: 25,
            color: darkGreen,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Pantau pengajuan dan pengembalian bukumu.',
          style: TextStyle(color: green),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            historyStat('Menunggu', waiting, pink),
            const SizedBox(width: 10),
            historyStat('Dipinjam', active, green),
            const SizedBox(width: 10),
            historyStat(
              'Selesai',
              mine.where((l) => l.status == 'Dikembalikan').length,
              const Color(0xFFD8EDE0),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            const Expanded(
              child: Text(
                'Aktivitas peminjaman',
                style: TextStyle(
                  color: darkGreen,
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                ),
              ),
            ),
            Text(
              '${mine.length} transaksi',
              style: const TextStyle(color: green, fontSize: 12),
            ),
          ],
        ),
        const SizedBox(height: 14),
        if (mine.isEmpty)
          emptyState(
            Icons.menu_book_rounded,
            'Belum ada peminjaman',
            'Buku yang kamu ajukan akan muncul di sini.',
          )
        else
          ...mine.map((loan) => loanCard(loan)),
        const SizedBox(height: 18),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: lightPink,
            borderRadius: BorderRadius.circular(18),
          ),
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info_outline_rounded, color: darkGreen),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Kembalikan buku sesuai batas waktu yang tertera. '
                  'Aplikasi ini masih berupa demo dan belum menghitung denda.',
                  style: TextStyle(
                    color: darkGreen,
                    fontSize: 12,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget historyStat(String title, int value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 8),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: lightPink),
        ),
        child: Column(
          children: [
            Container(
              height: 8,
              width: 8,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(height: 9),
            Text(
              '$value',
              style: const TextStyle(
                fontSize: 23,
                color: darkGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(color: green, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }

  // ==================== KARTU TRANSAKSI ====================

  Widget loanCard(Loan loan, {bool staff = false}) {
    final statusColor = loan.status == 'Dipinjam'
        ? green
        : loan.status == 'Dikembalikan'
            ? darkGreen
            : loan.status == 'Ditolak'
                ? const Color(0xFFD77A9D)
                : const Color(0xFFB78348);

    return Container(
      margin: const EdgeInsets.only(bottom: 13),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: lightPink),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 70,
                width: 55,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: bookCover(loan.book),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      loan.book.title,
                      style: const TextStyle(
                        color: darkGreen,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      loan.book.author,
                      style: const TextStyle(color: green, fontSize: 12),
                    ),
                    if (staff) ...[
                      const SizedBox(height: 4),
                      Text(
                        'Peminjam: ${loan.borrower}',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 13),
          const Divider(color: lightPink, height: 1),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(
                Icons.calendar_month_outlined,
                size: 17,
                color: green,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  'Batas kembali: ${formatDate(loan.dueDate)}',
                  style: const TextStyle(
                    fontSize: 11,
                    color: darkGreen,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.13),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  loan.status,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          if (staff) ...[
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: [
                if (loan.status == 'Menunggu')
                  FilledButton(
                    onPressed: () {
                      if (loan.book.stock <= 0) {
                        showMessage('Stok buku habis.');
                        return;
                      }
                      setState(() {
                        loan.book.stock--;
                        loan.status = 'Dipinjam';
                      });
                      showMessage('Peminjaman berhasil disetujui.');
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: green,
                      foregroundColor: white,
                    ),
                    child: const Text('Setujui'),
                  ),
                if (loan.status == 'Menunggu')
                  OutlinedButton(
                    onPressed: () {
                      setState(() => loan.status = 'Ditolak');
                      showMessage('Pengajuan ditolak.');
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: darkGreen,
                    ),
                    child: const Text('Tolak'),
                  ),
                if (loan.status == 'Dipinjam')
                  FilledButton(
                    onPressed: () {
                      setState(() {
                        loan.book.stock++;
                        loan.status = 'Dikembalikan';
                      });
                      showMessage('Buku telah dikembalikan.');
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: darkGreen,
                      foregroundColor: white,
                    ),
                    child: const Text('Proses kembali'),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  // ==================== PROFIL ====================

  Widget profilePage() {
    final mine = loans.where((l) => l.borrower == widget.name).length;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'Profil Saya',
          style: TextStyle(
            fontSize: 25,
            color: darkGreen,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [green, Color(0xFFA4D8B8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  color: white,
                  shape: BoxShape.circle,
                ),
                child: CircleAvatar(
                  radius: 42,
                  backgroundColor: lightPink,
                  child: Text(
                    widget.name.isEmpty ? '?' : widget.name[0].toUpperCase(),
                    style: const TextStyle(
                      color: darkGreen,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 13),
              Text(
                widget.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: white,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 13,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: white.withValues(alpha: 0.24),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  widget.isStaff ? 'Petugas Perpustakaan' : 'Anggota • Siswa',
                  style: const TextStyle(color: white, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            profileStat(
              'Koleksi',
              '${books.length}',
              Icons.menu_book_rounded,
            ),
            const SizedBox(width: 12),
            profileStat(
              'Aktivitas',
              '$mine',
              Icons.history_rounded,
            ),
          ],
        ),
        const SizedBox(height: 24),
        const Text(
          'Informasi akun',
          style: TextStyle(
            color: darkGreen,
            fontWeight: FontWeight.bold,
            fontSize: 19,
          ),
        ),
        const SizedBox(height: 12),
        profileOption(Icons.person_outline_rounded, 'Nama pengguna', widget.name),
        profileOption(
          Icons.badge_outlined,
          'Hak akses',
          widget.isStaff ? 'Petugas' : 'Siswa',
        ),
        profileOption(
          Icons.school_outlined,
          'Instansi',
          'SMK Negeri 5 Surakarta',
        ),
        profileOption(
          Icons.menu_book_outlined,
          'Aplikasi',
          'BiblioSMK • Demo',
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: lightPink,
            borderRadius: BorderRadius.circular(18),
          ),
          child: const Row(
            children: [
              Icon(Icons.favorite_rounded, color: darkGreen, size: 25),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Terus membaca, terus bertumbuh. ♡',
                  style: TextStyle(
                    color: darkGreen,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 50,
          child: OutlinedButton.icon(
            onPressed: logout,
            icon: const Icon(Icons.logout_rounded),
            label: const Text('Keluar dari akun'),
            style: OutlinedButton.styleFrom(
              foregroundColor: darkGreen,
              side: const BorderSide(color: pink),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget profileStat(String title, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(17),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(19),
          border: Border.all(color: lightPink),
        ),
        child: Row(
          children: [
            Icon(icon, color: green, size: 28),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: const TextStyle(
                      color: darkGreen,
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    title,
                    style: const TextStyle(color: green, fontSize: 11),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget profileOption(IconData icon, String title, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: lightPink),
      ),
      child: Row(
        children: [
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: lightPink,
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(icon, color: darkGreen),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: green, fontSize: 11),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    color: darkGreen,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==================== DASHBOARD PETUGAS ====================

  Widget dashboardPage() {
    final waiting = loans.where((l) => l.status == 'Menunggu').length;
    final borrowed = loans.where((l) => l.status == 'Dipinjam').length;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'Dashboard Petugas',
          style: TextStyle(
            color: darkGreen,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Ringkasan aktivitas perpustakaan.',
          style: TextStyle(color: green),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: green,
            borderRadius: BorderRadius.circular(22),
          ),
          child: const Row(
            children: [
              Expanded(
                child: Text(
                  'Halo, Petugas! 👋\nKelola perpustakaan dengan mudah.',
                  style: TextStyle(
                    color: white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    height: 1.5,
                  ),
                ),
              ),
              Icon(Icons.library_books_rounded, color: white, size: 46),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            statCard('Koleksi Buku', '${books.length}', Icons.menu_book),
            const SizedBox(width: 12),
            statCard('Menunggu', '$waiting', Icons.pending_actions),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            statCard('Dipinjam', '$borrowed', Icons.swap_horiz_rounded),
            const SizedBox(width: 12),
            statCard('Kategori', '${categories.length - 1}', Icons.category),
          ],
        ),
        const SizedBox(height: 24),
        const Text(
          'Transaksi terbaru',
          style: TextStyle(
            color: darkGreen,
            fontWeight: FontWeight.bold,
            fontSize: 19,
          ),
        ),
        const SizedBox(height: 12),
        if (loans.isEmpty)
          emptyState(
            Icons.receipt_long_rounded,
            'Belum ada transaksi',
            'Pengajuan peminjaman akan muncul di sini.',
          )
        else
          ...loans.reversed.map((loan) => loanCard(loan, staff: true)),
      ],
    );
  }

  Widget statCard(String title, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: lightPink),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                color: lightPink,
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(icon, color: darkGreen),
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: const TextStyle(
                color: darkGreen,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              title,
              style: const TextStyle(color: green, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  // ==================== KELOLA BUKU PETUGAS ====================

  Widget bookManagementPage() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'Data Buku',
          style: TextStyle(
            color: darkGreen,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Kelola stok dan lokasi koleksi buku.',
          style: TextStyle(color: green),
        ),
        const SizedBox(height: 15),
        ...books.map(
          (book) => Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: lightPink),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: SizedBox(
                height: 55,
                width: 48,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: bookCover(book),
                ),
              ),
              title: Text(
                book.title,
                style: const TextStyle(
                  color: darkGreen,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                '${book.author}\nStok ${book.stock} • Rak ${book.rack}',
                style: const TextStyle(height: 1.5),
              ),
              isThreeLine: true,
              trailing: PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert, color: green),
                onSelected: (value) {
                  setState(() {
                    if (value == 'tambah') {
                      book.stock++;
                    } else if (value == 'kurang' && book.stock > 0) {
                      book.stock--;
                    } else if (value == 'hapus') {
                      final hasActiveLoan = loans.any(
                        (loan) =>
                            loan.book == book &&
                            loan.status != 'Dikembalikan' &&
                            loan.status != 'Ditolak',
                      );

                      if (hasActiveLoan) {
                        showMessage(
                          'Buku memiliki transaksi aktif dan tidak bisa dihapus.',
                        );
                        return;
                      }

                      books.remove(book);
                    }
                  });
                },
                itemBuilder: (_) => const [
                  PopupMenuItem(
                    value: 'tambah',
                    child: Text('Tambah stok'),
                  ),
                  PopupMenuItem(
                    value: 'kurang',
                    child: Text('Kurangi stok'),
                  ),
                  PopupMenuItem(
                    value: 'hapus',
                    child: Text('Hapus buku'),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Data buku masih berupa data demo dan kembali ke awal saat aplikasi dimulai ulang.',
          style: TextStyle(color: green, fontSize: 12),
        ),
      ],
    );
  }

  // ==================== TRANSAKSI PETUGAS ====================

  Widget transactionPage() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'Transaksi Peminjaman',
          style: TextStyle(
            color: darkGreen,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Periksa, setujui, dan proses pengembalian.',
          style: TextStyle(color: green),
        ),
        const SizedBox(height: 20),
        if (loans.isEmpty)
          emptyState(
            Icons.receipt_long_rounded,
            'Belum ada pengajuan',
            'Pengajuan siswa akan tampil di halaman ini.',
          )
        else
          ...loans.reversed.map((loan) => loanCard(loan, staff: true)),
      ],
    );
  }

  // ==================== WIDGET BANTUAN ====================

  Widget sectionHeading(String title, IconData icon, String subtitle) {
    return Row(
      children: [
        Container(
          height: 42,
          width: 42,
          decoration: BoxDecoration(
            color: lightPink,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(icon, color: darkGreen),
        ),
        const SizedBox(width: 11),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: darkGreen,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(color: green, fontSize: 11),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget emptyState(IconData icon, String title, String subtitle) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: lightPink),
      ),
      child: Column(
        children: [
          Container(
            height: 75,
            width: 75,
            decoration: const BoxDecoration(
              color: lightPink,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: darkGreen, size: 37),
          ),
          const SizedBox(height: 15),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: darkGreen,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: green,
              fontSize: 12,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

String formatDate(DateTime date) {
  final day = date.day.toString().padLeft(2, '0');
  final month = date.month.toString().padLeft(2, '0');
  return '$day/$month/${date.year}';
}