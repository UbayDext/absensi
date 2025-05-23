import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_role_demo/cubit/cubit_get_studen/get_studen_cubit.dart';
import 'package:flutter_role_demo/cubit/cubit_get_studen/get_studen_state.dart';
import 'package:flutter_role_demo/cubit/cubit_post_studensStatus/post_studens_status_cubit.dart';
import 'package:flutter_role_demo/cubit/cubit_put_status/put_status_cubit.dart';
import 'package:flutter_role_demo/widget/warna.dart';

const Map<String, String> kodeToStatus = {
  'P': 'hadir',
  'S': 'sakit',
  'A': 'alfa',
};

class AttendenceDataSiswaScreen extends StatefulWidget {
  final String namaKelas;
  final DateTime tanggal;
  final String pelajaran;
  final int classroomId;
  final int pelajaranId;
  final List<String> siswaList;

  const AttendenceDataSiswaScreen({
    super.key,
    required this.namaKelas,
    required this.tanggal,
    required this.pelajaran,
    required this.classroomId,
    required this.pelajaranId,
    required this.siswaList,
  });

  @override
  State<AttendenceDataSiswaScreen> createState() =>
      _AttendenceDataSiswaScreenState();
}

class _AttendenceDataSiswaScreenState extends State<AttendenceDataSiswaScreen> {
  List<String> siswaList = [];
  final TextEditingController _controller = TextEditingController();
  Map<String, String> statusMap = {}; // simpan status per siswa ('P', 'S', 'A')
  bool _isStatusMapInitialized = false;

  @override
  void initState() {
    super.initState();
    context.read<GetStudenCubit>().getAllStudent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Warna.BgColor,
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            Text(
              'Kelas ${widget.namaKelas}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Warna.mainColor,
              ),
            ),
            Text(
              '${widget.tanggal.day} ${_getBulan(widget.tanggal.month)} ${widget.tanggal.year}',
              style: const TextStyle(fontSize: 14, color: Warna.mainColor),
            ),
          ],
        ),
        backgroundColor: Warna.trueColor,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Warna.midColor,
        onPressed: () {
          _controller.clear();
          showDialog(
            context: context,
            builder:
                (context) => AlertDialog(
                  title: const Text("Tambah Siswa"),
                  content: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(hintText: "Nama Siswa"),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Batal"),
                    ),
                    TextButton(
                      onPressed: () async {
                        final nama = _controller.text.trim();

                        if (nama.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Nama siswa tidak boleh kosong."),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        final kode = statusMap[nama] ?? 'P';
                        final status = kodeToStatus[kode] ?? 'hadir';

                        final result = await context
                            .read<PostStudensStatusCubit>()
                            .addStatus(
                              name: nama,
                              status: status,
                              userId: null,
                              pelajaranId: widget.pelajaranId,
                              classroomId: widget.classroomId,
                              date: widget.tanggal,
                            );

                        if (result != null) {
                          //  Tambahkan ke siswaList dan statusMap
                          setState(() {
                            siswaList.add(nama);
                            statusMap[nama] = kode;
                          });

                          //  Ambil ulang data dari backend
                          await context.read<GetStudenCubit>().getAllStudent();

                          Navigator.pop(context);

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "✅ Siswa berhasil ditambahkan dan disimpan.",
                              ),
                              backgroundColor: Colors.green,
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("❌ Gagal menambahkan siswa $nama"),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      child: const Text("Simpan"),
                    ),
                  ],
                ),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: Warna.mainColor,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Center(
              child: Text(
                widget.pelajaran,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Warna.TextColor,
                ),
              ),
            ),
          ),
          _buildTableHeader(),
          Expanded(
            child: BlocBuilder<GetStudenCubit, GetStudenState>(
              builder: (context, state) {
                if (state.butLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.butError.isNotEmpty) {
                  return Center(child: Text("❌ ${state.butError}"));
                }

                final filteredSiswa =
                    state.attandenceStudent
                        .where(
                          (e) => // filter list data done ✅
                              e.classroomId == widget.classroomId.toString() &&
                              (e.pelajaran?.nama ?? '').toLowerCase() ==
                                  widget.pelajaran.toLowerCase(),
                        )
                        .toList();

                final siswaGabungan =
                    [
                      ...filteredSiswa.map((e) => e.name ?? '-'),
                      ...siswaList,
                    ].toSet().toList();

                //  Inisialisasi statusMap hanya sekali
                if (!_isStatusMapInitialized) {
                  for (final siswa in filteredSiswa) {
                    final nama = siswa.name ?? '-';
                    final statusBackend =
                        siswa.status?.toLowerCase() ?? 'hadir';

                    String kodeStatus = 'P';
                    if (statusBackend == 'hadir') {
                      kodeStatus = 'P';
                    } else if (statusBackend == 'sakit') {
                      kodeStatus = 'S';
                    } else if (statusBackend == 'alfa') {
                      kodeStatus = 'A';
                    }

                    statusMap[nama] = kodeStatus;
                  }

                  for (final nama in siswaGabungan) {
                    statusMap.putIfAbsent(nama, () => 'P');
                  }

                  _isStatusMapInitialized =
                      true; // ✅ tandai sudah terinisialisasi
                }

                if (siswaGabungan.isEmpty) {
                  return const Center(
                    child: Text('📭 Tidak ada siswa untuk pelajaran ini'),
                  );
                }

                return ListView.builder(
                  itemCount: siswaGabungan.length,
                  itemBuilder: (context, index) {
                    final nama = siswaGabungan[index];
                    return _buildRow(context, index, nama);
                  },
                );
              },
            ),
          ),

          Container(
            width: 200,
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () async {
                final getStudenState = context.read<GetStudenCubit>().state;

                final siswaDariBackend =
                    getStudenState.attandenceStudent
                        .where(
                          (e) =>
                              e.classroomId == widget.classroomId.toString() &&
                              (e.pelajaran?.nama ?? '').toLowerCase() ==
                                  widget.pelajaran.toLowerCase(),
                        )
                        .toList();

                bool semuaSukses = true;

                for (final siswa in siswaDariBackend) {
                  final nama = siswa.name ?? '-';
                  final kode = statusMap[nama] ?? 'P';
                  final status = kodeToStatus[kode] ?? 'hadir';

                  final sukses = await context
                      .read<PutStudensStatusCubit>()
                      .updateStatus(
                        id: siswa.id!,
                        name: nama,
                        status: status,
                        userId:
                            siswa.userId != null
                                ? int.tryParse(siswa.userId!)
                                : null,
                        pelajaranId: widget.pelajaranId,
                        classroomId: widget.classroomId,
                        date: widget.tanggal,
                      );

                  if (!sukses) { // symbol ! firs reverse
                    semuaSukses = false;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('❌ Gagal update status untuk $nama'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }

                if (semuaSukses) {
                  await context.read<GetStudenCubit>().getAllStudent();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("✅ Semua data berhasil diperbarui."),
                      backgroundColor: Colors.green,
                    ),
                  );
                  setState(() {}); // for refresh and restart rebuild UI must
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Warna.trueColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Save',
                style: TextStyle(color: Warna.TextColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      decoration: const BoxDecoration(
        color: Warna.midColor,
        border: Border(bottom: BorderSide(color: Warna.TextColor, width: 1)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: const [
          Expanded(
            flex: 4,
            child: Center(
              child: Text(
                'Student',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text('P', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          Expanded(
            child: Center(
              child: Text('S', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          Expanded(
            child: Center(
              child: Text('A', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(BuildContext context, int index, String name) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: const BoxDecoration(
        color: Warna.mainColor,
        border: Border(bottom: BorderSide(color: Warna.BgColor, width: 5)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(name, style: const TextStyle(fontSize: 14)),
          ),
          _buildRadio(name, 'P'),
          _buildRadio(name, 'S'),
          _buildRadio(name, 'A'),
        ],
      ),
    );
  }

  Widget _buildRadio(String name, String value) {
    return Expanded(
      child: Center(
        child: Radio<String>(
          value: value,
          groupValue: statusMap[name],
          visualDensity: VisualDensity.compact,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          onChanged: (val) {
            if (val != null) {
              setState(() {
                statusMap[name] = val;
              });
            }
          },
        ),
      ),
    );
  }

  String _getBulan(int bulan) {
    const bulanList = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];
    return bulanList[bulan - 1];
  }
}
