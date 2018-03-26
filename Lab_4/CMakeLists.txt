project(convolution)

SET(CMAKE_CXX_STANDARD 17)

add_executable(convolution main.cpp filter.cpp filter.h fir_coeffs.h)