## Qt项目公共库

================================================

作者：康林（kl222@126.com)

------------------------------------------------

### 功能

本人Qt项目的一些公共库

- [x] 关于对话框
- [x] 在线更新

------------------------------------------------

- [![Windows 编译状态](https://ci.appveyor.com/api/projects/status/cy6jwbbysuj7t1wp/branch/master?svg=true)](https://ci.appveyor.com/project/KangLin/rabbitcommon/branch/master)
- [![Linux 编译状态](https://travis-ci.org/KangLin/RabbitCommon.svg?branch=master)](https://travis-ci.org/KangLin/RabbitCommon)

------------------------------------------------

### 编译
- 建立并进入build目录

        git clone --recursive https://github.com/KangLin/RabbitCommon.git
        cd RabbitCommon
        mkdir build

- 编译
  + 用 qmake 

        cd build
        qmake ../RabbitCommon.pro
        make install
    
  + 用 cmake
  
        cd build
        cmake .. -DQt5_DIR=${QT_ROOT}/lib/cmake/Qt5
        cmake --build .

------------------------------------------------

### 使用
- 直接用源码
  + 是QT工程
    - 子模块方式：
      + 增加子模块：
      
            git submodule add https://github.com/KangLin/RabbitCommon.git 3th_libs/RabbitCommon
      
      + 在工程文件(.pro)中直接引入 RabbitCommon.pri

            include(3th_libs/RabbitCommon/RabbitCommon.pri)

    - 非子模块方式：在环境变量（RabbitCommon_DIR） 或 QMAKE参数 （RabbitCommon_DIR） 
      中指定 RabbitCommon 源码根目录的位置，然后在主工程文件（.pro）中加入下列：
    
            isEmpty(RabbitCommon_DIR): RabbitCommon_DIR=$$(RabbitCommon_DIR)
            !isEmpty(RabbitCommon_DIR): exists("$${RabbitCommon_DIR}/Src/RabbitCommon.pri"){
                DEFINES += RABBITCOMMON
                include($${RabbitCommon_DIR}/Src/RabbitCommon.pri)
            } else{
                message("1. Please download RabbitCommon source code from https://github.com/KangLin/RabbitCommon ag:")
                message("   git clone https://github.com/KangLin/RabbitCommon.git")
                message("2. Then set value RabbitCommon_DIR to download root dirctory")
            }
    
  + cmake工程
    - 子模块方式
    
            add_subdirectory(3th_libs/RabbitCommon/Src)
        
    - 非子模块方式
    
            set(RabbitCommon_DIR $ENV{RabbitCommon_DIR} CACHE PATH "Set RabbitCommon source code root directory.")
            if(EXISTS ${RabbitCommon_DIR}/Src)
                add_subdirectory(${RabbitCommon_DIR}/Src ${CMAKE_BINARY_DIR}/RabbitCommon)
            else()
                message(FATAL_ERROR 
                "1. Please download RabbitCommon source code from https://github.com/KangLin/RabbitCommon ag:"
                "   git clone https://github.com/KangLin/RabbitCommon.git"
                "2. Then set cmake value or environment variable RabbitCommon_DIR to download root dirctory."
                "    ag:"
                "       cmake -DRabbitCommon_DIR= ")
            endif()

- 加载翻译资源
  + 用库中提供的函数

        CTools::Instance()->InitTranslator();

  + 自定义
  
        QString szPre;    
        #if defined(Q_OS_ANDROID) || _DEBUG
            szPre = ":/Translations";
        #else
            szPre = qApp->applicationDirPath() + QDir::separator() + ".." + QDir::separator() + "translations";
        #endif
        m_Translator.load(szPre + "/RabbitCommon_" + QLocale::system().name() + ".qm");
        qApp->installTranslator(&m_Translator);
        
------------------------------------------------

### 下载
https://github.com/KangLin/RabbitCommon/releases/latest

------------------------------------------------

## 捐赠
- 捐赠(大于￥20)：  
![捐赠( 大于 ￥20 )](https://raw.githubusercontent.com/KangLin/Tasks/master/Src/Resource/image/Contribute.png "捐赠(大于￥20)")

- 捐赠￥20  
![捐赠￥20](https://raw.githubusercontent.com/KangLin/Tasks/master/Src/Resource/image/Contribute20.png "捐赠￥20")

------------------------------------------------

### [许可协议](License.md "License.md")