using Playwright
using Documenter

DocMeta.setdocmeta!(Playwright, :DocTestSetup, :(using Playwright); recursive=true)

makedocs(;
    modules=[Playwright],
    authors="abhi@stipple.app",
    repo="https://github.com/abhimanyuaryan/Playwright.jl/blob/{commit}{path}#{line}",
    sitename="Playwright.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://abhimanyuaryan.github.io/Playwright.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/abhimanyuaryan/Playwright.jl",
    devbranch="main",
)
