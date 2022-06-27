include(FetchContent)

# FetchContent_MakeAvailable was not added until CMake 3.14
if(${CMAKE_VERSION} VERSION_LESS 3.14)
    include(add_FetchContent_MakeAvailable.cmake)
endif()

set(SPDLOG_GIT_TAG v1.4.1) # 指定版本
set(SPDLOG_GIT_URL https://github.com/Matrix-Ke/CMakeInit.git) # 指定git仓库地址

FetchContent_Declare(
    spdlog
    GIT_REPOSITORY ${SPDLOG_GIT_URL}
    GIT_TAG ${SPDLOG_GIT_TAG}
)

FetchContent_MakeAvailable(spdlog)

# ============使用方式===============
# 在CMakeLists.txt中，包含cmake/CMakeFetchContent.cmake，便可将项目作为library来使用了(主义cmake最小版本应当设置为3.14)
include(cmake/CMakeFetchContent.cmake)
include(CMakeInit)
target_link_libraries(test_demo PRIVATE CMakeInit)

#==============================设置变量控制include===========================
set(CMakeFetchContent_FOUND TRUE)