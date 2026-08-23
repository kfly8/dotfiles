-- Workaround for an upstream nvim-treesitter bug: the "set-lang-from-info-string!"
-- query directive (used by markdown's injections.scm to pick the language of
-- fenced code blocks) can call vim.treesitter.get_node_text() on a node whose
-- range is no longer valid, crashing the treesitter highlighter's decoration
-- provider with "attempt to call method 'range' (a nil value)".
-- See: https://github.com/neovim/neovim/issues/39032
--      https://github.com/nvim-treesitter/nvim-treesitter/issues/8618
--
-- Re-register the directive with the node-text lookup wrapped in pcall, so a
-- stale node just skips the injection instead of crashing the highlighter.

local ok = pcall(require, "nvim-treesitter.query_predicates")
if not ok then
  return
end

local non_filetype_match_injection_language_aliases = {
  ex = "elixir",
  pl = "perl",
  sh = "bash",
  uxn = "uxntal",
  ts = "typescript",
}

local function get_parser_from_markdown_info_string(injection_alias)
  local match = vim.filetype.match({ filename = "a." .. injection_alias })
  return match or non_filetype_match_injection_language_aliases[injection_alias] or injection_alias
end

vim.treesitter.query.add_directive("set-lang-from-info-string!", function(match, _, bufnr, pred, metadata)
  local capture_id = pred[2]
  local node = match[capture_id]
  if not node then
    return
  end

  local text_ok, text = pcall(vim.treesitter.get_node_text, node, bufnr)
  if not text_ok then
    return
  end

  metadata["injection.language"] = get_parser_from_markdown_info_string(text:lower())
end, { force = true, all = false })
