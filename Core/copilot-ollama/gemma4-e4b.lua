--[[ Copilot CLI BYOK: Ollama gemma4:e4b (local)

Configures GitHub Copilot CLI to use a local Ollama instance with the
gemma4:e4b model.

Prerequisites:
  - Ollama running: ollama serve
  - Model pulled:   ollama pull gemma4:e4b
  - Context window increased (Ollama default is too small):
      ollama run gemma4:e4b
      /set parameter num_ctx 8192
      /save gemma4:e4b

Usage:
  module load copilot-ollama/gemma4-e4b
  copilot

See: https://docs.github.com/en/copilot/how-tos/copilot-cli/customize-copilot/use-byok-models

--]]

local base_url = "http://localhost:11434/v1"
local model    = "gemma4:e4b"

setenv("COPILOT_PROVIDER_BASE_URL", base_url)
setenv("COPILOT_PROVIDER_TYPE",     "openai")
setenv("COPILOT_MODEL",             model)

-- Fully local: prevent Copilot CLI from contacting GitHub servers
setenv("COPILOT_OFFLINE", "true")
