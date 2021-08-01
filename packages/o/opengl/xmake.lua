package("opengl")

    set_homepage("https://opengl.org/")
    set_description("OpenGL - The Industry Standard for High Performance Graphics")

    on_fetch(function (package, opt)
        if opt.system then
            if package:is_plat("macosx") then
                return {frameworks = "OpenGL", defines = "GL_SILENCE_DEPRECATION"}
            elseif package:is_plat("windows", "mingw") then
                return {links = "opengl32"}
            elseif package:is_plat("linux") and package.find_package then
                print("xxxzz", os.getenv("PATH"))
                print("find", find_package("opengl"))
                return package:find_package("opengl", opt) or package:find_package("libgl", opt)
            end
        end
    end)
