// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';

// import '../../blocs/chat/chat_bloc.dart';
// import '../../entities/chat/chat_entity.dart';
// import '../../utils/app_color.dart';
// import '../../utils/app_text.dart';
// import '../../utils/validators.dart';
// import '../web/web_animation_cursor.dart';
// import '../web/web_chat_widget.dart';

// class ChatPage extends StatelessWidget {
//   const ChatPage({
//     super.key,
//     required this.id,
//     required this.chatBloc,
//   });

//   final String id;
//   final ChatBloc chatBloc;

//   @override
//   Widget build(BuildContext context) {
//     return AnnotatedRegion(
//       value: SystemUiOverlayStyle(
//         statusBarColor:
//             colorPrimaryDark.withOpacity(0.5), // ubah warna status bar disini
//       ),
//       child: BlocProvider<ChatBloc>(
//         create: (context) => ChatBloc()..add(ChatOnTapHistoryIdEvent(id)),
//         child: Scaffold(
//           appBar: AppBar(
//             backgroundColor: colorPrimaryDark,
//             leadingWidth: 35,
//             title: AppText.labelW600(
//               "ArBot $id",
//               18,
//               Colors.white,
//             ),
//             elevation: 0,
//           ),
//           body: StreamBuilder<ChatEntity>(
//             stream: chatBloc.apiService.streamChat(id),
//             builder: (context, snapshot) {
//               return SingleChildScrollView(
//                 reverse: true,
//                 child: Padding(
//                   padding: const EdgeInsets.only(
//                       top: 18.0, right: 16, left: 16, bottom: 50),
//                   child: BlocBuilder<ChatBloc, ChatState>(
//                     builder: (context, state) {
//                       return Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Column(
//                             children: List.generate(
//                               snapshot.data?.messages.length ?? 0,
//                               (index) {
//                                 final data = snapshot.data?.messages[index];
//                                 if (data!.role == "user") {
//                                   return WebChatUserWidget(data: data);
//                                 }
//                                 return WebChatBotWidget(
//                                   data: data,
//                                   isLastMessage: (index ==
//                                           snapshot.data!.messages.length - 1 &&
//                                       !data.isRead),
//                                   chatBloc: chatBloc,
//                                 );
//                               },
//                             ),
//                           ),
//                           state.isTyping
//                               ? const Padding(
//                                   padding: EdgeInsets.symmetric(vertical: 18.0),
//                                   child: WebAnimationCursor(),
//                                 )
//                               : const SizedBox(),
//                         ],
//                       );
//                     },
//                   ),
//                 ),
//               );
//             },
//           ),
//           floatingActionButtonLocation:
//               FloatingActionButtonLocation.centerDocked,
//           floatingActionButton: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 14),
//             height: 65,
//             child: BlocBuilder<ChatBloc, ChatState>(
//               builder: (context, state) {
//                 return Row(
//                   children: [
//                     if (!state.isVoice)
//                       Expanded(
//                         child: TextFormField(
//                           controller: chatBloc.tcQuestion,
//                           validator: (val) => Validators.requiredField(val!),
//                           style: GoogleFonts.montserrat(
//                             color: Colors.grey.shade600,
//                           ),
//                           textInputAction: TextInputAction.done,
//                           onEditingComplete: () =>
//                               chatBloc.add(ChatOnSendMessageEvent()),
//                           decoration: InputDecoration(
//                             fillColor: Colors.white,
//                             filled: true,
//                             hintStyle: GoogleFonts.montserrat(
//                               color: const Color(0xFFA2A4A8),
//                             ),
//                             contentPadding: const EdgeInsets.symmetric(
//                                 vertical: 0, horizontal: 12),
//                             hintText: "Ketik pertanyaan...",
//                             enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: Colors.grey.shade300,
//                                 width: 1,
//                               ),
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: Colors.grey.shade400,
//                                 width: 1,
//                               ),
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                           ),
//                         ),
//                       ),
//                     if (!state.isVoice)
//                       const SizedBox(
//                         width: 12,
//                       ),
//                     if (state.isVoice)
//                       Expanded(
//                         child: AnimatedContainer(
//                           duration: const Duration(seconds: 1),
//                           height: 48,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(8),
//                             color: Colors.red,
//                           ),
//                           child: IconButton(
//                             onPressed: () => chatBloc.add(ChatOnVoiceEvent()),
//                             icon: const Icon(
//                               Icons.stop_rounded,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ),
//                     if (!state.isVoice)
//                       AnimatedContainer(
//                         duration: const Duration(seconds: 1),
//                         height: 48,
//                         width: 48,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8),
//                           color: const Color(0xFF0E85D1),
//                         ),
//                         child: IconButton(
//                           onPressed: () => chatBloc.add(ChatOnVoiceEvent()),
//                           icon: const Icon(
//                             Icons.mic_rounded,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                   ],
//                 );
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
