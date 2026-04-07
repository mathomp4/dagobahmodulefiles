--[[ Copilot CLI BYOK: NASA LiteLLM - gemini-3.1-flash-lite-preview

Configures GitHub Copilot CLI to use the NASA CAIO LiteLLM gateway
with the gemini-3.1-flash-lite-preview model (lightweight/fast).

Prerequisites:
  Export your API key before loading this module:
    export NASA_LITELLM_API_KEY=<your-key>

  The key can be found in ~/.config/opencode/opencode.jsonc.

Usage:
  export NASA_LITELLM_API_KEY=<your-key>
  module load copilot-nasa-litellm/gemini-3.1-flash-lite-preview
  copilot

See: https://docs.github.com/en/copilot/how-tos/copilot-cli/customize-copilot/use-byok-models

--]]

local base_url = "https://llm-api-access.caio.mcp.nasa.gov"
local model    = "gemini-3.1-flash-lite-preview"

local api_key = os.getenv("NASA_LITELLM_API_KEY") or ""
if api_key == "" then
   LmodWarning([[NASA_LITELLM_API_KEY is not set.
   Export it before loading this module:
     export NASA_LITELLM_API_KEY=<your-key>]])
end

setenv("COPILOT_PROVIDER_BASE_URL",          base_url)
setenv("COPILOT_PROVIDER_TYPE",              "openai")
setenv("COPILOT_PROVIDER_API_KEY",           api_key)
setenv("COPILOT_MODEL",                      model)
-- Flash Lite is a smaller/faster model; 128k prompt, 8k output are reasonable limits
setenv("COPILOT_PROVIDER_MAX_PROMPT_TOKENS",  "128000")
setenv("COPILOT_PROVIDER_MAX_OUTPUT_TOKENS",  "8192")
