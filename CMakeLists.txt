cmake_minimum_required(VERSION 3.16)
project(ImageEditor VERSION 0.1 LANGUAGES CXX)

# Set C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Find required packages
find_package(Qt6 6.8 REQUIRED COMPONENTS Quick)


set(OpenCV_DIR "C:/opencv/OpenCV-MinGW-Build-OpenCV-4.5.5-x64")
find_package(OpenCV REQUIRED)

# Display OpenCV information
message(STATUS "OpenCV library status:")
message(STATUS "    config: ${OpenCV_DIR}")
message(STATUS "    version: ${OpenCV_VERSION}")
message(STATUS "    libraries: ${OpenCV_LIBS}")
message(STATUS "    include path: ${OpenCV_INCLUDE_DIRS}")

# Qt setup
qt_standard_project_setup(REQUIRES 6.8)

# Create executable
qt_add_executable(appImageEditor
    main.cpp
)

# Add QML module
qt_add_qml_module(appImageEditor
    URI ImageEditor
    VERSION 1.0
    QML_FILES
        qml/Main.qml
        qml/LeftPanel.qml
        qml/CenterPanel.qml
        qml/RightPanel.qml
        qml/tools/color/grayscale.qml
        # qml/components/ToolButton.qml
        # qml/components/ParameterSlider.qml
        # qml/components/ImageViewer.qml
    SOURCES
        imagemanager.h imagemanager.cpp
        selectionmanager.h selectionmanager.cpp
        colortoolprocessor.h colortoolprocessor.cpp
        SOURCES imagestorage.h imagestorage.cpp
)

# Set target properties
set_target_properties(appImageEditor PROPERTIES
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

# Link libraries
target_link_libraries(appImageEditor PRIVATE
    Qt6::Quick
    ${OpenCV_LIBS}
)

# Include directories
target_include_directories(appImageEditor PRIVATE
    ${OpenCV_INCLUDE_DIRS}
)

# Installation
include(GNUInstallDirs)
install(TARGETS appImageEditor
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
