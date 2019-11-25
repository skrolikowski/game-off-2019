return {
  version = "1.2",
  luaversion = "5.1",
  tiledversion = "1.3.1",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 32,
  height = 25,
  tilewidth = 32,
  tileheight = 32,
  nextlayerid = 8,
  nextobjectid = 53,
  properties = {},
  tilesets = {
    {
      name = "ui_tiles",
      firstgid = 1,
      filename = "ui_tiles.tsx",
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      columns = 8,
      image = "tiles/ui_tiles.png",
      imagewidth = 256,
      imageheight = 256,
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 32,
        height = 32
      },
      properties = {},
      terrains = {},
      tilecount = 64,
      tiles = {}
    },
    {
      name = "ui_icons",
      firstgid = 65,
      filename = "ui_icons.tsx",
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      columns = 16,
      image = "tiles/ui_icons.png",
      imagewidth = 512,
      imageheight = 384,
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 32,
        height = 32
      },
      properties = {},
      terrains = {},
      tilecount = 192,
      tiles = {}
    },
    {
      name = "ui_entities",
      firstgid = 257,
      filename = "ui_entities.tsx",
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      columns = 4,
      image = "tiles/ui_entities.png",
      imagewidth = 128,
      imageheight = 128,
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 32,
        height = 32
      },
      properties = {},
      terrains = {},
      tilecount = 16,
      tiles = {}
    },
    {
      name = "warTileset_32x32",
      firstgid = 273,
      filename = "warTileset_32x32.tsx",
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      columns = 8,
      image = "tiles/warTileset_32x32.png",
      imagewidth = 256,
      imageheight = 256,
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 32,
        height = 32
      },
      properties = {},
      terrains = {},
      tilecount = 64,
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      id = 1,
      name = "UI Back",
      x = 0,
      y = 0,
      width = 32,
      height = 25,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "base64",
      compression = "zlib",
      data = "eAFjYBgFtAwBfaDhxmjYgJYWopltBuSromETNDW05BoCDTfFgmlpJzXN5gEaJkAm5qWCQ4SBZoiQiQVH7ac4BEbDfzT9jeY/8tLAaPlDcfHDMNLLHz5gEAqRifkpD/5RE2gcAgAH9ha+"
    },
    {
      type = "tilelayer",
      id = 3,
      name = "UI Front",
      x = 0,
      y = 0,
      width = 32,
      height = 25,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "base64",
      compression = "zlib",
      data = "eAFjYBgFoyEwGgKDOQQKcDgOJD4PhxwucRzK8QrLMuKVZmAkII9fN2FZFRqbT9gFpKtgHoJuxuVLDgJ+YSUgj8vcoSLOA/QfJwl+BKnnI0H9YA+HxzgcCBMnJWxwGDXshLmGUfwPhsiRBTpCEYrlsDiIkDwWLSQJyQNVK0OxAhadhOSxaBkVAoYAADBzBoc="
    },
    {
      type = "tilelayer",
      id = 7,
      name = "UI Top",
      x = 0,
      y = 0,
      width = 32,
      height = 25,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "base64",
      compression = "zlib",
      data = "eAFjYBgFwz0EXJE86IbEHmWOhsBQCAF+xqHgylE3jobAaAiMhsBoCIyGwGgIEBsCAEoFAJw="
    },
    {
      type = "objectgroup",
      id = 2,
      name = "Buttons",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 29,
          name = "[M]enu",
          type = "",
          shape = "rectangle",
          x = 320,
          y = 672,
          width = 128,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 38,
          name = "[E]sc",
          type = "",
          shape = "rectangle",
          x = 576,
          y = 672,
          width = 128,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 51,
          name = "Volume Up",
          type = "",
          shape = "rectangle",
          x = 896,
          y = 96,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Special"] = "volumeup"
          }
        },
        {
          id = 52,
          name = "Volume Down",
          type = "",
          shape = "rectangle",
          x = 800,
          y = 96,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Special"] = "volumedown"
          }
        }
      }
    },
    {
      type = "objectgroup",
      id = 5,
      name = "Text",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 39,
          name = "[E]sc",
          type = "",
          shape = "rectangle",
          x = 592,
          y = 687,
          width = 96,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Color"] = "white",
            ["Font"] = "md"
          }
        },
        {
          id = 31,
          name = "[M]enu",
          type = "",
          shape = "rectangle",
          x = 337.333,
          y = 688,
          width = 91,
          height = 30.6667,
          rotation = 0,
          visible = true,
          properties = {
            ["Color"] = "white",
            ["Font"] = "md"
          }
        },
        {
          id = 34,
          name = "Vampires",
          type = "",
          shape = "rectangle",
          x = 545.333,
          y = 576,
          width = 158.667,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Align"] = "right",
            ["Color"] = "black",
            ["Font"] = "sm"
          }
        },
        {
          id = 37,
          name = "Wicked, strong, and dangerous.",
          type = "",
          shape = "rectangle",
          x = 545.333,
          y = 608,
          width = 189.333,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Align"] = "left",
            ["Color"] = "gray",
            ["Font"] = "xs",
            ["yOffset"] = 0
          }
        },
        {
          id = 24,
          name = "Sneaky, devious, enduring, and able.",
          type = "",
          shape = "rectangle",
          x = 544,
          y = 352,
          width = 190.667,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Align"] = "left",
            ["Color"] = "gray",
            ["Font"] = "xs",
            ["yOffset"] = 0
          }
        },
        {
          id = 36,
          name = "Tricky, quick, and numerous.",
          type = "",
          shape = "rectangle",
          x = 544,
          y = 544,
          width = 190.667,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Align"] = "left",
            ["Color"] = "gray",
            ["Font"] = "xs",
            ["yOffset"] = 0
          }
        },
        {
          id = 33,
          name = "Skulls",
          type = "",
          shape = "rectangle",
          x = 576,
          y = 512,
          width = 157.333,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Align"] = "left",
            ["Color"] = "black",
            ["Font"] = "sm",
            ["xOffset"] = 10
          }
        },
        {
          id = 35,
          name = "Devious, determined, and unrelenting.",
          type = "",
          shape = "rectangle",
          x = 544,
          y = 480,
          width = 189.333,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Align"] = "left",
            ["Color"] = "gray",
            ["Font"] = "xs",
            ["yOffset"] = 0
          }
        },
        {
          id = 32,
          name = "Skeletons",
          type = "",
          shape = "rectangle",
          x = 544,
          y = 448,
          width = 126.667,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Alight"] = "right",
            ["Color"] = "black",
            ["Font"] = "sm"
          }
        },
        {
          id = 28,
          name = "Strong, determined, patient, and bold.",
          type = "",
          shape = "rectangle",
          x = 544,
          y = 416,
          width = 190.667,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Align"] = "left",
            ["Color"] = "gray",
            ["Font"] = "xs",
            ["yOffset"] = 0
          }
        },
        {
          id = 25,
          name = "Heavy Priest",
          type = "",
          shape = "rectangle",
          x = 576,
          y = 384,
          width = 158.667,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Align"] = "left",
            ["Color"] = "black",
            ["Font"] = "sm",
            ["xOffset"] = 10
          }
        },
        {
          id = 23,
          name = "Trap Priest",
          type = "",
          shape = "rectangle",
          x = 545.333,
          y = 320,
          width = 157.333,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Align"] = "right",
            ["Color"] = "black",
            ["Font"] = "sm"
          }
        },
        {
          id = 20,
          name = "Quick, insightful, steady, and wise.",
          type = "",
          shape = "rectangle",
          x = 545.333,
          y = 288,
          width = 190.667,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Align"] = "right",
            ["Color"] = "gray",
            ["Font"] = "xs",
            ["yOffset"] = 0
          }
        },
        {
          id = 42,
          name = "Range Priest",
          type = "",
          shape = "rectangle",
          x = 576,
          y = 256,
          width = 160,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Align"] = "left",
            ["Color"] = "black",
            ["Font"] = "sm",
            ["xOffset"] = 10
          }
        },
        {
          id = 14,
          name = "Characters",
          type = "",
          shape = "rectangle",
          x = 544,
          y = 224,
          width = 160,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Color"] = "black",
            ["Font"] = "md"
          }
        },
        {
          id = 45,
          name = "*Wrap tiles are light brown located in the Void.",
          type = "",
          shape = "rectangle",
          x = 288,
          y = 320,
          width = 257.333,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Align"] = "left",
            ["Color"] = "gray",
            ["Font"] = "xs",
            ["xOffset"] = 10
          }
        },
        {
          id = 43,
          name = "Set cursor in Wrap tile marked by indicator.",
          type = "",
          shape = "rectangle",
          x = 320,
          y = 256,
          width = 222.667,
          height = 62.6667,
          rotation = 0,
          visible = true,
          properties = {
            ["Align"] = "left",
            ["Color"] = "black",
            ["Font"] = "sm",
            ["xOffset"] = 10
          }
        },
        {
          id = 41,
          name = "How to Play",
          type = "",
          shape = "rectangle",
          x = 320,
          y = 224,
          width = 160,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Color"] = "black",
            ["Font"] = "md"
          }
        },
        {
          id = 46,
          name = "Spend Magic to Summon Priest",
          type = "",
          shape = "rectangle",
          x = 320,
          y = 384,
          width = 224,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Align"] = "left",
            ["Color"] = "black",
            ["Font"] = "sm",
            ["xOffset"] = 10
          }
        },
        {
          id = 47,
          name = "Spend your magic wisely.",
          type = "",
          shape = "rectangle",
          x = 288,
          y = 416,
          width = 256,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Align"] = "left",
            ["Color"] = "gray",
            ["Font"] = "xs",
            ["xOffset"] = 10
          }
        },
        {
          id = 48,
          name = "Killing monsters will replenish magic.",
          type = "",
          shape = "rectangle",
          x = 352,
          y = 448,
          width = 192,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {
            ["Align"] = "left",
            ["Color"] = "gray",
            ["Font"] = "xs",
            ["xOffset"] = 10
          }
        },
        {
          id = 49,
          name = "Last as long as you can!!",
          type = "",
          shape = "rectangle",
          x = 288,
          y = 544,
          width = 238.667,
          height = 62.6667,
          rotation = 0,
          visible = true,
          properties = {
            ["Color"] = "black",
            ["Font"] = "md",
            ["xOffset"] = 10
          }
        },
        {
          id = 50,
          name = "Volume",
          type = "",
          shape = "rectangle",
          x = 800,
          y = 96,
          width = 128,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["Color"] = "black",
            ["Font"] = "sm"
          }
        }
      }
    }
  }
}
