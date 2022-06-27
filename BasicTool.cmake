# 添加第三方依赖包
set(Fetch_Name "BasicTool")
set(Fetch_Url  "git@github.com:Matrix-Ke/MBasicTool.git")
set(Output_Dir  "${CMAKE_CURRENT_SOURCE_DIR}/${Fetch_Name}")
Fetchcontent_declare(
    ${Fetch_Name}	#库名字
    GIT_REPOSITORY  ${Fetch_Url}	# 仓库地址
    # GIT_TAG v1.x # 库版本
    SOURCE_DIR  ${Output_Dir}# 指定库下载地址
    )
FetchContent_MakeAvailable(${Fetch_Name})

if(TARGET ${Fetch_Name})
    # option(SPDLOG_BUILD_EXAMPLE "" OFF)
    # option(SPDLOG_INSTALL "" OFF)
    # add_subdirectory(_deps/${Fetch_Name})
    set_target_properties(${Fetch_Name} PROPERTIES FOLDER ${Fetch_Name})
    message(STATUS  ${Fetch_Name}:" ${Fetch_Name} target add successfully")
endif()

#==============================设置变量控制include===========================
set(${Fetch_Name}_FOUND TRUE)