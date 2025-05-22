import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_role_demo/cubit/cubit_data_kelas_siswa/data_siswa_kelas_cubit.dart';
import 'package:flutter_role_demo/cubit/cubit_deleted_class/deleted_class_cubit.dart';
import 'package:flutter_role_demo/cubit/cubit_get_kelas/get_data_kelas_cubit.dart';
import 'package:flutter_role_demo/cubit/cubit_get_kelas/get_data_kelas_state.dart';
import 'package:flutter_role_demo/cubit/cubit_update_class/update_class_cubit.dart';
import 'package:flutter_role_demo/presentation/screen/attendence_siswa_screen.dart';

import 'package:flutter_role_demo/widget/warna.dart';

class AttendenceScreen extends StatefulWidget {
  const AttendenceScreen({super.key});

  @override
  State<AttendenceScreen> createState() => _AttendenceScreenState();
}

class _AttendenceScreenState extends State<AttendenceScreen> {
  final _addController = TextEditingController();

  @override
  void initState() {
    super.initState();

   
    Future.microtask(() {
      context.read<GetDataKelasCubit>().getAllKelas();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Warna.BgColor,
      body: BlocBuilder<GetDataKelasCubit, GetDataKelasState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.isError.isNotEmpty) {
            return Center(child: Text("❌ ${state.isError}"));
          }

          if (state.classData.isEmpty) {
            return const Center(child: Text("📭 Tidak ada data kelas"));
          }

          return ListView.builder(
            itemCount: state.classData.length,
            itemBuilder: (context, index) {
              final kelas = state.classData[index];

              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Warna.trueColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  child: ListTile(
                    onTap: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2050),
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: ColorScheme.light(
                                primary: Warna.midColor,
                                onPrimary: Warna.mainColor,
                                onSurface: Warna.TextColor,
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );
                      if (selectedDate != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) => AttendenceSiswaScreen(
                                  namaKelas: kelas.name ?? '',
                                  tanggal: selectedDate,
                                ),
                          ),
                        );
                      }
                    },
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    title: Text(
                      kelas.name ?? 'Tanpa Nama',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    trailing: PopupMenuButton<String>(
                      icon: const Icon(Icons.more_vert, color: Colors.white),
                      onSelected: (value) {
                        if (value == 'edit') {
                          final editController = TextEditingController(
                            text: kelas.name,
                          );
                          showDialog(
                            context: context,
                            builder:
                                (_) => AlertDialog(
                                  title: const Text("Edit Kelas"),
                                  content: TextField(
                                    controller: editController,
                                    decoration: const InputDecoration(
                                      labelText: "Nama Kelas",
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text("Batal"),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        await context
                                            .read<UpdateClassCubit>()
                                            .toUpdateClass(
                                              id: kelas.id ?? 0,
                                              name: editController.text,
                                            );

                                        Navigator.pop(context);
                                        context
                                            .read<GetDataKelasCubit>()
                                            .getAllKelas();
                                      },
                                      child: const Text("Update"),
                                    ),
                                  ],
                                ),
                          );
                        } else if (value == 'delete') {
                          context.read<DeleteClassCubit>().toDeleteClass(
                            kelas.id ?? 0,
                          );
                          context.read<GetDataKelasCubit>().getAllKelas();
                        }
                      },
                      itemBuilder:
                          (context) => const [
                            PopupMenuItem(value: 'edit', child: Text('Edit')),
                            PopupMenuItem(
                              value: 'delete',
                              child: Text('Hapus'),
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Warna.midColor,
        onPressed: () {
          _addController.clear();
          showDialog(
            context: context,
            builder:
                (_) => AlertDialog(
                  title: const Text('Tambah Kelas'),
                  content: TextField(
                    controller: _addController,
                    decoration: const InputDecoration(hintText: 'Nama Kelas'),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Batal'),
                    ),
                    TextButton(
                      onPressed: () async {
                        {
                          await context.read<DataSiswaKelasCubit>().tambahSiswa(
                            _addController.text,
                          );
                          Navigator.pop(context);                     
                          context.read<GetDataKelasCubit>().getAllKelas();
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
