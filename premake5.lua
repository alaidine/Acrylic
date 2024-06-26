workspace "Acrylic"

architecture "x64"

configurations { "Debug", "Release", "Dist" }

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

project "Acrylic"
location "Acrylic"
kind "SharedLib"
language "C++"

targetdir("bin/" .. outputdir .. "/%{prj.name}")
objdir("bin-int/" .. outputdir .. "/%{prj.name}")

files { "%{prj.name}/src/**.h", "%{prj.name}/src/**.cpp" }
includedirs { "%{prj.name}/vendor/spdlog/include" }

filter "system:windows"
cppdialect "C++17"
staticruntime "On"
systemversion "latest"

defines { "AC_PLATFORM_WINDOWS", "AC_BUILD_DLL" }

postbuildcommands {
	("{COPY} %{cfg.buildtarget.relpath} ../bin/" .. outputdir .. "/Sandbox")
}

filter "configurations:Debug"
defines "AC_DEBUG"
optimize "On"

filter "configurations:Release"
defines "AC_RELEASE"
optimize "On"

filter "configurations:Dist"
defines "AC_DIST"
optimize "On"

project "Sandbox"
location "Sandbox"
kind "ConsoleApp"
language "C++"

targetdir("bin/" .. outputdir .. "/%{prj.name}")
objdir("bin-int/" .. outputdir .. "/%{prj.name}")

files { "%{prj.name}/src/**.h", "%{prj.name}/src/**.cpp" }
includedirs { "Acrylic/vendor/spdlog/include", "Acrylic/src" }

links { "Acrylic" }

filter "system:windows"
cppdialect "C++17"
staticruntime "On"
systemversion "latest"

defines { "AC_PLATFORM_WINDOWS" }

filter "configurations:Debug"
defines "AC_DEBUG"
optimize "On"

filter "configurations:Release"
defines "AC_RELEASE"
optimize "On"

filter "configurations:Dist"
defines "AC_DIST"
optimize "On"
