//
//  Interface.h
//  MyFramework
//
//  Created by 张发政 on 2017/1/6.
//  Copyright © 2017年 zhangfazheng. All rights reserved.
//

#ifndef Interface_h
#define Interface_h


/**完整url*/
//http://apis.baidu.com/apistore/idservice/id
//#define BaseURL @"http://192.168.1.103:8080/Operation"
#define BaseURL @"http://192.168.1.82:8080/Operation"
//#define BaseURL @"http://192.168.88.220:8080/Operation"
//#define BaseURL @"http://c.m.163.com/"

/**国内天气预报融合版－－－－－apikey*/

// 获取RSA公钥
#define GetInstrumentData @"phone/IOSController/selectAllTable.do"
#define    PhoneLogin @"phone/PhoneLoginController/phoneLogin.do"
#define PhoneLogin2 @"phone/LoginController/test.do"

//新建手术器械
#define CreateInstrument @"phone/IOSController/addInstrument.do"

//新建手术包
#define CreatePackage @"phone/IOSController/addPackage.do"

//编辑手术器械
#define UpdateInstrument @"phone/IOSController/updateInstrumentById.do"

//修改的包和器械的状态
#define updatePackAndInstStatus @"phone/IOSController/updatePackAndInstInfo.do"

//查询某段时间以后的器械列表
#define GetInstrumentByTime @"phone/IOSController/getInstrumentListByTime.do"

//获取日志信息
#define GetLogInfo @"phone/IOSController/getLogInfoList.do"
#define GetLogInfoByCondition @"phone/IOSController/getLogInfoListByCondition.do"

//删除器械
#define DeleteInstrument @"phone/IOSController/deleteInstrumentByITag.do"

//修改密码
#define UpdatePassword @"phone/IOSController/updatePasswordById.do"

#endif /* Interface_h */

