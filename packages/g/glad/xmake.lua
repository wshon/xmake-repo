package("glad")

    set_homepage("https://glad.dav1d.de/")
    set_description("Multi-Language Vulkan/GL/GLES/EGL/GLX/WGL Loader-Generator based on the official specs.")
    set_license("MIT")

    add_urls("https://github.com/Dav1dde/glad/archive/$(version).tar.gz",
             "https://github.com/Dav1dde/glad.git")
    add_versions("v0.1.34", "4be2900ff76ac71a2aab7a8be301eb4c0338491c7e205693435b09aad4969ecd")

    if is_plat("linux") then
        add_syslinks("dl")
    end
    on_load("windows", "linux", "macosx", function (package)
        if not package.is_built or package:is_built() then
            package:add("deps", "cmake", "python 3.x", {kind = "binary"})
        end
    end)

    on_install("windows", "linux", "macosx", function (package)
        local configs = {"-DGLAD_INSTALL=ON", "-DGLAD_REPRODUCIBLE=ON"}
        if package:is_plat("windows") then
            table.insert(configs, "-DUSE_MSVC_RUNTIME_LIBRARY_DLL=" .. (package:config("vs_runtime"):startswith("MT") and "OFF" or "ON"))
        end
        import("package.tools.cmake").install(package, configs)
    end)

    on_test(function (package)
        assert(package:has_cfuncs("gladLoadGL", {includes = "glad/glad.h"}))
    end)
