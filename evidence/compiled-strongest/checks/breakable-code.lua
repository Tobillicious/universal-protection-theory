-- PDF only: let long inline code (hashes, theorem names) break between characters.
local esc = {['\\']='\\textbackslash{}', ['{']='\\{', ['}']='\\}', ['_']='\\_', ['^']='\\^{}',
             ['#']='\\#', ['$']='\\$', ['%']='\\%', ['&']='\\&', ['~']='\\textasciitilde{}'}
function Code(el)
  if not FORMAT:match('latex') or utf8.len(el.text) <= 16 then return nil end
  local parts = {}
  for _, c in utf8.codes(el.text) do
    local ch = utf8.char(c)
    parts[#parts + 1] = esc[ch] or ch
  end
  return pandoc.RawInline('latex', '\\texttt{' .. table.concat(parts, '\\allowbreak{}') .. '}')
end


-- Preserve literal code and indentation while allowing long equations to wrap.
-- This uses the core LaTeX text primitives, without optional TeX packages.
function CodeBlock(el)
  if not FORMAT:match('latex') then return nil end
  local lines = {}
  for line in (el.text .. '\n'):gmatch('(.-)\n') do
    local chars = {}
    for _, c in utf8.codes(line) do
      local ch = utf8.char(c)
      chars[#chars + 1] = ch == ' ' and '\\hspace*{0.525em}' or (esc[ch] or ch)
    end
    lines[#lines + 1] = '\\noindent ' .. table.concat(chars, '\\allowbreak{}') .. '\\par'
  end
  return pandoc.RawBlock('latex', '\\begin{quote}\\small\\ttfamily\\raggedright\\setlength{\\parskip}{0pt}\n'
    .. table.concat(lines, '\n') .. '\n\\end{quote}')
end


-- Equivalent roman subscripts supported by Pandoc's MathML writer.
function Math(el)
  el.text = el.text:gsub('{\\rm%s+([^}]+)}', '{\\mathrm{%1}}')
  return el
end

-- Long literal identifiers in ordinary prose also need legal break points.
function Str(el)
  if not FORMAT:match('latex') or utf8.len(el.text) < 15 then return nil end
  if not (el.text:find('_', 1, true) or el.text:find('/', 1, true)) then return nil end
  local parts = {}
  for _, c in utf8.codes(el.text) do
    local ch = utf8.char(c)
    parts[#parts + 1] = esc[ch] or ch
  end
  return pandoc.RawInline('latex', table.concat(parts, '\\allowbreak{}'))
end


-- The source's paired p_* identifiers are literal stars, not emphasis.
function Emph(el)
  local text = pandoc.utils.stringify(el)
  if text:match('^=b ') and text:match('p_$') then
    local result = pandoc.Inlines({pandoc.Str('*')})
    result:extend(el.content)
    result:insert(pandoc.Str('*'))
    return result
  end
  return nil
end
