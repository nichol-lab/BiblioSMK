
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  static Map<String, dynamic>? _user;
  static int _nextBookId = 6;
  static int _nextLoanId = 1;
  static int _nextUserId = 100;

  static final List<Map<String, dynamic>> _books = [
    {
      'id': 1,
      'title': 'Laskar Pelangi',
      'author': 'Andrea Hirata',
      'publisher': 'Bentang Pustaka',
      'category_id': 1,
      'category': {'id': 1, 'name': 'Novel'},
      'stock': 5,
      'shelf': 'A-01',
      'published_year': 2005,
    },
    {
      'id': 2,
      'title': 'Bumi',
      'author': 'Tere Liye',
      'publisher': 'Gramedia',
      'category_id': 1,
      'category': {'id': 1, 'name': 'Novel'},
      'stock': 4,
      'shelf': 'A-02',
      'published_year': 2014,
    },
    {
      'id': 3,
      'title': 'Dasar-Dasar Pemrograman',
      'author': 'Abdul Kadir',
      'publisher': 'Andi Publisher',
      'category_id': 2,
      'category': {'id': 2, 'name': 'Teknologi'},
      'stock': 3,
      'shelf': 'B-01',
      'published_year': 2020,
    },
    {
      'id': 4,
      'title': 'Pemrograman Web',
      'author': 'Budi Raharjo',
      'publisher': 'Informatika',
      'category_id': 2,
      'category': {'id': 2, 'name': 'Teknologi'},
      'stock': 0,
      'shelf': 'B-02',
      'published_year': 2022,
    },
    {
      'id': 5,
      'title': 'Negeri 5 Menara',
      'author': 'Ahmad Fuadi',
      'publisher': 'Gramedia',
      'category_id': 1,
      'category': {'id': 1, 'name': 'Novel'},
      'stock': 6,
      'shelf': 'A-03',
      'published_year': 2009,
    },
  ];

  static final List<Map<String, dynamic>> _loans = [];
  static final List<Map<String, dynamic>> _users = [];

  static Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    final e = email.trim().toLowerCase();

    if (e.isEmpty || password.isEmpty) {
      throw Exception('Email dan kata sandi wajib diisi.');
    }

    Map<String, dynamic>? user;

    if (e == 'siswa@bibliosmk.test' &&
        password == 'password123') {
      user = {
        'id': 2,
        'name': 'Siswa Demo',
        'email': e,
        'role': 'siswa',
        'nis': '2026001',
      };
    } else if (e == 'petugas@bibliosmk.test' &&
        password == 'password123') {
      user = {
        'id': 1,
        'name': 'Petugas Perpustakaan',
        'email': e,
        'role': 'petugas',
        'nis': null,
      };
    } else {
      for (final account in _users) {
        if (account['email'] == e &&
            account['password'] == password) {
          user = Map<String, dynamic>.from(account['user']);
          break;
        }
      }
    }

    if (user == null) {
      throw Exception(
        'Akun tidak ditemukan. Periksa email dan kata sandi.',
      );
    }

    _user = user;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', 'demo-token');
    await prefs.setString('demo_user', jsonEncode(user));

    return Map<String, dynamic>.from(user);
  }

  static Future<Map<String, dynamic>> register(
    String name,
    String email,
    String password,
    String confirmation,
    String nis,
  ) async {
    final n = name.trim();
    final e = email.trim().toLowerCase();

    if (n.isEmpty || e.isEmpty) {
      throw Exception('Nama dan email wajib diisi.');
    }
    if (!e.contains('@') || !e.contains('.')) {
      throw Exception('Format email tidak valid.');
    }
    if (password.length < 8) {
      throw Exception('Kata sandi minimal 8 karakter.');
    }
    if (password != confirmation) {
      throw Exception('Konfirmasi kata sandi tidak sama.');
    }
    if (e == 'siswa@bibliosmk.test' ||
        e == 'petugas@bibliosmk.test' ||
        _users.any((u) => u['email'] == e)) {
      throw Exception('Email sudah digunakan.');
    }

    final user = <String, dynamic>{
      'id': _nextUserId++,
      'name': n,
      'email': e,
      'role': 'siswa',
      'nis': nis.trim().isEmpty ? null : nis.trim(),
    };

    _users.add({
      'email': e,
      'password': password,
      'user': Map<String, dynamic>.from(user),
    });

    _user = user;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', 'demo-token');
    await prefs.setString('demo_user', jsonEncode(user));

    return Map<String, dynamic>.from(user);
  }

  static Future<Map<String, dynamic>> me() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString('demo_user');

    if (saved == null) {
      throw Exception('Sesi berakhir. Silakan login kembali.');
    }

    _user = Map<String, dynamic>.from(
      jsonDecode(saved) as Map,
    );

    return Map<String, dynamic>.from(_user!);
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('demo_user');
    _user = null;
  }

  static Future<List<dynamic>> books({
    String search = '',
  }) async {
    final q = search.trim().toLowerCase();

    return _books.where((book) {
      final text =
          '${book['title']} ${book['author']} ${book['publisher']}'
              .toLowerCase();
      return text.contains(q);
    }).map((book) => Map<String, dynamic>.from(book)).toList();
  }

  static Future<List<dynamic>> loans() async {
    return _loans.where((loan) {
      return _user?['role'] == 'petugas' ||
          loan['user_id'] == _user?['id'];
    }).map((loan) => Map<String, dynamic>.from(loan)).toList();
  }

  static Future<dynamic> requestLoan(int bookId) async {
    if (_user == null) {
      throw Exception('Silakan login terlebih dahulu.');
    }
    if (_user!['role'] != 'siswa') {
      throw Exception('Hanya siswa yang dapat meminjam buku.');
    }

    final index = _books.indexWhere((b) => b['id'] == bookId);

    if (index == -1) throw Exception('Buku tidak ditemukan.');
    if ((_books[index]['stock'] as int) <= 0) {
      throw Exception('Stok buku habis.');
    }

    final book = Map<String, dynamic>.from(_books[index]);
    _books[index]['stock'] = (_books[index]['stock'] as int) - 1;

    final loan = <String, dynamic>{
      'id': _nextLoanId++,
      'user_id': _user!['id'],
      'user': {'name': _user!['name']},
      'items': [
        {'book': {'title': book['title']}}
      ],
      'status': 'pending',
      'due_date': DateTime.now()
          .add(const Duration(days: 7))
          .toIso8601String()
          .split('T')
          .first,
      'fine_amount': 0,
      '_book_id': bookId,
    };

    _loans.add(loan);
    return Map<String, dynamic>.from(loan);
  }

  static Map<String, dynamic> _findLoan(int id) {
    final index = _loans.indexWhere((loan) => loan['id'] == id);

    if (index == -1) {
      throw Exception('Transaksi tidak ditemukan.');
    }

    return _loans[index];
  }

  static void _restoreStock(Map<String, dynamic> loan) {
    final bookId = loan['_book_id'];
    final index = _books.indexWhere((book) => book['id'] == bookId);

    if (index != -1) {
      _books[index]['stock'] =
          (_books[index]['stock'] as int) + 1;
    }
  }

  static Future<dynamic> approve(int id) async {
    if (_user?['role'] != 'petugas') {
      throw Exception('Akses khusus petugas.');
    }

    final loan = _findLoan(id);

    if (loan['status'] != 'pending') {
      throw Exception('Transaksi bukan berstatus pending.');
    }

    loan['status'] = 'approved';
    return Map<String, dynamic>.from(loan);
  }

  static Future<dynamic> reject(int id) async {
    if (_user?['role'] != 'petugas') {
      throw Exception('Akses khusus petugas.');
    }

    final loan = _findLoan(id);

    if (loan['status'] != 'pending') {
      throw Exception('Transaksi sudah diproses.');
    }

    _restoreStock(loan);
    loan['status'] = 'rejected';
    return Map<String, dynamic>.from(loan);
  }

  static Future<dynamic> returnBook(int id) async {
    if (_user?['role'] != 'petugas') {
      throw Exception('Akses khusus petugas.');
    }

    final loan = _findLoan(id);

    if (loan['status'] != 'approved') {
      throw Exception('Peminjaman belum disetujui.');
    }

    _restoreStock(loan);
    loan['status'] = 'returned';
    return Map<String, dynamic>.from(loan);
  }

  static Map<String, dynamic> _prepareBook(
    int id,
    Map<String, dynamic> data,
  ) {
    final categoryId =
        int.tryParse('${data['category_id'] ?? 1}') ?? 1;

    return {
      ...data,
      'id': id,
      'title': '${data['title'] ?? ''}'.trim(),
      'author': '${data['author'] ?? ''}'.trim(),
      'publisher': data['publisher'],
      'category_id': categoryId,
      'category': {
        'id': categoryId,
        'name': categoryId == 2 ? 'Teknologi' : 'Novel',
      },
      'stock': int.tryParse('${data['stock'] ?? 0}') ?? 0,
      'shelf': '${data['shelf'] ?? ''}'.trim(),
      'published_year':
          int.tryParse('${data['published_year'] ?? ''}'),
    };
  }

  static Future<dynamic> createBook(
    Map<String, dynamic> data,
  ) async {
    if (_user?['role'] != 'petugas') {
      throw Exception('Akses khusus petugas.');
    }

    if ('${data['title'] ?? ''}'.trim().isEmpty ||
        '${data['author'] ?? ''}'.trim().isEmpty) {
      throw Exception('Judul dan pengarang wajib diisi.');
    }

    if ((int.tryParse('${data['stock'] ?? 0}') ?? -1) < 0) {
      throw Exception('Stok tidak boleh negatif.');
    }

    final book = _prepareBook(_nextBookId++, data);
    _books.add(book);

    return Map<String, dynamic>.from(book);
  }

  static Future<dynamic> updateBook(
    int id,
    Map<String, dynamic> data,
  ) async {
    if (_user?['role'] != 'petugas') {
      throw Exception('Akses khusus petugas.');
    }

    final index = _books.indexWhere((book) => book['id'] == id);

    if (index == -1) throw Exception('Buku tidak ditemukan.');

    final merged = {..._books[index], ...data};

    if ('${merged['title'] ?? ''}'.trim().isEmpty ||
        '${merged['author'] ?? ''}'.trim().isEmpty) {
      throw Exception('Judul dan pengarang wajib diisi.');
    }

    if ((int.tryParse('${merged['stock'] ?? 0}') ?? -1) < 0) {
      throw Exception('Stok tidak boleh negatif.');
    }

    _books[index] = _prepareBook(id, merged);

    return Map<String, dynamic>.from(_books[index]);
  }

  static Future<dynamic> deleteBook(int id) async {
    if (_user?['role'] != 'petugas') {
      throw Exception('Akses khusus petugas.');
    }

    final activeLoan = _loans.any((loan) =>
        loan['_book_id'] == id &&
        (loan['status'] == 'pending' ||
            loan['status'] == 'approved'));

    if (activeLoan) {
      throw Exception(
        'Buku memiliki peminjaman yang belum selesai.',
      );
    }

    final index = _books.indexWhere((book) => book['id'] == id);

    if (index == -1) throw Exception('Buku tidak ditemukan.');

    _books.removeAt(index);
    return {'message': 'Buku berhasil dihapus.'};
  }
}
