import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_role_demo/Model/kelas_get/kelas_get.dart';
import 'package:flutter_role_demo/cubit/cubit_Get_mapel/get_mapel_cubit.dart';
import 'package:flutter_role_demo/cubit/cubit_Get_mapel/get_mapel_state.dart';
import 'package:flutter_role_demo/cubit/cubit_Post_mapel/post_mapel_cubit.dart';
import 'package:flutter_role_demo/cubit/cubit_deleted_mapela/deleted_mapela_cubit.dart';
import 'package:flutter_role_demo/cubit/cubit_put_mapel/put_mapel_cubit.dart';
import 'package:flutter_role_demo/cubit/cubit_get_kelas/get_data_kelas_cubit.dart';
import 'package:flutter_role_demo/presentation/screen/attendence_data_siswa_screen.dart';
import 'package:flutter_role_demo/widget/warna.dart';

class AttendenceSiswaScreen extends StatefulWidget {
  final String namaKelas;
  final DateTime tanggal;

  const AttendenceSiswaScreen({
    super.key,
    required this.namaKelas,
    required this.tanggal,
  });

  @override
  State<AttendenceSiswaScreen> createState() => _AttendenceSiswaScreenState();
}

class _AttendenceSiswaScreenState extends State<AttendenceSiswaScreen> {
  final _addController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<GetDataKelasCubit>().getAllKelas();
    context.read<GetMapelCubit>().getAllMapel();
  }

  @override
  Widget build(BuildContext context) {
    final kelasState = context.watch<GetDataKelasCubit>().state;
    final classroom = kelasState.classData.firstWhere(
      (c) => c.name == widget.namaKelas,
      orElse: () => KelasGet(id: 0, name: '-'),
    );

    final classroomId = classroom.id.toString();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new, color: Warna.TextColor),
        ),
        centerTitle: true,
        title: const Text(
          'Chose your Lesson',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Warna.midColor,
          ),
        ),
        backgroundColor: Warna.trueColor,
      ),
      body: Container(
        color: Warna.BgColor,
        child: BlocBuilder<GetMapelCubit, GetMapelState>(
          builder: (context, state) {
            if (state.ifLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.ifError.isNotEmpty) {
              return Center(child: Text('❌ ${state.ifError}'));
            }

            final filteredMapel =
                state.mapelData.where((e) => e.classroomId == classroomId).toList();

            if (filteredMapel.isEmpty) {
              return const Center(
                child: Text('📭 Tidak ada pelajaran untuk kelas ini'),
              );
            }

            return ListView.builder(
              itemCount: filteredMapel.length,
              itemBuilder: (context, index) {
                final mapel = filteredMapel[index];
                final pelajaran = mapel.nama ?? '-';

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Warna.mainColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AttendenceDataSiswaScreen(
                              namaKelas: widget.namaKelas,
                              classroomId: classroom.id ?? 0,
                              pelajaranId: mapel.id ?? 0,
                              tanggal: widget.tanggal,
                              pelajaran: pelajaran,
                              siswaList: const [],
                            ),
                          ),
                        );
                      },
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      title: Text(
                        pelajaran,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Warna.TextColor,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.arrow_forward_ios, size: 18, color: Warna.TextColor),
                          const SizedBox(width: 8),
                          PopupMenuButton<String>(
                            icon: const Icon(Icons.more_vert, color: Warna.TextColor),
                            onSelected: (value) async {
                              if (value == 'edit') {
                                final _editController =
                                    TextEditingController(text: pelajaran);
                                showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: const Text('Edit Pelajaran'),
                                    content: TextField(
                                      controller: _editController,
                                      decoration: const InputDecoration(hintText: 'Nama Baru'),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Batal'),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          await context.read<PutMapelCubit>().updateMapel(
                                                id: mapel.id ?? 0,
                                                nama: _editController.text.trim(),
                                                classroomId: classroom.id!,
                                              );
                                          if (mounted) {
                                            Navigator.pop(context);
                                            context.read<GetMapelCubit>().getAllMapel();
                                          }
                                        },
                                        child: const Text('Update'),
                                      ),
                                    ],
                                  ),
                                );
                              } else if (value == 'delete') {
                                final confirm = await showDialog<bool>(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: const Text('Konfirmasi'),
                                    content: const Text(
                                      'Yakin ingin menghapus pelajaran ini?',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context, false),
                                        child: const Text('Batal'),
                                      ),
                                      TextButton(
                                        onPressed: () => Navigator.pop(context, true),
                                        child: const Text('Hapus'),
                                      ),
                                    ],
                                  ),
                                );

                                if (confirm == true) {
                                  await context
                                      .read<DeletedMapelaCubit>()
                                      .toDeletedMapel(mapel.id ?? 0);
                                  if (mounted) context.read<GetMapelCubit>().getAllMapel();
                                }
                              }
                            },
                            itemBuilder: (context) => const [
                              PopupMenuItem(value: 'edit', child: Text('Edit')),
                              PopupMenuItem(value: 'delete', child: Text('Delete')),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Warna.midColor,
        onPressed: () {
          _addController.clear();
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('Tambah Pelajaran'),
              content: TextField(
                controller: _addController,
                decoration: const InputDecoration(hintText: 'Nama Pelajaran'),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Batal'),
                ),
                TextButton(
                  onPressed: () async {
                    await context.read<PostMapelCubit>().addMapelStud(
                          _addController.text.trim(),
                          classroom.id!,
                        );
                    if (mounted) {
                      Navigator.pop(context);
                      context.read<GetMapelCubit>().getAllMapel();
                    }
                  },
                  child: const Text('Simpan'),
                ),
              ],
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
