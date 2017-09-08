//
//  YLBlockType.h
//  YLDraw
//
//  Created by simpletour on 16/1/30.
//  Copyright © 2016年 duyulong. All rights reserved.
//

#ifndef YLBlockType_h
#define YLBlockType_h

#define kYLKeyForBlockType (@"kYLKeyForBlockType")
#define kYLModel           (@"kYLModel")
#define kYLValue           (@"kYLValue")
#define kYLUsername        (@"kYLUsername")
#define kYLPassword        (@"kYLPassword")

typedef NS_ENUM(NSUInteger, YLBlockType) {
    
    //========================================= 企业版  ====================================
    /********   组件    **********/
    kYLBlockTypeTabsView,
    kYLBlockTypePickerShow,
    kYLBlockTypePickerFinish,
    kYLBlockTypeTabChange,
    
    kYLBlockTypePickerRadioClick,
    
    kYLBlockTypePhotoOption,
    kYLBlockTypePhotoLibrary,
    kYLBlockTypePhotoCamera,
    kYLBlockTypePhotoResult,
    
    kYLBlockTypeBannerClick,
    
    kYLBlockTypeBeginEditing,
    kYLBlockTypeSearchBarSearch,
    kYLBlockTypeSearchBarCancel,
    kYLBlockTypeSearchBarClear,
    
    kYLBlockTypeWebLoadFinish,
    
    /********   首页  **********/
    kYLBlockTypeHomeBusiness,
    kYLBlockTypeHomeTax,
    kYLBlockTypeHomeBuild,
    kYLBlockTypeHomeEconomy,
    kYLBlockTypeHomeOpen,
    
    //企业通讯录进入详情
    kDDBlockTypeEnterpriseContactDeatil,
    
    kDDBlockTypePopToEnterprise,
    
    /********   新闻  **********/
    kYLBlockTypeNewsDetail,
    
    /********   消息  **********/
    kYLBlockTypeMessageSystem,
    kYLBlockTypeMessageDetail,
    
    /********   搜索  **********/
    kYLBlockTypeSearchTag,
    
    /********   评论 **********/
    kYLBlockTypePost,
    kYLBlockTypeCommentDetail,
    kYLBlockTypeCommentSend,
    kYLBlockTypeCommentReply,
    
    /********   收藏  **********/
    kYLBlockTypeCollectAdd,
    kYLBlockTypeCollectCancel,
    
    /********   个人中心  **********/
    kYLBlockTypeUserCenterEnterpriseContact,
    kYLBlockTypeUserCenterCollect,
    kYLBlockTypeUserCenterEnterprise,
    kYLBlockTypeUserCenterPolicy,
    kYLBlockTypeUserCenterOffice,
    kYLBlockTypeUserCenterNotification,
    kYLBlockTypeUserCenterForum,
    kYLBlockTypeUserCenterMessage,
    kYLBlockTypeUserCenterEnterPriseData,
    kYLBlockTypeUserCenterEnterPriseAuth,
    kYLBlockTypeUserCenterSetting,
    kYLBlockTypePersonInfo,
    kYLBlockTypePersonInfoAvatar,
    kYLBlockTypePersonInfoNickname,
    kYLBlockTypePersonInfoSex,
    kYLBlockTypePersonInfoPhone,
    kYLBlockTypePersonInfoChangePassword,
    
    //设置
    kYLBlockTypeSettingClearCache,
    kYLBlockTypeSettingFeedback,
    kYLBlockTypeSettingAbout,
    
    //分享
    kYLBlockTypeShareShow,
    kYLBlockTypeShareHide,
    kYLBlockTypeShareWeChatFriend,
    kYLBlockTypeShareWeChatCycle,
    
    kDDBlockTypeShareLifeVersionChatFriend,
    kDDBlockTypeShareLifeVersionChatCycle,
    
    
    /********   登录注册  **********/
    kYLBlockTypeLogin,
    kYLBlockTypeLoginout,
    kYLBlockTypeRegister,
    kYLBlockTypeMessageCode,
    kYLBlockTypeForgetPassword,
    
    //通讯录搜索类型
    
    kDDBlockTypeCompany,
    kDDBlockTypeRegisterType,
    kDDBlockTypeIndustry,
    kDDBlockTypeLegalPerson,
    kDDBlockTypeBusinessScope,
    kDDBlockTypeRegisterCapital,
    
    
    //======================================== 生活版  ========================
    
    /********   生活版首页  **********/
    kDDBlockTypeLifeHomeTraffic,
    kDDBlockTypeLifeHomeMovieTicket,
    kDDBlockTypeLifeHomeRecharege,
    kDDBlockTypeLifeHomeGroupBuying,
    kDDBlockTypeLifeHomeHotline,
    
    kDDBlockTypeLifeHomeNews,
    kDDBlockTypeLifeHomeAds,
    
    kDDBlockTypeLifeBus,
    kDDBlockTypeLifeBusSearch,  
    
    /********************* 社区(招聘、求职、出租、求租、柳梧圈) *********************/
    kDDBlockTypeRecruit,
    kDDBlockTypeJobWant,
    kDDBlockTypeRentOut,
    kDDBlockTypeRentWant,
    kDDBlockTypeLWQ,
    
     /********   周边 **********/
    kDDBlockTypeDelicious,
    kDDBlockTypeHotel,
    kDDBlockTypeEntertainment,
    kDDBlockTypeOther,
    
     /********   个人中心 **********/
    kDDBlockTypeReadyPayying,
    kDDBlockTypeReadyShipping,
    kDDBlockTypeReadyConfirm,
    kDDBlockTypeReadyComment,
    kDDBlockTypeReadyReturn,
    
    //我的消息
    kDDBlockTypeMyMessage,
    
    kDDBlockTypeMyOrders,
    kDDBlockTypeMySends,
    kDDBlockTypeMyTakeOuts,
    kDDBlockTypeMySetting,
    
    kDDBlockTypePersonInfo,
    
    kDDBlockTypeRadioButtonSelectedItem,
    
    //发布
    kDDBlockTypePublishAction,
    
    kDDBlockTypeDeliverRentWantValue,
    
    kDDBlockTypeDeliverRentWantTitle,
    kDDBlockTypeDeliverRentWantSummary,
    kDDBlockTypeDeliverRentWantPerson,
    kDDBlockTypeDeliverRentWantPhone,
    
    
    //拨号
    kDDBlockTypeHotlineSend,
    kDDBlockTypeHotlineInquire,
    
    kDDBlockTypeCamera,
    kDDBlockTypeAlerm,
    //发布标题
    kDDBlockTypeTitleText,
    //发布内容
    kDDBlockTypeContentText,

    kDDBlockTypeLwqImageBrowser,
    
    
    kDDBlockTypeMyNotesEdit,
    kDDBlockTypeMyNotesDelete,
    
    //查看近两笔消费
    kDDBlockTypeWatchRencentTwoConsume,
    //开通社保
    kDDBlockTypeSocialInsurnceOpen,
    //确认开通
    kDDBlockTypeSocialInsurnceOpenConfirmed,
    //社保查询
    kDDBlockTypeSocialInsurnceInquire,
    
    kDDBlockTypeBackAction,
    
    kDDPopPickerViewAction,

    
    //我的发帖 
    kDDBlockTypeNotesEdit,
    kDDBlockTypeNotesDelete,
    kDDBlockTypeNotesShow,
    kDDBlockTypeNotesHide,
    
    
    //微信充值
    kDDBlockTypeWechatPayCreateOrder,
    kDDBlockTypeWechatPayConfirmPay,
    
    kDDBlockTypeDataSubmit,
    kDDBlockTypeEnterpriseHomePage,
    kDDBlockTypeAuthSubmit,
    kDDBlockTypeDataEdit,
    
    kDDBlockTypeEnterprisesDetail,
    
};

#endif /* YLBlockType_h */




















