-- Matugen 配色模板
-- 修改此文件后需要重新运行 Matugen。
-- 生成结果：~/.config/nvim/generated.lua

local c = {
  bg = "#0f1416",
  fg = "#dee3e6",
  muted = "#bfc8cc",
  outline = "#899296",

  surface = "#1b2023",
  surface_low = "#171c1e",
  surface_high = "#252b2d",

  primary = "#86d1ea",
  on_primary = "#003642",

  secondary = "#b3cad3",
  secondary_container = "#344a52",
  on_secondary_container = "#cee6f0",

  tertiary = "#c1c4eb",
  tertiary_container = "#414465",
  on_tertiary_container = "#dfe0ff",

  error = "#ffb4ab",
}

-- Base16 基础色板。
-- Material 配色的强调色数量较少，部分语法类别会共享颜色。
require("base16-colorscheme").setup({
  base00 = c.bg,
  base01 = c.surface_low,
  base02 = c.surface_high,
  base03 = c.outline,
  base04 = c.muted,
  base05 = c.fg,
  base06 = c.fg,
  base07 = c.fg,

  base08 = c.tertiary,
  base09 = c.tertiary,
  base0A = c.secondary,
  base0B = c.primary,
  base0C = c.secondary,
  base0D = c.secondary,
  base0E = c.primary,
  base0F = c.error,
})

local function hl(name, value)
  vim.api.nvim_set_hl(0, name, value)
end

local function link(groups, target)
  for _, group in ipairs(groups) do
    hl(group, { link = target })
  end
end

-- 编辑区
hl("Normal", { fg = c.fg, bg = c.bg })
hl("NormalNC", { link = "Normal" })
hl("EndOfBuffer", { fg = c.surface_high })
hl("NonText", { fg = c.outline })
hl("Whitespace", { fg = c.outline })

-- 光标行与行号
hl("CursorLine", { bg = c.surface_low })
hl("CursorLineNr", {
  fg = c.primary,
  bg = c.surface_low,
  bold = true,
})
hl("LineNr", { fg = c.outline })
hl("SignColumn", { bg = c.bg })
hl("ColorColumn", { bg = c.surface_low })
hl("WinSeparator", { fg = c.outline })

-- 选区与搜索
hl("Visual", {
  fg = c.on_secondary_container,
  bg = c.secondary_container,
})
hl("VisualNOS", { link = "Visual" })

hl("Search", {
  fg = c.on_tertiary_container,
  bg = c.tertiary_container,
})
hl("IncSearch", {
  fg = c.on_primary,
  bg = c.primary,
  bold = true,
})
hl("CurSearch", { link = "IncSearch" })
hl("MatchParen", {
  fg = c.primary,
  bg = c.surface_high,
  bold = true,
})

-- 浮窗、补全菜单
hl("NormalFloat", { fg = c.fg, bg = c.surface })
hl("FloatBorder", { fg = c.outline, bg = c.surface })
hl("FloatTitle", {
  fg = c.primary,
  bg = c.surface,
  bold = true,
})
hl("Pmenu", { fg = c.fg, bg = c.surface })
hl("PmenuSel", {
  fg = c.on_secondary_container,
  bg = c.secondary_container,
})
hl("PmenuSbar", { bg = c.surface_high })
hl("PmenuThumb", { bg = c.outline })

-- 状态栏、消息与折叠
hl("StatusLine", { fg = c.fg, bg = c.surface_high })
hl("StatusLineNC", { fg = c.muted, bg = c.surface_low })
hl("MsgArea", { fg = c.fg, bg = c.bg })
hl("Folded", { fg = c.muted, bg = c.surface_low })

-- 基础语法高亮
hl("Comment", { fg = c.muted, italic = true })
hl("Identifier", { fg = c.fg })
hl("Function", { fg = c.secondary })
hl("Statement", { fg = c.primary })
hl("Keyword", { fg = c.primary })
hl("Operator", { fg = c.muted })
hl("Type", { fg = c.tertiary })
hl("Constant", { fg = c.tertiary })
hl("String", { fg = c.primary })
hl("Number", { fg = c.tertiary })
hl("Boolean", { fg = c.tertiary })
hl("Special", { fg = c.secondary })
hl("Delimiter", { fg = c.muted })

-- 现代 Tree-sitter 捕获组。
-- 仅定义颜色，不会自动安装或启用语法解析器。
link({ "@comment" }, "Comment")
link({ "@variable", "@variable.parameter", "@property" }, "Identifier")
link({
  "@function",
  "@function.call",
  "@function.builtin",
  "@function.method",
  "@function.method.call",
}, "Function")
link({ "@keyword" }, "Keyword")
link({ "@type", "@type.builtin", "@constructor" }, "Type")
link({ "@constant", "@constant.builtin" }, "Constant")
link({ "@string", "@character" }, "String")
link({ "@number", "@number.float" }, "Number")
link({ "@boolean" }, "Boolean")
link({ "@operator" }, "Operator")
link({ "@punctuation" }, "Delimiter")

-- 诊断信息：错误突出，其他级别沿用主题强调色。
hl("DiagnosticError", { fg = c.error })
hl("DiagnosticWarn", { fg = c.tertiary })
hl("DiagnosticInfo", { fg = c.secondary })
hl("DiagnosticHint", { fg = c.primary })
hl("DiagnosticOk", { fg = c.primary })

local diagnostic_colors = {
  Error = c.error,
  Warn = c.tertiary,
  Info = c.secondary,
  Hint = c.primary,
  Ok = c.primary,
}

for severity, color in pairs(diagnostic_colors) do
  hl("DiagnosticUnderline" .. severity, {
    sp = color,
    undercurl = true,
  })
  hl("DiagnosticVirtualText" .. severity, { fg = color })
  hl("DiagnosticFloating" .. severity, { fg = color, bg = c.surface })
  hl("DiagnosticSign" .. severity, { fg = color })
end
