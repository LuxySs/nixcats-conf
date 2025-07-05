local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local extras = require('luasnip.extras')
local rep = extras.rep
local fmt = require('luasnip.extras.fmt').fmt
local c = ls.choice_node
local f = ls.function_node
local d = ls.dynamic_node
local sn = ls.snippet_node
local l = require('luasnip.extras').lambda

ls.add_snippets('cpp', {
  s('std::cout', {
    t('std::cout << '),
    i(1),
    t(' << std::endl;'),
  }),
})

ls.add_snippets('cpp', {
  s(
    'guard',
    fmt(
      [[
#ifndef {}
#define {}

{}

#endif // {}
    ]],
      {
        d(1, function(_, parent)
          local filename = parent.env.TM_FILENAME:upper():gsub('%.', '_')
          return sn(nil, i(1, filename))
        end),
        rep(1),
        i(2),
        rep(1),
      }
    )
  ),
})
