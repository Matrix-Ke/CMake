# ====================================全局设置================================
set(CMAKE_DEBUG_POSTFIX "_d")

# 设置c++ 版本 目前选择17版
set(CMAKE_CXX_STANDARD 17) # 方法一，全局设置
set(CMAKE_CXX_FLAGS "/GR-") # 设置关闭RTTI
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/CMake)# 设置Include路径
# 输出目录划分
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${PROJECT_SOURCE_DIR}/Bin")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${PROJECT_SOURCE_DIR}/Bin")

#===============================引入cmake内置包========================
include(FetchContent)

# Cmake划分目录
set_property(GLOBAL PROPERTY USE_FOLDERS ON)



# 方法二，通过依赖的方式设置
# set_target_properties(${TARGET_NAME} PROPERTIES CXX_STANDARD 17)
# add_library(CPP_compiler_flags  INTERFACE)
# target_compile_features(CPP_compiler_flags INTERFACE cxx_std_14)
# set(gcc_like_cxx "$<COMPILE_LANG_AND_ID:CXX,ARMClang,AppleClang,Clang,GNU,LCC>")
# set(msvc_cxx "$<COMPILE_LANG_AND_ID:CXX,MSVC>")
# target_compile_options(CPP_compiler_flags INTERFACE
# "$<${gcc_like_cxx}:$<BUILD_INTERFACE:-Wall;-Wextra;-Wshadow;-Wformat=2;-Wunused>>"
# "$<${msvc_cxx}:$<BUILD_INTERFACE:-W3>>"
# )

# # #尽量不要是强制使用set(CMAKE_BUILD_TYPE release)这种形式， 把配置写死在代码中,如果没有buildType就提供STRING提示选择
# set(DefaultBuildType "Release")
# if(NOT CMAKE_CONFIGURATION_TYPES)  #AND NOT CMAKE_BUILD_TYPE
# message(STATUS "Setting build type to '${DefaultBuildType}' as none was specified.")
# set(CMAKE_CONFIGURATION_TYPES "${DefaultBuildType}" CACHE STRING "Choose the type of build." FORCE)
# # Set the possible values of build type for cmake-gui
# set_property(CACHE CMAKE_CONFIGURATION_TYPES PROPERTY STRINGS
# "Debug" "Release" "Profile" "Ship")
# endif()
if(NOT SET_UP_CONFIGURATIONS_DONE)
    set(SET_UP_CONFIGURATIONS_DONE TRUE)

    # No reason to set CMAKE_CONFIGURATION_TYPES if it's not a multiconfig generator
    # Also no reason mess with CMAKE_BUILD_TYPE if it's a multiconfig generator.
    get_property(isMultiConfig GLOBAL PROPERTY GENERATOR_IS_MULTI_CONFIG)

    if(isMultiConfig)
        set(CMAKE_CONFIGURATION_TYPES "Debug;Release;Profile" CACHE STRING "" FORCE)
    else()
        if(NOT CMAKE_BUILD_TYPE)
            message("Defaulting to release build.")
            set(CMAKE_BUILD_TYPE Release CACHE STRING "" FORCE)
        endif()

        set_property(CACHE CMAKE_BUILD_TYPE PROPERTY HELPSTRING "Choose the type of build")

        # set the valid options for cmake-gui drop-down list
        set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug;Release;Profile")
    endif()

    # now set up the Profile configuration
    # set(CMAKE_C_FLAGS_PROFILE "...")
    set(CMAKE_CXX_FLAGS_PROFILE "${CMAKE_CXX_FLAGS_RELEASE}")
    set(CMAKE_EXE_LINKER_FLAGS_PROFILE "${CMAKE_EXE_LINKER_FLAGS_RELEASE}")
    set(CMAKE_SHARED_LINKER_FLAGS_PROFILE "${CMAKE_SHARED_LINKER_FLAGS_RELEASE}")
endif()

#==============================设置变量控制include===========================
set(SetupProject_FOUND TRUE)