// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_role_demo/cubit/cubit_data_kelas_siswa/data_siswa_kelas_cubit.dart';
// import 'package:flutter_role_demo/cubit/cubit_data_kelas_siswa/data_siswa_kelas_state.dart';
// import 'package:flutter_role_demo/widget/warna.dart';

// class DataSiswaScreen extends StatelessWidget {
//   final String namaKelas;

//   DataSiswaScreen({super.key, required this.namaKelas});

//   final _addController = TextEditingController();

//   Color getStatusColor(bool? status) {
//     if (status == true) return Warna.trueColor;
//     if (status == false) return Warna.alpaColor;
//     if (status == null) return Warna.midColor;
//     return Colors.white;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Status Siswa - $namaKelas')),
//       body: BlocBuilder<DataSiswaKelasCubit, DataSiswaKelasState>(
//         builder: (context, state) {
//           return ListView.builder(
//             itemCount: state.siswa.length,
//             itemBuilder: (context, index) {
//               final siswa = state.siswa[index];
//               final status = state.statusSiswa[siswa];

//               return ListTile(
//                 title: Text(siswa),
//                 trailing: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Checkbox(
//                       value: status,
//                       tristate: true,
//                       activeColor: getStatusColor(status),
//                       onChanged: (_) =>
//                           context.read<DataSiswaKelasCubit>().toggleStatus(siswa),
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.edit),
//                       onPressed: () {
//                         final editController =
//                             TextEditingController(text: siswa);
//                         showDialog(
//                           context: context,
//                           builder: (_) => AlertDialog(
//                             title: const Text("Edit Siswa"),
//                             content: TextField(
//                               controller: editController,
//                               decoration: const InputDecoration(
//                                   labelText: "Nama Siswa"),
//                             ),
//                             actions: [
//                               TextButton(
//                                 onPressed: () {
//                                   context
//                                       .read<DataSiswaKelasCubit>()
//                                       .editSiswa(index, editController.text);
//                                   Navigator.pop(context);
//                                 },
//                                 child: const Text("Update"),
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.delete),
//                       onPressed: () =>
//                           context.read<DataSiswaKelasCubit>().deleteSiswa(index),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           _addController.clear();
//           showDialog(
//             context: context,
//             builder: (_) => AlertDialog(
//               title: const Text('Tambah Siswa'),
//               content: TextField(
//                 controller: _addController,
//                 decoration: const InputDecoration(hintText: 'Nama Siswa'),
//               ),
//               actions: [
//                 TextButton(
//                   onPressed: () => Navigator.pop(context),
//                   child: const Text('Batal'),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     if (_addController.text.isNotEmpty) {
//                       context
//                           .read<DataSiswaKelasCubit>()
//                           .tambahSiswa(_addController.text);
//                       Navigator.pop(context);
//                     }
//                   },
//                   child: const Text('Simpan'),
//                 ),
//               ],
//             ),
//           );
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
