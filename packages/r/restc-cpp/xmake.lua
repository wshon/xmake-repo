package("rply")

    set_homepage("https://github.com/jgaa/restc-cpp")
    set_description("The magic that takes the pain out of accessing JSON API's from C++.")
    set_license("MIT")

    add_urls("https://github.com/jgaa/restc-cpp/archive/refs/tags/$(version).tar.gz")
    add_versions("v0.10.0", "daf0b060fe701adf72aab0d525323d2e2e1bde9aa6aa9713ff1a5ef1e768d703")

    on_install(function (package)
        io.writefile("xmake.lua", [[
            add_rules("mode.debug", "mode.release")
            target("rply")
                set_kind("$(kind)")
                add_files("rply.c")
                add_headerfiles("rply.h", "rplyfile.h")
        ]])
        local configs = {kind = "static"}
        if package:config("shared") then
            configs.kind = "shared"
        elseif package:is_plat("linux") and package:config("pic") ~= false then
            configs.cxflags = "-fPIC"
        end
        import("package.tools.xmake").install(package, configs)
    end)

    on_test(function (package)
        assert(package:has_cfuncs("ply_create", {includes = "rply.h"}))
    end)
