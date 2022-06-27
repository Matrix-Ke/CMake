# 添加第三方依赖包
Fetchcontent_declare(
    spdlog	#库名字
    GIT_REPOSITORY  git@github.com:gabime/spdlog.git	# 仓库地址
    GIT_TAG v1.x # 库版本
    SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/_deps/spdlog # 指定库下载地址
    )
FetchContent_MakeAvailable(spdlog)

if(TARGET spdlog)
    option(SPDLOG_BUILD_EXAMPLE "" OFF)
    option(SPDLOG_INSTALL "" OFF)
    option(spdlog-utests  OFF)
    # add_subdirectory(_deps/spdlog)
    set_target_properties(spdlog PROPERTIES FOLDER BasicTool)
    message(STATUS  spdlog:" spdlog target add successfully")
endif()