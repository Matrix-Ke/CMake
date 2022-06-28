#example
# 添加第三方依赖包
function(FetchContent_ForTarget)
    set(option TEST_Option)
    set(oneValueArgs TargetName Git_Url Output_Dir)
    set(multiValueArgs Other)
    cmake_parse_arguments(ArgPrefix "${option}" "${oneValueArgs}"  "${multiValueArgs}" ${ARGN})
    # 通过 prefix_参数名: 例如 ArgPrefix_TEST_Option
    message("TEST_Option = ${ArgPrefix_TEST_Option};")
    message("TargetName = ${ArgPrefix_TargetName};")
    message("Git_Url = ${ArgPrefix_Git_Url};")
    message("Other  = ${ArgPrefix_Other};")
    message("Output_Dir  = ${ArgPrefix_Output_Dir};")
#     Fetchcontent_declare(
#     ${ArgPrefix_TargetName}	#库名字
#     GIT_REPOSITORY   ${ArgPrefix_Git_Url}	# 仓库地址
#     # GIT_TAG v1.x # 库版本
#     SOURCE_DIR ${ArgPrefix_Output_Dir} # 指定库下载地址
#     )
# FetchContent_MakeAvailable(spdlog)
endfunction(FetchContent_ForTarget)


# ===========================================全局函数================================
# 添加子文件夹
function(Add_all_subdirectory)
    file(GLOB _children LIST_DIRECTORIES true RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_CURRENT_SOURCE_DIR}/*)
    set(_dirlist "")
    foreach(_child ${_children})
        if(EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/${_child}/CMakeLists.txt)
            list(APPEND _dirlist ${_child})
            add_subdirectory(${_child})
        endif()
    endforeach()
endfunction()

# 获取当前文件夹名称
function(GetCurrentDirectoryName _current_dir_name)
    get_filename_component(temp_dir_name ${CMAKE_CURRENT_SOURCE_DIR} NAME)
    string(REPLACE " " "_" temp_dir_name ${temp_dir_name})
    set(${_current_dir_name} ${temp_dir_name} PARENT_SCOPE)
endfunction(GetCurrentDirectoryName current_dir_name)

#==============================设置变量控制include===========================
set(CMakeFunction_FOUND TRUE)