// import 'package:flutter/material.dart';
// import 'package:flutter_role_demo/cubit/cubit_crud_kelas/crud_kelas_cubit.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_role_demo/cubit/cubit_crud_kelas/crud_kelas_state.dart';
// import 'package:flutter_role_demo/cubit/cubit_data_kelas_siswa/data_siswa_kelas_cubit.dart';
// import 'package:flutter_role_demo/presentation/screen/data_siswa_screen.dart';

// class CrudKelasScreen extends StatelessWidget {
//   CrudKelasScreen({super.key});

//   final kelasController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Data Kelas')),
//       drawer: Drawer(
//         child: Column(
//           children: [
//             const DrawerHeader(
//               child: Text(
//                 'Daftar kelas',
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//             ),
//             Expanded(
//               child: BlocBuilder<CrudKelasCubit, CrudKelasState>(
//                 builder: (context, state) {
//                   return ListView.builder(
//                     itemCount: state.kelas.length,
//                     itemBuilder: (context, index) {
//                       return ListTile(
//                         title: Text(state.kelas[index]),
//                         onTap: () {
//                           Navigator.pop(context);
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder:
//                                   (context) => DataSiswaScreen(
//                                     namaKelas: state.kelas[index],
//                                   ),
//                             ),
//                           );
//                         },
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 ElevatedButton.icon(onPressed: () {
//                   Navigator.pushReplacementNamed(context, '/home');
//                 },
//                 icon: Icon(Icons.login_outlined),
//                 label: const Text('Log-out'),
//                  )
//               ],
//             )
//           ],
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextFormField(
//               controller: kelasController,
//               decoration: const InputDecoration(
//                 labelText: 'Kelas',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: () {
//                 if (kelasController.text.isNotEmpty) {
//                   context.read<CrudKelasCubit>().addKelas(kelasController.text);
//                   kelasController.clear();
//                 }
//               },
//               child: const Text('Simpan'),
//             ),
//             const SizedBox(height: 15),
//             Expanded(
//               child: BlocBuilder<CrudKelasCubit, CrudKelasState>(
//                 builder: (context, state) {
//                   return ListView.builder(
//                     itemCount: state.kelas.length,
//                     itemBuilder: (context, index) {
//                       return Card(
//                         child: ListTile(
//                           title: Text(state.kelas[index]),
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder:
//                                     (context) => BlocProvider(
//                                       create:
//                                           (context) => DataSiswaKelasCubit(),
//                                       child: DataSiswaScreen(
//                                         namaKelas: state.kelas[index],
//                                       ),
//                                     ),
//                               ),
//                             );
//                           },
//                           trailing: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               // Tombol Edit
//                               IconButton(
//                                 icon: const Icon(Icons.edit),
//                                 onPressed: () {
//                                   final editController = TextEditingController(
//                                     text: state.kelas[index],
//                                   );
//                                   showDialog(
//                                     context: context,
//                                     builder:
//                                         (_) => AlertDialog(
//                                           title: const Text('Edit Kelas'),
//                                           content: TextField(
//                                             controller: editController,
//                                             decoration: const InputDecoration(
//                                               hintText: 'Nama kelas baru',
//                                             ),
//                                           ),
//                                           actions: [
//                                             TextButton(
//                                               onPressed: () {
//                                                 if (editController
//                                                     .text
//                                                     .isNotEmpty) {
//                                                   context
//                                                       .read<CrudKelasCubit>()
//                                                       .editKelas(
//                                                         index,
//                                                         editController.text,
//                                                       );
//                                                   Navigator.pop(context);
//                                                 }
//                                               },
//                                               child: const Text('Simpan'),
//                                             ),
//                                             TextButton(
//                                               onPressed:
//                                                   () => Navigator.pop(context),
//                                               child: const Text('Batal'),
//                                             ),
//                                           ],
//                                         ),
//                                   );
//                                 },
//                               ),
//                               // Tombol Hapus
//                               IconButton(
//                                 icon: const Icon(Icons.delete),
//                                 onPressed: () {
//                                   context.read<CrudKelasCubit>().deleteKelas(
//                                     index,
//                                   );
//                                 },
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
