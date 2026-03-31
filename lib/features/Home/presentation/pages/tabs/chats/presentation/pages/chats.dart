import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lux_estate/core/constants.dart';
import 'package:lux_estate/core/theme/app_colors.dart';
import 'package:lux_estate/core/theme/app_sizes.dart';
import 'package:lux_estate/features/Home/presentation/pages/tabs/chats/domain/entity/chat_message.dart';
import 'package:lux_estate/features/search/presentation/pages/widgets/search_appbar/search_appbar.dart';

class MessagesTab extends StatelessWidget {
  const MessagesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:
            AppColors.backgroundWhite, // Soft background from image

        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSizes.spaceM.verticalSpace,

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Text(
                'Messages',
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SearchSection(hasFilter: false, hintText: "Search"),
            // _buildSearchBar(),
            Expanded(child: _buildChatList()),
          ],
        ),
      ),
    );
  }

  Widget _buildChatList() {
    // Dummy Data
    final List<ChatMessage> chats = [
      ChatMessage(
        name: 'Elena Vance',
        lastMessage: 'The penthouse contract is rea...',
        time: 'JUST NOW',
        isOnline: true,
      ),
      ChatMessage(
        name: 'Marcus Thorne',
        lastMessage: 'I\'ve scheduled the private tour f...',
        time: '2H AGO',
      ),
      ChatMessage(
        name: 'Sophia Chen',
        lastMessage: 'The panoramic photos you requ...',
        time: 'YESTERDAY',
      ),
      ChatMessage(
        name: 'Aura Development Group',
        lastMessage: 'Phase 2 pre-sales are now open ...',
        time: 'AUG 12',
        isDeveloper: true,
      ),
      ChatMessage(
        name: 'Julian Rossi',
        lastMessage: 'Looking forward to hearing your ...',
        time: 'AUG 10',
      ),
      ChatMessage(
        name: 'Marcus Thorne',
        lastMessage: 'I\'ve scheduled the private tour f...',
        time: '2H AGO',
      ),
      ChatMessage(
        name: 'Marcus Thorne',
        lastMessage: 'I\'ve scheduled the private tour f...',
        time: '2H AGO',
      ),
      ChatMessage(
        name: 'Marcus Thorne',
        lastMessage: 'I\'ve scheduled the private tour f...',
        time: '2H AGO',
      ),
      ChatMessage(
        name: 'Aura Development Group',
        lastMessage: 'Phase 2 pre-sales are now open ...',
        time: 'AUG 12',
        isDeveloper: true,
      ),
    ];

    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      itemCount: chats.length,
      separatorBuilder: (context, index) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        final chat = chats[index];
        return _buildChatTile(chat);
      },
    );
  }

  Widget _buildChatTile(ChatMessage chat) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 30.r,
                backgroundColor: const Color(0xFFE0E0E0),
                backgroundImage: chat.isDeveloper
                    ? null
                    : AssetImage(AppAssetsPath.villa),
                child: chat.isDeveloper
                    ? Icon(Icons.business, color: Colors.black54, size: 30.sp)
                    : null,
              ),
              if (chat.isOnline)
                Positioned(
                  right: 2,
                  bottom: 2,
                  child: Container(
                    height: 12.w,
                    width: 12.w,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      chat.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                    Text(
                      chat.time,
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                        color: chat.time == 'JUST NOW'
                            ? Colors.cyan
                            : Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        chat.lastMessage,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                    if (chat.isDeveloper)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.greenAccent.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          'DEVELOPER',
                          style: TextStyle(
                            fontSize: 8.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade700,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
