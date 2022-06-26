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