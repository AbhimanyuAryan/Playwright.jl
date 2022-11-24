using Playwright
using Test

@testset "Playwright.jl sync test" begin
  @uitest p begin
    browser = p.firefox.launch()
    page = browser.new_page()
    try
      page.goto("https://genieframework.com/")
    catch e
      "Failed goto"
    end
    @test page.title() == "Genie Framework - Highly Productive Web Development with Julia"
    browser.close()
  end
end


