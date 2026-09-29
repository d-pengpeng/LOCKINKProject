//
//  requestUrlRFile.h
//  AuctionLiveProject
//
//  Created by Edwin on 2023/5/3.
//

#ifndef requestUrlRFile_h
#define requestUrlRFile_h



//外网
#define INTERFACEADDRESS @"http://106.55.181.135:8081/"
#define socketWSUrl @"ws://106.55.181.135:8081/ws"


//三期开发
#define request_waveform_ab_save @"waveform/ab/save"
#define request_waveform_ab_pageWaveform @"waveform/ab/pageWaveform"
#define request_waveform_ab_batchDelete @"waveform/ab/batchDelete"


//二期开发
#define request_waveform_save @"waveform/save"
#define request_waveform_listFeel @"waveform/listFeel"
#define request_waveform_pageWaveform @"waveform/pageWaveform"
#define request_waveform_batchDelete @"waveform/batchDelete"




//登录
#define request_login_countries @"country/countries"
#define request_login_sendVerificationCode @"oauth/sendVerificationCode"
#define request_login_login @"oauth/login"
#define request_login_register @"oauth/register"
#define request_login_retrievePassword @"oauth/retrievePassword"
#define request_login_logout @"oauth/logout"
#define request_login_changeBinding @"oauth/changeBinding"
#define request_login_modifyPassword @"oauth/modifyPassword"
#define request_oauth_checkVerificationCode @"oauth/checkVerificationCode"


#define request_other_getAllServiceUid @"other/getServiceUid"


#define request_login_uploadImages @"upload/uploadImages"
#define request_upload_getTmpCredential @"upload/getTmpCredential"
#define request_carousel_listAll @"carousel/listAll"
#define request_config_get @"config/get"


//首页
#define request_device_listAll @"device/listAll"
#define request_device_saveOrUpdate @"device/saveOrUpdate"
#define request_device_chooseRole @"device/chooseRole"
#define request_device_generateInvitationRecord @"device/generateInvitationRecord"
#define request_seekingMasterRecord_post @"seekingMasterRecord/post"
#define request_device_detail @"device/detail"
#define request_voteRecord_pageVoteRecord @"voteRecord/pageVoteRecord"
#define request_voteRecord_post @"voteRecord/post"
#define request_device_addScheduledElectricShock @"device/addScheduledElectricShock"
#define request_device_pageLocationLockLog @"device/pageLocationLockLog"
#define request_device_changeRole @"device/changeRole"
#define request_device_getInvitationRecord @"device/getInvitationRecord"
#define request_device_acceptOrDeclineInvitation @"device/acceptOrDeclineInvitation"
#define request_device_forcedUnlocks @"device/forcedUnlocks"
#define request_device_operatingPermissions @"device/operatingPermissions"
#define request_device_applyForUnlock @"device/applyForUnlock"
#define request_device_pageLocationLockCloseLog @"device/pageLocationLockCloseLog"
#define request_device_deleteLocationLockCloseLog @"device/deleteLocationLockCloseLog"
#define request_device_clearLocationLockCloseLog @"device/clearLocationLockCloseLog"
#define request_device_pageDeviceLog @"device/pageDeviceLog"
#define request_device_forceUnbind @"device/forceUnbind"
#define request_device_togglePublicityStatus @"device/togglePublicityStatus"
#define request_device_updateDeviceName @"device/updateDeviceName"
#define request_device_unlink @"device/unlink"
#define request_device_generatePermissionTransferRecord @"device/generatePermissionTransferRecord"
#define request_device_getTimeVoucherList @"device/getTimeVoucherList"
#define request_device_useTimeVoucher @"device/useTimeVoucher"
#define request_device_activeHardcoreMode @"device/activeHardcoreMode"
#define request_device_relieveHardcoreMode @"device/relieveHardcoreMode"

#define request_device_generateTimeVoucher @"device/generateTimeVoucher"
#define request_device_getScheduledElectricShockList @"device/getScheduledElectricShockList"
#define request_device_deleteScheduledElectricShock @"device/deleteScheduledElectricShock"
#define request_device_saveLocationLockInfo @"device/saveLocationLockInfo"
#define request_device_switchLocationLockRecordStatus @"device/switchLocationLockRecordStatus"
#define request_device_getRandomPhrase @"device/getRandomPhrase"
#define request_device_connectOrDisconnect @"device/connectOrDisconnect"
#define request_device_terminateRemoteConnect @"device/terminateRemoteConnect"
#define request_device_getRemainingRoles @"device/getRemainingRoles"
#define request_device_getPermissionTransferRecord @"device/getPermissionTransferRecord"
#define request_device_acceptOrDeclinePermissionTransfer @"device/acceptOrDeclinePermissionTransfer"
#define request_device_deleteTimeVoucher @"device/deleteTimeVoucher"
#define request_voteRecord_getInProgressVoteRecord @"voteRecord/getInProgressVoteRecord"


//广场
#define request_square_pageFollowUpActivity @"square/pageFollowUpActivity"
#define request_square_pageRecommendedActivity @"square/pageRecommendedActivity"
#define request_square_pageToysActivity @"square/pageToysActivity"
#define request_square_likeOrDislike @"activity/likeOrDislike"
#define request_square_post @"activity/post"
#define request_square_getRankings @"square/getRankings"
#define request_square_joinEnduranceRanking @"square/joinEnduranceRanking"
#define request_square_joinBatteryRanking @"square/joinBatteryRanking"
#define request_comment_pageComment @"comment/pageComment"
#define request_comment_post @"comment/post"
#define request_square_processApplicationOrVote @"square/processApplicationOrVote"
#define request_square_detail @"square/detail"
#define request_comment_reply @"comment/reply"
#define request_square_listProduct @"square/listProduct"
#define request_other_listReportCategory @"other/listReportCategory"
#define request_comment_delete @"comment/delete"
#define request_comment_likeOrDislike @"comment/likeOrDislike"
#define request_square_listParticipant @"square/listParticipant"


//发现
#define request_other_filterSignal @"other/filterSignal"
#define request_other_publishSignal @"other/publishSignal"
#define request_other_getSignalBasicInfo @"other/getSignalBasicInfo"




//消息
#define request_message_pageBoundDevice @"message/pageBoundDevice"
#define request_user_userSearch @"user/userSearch"
#define request_message_pageDeviceMessage @"message/pageDeviceMessage"
#define request_message_pageSystemMessage @"message/pageSystemMessage"
#define request_message_pageInteractiveMessage @"message/pageInteractiveMessage"
#define request_message_acceptOrDeclineActiveHardcoreMode @"message/acceptOrDeclineActiveHardcoreMode"
#define request_message_acceptOrDeclineRelieveHardcoreMode @"message/acceptOrDeclineRelieveHardcoreMode"

#define request_message_acceptOrDeclineUnlockRequest @"message/acceptOrDeclineUnlockRequest"
#define request_message_acceptOrDeclineBeMater @"message/acceptOrDeclineBeMater"
#define request_message_getMessageOverview @"message/getMessageOverview"



//我的
#define request_user_me @"user/me"
#define request_user_other @"user/other"
#define request_user_pageOtherActivity @"activity/pageOtherActivity"
#define request_user_pageTimelineAlbum @"album/pageTimelineAlbum"
#define request_album_upload @"album/upload"
#define request_album_pageOwnToysActivity @"square/pageOwnToysActivity"
#define request_device_pageDevice @"device/pageDevice"
#define request_user_pageGuestRecord @"user/pageGuestRecord"
#define request_user_followOrUnfollow @"follow/followOrUnfollow"
#define request_user_pageFollowing @"follow/pageFollowing"
#define request_user_pageFollower @"follow/pageFollower"
#define request_user_updateProfile @"user/updateProfile"
#define request_user_updateBg @"user/updateBg"
#define request_user_updateInfo @"user/updateInfo"
#define request_faq_listAll @"faq/listAll"
#define request_feedback_report @"feedback/report"
#define request_other_getAboutUs @"other/getAboutUs"
#define request_other_checkUpdate @"other/checkUpdate"
#define request_other_complaint @"other/complaint"
#define request_user_updateQuote @"user/updateQuote"
#define request_album_batchDelete @"album/batchDelete"
#define request_activity_deleteActivity @"activity/deleteActivity"
#define request_other_blockOrUnblock @"other/blockOrUnblock"
#define request_other_pageBlackList @"other/pageBlackList"
#define request_config_establishLink @"config/establishLink"
#define request_config_listAccountLink @"config/listAccountLink"
#define request_config_deleteLink @"config/deleteLink"

//获取im userSig
#define request_user_getUserSig  @"im/getUserSig"

//聊天门卫：发送消息前校验是否放行
#define request_im_beforeSendCheck @"im/beforeSendCheck"


//七牛
#define request_Member_getQiniuToken @"api/Member/getQiniuToken"


#endif /* requestUrlRFile_h */
