__precompile__(true)
module Playwright

using PyCall

const playwright = PyNULL()
const sync_playwright = PyNULL()
const async_playwright = PyNULL()

function __init__()
  copy!(playwright, pyimport_conda("playwright", "playwright", "microsoft"))
  copy!(sync_playwright, pyimport("playwright.sync_api").sync_playwright)
  copy!(async_playwright, pyimport("playwright.async_api").async_playwright)
end

# macro uitest(VAR, BLOCK)
#   EXPR = sync_playwright()
#   as = :as
#   if isexpr(VAR, :(::))
#     VAR, TYPE = VAR.args
#   else
#     TYPE = PyAny
#   end
#   if !((as == :as) && isa(VAR, Symbol))
#     throw(ArgumentError("usage: @pywith EXPR[::TYPE1] [as VAR[::TYPE2]] BLOCK."))
#   end
#   PyCall._pywith(EXPR, VAR, TYPE, BLOCK)
# end

end
