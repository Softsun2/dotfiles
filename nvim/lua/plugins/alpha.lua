local alpha = require('alpha')
local dashboard = require('alpha.themes.dashboard')

-- https://drewish.com/projects/unicoder/
dashboard.section.header.val = {
  [[                         ▗▄▄▄▙████▙▄▄▖                      ]],
  [[                      ▗▟█▀▘▘        ▀▀█▄                    ]],
  [[                    ▗▟▀                ▀▙▖                  ]],
  [[                   ▟▛▘                  ▝█▖                 ]],
  [[    ▄▄▄▄          ▟▘                     ▜▛                 ]],
  [[   ██▀▀█▙        ▟▛                      ▐█                 ]],
  [[  ▐█   ▜█▌    ▗█▐▛     ▗▖▖                █▌      ▄███▄▖    ]],
  [[  ▐▙   ▐█▙▄▄▄▄██▝    ▜██▘█▖               ▜▙▖    ▐█▛  ▝▜▙   ]],
  [[  ▐▙    ▜███▛▀▘        ▀▜██▘       ▗▄▟▛▙▄▄▖▝██▄▄▄█▛   ▗█▛   ]],
  [[   █▖     ▘                       ▝▀▀▜█▛▀▀   ▝▀▀▀▀    ▟█▘   ]],
  [[   ▐▙▖                       ▄▖ ▄▖                  ▗██▘    ]],
  [[    ▀▙▖               █▙                           ▟██▀     ]],
  [[     ▀█▙▄             ▀██▄▄▖         ▗  █▖       ▄██▛       ]],
  [[       ▀██▙▄▄▄          ▝▀▀████▛▜██▀████▀      ▄██▛▘        ]],
  [[         ▝▀████▙▙▌          ▝▜▜█▛▘           ▄▟█▀           ]],
  [[              ▘▘▀██                      ▖▄▟█▀▀             ]],
  [[                  ▝▀█▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▘▀▀▘▘                 ]],
  [[                      ▝▀▀▀▀▀▀▀▀▀▀▀▀                         ]],
}

-- https://www.nerdfonts.com/cheat-sheet
dashboard.section.buttons.val = {
  dashboard.button("e", "  New file", "<cmd>ene <CR>"),
  dashboard.button("r", "  MRU", ":Telescope oldfiles<CR>"),
  dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
  -- FIXME: Don't wan't to cd. Can't ff from home if we exit the config file search.
  dashboard.button("c", "  Config" , ":cd ~/.config/nvim<CR>:Telescope find_files<CR>"),
  dashboard.button("q", "  Quit" , ":qa<CR>"),
  -- dashboard.button("SPC s l", "  Open last session"),
  -- dashboard.button("b", "  Bookmarks"),
  -- dashboard.button("w", "  Find word", ":Telescope live_grep<CR>"),
}

dashboard.section.footer.val = {
  [[                       ]],
  [[     I know you're     ]],
  [[       out there.      ]],
  [[                       ]],
}

alpha.setup(dashboard.opts)
