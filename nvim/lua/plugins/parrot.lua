return {
  "frankroeder/parrot.nvim",
  dependencies = { "ibhagwan/fzf-lua", "nvim-lua/plenary.nvim" },
  opts = {},
  config = function()
    require("parrot").setup({
      -- Providers must be explicitly set up to make them available.
      providers = {
        anthropic = {
          name = "anthropic",
          endpoint = "https://api.anthropic.com/v1/messages",
          model_endpoint = "https://api.anthropic.com/v1/models",
          api_key = os.getenv("ANTHROPIC_API_KEY"),
          params = {
            chat = { max_tokens = 4096 },
            command = { max_tokens = 4096 },
          },
          topic = {
            model = "claude-3-5-haiku-latest",
            params = { max_tokens = 32 },
          },
          headers = function(self)
            return {
              ["Content-Type"] = "application/json",
              ["x-api-key"] = self.api_key,
              ["anthropic-version"] = "2023-06-01",
            }
          end,
          models = {
            "claude-sonnet-4-20250514",
            "claude-3-7-sonnet-20250219",
            "claude-3-5-sonnet-20241022",
            "claude-3-5-haiku-20241022",
          },
          hooks = {
            Ask = function(parrot, params)
              local template = [[
          In light of your existing knowledge base, please generate a response that
          is succinct and directly addresses the question posed. Prioritize accuracy
          and relevance in your answer, drawing upon the most recent information
          available to you. Aim to deliver your response in a concise manner,
          focusing on the essence of the inquiry.
          Question: {{command}}
        ]]
              local model_obj = parrot.get_model("command")
              parrot.logger.info("Asking model: " .. model_obj.name)
              parrot.Prompt(params, parrot.ui.Target.popup, model_obj, "🤖 Ask ~ ", template)
            end,
          },
          preprocess_payload = function(payload)
            for _, message in ipairs(payload.messages) do
              message.content = message.content:gsub("^%s*(.-)%s*$", "%1")
            end
            if payload.messages[1] and payload.messages[1].role == "system" then
              -- remove the first message that serves as the system prompt as anthropic
              -- expects the system prompt to be part of the API call body and not the messages
              payload.system = payload.messages[1].content
              table.remove(payload.messages, 1)
            end
            return payload
          end,
        },
      },
    })
  end,
}
