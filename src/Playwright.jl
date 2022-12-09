__precompile__(true)
module Playwright

export sync_playwright, @uitest

import Base.Meta: isexpr
using Conda, PyCall, Pkg

const playwright = PyNULL()
const sync_playwright = PyNULL()
const async_playwright = PyNULL()
const asyncio = PyNULL()


function __init__()
  # setup pycall and conda env
  ENV["PYTHON"] = joinpath(Conda.BINDIR, "python")
  ENV["CONDA_JL_HOME"] = Conda.ROOTENV
  Pkg.build("PyCall")

  # setup playwright
  copy!(playwright, pyimport_conda("playwright", "playwright", "microsoft"))

  @info "Installing Python Playwright drivers..."

  playwrightdrivers = joinpath(Sys.iswindows() ? Conda.SCRIPTDIR : Conda.BINDIR, "playwright")
  run(`$playwrightdrivers install`)

  copy!(sync_playwright, pyimport("playwright.sync_api").sync_playwright)
  copy!(async_playwright, pyimport("playwright.async_api").async_playwright)
  copy!(asyncio, pyimport("asyncio"))
end

macro uitest(VAR, BLOCK)
  EXPR = sync_playwright()
  as = :as
  if isexpr(VAR, :(::))
    VAR, TYPE = VAR.args
  else
    TYPE = PyAny
  end
  if !((as == :as) && isa(VAR, Symbol))
    throw(ArgumentError("usage: @pywith EXPR[::TYPE1] [as VAR[::TYPE2]] BLOCK."))
  end
  PyCall._pywith(EXPR, VAR, TYPE, BLOCK)
end

end
