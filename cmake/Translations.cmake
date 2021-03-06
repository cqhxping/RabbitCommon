#GENERATED_QT_TRANSLATIONS 函数：生成 qt 翻译
#+ 功能：
#  - 生成或更新翻译源文件(.ts)，需要手动执行目标 translations_update_${TRANSLATIONS_NAME} 
#  - 生成翻译文件(.qm)
#  - 生成翻译资源文件(.qrc)，放到参数 OUT_QRC 指定的变量中
#  - 安装翻译文件(.qm)到安装目录。目录结构详见后面说明
#+ 参数：
#  - SOURCES: 要理新的源文件。默认使用变量 SOURCE_FILES 和 SOURCE_UI_FILES 之中的源文件。
#  - NAME: 生成的翻译源文件(.ts)文件名前缀，默认值 ${PROJECT_NAME}。
#    **注意**：翻译资源名为此名字加上前缀 translations_ ,它也可以由 OUT_QRC_NAME 参数指定的变量得到
#  - TSDIR: 翻译源文件(.ts)存放的目录，默认值：${CMAKE_CURRENT_SOURCE_DIR}/Resource/Translations
#  - QM_INSTALL_DIR: 指定翻译文件（.qm）的安装目录。默认值：${CMAKE_INSTAL_PREFIX}/translations
#+ 输出值参数：
#  - OUT_QRC: 生成的翻译资源文件(.qrc) 变量。
#    如果需要使用翻译资源文件，则把它加入到add_executable 或 add_library 中。
#  - OUT_QRC_NAME: 翻译资源文件名变量，它用于代码使用库中的资源时，
#    调用 Q_INIT_RESOURCE 初始化此翻译资源
#+ 使用：
#  - 在 CMakeLists.txt加入包含此文件

#        include(Translations.cmake)
  
#  - 调用 GENERATED_QT_TRANSLATIONS 函数
#    + [必选] 设置 SOURCES 参数为要更新的源文件
#    + [必选] 设置 OUT_QRC 参数为接收资源文件名变量
#    + [可选] 设置 NAME 参数为翻译源文件(.ts)文件名的前缀，默认值是目标名 ${PROJECT_NAME}。
#            **注意**：翻译资源名为此名字加上前缀 translations_ 。这个也可以由 OUT_QRC_NAME 参数指定的变量得到
#    + [可选] 设置 TSDIR 参数为翻译源文件(.ts)生成的目录。默认值是 ${CMAKE_CURRENT_SOURCE_DIR}/Resource/Translations
#    + [可选] 设置 QM_INSTALL_DIR 参数为翻译文件（.qm）的安装目录。默认值：${CMAKE_INSTAL_PREFIX}/translations
#  - 如果要使用翻译资源文件，
#    则把输出参数 OUT_QRC 后的变量值加入到 add_executable 或 add_library 中。

#        GENERATED_QT_TRANSLATIONS(SOURCES ${SOURCE_FILES} ${SOURCE_UI_FILES}
#            OUT_QRC TRANSLATIONS_RESOURCE_FILES)
#        add_executable(${PROJECT_NAME} ${TRANSLATIONS_RESOURCE_FILES})

#    在C++代码 main 中加入下列代码初始化翻译资源：

#        Q_INIT_RESOURCE(translations_${PROJECT_NAME}); 

#  - 如果不需要把翻译放入到资源文件中。在代码中从文件系统加载翻译。详见后面的程序的安装目录。
        
#        QTranslator translator;
#        translator.load(RabbitCommon::CDir::Instance()->GetDirTranslations()
#                   + "/" + qApp->applicationName() + "_" + QLocale::system().name() + ".qm");
#        qApp->installTranslator(&translator);

#  - 增加目标依赖（可选，默认会自动执行）： 

#        add_dependencies(${TRANSLATIONS_NAME} translations_${TRANSLATIONS_NAME})

#  - 在源码 main 函数中加入下列代码。
#    + 初始化翻译资源。如果是 DEBUG，需要加入宏定义 _DEBUG . 必须使用 -DCMAKE_BUILD_TYPE=Debug

#        // 如果使用了翻译资源文件，则必须加上此步，初始化翻译资源
#        // 资源文件名为 translations_ 加上 “设置的 NAME”
#        Q_INIT_RESOURCE(translations_${PROJECT_NAME});

#    + 安装翻译

#        // 安装翻译
#        QTranslator translator;
#        translator.load(RabbitCommon::CDir::Instance()->GetDirTranslations()
#                   + "/" + qApp->applicationName() + "_" + QLocale::system().name() + ".qm");
#        qApp->installTranslator(&translator);

#  - 完整的例子：
#    + CMakeLists.txt
  
#        #翻译
#        include(${CMAKE_CURRENT_SOURCE_DIR}/../cmake/Qt5CorePatches.cmake)
#        include(${CMAKE_CURRENT_SOURCE_DIR}/../cmake/Translations.cmake)
        
#        GENERATED_QT_TRANSLATIONS(SOURCES ${SOURCE_FILES} ${SOURCE_UI_FILES}
#            OUT_QRC TRANSLATIONS_RESOURCE_FILES)
#        if("Debug" STREQUAL CMAKE_BUILD_TYPE)
#            LIST(APPEND QRC_FILE 
#                ${TRANSLATIONS_RESOURCE_FILES}
#                )
#        endif()
#        add_executable(${PROJECT_NAME} ${QRC_FILE})
#        # 增加依赖（可选）
#        add_dependencies(${PROJECT_NAME} translations_${PROJECT_NAME})

#    + 源码文件(main.c)

#        // 如果使用了翻译资源文件，则必须加上此步，初始化翻译资源
#        // 资源文件名为 translations_ 加上 “设置的 NAME”
#        #ifdef _DEBUG
#            Q_INIT_RESOURCE(translations_${PROJECT_NAME});
#        #endif 
#        // 安装翻译对象
#        QTranslator translator;
#        translator.load(RabbitCommon::CDir::Instance()->GetDirTranslations()
#                   + "/" + qApp->applicationName() + "_" + QLocale::system().name() + ".qm");
#        qApp->installTranslator(&translator);


# debug 翻译资源做为资源文件嵌入程序

# android 翻译 qm 文件放在 assets 中
#
# Android:
#     assets                                       GetDirApplicationInstallRoot()  (Only read)
#        |- translations                           GetDirTranslations()
#        |        |- ${TRANSLATIONS_NAME}_zh_CN.ts
#        |        |- ${TRANSLATIONS_NAME}_zh_TW.ts

# 其它系统发行模式下，做为文件放在程序的安装目录 translations 目录下
# 程序的安装目录：
#   AppRoot |
#           |- bin
#           |   |- App.exe
#           |- lib
#           |
#           |- translations
#                 |- ${TRANSLATIONS_NAME}_zh_CN.qm
#                 |- ${TRANSLATIONS_NAME}_zh_TW.qm
#
# 源码目录：
#   SourceRoot |
#              |- App
#              |   |- Resource
#              |        |-Translations
#              |             |- ${TRANSLATIONS_NAME}_zh_CN.ts
#              |             |- ${TRANSLATIONS_NAME}_zh_TW.ts
#              |- cmake
#              |   |- Translations.cmake
#              |- Src
#                  |- Resource
#                       |-Translations
#                            |- ${TRANSLATIONS_NAME}_zh_CN.ts
#                            |- ${TRANSLATIONS_NAME}_zh_TW.ts

include (CMakeParseArguments)

function(GENERATED_QT_TRANSLATIONS)
    cmake_parse_arguments(PARA "" "NAME;TSDIR;QM_INSTALL_DIR;OUT_QRC;OUT_QRC_NAME" "SOURCES" ${ARGN})
    
    SET(TRANSLATIONS_NAME ${PROJECT_NAME})
    if(DEFINED PARA_NAME)
        SET(TRANSLATIONS_NAME ${PARA_NAME})
    endif()
    message("TRANSLATIONS_NAME:${TRANSLATIONS_NAME}")
    
    set(TS_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Resource/Translations)
    if(DEFINED PARA_TSDIR)
        set(TS_DIR ${PARA_TSDIR})
    endif()
    
    SET(TS_FILES
        #${TS_DIR}/${TRANSLATIONS_NAME}_zh.ts
        ${TS_DIR}/${TRANSLATIONS_NAME}_zh_CN.ts
        #${TS_DIR}/${TRANSLATIONS_NAME}_zh_rCN.ts
        ${TS_DIR}/${TRANSLATIONS_NAME}_zh_TW.ts
        #${TS_DIR}/${TRANSLATIONS_NAME}_zh_rTW.ts
        )

    OPTION(OPTION_TRANSLATIONS "Refresh translations on compile" ON)
    MESSAGE("Refresh translations on compile: ${OPTION_TRANSLATIONS}\n")
    IF(OPTION_TRANSLATIONS)
        FIND_PACKAGE(Qt5 CONFIG REQUIRED LinguistTools) #语言工具
        IF(NOT Qt5_LRELEASE_EXECUTABLE)
            MESSAGE(WARNING "Could not find lrelease. Your build won't contain translations.")
        ELSE(NOT Qt5_LRELEASE_EXECUTABLE)
            
            LIST(APPEND SOURCE_FILES ${SOURCE_UI_FILES})
            if(PARA_SOURCES)
                SET(SOURCE_FILES ${PARA_SOURCES})
            endif()

            OPTION(ENABLE_UPDATE_TRANSLATIONS "Use qt5_create_translation" OFF)
            if(ENABLE_UPDATE_TRANSLATIONS)
                #注：根据 https://bugreports.qt.io/browse/QTBUG-41736 ，qt5_create_translation这个宏会在make clean或rebuild时把全部ts文件都删掉后再重新生成，这意味着已经翻译好的文本会全部丢失，已有的解决方法也已经失效，而Qt官方也没有针对这个问题进行修复，因此不建议再使用这个宏了，还是手动生成ts文件再搭配qt5_add_translation比较保险。
                qt5_create_translation(QM_FILES_UPDATE ${SOURCE_FILES} ${TS_FILES}) # 生成或更新翻译源文件（.ts）和生成翻译文件（.qm） 文件
                # 手动执行目标，生成或更新翻译源文件(.ts)
                ADD_CUSTOM_TARGET(translations_update_${PROJECT_NAME} DEPENDS ${QM_FILES_UPDATE})
            endif()

            qt5_add_translation(QM_FILES ${TS_FILES}) #生成翻译文件（.qm）
            # 自动执行目标，生成翻译文件(.qm)
            ADD_CUSTOM_TARGET(translations_${PROJECT_NAME} ALL DEPENDS ${QM_FILES})
            
            #add_dependencies(${TRANSLATIONS_NAME} translations_${TRANSLATIONS_NAME})
            
            # 生成资源文件
            set(RESOURCE_FILE_NAME "${CMAKE_CURRENT_BINARY_DIR}/translations_${TRANSLATIONS_NAME}.qrc")
            file(WRITE "${RESOURCE_FILE_NAME}"
                "<!DOCTYPE RCC>
                <RCC version=\"1.0\">
                <qresource prefix=\"/translations\">
                ")
            foreach(qm ${QM_FILES})
                get_filename_component(qm_name ${qm} NAME)
                file(APPEND "${RESOURCE_FILE_NAME}"
                    "    <file alias=\"${qm_name}\">${qm}</file>\n")
            endforeach(qm)
            file(APPEND "${RESOURCE_FILE_NAME}"
                "  </qresource>
                </RCC>
                ")
            set(TRANSLATIONS_RESOURCE_FILES ${RESOURCE_FILE_NAME} PARENT_SCOPE)
            if(DEFINED PARA_OUT_QRC)
                set(${PARA_OUT_QRC} ${${PARA_OUT_QRC}} ${RESOURCE_FILE_NAME} PARENT_SCOPE)
            endif()
            if(DEFINED PARA_OUT_QRC_NAME)
                get_filename_component(OUT_QRC_NAME ${RESOURCE_FILE_NAME} NAME)
                set(${PARA_OUT_QRC_NAME} ${OUT_QRC_NAME} PARENT_SCOPE)
            endif()

            if(DEFINED PARA_QM_INSTALL_DIR)
                install(FILES ${QM_FILES} DESTINATION "${PARA_QM_INSTALL_DIR}"
                    COMPONENT Runtime)
            else()
                if(ANDROID)
                    install(FILES ${QM_FILES} DESTINATION "assets/translations"
                        COMPONENT Runtime)
                else()
                    install(FILES ${QM_FILES} DESTINATION "translations"
                        COMPONENT Runtime)
                endif()
            endif()
            
        ENDIF(NOT Qt5_LRELEASE_EXECUTABLE)
    ENDIF(OPTION_TRANSLATIONS)

endfunction()
