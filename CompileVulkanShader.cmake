function (add_shaders_target TARGET)
  set(option TEST_Option)
  set(oneValueArgs OUTPUT_DIR TARGET_OUTPUT_NAME )
  cmake_parse_arguments ("SHADER" "" "${oneValueArgs}" "SOURCES" ${ARGN})
  set (SHADERS_DIR ${SHADER_OUTPUT_DIR}/Shader)
  # message(STATUS OUTPUT_DIR = ${SHADERS_DIR})
  add_custom_command (
    OUTPUT ${SHADERS_DIR}
    COMMAND ${CMAKE_COMMAND} -E make_directory ${SHADERS_DIR}
    )
  add_custom_command (
    OUTPUT ${SHADERS_DIR}/frag.spv ${SHADERS_DIR}/vert.spv
    COMMAND glslang::validator
    ARGS --target-env vulkan1.0  ${SHADER_SOURCES} --quiet -V 
    WORKING_DIRECTORY ${SHADERS_DIR}
    DEPENDS ${SHADERS_DIR} ${SHADER_SOURCES}
    COMMENT "Compiling Shaders"
    VERBATIM
    )
  add_custom_target (${TARGET} DEPENDS ${SHADERS_DIR}/frag.spv ${SHADERS_DIR}/vert.spv)
  if(TARGET ${TARGET})
    # message(STATUS  "${TARGET} Shaders has compile sucessfully"  )
  endif()
endfunction ()


function(compile_shader SHADERS TARGET_NAME SHADER_INCLUDE_FOLDER GENERATED_DIR GLSLANG_BIN)

    set(working_dir "${CMAKE_CURRENT_SOURCE_DIR}/${GENERATED_DIR}/spv")
    set(ALL_GENERATED_SPV_FILES "")

    foreach(SHADER ${SHADERS})
    # Prepare a header name and a global variable for this shader
        get_filename_component(SHADER_NAME ${SHADER} NAME)

        set(SPV_FILE "${CMAKE_CURRENT_SOURCE_DIR}/${GENERATED_DIR}/spv/${SHADER_NAME}.spv")
        
        add_custom_command(
            OUTPUT ${SPV_FILE}
            COMMAND ${GLSLANG_BIN} -I${SHADER_INCLUDE_FOLDER} -V100 -o ${SPV_FILE} ${SHADER}
            DEPENDS ${SHADER}
            WORKING_DIRECTORY "${working_dir}")

        list(APPEND ALL_GENERATED_SPV_FILES ${SPV_FILE})

    endforeach()

    # message(STATUS  ALL_GENERATED_SPV_FILES = ${ALL_GENERATED_SPV_FILES})
    add_custom_target(${TARGET_NAME} DEPENDS ${ALL_GENERATED_SPV_FILES} SOURCES ${SHADERS})

endfunction()