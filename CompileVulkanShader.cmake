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
